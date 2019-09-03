Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10484C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB9C22D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Ht/45pru";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kH/Bhwil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfICPBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:01:48 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41299 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728992AbfICPBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:01:47 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0D7DD220E1;
        Tue,  3 Sep 2019 11:01:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 03 Sep 2019 11:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=GYEKrkGFe+6PHocrT18QLbwFvs
        Cty7iXKZ8NZtXqtBQ=; b=Ht/45pruw/MCgLjRSBXyJl18S+KQSa7MiGrSRvn+Nc
        btaT3lz6016YewNRrwI2+frNi5o1LvlvuLiH+Vs/bomlX9+sfg/A+fbjXW+lyG/x
        MfBGP6pHSN2jLLxEHZdnAFJ6fJyek0LA++47YruaJ/0uIxgCZSLD74WmcGAeJh9p
        Wrv2ygiHl89vAat1h+aMLCkAWw8Arli2eKotTEuWY20AtL2cKlRY6WEcCYKjzec8
        7c7w3CpH4P70ux5qM90qNsu9L948OEOTa+hmPlTin2SduMTyRNA3TJK8a/894JPh
        J9vjOe6sxwXWdeorIXlJUUZjIm0jbx0oQP67lP8cPXVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GYEKrkGFe+6PHocrT
        18QLbwFvsCty7iXKZ8NZtXqtBQ=; b=kH/BhwilQ75ZwTtepb2dlIGPlTuCs3dxo
        1iKrXPzbswMzGikRdJk5LGWudUQwnwzZQrEGfb363A5Kmfj5kaPS/Er5qy0KDnkv
        +BLCjA699AxqLDChmopkrwztWCvLV9LIzXxTAsYCfmWz9Wjdkcgx8Q5wL/maIaXn
        LyIDoJujmtW7vzuT8NrF1asLv2IBml0sz/n7MSGpwNWb377fdXLmk4Z6oY/7J3H+
        kOton5m07wZIMjtopTT3GsKQxUYsOuEFN2JmxVgb5Kalik5NG3+sGZEV+S9vRFYn
        OHv+Wuwtg7PnI1vNfojkme/UX8HcXA5vTAK9ZUmbePQKr8foXeMHQ==
X-ME-Sender: <xms:WoBuXX7aS5yJJ0niYHZGIF0XMLmo6sa83lUjJcddFI5ztUaoQHb1OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudejfedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucfkphepudegrdefrdejhedrudekudenucfrrghrrghmpehmrghilhhfrhhomhepohdq
    thgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphenucevlhhushhtvghrufhiiigvpe
    dt
X-ME-Proxy: <xmx:WoBuXRzP-i-Ay9TrXrLbdB9ufVmt8u5_uyT-PYITtyH7Wi4tQdOemw>
    <xmx:WoBuXQ3XgNLnXwHgOwhZbJ5XnGydTM0uutLufJ9E7ZXYO4SFtfGgkQ>
    <xmx:WoBuXWLlAU6KMBsTiUSVEu9NKpDqudhJCCtwQ4dlVoxsVDSEt3y-fA>
    <xmx:WoBuXbG10obOHxnMPqHIPY0Mmu4pIqI5EJOTdKAhNf3YdVyqAdSVjA>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp [14.3.75.181])
        by mail.messagingengine.com (Postfix) with ESMTPA id CC01BD60065;
        Tue,  3 Sep 2019 11:01:44 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     clemens@ladisch.de, tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update entry for firewire audio drivers with UAPI header
Date:   Wed,  4 Sep 2019 00:01:41 +0900
Message-Id: <20190903150141.24484-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The most of drivers in ALSA firewire stack supports common ioctl commands
to enable/disable packet streaming as well as some ioctl commands for
model-specific features. An UAPI header is exported to userspace.

This commit adds supplement for entry of ALSA firewire stack with a path
of the UAPI header.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4200194e69ea..6bd54ce6dc66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6271,6 +6271,7 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 S:	Maintained
 F:	sound/firewire/
+F:	include/uapi/sound/firewire.h
 
 FIREWIRE MEDIA DRIVERS (firedtv)
 M:	Stefan Richter <stefanr@s5r6.in-berlin.de>
-- 
2.20.1

