Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C85C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60B521743
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918302;
	bh=DWibo/aJh4AAodUHDgO+L5KNjhDwqYb3UZ8Bd9YCGRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xdFwT3AUrkkbKREDTNfGsn7DM1WWE54KBrN5JOYpF3+GvP9ljui7sg493fgGNn1Eo
	 nSHtkyCelLs6RWFuSj+RpTGY7z8/C2ZNscbw6V+wJSp6dL5hYH6mwIkOUinydpQd2x
	 vbHKZ20CMPxh5WLILxqBi1yGcdWj3J4bNsPMNWB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfEOLFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbfEOLE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:04:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 665EC2173C;
        Wed, 15 May 2019 11:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918297;
        bh=DWibo/aJh4AAodUHDgO+L5KNjhDwqYb3UZ8Bd9YCGRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z5CHwpLiwAoPUPBD0l9/iZs9bJ40qoD3Ev8pwJOdOdjd7rubk4wbCGGi1g4QhdrXI
         i9CfPNHiFE/B/mG8dZvYFEirPXIezs5YQ3I38P1VAld9FupAPAvfP3DQEE5++3CbpC
         bTEE6knLrg9ePFnzjITdmT+6vjeoaNZGHh5AbT28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, Diana Craciun" 
        <diana.craciun@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Diana Craciun <diana.craciun@nxp.com>
Subject: [PATCH 4.4 081/266] powerpc/fsl: Emulate SPRN_BUCSR register
Date:   Wed, 15 May 2019 12:53:08 +0200
Message-Id: <20190515090725.183169160@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Diana Craciun <diana.craciun@nxp.com>

commit 98518c4d8728656db349f875fcbbc7c126d4c973 upstream.

In order to flush the branch predictor the guest kernel performs
writes to the BUCSR register which is hypervisor privilleged. However,
the branch predictor is flushed at each KVM entry, so the branch
predictor has been already flushed, so just return as soon as possible
to guest.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
[mpe: Tweak comment formatting]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kvm/e500_emulate.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -277,6 +277,13 @@ int kvmppc_core_emulate_mtspr_e500(struc
 		vcpu->arch.pwrmgtcr0 = spr_val;
 		break;
 
+	case SPRN_BUCSR:
+		/*
+		 * If we are here, it means that we have already flushed the
+		 * branch predictor, so just return to guest.
+		 */
+		break;
+
 	/* extra exceptions */
 #ifdef CONFIG_SPE_POSSIBLE
 	case SPRN_IVOR32:


