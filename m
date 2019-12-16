Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BCAC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA2D20684
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521447;
	bh=Tgt3hYhn2Vbxqxu5CwkS5iRqCOUt0A3BTITnlSbICao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ef0mK1JrgCIxticfawKb2RQj+ZttvyfFYTSVKNB5FQUX17hg2Eg84ep+tbY5ezGbd
	 1iW0zXYB+KsEGx6DH/jMZJc52vu/a1ybOPUludvTxfvcLXvvWfqvpMVR35/4k5qTdX
	 6+Yv13HtAX3lFSKGicv0dzRvVEDUvNzm4SMzdh8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfLPShZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:37:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729953AbfLPSGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:06:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1A782072B;
        Mon, 16 Dec 2019 18:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519577;
        bh=Tgt3hYhn2Vbxqxu5CwkS5iRqCOUt0A3BTITnlSbICao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YVcZ2C67IKL3HChYGwD86I/MpQnddJVxfeRIP2LVUgtnBpNat93CCsItJaDScaeUF
         mnwvRcv/2MwcfK10nng+M7BFdGiKKQ8p/XM0Psz44h+Yp5iF58uJrKcD2S9ASx508p
         SutISMlXeCgjqktFvr43LqY8XCB4nemfLDRa6u/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shirish S <shirish.s@amd.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        x86-ml <x86@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 122/140] x86/MCE/AMD: Turn off MC4_MISC thresholding on all family 0x15 models
Date:   Mon, 16 Dec 2019 18:49:50 +0100
Message-Id: <20191216174822.819543339@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shirish S <Shirish.S@amd.com>

[ Upstream commit c95b323dcd3598dd7ef5005d6723c1ba3b801093 ]

MC4_MISC thresholding is not supported on all family 0x15 processors,
hence skip the x86_model check when applying the quirk.

 [ bp: massage commit message. ]

Signed-off-by: Shirish S <shirish.s@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1547106849-3476-2-git-send-email-shirish.s@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index fee118b3b69fd..a0bc7f7570814 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1632,11 +1632,10 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 			mce_flags.overflow_recov = 1;
 
 		/*
-		 * Turn off MC4_MISC thresholding banks on those models since
+		 * Turn off MC4_MISC thresholding banks on all models since
 		 * they're not supported there.
 		 */
-		if (c->x86 == 0x15 &&
-		    (c->x86_model >= 0x10 && c->x86_model <= 0x1f)) {
+		if (c->x86 == 0x15) {
 			int i;
 			u64 hwcr;
 			bool need_toggle;
-- 
2.20.1



