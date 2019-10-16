Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34D2FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F1D2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264348;
	bh=t5SabUBL58cN4oJLeCIcShWn59cDVugH9Hne/Pi4n7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GAzsn2qXZIRO6K/LAJ5D/M5+Q5FxT8L4CjBHuPJyekB6HNa//GQ84uTmdQ2kk+Lvv
	 p1v6wANO+PoZ7G+Q89cDTxuEnfVLieVjLk5woq/iAyZjRq1pnlmy1rK+9aPX6dpAFD
	 0KAzl2+9aRc5q9tXGj6hPQuwJyu+jJJNeeMWWXQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394949AbfJPVyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437656AbfJPVyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:54:04 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A11F21D7A;
        Wed, 16 Oct 2019 21:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262843;
        bh=t5SabUBL58cN4oJLeCIcShWn59cDVugH9Hne/Pi4n7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zc1m7GtX/nqhoB4KdqfE9jlNHRZ8E292RLQbpBqTjDkPjRlfNOFuwvjC2rYdVVpLH
         JWTpvFNa2e29GoRw6Va8a4o5wvoXHQURTsuStqS4PUrgqYcvKK3wILff/dEuJbHWXS
         woWPMRsZshyTFc+MP0MPHIej1RjyLEe9x2P9xwtk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4.9 01/92] KVM: s390: Test for bad access register and size at the start of S390_MEM_OP
Date:   Wed, 16 Oct 2019 14:49:34 -0700
Message-Id: <20191016214800.188301016@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Huth <thuth@redhat.com>

commit a13b03bbb4575b350b46090af4dfd30e735aaed1 upstream.

If the KVM_S390_MEM_OP ioctl is called with an access register >= 16,
then there is certainly a bug in the calling userspace application.
We check for wrong access registers, but only if the vCPU was already
in the access register mode before (i.e. the SIE block has recorded
it). The check is also buried somewhere deep in the calling chain (in
the function ar_translation()), so this is somewhat hard to find.

It's better to always report an error to the userspace in case this
field is set wrong, and it's safer in the KVM code if we block wrong
values here early instead of relying on a check somewhere deep down
the calling chain, so let's add another check to kvm_s390_guest_mem_op()
directly.

We also should check that the "size" is non-zero here (thanks to Janosch
Frank for the hint!). If we do not check the size, we could call vmalloc()
with this 0 value, and this will cause a kernel warning.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Link: https://lkml.kernel.org/r/20190829122517.31042-1-thuth@redhat.com
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kvm/kvm-s390.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3033,7 +3033,7 @@ static long kvm_s390_guest_mem_op(struct
 	const u64 supported_flags = KVM_S390_MEMOP_F_INJECT_EXCEPTION
 				    | KVM_S390_MEMOP_F_CHECK_ONLY;
 
-	if (mop->flags & ~supported_flags)
+	if (mop->flags & ~supported_flags || mop->ar >= NUM_ACRS || !mop->size)
 		return -EINVAL;
 
 	if (mop->size > MEM_OP_MAX_SIZE)


