Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069BAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C796A21783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497326;
	bh=hsj6mtJD8TKRNhJwMDJL0ulHgOWI8gc8BwKJnbp9dbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LEXwQ7ceRfTy/EpnUV0Bk5I1T3CxOzfUSCqS1LgTYrshaLfweN9CW1zq14bSy3eKS
	 brFfx42s6om4fK6AhmEiuJbxGEcPPkhDMqAoKALZF5XRzopGQs8nrJ2LY6zzCqNmmb
	 afNZkO7g/8c72VDr1sUT3uX9+q5m9FBeNFAGoeRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfKKSfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:35:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:53190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbfKKSfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:35:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3E0E20659;
        Mon, 11 Nov 2019 18:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497319;
        bh=hsj6mtJD8TKRNhJwMDJL0ulHgOWI8gc8BwKJnbp9dbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0S11cF0PFK5PcJFSZPrItxu4THOXUOoq8zmSLoIp7a1aOp+0Ng9EVVag+QiDJ85i
         l9qOVFY5dOSlpWmrT9vPeWzdnxPPFmZlzCUGYqu0vNizBqO5Falxe2qhehFZyTITXk
         BAhKls4D26A+UpHIqgMQYbIwXou5iA/cZWUGHx7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 013/105] ALSA: bebob: fix to detect configured source of sampling clock for Focusrite Saffire Pro i/o series
Date:   Mon, 11 Nov 2019 19:27:43 +0100
Message-Id: <20191111181429.323338125@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181421.390326245@linuxfoundation.org>
References: <20191111181421.390326245@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 706ad6746a66546daf96d4e4a95e46faf6cf689a upstream.

For Focusrite Saffire Pro i/o, the lowest 8 bits of register represents
configured source of sampling clock. The next lowest 8 bits represents
whether the configured source is actually detected or not just after
the register is changed for the source.

Current implementation evaluates whole the register to detect configured
source. This results in failure due to the next lowest 8 bits when the
source is connected in advance.

This commit fixes the bug.

Fixes: 25784ec2d034 ("ALSA: bebob: Add support for Focusrite Saffire/SaffirePro series")
Cc: <stable@vger.kernel.org> # v3.16+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20191102150920.20367-1-o-takashi@sakamocchi.jp
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/bebob/bebob_focusrite.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/firewire/bebob/bebob_focusrite.c
+++ b/sound/firewire/bebob/bebob_focusrite.c
@@ -28,6 +28,8 @@
 #define SAFFIRE_CLOCK_SOURCE_SPDIF		1
 
 /* clock sources as returned from register of Saffire Pro 10 and 26 */
+#define SAFFIREPRO_CLOCK_SOURCE_SELECT_MASK	0x000000ff
+#define SAFFIREPRO_CLOCK_SOURCE_DETECT_MASK	0x0000ff00
 #define SAFFIREPRO_CLOCK_SOURCE_INTERNAL	0
 #define SAFFIREPRO_CLOCK_SOURCE_SKIP		1 /* never used on hardware */
 #define SAFFIREPRO_CLOCK_SOURCE_SPDIF		2
@@ -190,6 +192,7 @@ saffirepro_both_clk_src_get(struct snd_b
 		map = saffirepro_clk_maps[1];
 
 	/* In a case that this driver cannot handle the value of register. */
+	value &= SAFFIREPRO_CLOCK_SOURCE_SELECT_MASK;
 	if (value >= SAFFIREPRO_CLOCK_SOURCE_COUNT || map[value] < 0) {
 		err = -EIO;
 		goto end;


