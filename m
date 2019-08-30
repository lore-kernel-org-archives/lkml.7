Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6618FC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBCF21670
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="qDdOmGkl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pq/kg7Yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfH3NYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 09:24:55 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38277 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727135AbfH3NYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 09:24:55 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id CEDC4216CA;
        Fri, 30 Aug 2019 09:24:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 30 Aug 2019 09:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=ZOc9QF1XymxW3TThIgoaBqoQxx
        9B1Byr0m0WbXALdyM=; b=qDdOmGklgM6I4mp1panEmbhQgcExvXkr5+hGR8R2o6
        1Vez34FQS8/ePkcUAFMI0enr//V+VjBxUWbvqR6+76w7evFBjMYHymGj4/4sWEQU
        AuojrZjwt8E5mb2BIdJMa8Wlhqv6pmDEHtm/Mn7cebfij2QyqG494vGrDeIFe5kG
        Z+tuSvxt+MJnASxsK2WXL6zb694XHUG69fn0WTdMJa7LiceCPUizW5eyBpHmmjNq
        yhFE4Bbezu+Ut7LhunVx9Zwl0bf6mj4y2sYN0/ASXp/yqG98dX3CaLIHfsX8kDij
        D2Xh6wWm7bqDiUZaAqglyJtKYghQctsUT0UvWNIbS63w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZOc9QF1XymxW3TThI
        goaBqoQxx9B1Byr0m0WbXALdyM=; b=pq/kg7YcvTVNQycv6Qhe6z9rENNssGsv8
        Pq3ES9eftm84D62HQxn0v1Ph0/YK0WlznoBrhqh3OEACOI0ynGqwUKIbBiXm6CD5
        D4H2GwL99GuiSTDR4I282Y44Sbi28gOauZ3A6dadOZM/IztkOJA1p6MAA4VB6UoT
        CM6nrsqrXvg/Rs+rqZOhpBc+rZDwrPR542VpYyck17V6b0ztYe3pjxKXkK/7m4oM
        QW77d0ZQljJXJqppo7DOH/Devo5p5enIZMn8CXXwjxHd89H5OoT9tq6kR2HRhPCH
        s4hr9LkwZUAemSLTZFzwu09bHv073hJXdabQEzC4hnHQcNA2e11Xw==
X-ME-Sender: <xms:pCNpXZloFqCOHncUh7uMVRr78On8q-12xa807MTL_zHW5sIyTMV5kA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeigedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucfkphepudegrdefrdejhedrudekudenucfrrghrrghmpehmrghilhhfrhhomhepohdq
    thgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphenucevlhhushhtvghrufhiiigvpe
    dt
X-ME-Proxy: <xmx:pCNpXe5e3bjKd5N115lHBgc6osDA2JBMjXp13-gxMkxaeo3M6g8MRA>
    <xmx:pCNpXfiazfQAYpA1sfjqrHOCarJCp324Zqe7YDIOSaDUWeS4OHLZbg>
    <xmx:pCNpXbHGzm8PIj8kalZ8J5KIussaj1NdDdssW7oFIGHdw5tfVXE1Mg>
    <xmx:pSNpXbbdEtnmES80RSjZP-VwXVy8i_3tScO7vd02ReXBtmZgC91muw>
Received: from workstation.flets-east.jp (ae075181.dynamic.ppp.asahi-net.or.jp [14.3.75.181])
        by mail.messagingengine.com (Postfix) with ESMTPA id AA446D6005E;
        Fri, 30 Aug 2019 09:24:50 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     clemens@ladisch.de, tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update entry of firewire audio drivers
Date:   Fri, 30 Aug 2019 22:24:46 +0900
Message-Id: <20190830132446.5154-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds myself as one of maintainers for firewire audio
drivers and IEC 61883-1/6 packet streaming engine. I call them ALSA
firewire stack as a whole.

6 years ago I joined in development for this category of drivers with
heavy reverse-engineering tasks and over 100 models are now available
from ALSA applications. IEEE 1394 bus itself and units on the bus are
enough legacy but the development still continues.

I have a plan to add drastic enhancement in kernel v5.5 and v5.6 period.
This commit adds myself into MAINTAINERS so that developers and users
can easily find active developer to post their issues, especially for
regression.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 24e29b2e53c9..8929a2ec75f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6264,8 +6264,9 @@ S:	Maintained
 F:	drivers/hwmon/f75375s.c
 F:	include/linux/f75375s.h
 
-FIREWIRE AUDIO DRIVERS
+FIREWIRE AUDIO DRIVERS and IEC 61883-1/6 PACKET STREAMING ENGINE
 M:	Clemens Ladisch <clemens@ladisch.de>
++M:	Takashi Sakamoto <o-takashi@sakamocchi.jp>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 S:	Maintained
-- 
2.20.1

