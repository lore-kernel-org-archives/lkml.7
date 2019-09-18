Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3521C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A09218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787770;
	bh=Zl8Of0omv0EGP4bw75V5pdGDyx+pj44Tljf0cyGCyHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FSjJw0E+snj5pm3NMPcDVlZbE8yLGSSSkdkDHl1dth6s9ikSBNiPL/+H9MLYTmheG
	 JeGKOzPqY9oK6hSd5fnnHhctRJYk4G/CRo8EEQCTK0+6ws589dnzxQ5yppi5RQ6x/m
	 xmT8iRO8qiC0FFvC2EOkzTawFHuXCO7popbr6/Hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfIRGWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729443AbfIRGWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:22:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EA842196E;
        Wed, 18 Sep 2019 06:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787757;
        bh=Zl8Of0omv0EGP4bw75V5pdGDyx+pj44Tljf0cyGCyHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGoPJprPyrLQ/SbTWZ3lgoJ0l60how+/hV++6jzv1JGvdD1uqyyl5Dvcmd2EfdhjL
         N3oZqsWy8VXxdxkPxR5YTrSy8Tjh6L+6ZgCHRESvSrDfMow9A1fk6mSCZQ1ORS/Uto
         XWiFCFNreVcUD/oBW+9uFB7SrROO0wrqKHxEFwxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
Subject: [PATCH 4.19 22/50] KVM: s390: Do not leak kernel stack data in the KVM_S390_INTERRUPT ioctl
Date:   Wed, 18 Sep 2019 08:19:05 +0200
Message-Id: <20190918061225.381771977@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061223.116178343@linuxfoundation.org>
References: <20190918061223.116178343@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Huth <thuth@redhat.com>

commit 53936b5bf35e140ae27e4bbf0447a61063f400da upstream.

When the userspace program runs the KVM_S390_INTERRUPT ioctl to inject
an interrupt, we convert them from the legacy struct kvm_s390_interrupt
to the new struct kvm_s390_irq via the s390int_to_s390irq() function.
However, this function does not take care of all types of interrupts
that we can inject into the guest later (see do_inject_vcpu()). Since we
do not clear out the s390irq values before calling s390int_to_s390irq(),
there is a chance that we copy random data from the kernel stack which
could be leaked to the userspace later.

Specifically, the problem exists with the KVM_S390_INT_PFAULT_INIT
interrupt: s390int_to_s390irq() does not handle it, and the function
__inject_pfault_init() later copies irq->u.ext which contains the
random kernel stack data. This data can then be leaked either to
the guest memory in __deliver_pfault_init(), or the userspace might
retrieve it directly with the KVM_S390_GET_IRQ_STATE ioctl.

Fix it by handling that interrupt type in s390int_to_s390irq(), too,
and by making sure that the s390irq struct is properly pre-initialized.
And while we're at it, make sure that s390int_to_s390irq() now
directly returns -EINVAL for unknown interrupt types, so that we
immediately get a proper error code in case we add more interrupt
types to do_inject_vcpu() without updating s390int_to_s390irq()
sometime in the future.

Cc: stable@vger.kernel.org
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/kvm/20190912115438.25761-1-thuth@redhat.com
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kvm/interrupt.c |   10 ++++++++++
 arch/s390/kvm/kvm-s390.c  |    2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1879,6 +1879,16 @@ int s390int_to_s390irq(struct kvm_s390_i
 	case KVM_S390_MCHK:
 		irq->u.mchk.mcic = s390int->parm64;
 		break;
+	case KVM_S390_INT_PFAULT_INIT:
+		irq->u.ext.ext_params = s390int->parm;
+		irq->u.ext.ext_params2 = s390int->parm64;
+		break;
+	case KVM_S390_RESTART:
+	case KVM_S390_INT_CLOCK_COMP:
+	case KVM_S390_INT_CPU_TIMER:
+		break;
+	default:
+		return -EINVAL;
 	}
 	return 0;
 }
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3958,7 +3958,7 @@ long kvm_arch_vcpu_async_ioctl(struct fi
 	}
 	case KVM_S390_INTERRUPT: {
 		struct kvm_s390_interrupt s390int;
-		struct kvm_s390_irq s390irq;
+		struct kvm_s390_irq s390irq = {};
 
 		if (copy_from_user(&s390int, argp, sizeof(s390int)))
 			return -EFAULT;


