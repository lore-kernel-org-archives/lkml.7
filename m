Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E85C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEEF20885
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420793;
	bh=ETy3/oLlODMF6IqyyikE3r7NS0VCBoZzrTvaSa//SfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1P+oKK8adhUabCqdCr4KjWIS658qd9Gj0EG/3sf6ipcwPe9ou3QE/3muJeDyDpza7
	 pI0OR221CR80xFH+VBLsWk9VcD4fQFuqHj2wC2u26VSM4/4qtyJ0PkXazlYtV92+Wz
	 K7C8SV5gcZABVbVocZ00yr2sk+EJKZF3COczC4oA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbfKVLG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:06:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbfKVLGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:06:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF06520726;
        Fri, 22 Nov 2019 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420785;
        bh=ETy3/oLlODMF6IqyyikE3r7NS0VCBoZzrTvaSa//SfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Egb5sNNcgrNDeCyH8A5/piT2JXZ26um48yzOyjGmvHThTU0Nal5HXIAwt6QXunKtF
         OuOWjfoju1lqpWjhkRDSYigGr8/JdfGY/YEFtrwZcO5/YJ/nWIgIBB9u4VutgMWhNB
         VNpu6jQ0se9Bt+A0QRwyiK2WRSqyZAV9XoeMD1JQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 218/220] powerpc/time: Fix clockevent_decrementer initalisation for PR KVM
Date:   Fri, 22 Nov 2019 11:29:43 +0100
Message-Id: <20191122100929.297295181@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit b4d16ab58c41ff0125822464bdff074cebd0fe47 ]

In the recent commit 8b78fdb045de ("powerpc/time: Use
clockevents_register_device(), fixing an issue with large
decrementer") we changed the way we initialise the decrementer
clockevent(s).

We no longer initialise the mult & shift values of
decrementer_clockevent itself.

This has the effect of breaking PR KVM, because it uses those values
in kvmppc_emulate_dec(). The symptom is guest kernels spin forever
mid-way through boot.

For now fix it by assigning back to decrementer_clockevent the mult
and shift values.

Fixes: 8b78fdb045de ("powerpc/time: Use clockevents_register_device(), fixing an issue with large decrementer")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/time.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 6a1f0a084ca35..7707990c4c169 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -988,6 +988,10 @@ static void register_decrementer_clockevent(int cpu)
 
 	printk_once(KERN_DEBUG "clockevent: %s mult[%x] shift[%d] cpu[%d]\n",
 		    dec->name, dec->mult, dec->shift, cpu);
+
+	/* Set values for KVM, see kvm_emulate_dec() */
+	decrementer_clockevent.mult = dec->mult;
+	decrementer_clockevent.shift = dec->shift;
 }
 
 static void enable_large_decrementer(void)
-- 
2.20.1



