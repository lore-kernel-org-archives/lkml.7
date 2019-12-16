Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7A0C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF09206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519000;
	bh=RARFCDjsWk3oIy7ZHkpustOzA5dM86R+xpwqdoBpGK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fWOqvh4h2/b2D4E12/jDBDohC4skE3oFeX2i3+hfo4Q39OFqw6Z3Bk+xGcTZdW76n
	 rb/f0EZ2t+Za1wdT+d2DZvkaS+I8xo0beqrDYU3Ob7nMiuAlsH/vc5FhTSRYb+UDC6
	 XqBZB4jCNreue6y80HUM3+yGo+AOahMk016JycCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfLPR4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:56:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbfLPR4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:56:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46391205ED;
        Mon, 16 Dec 2019 17:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518995;
        bh=RARFCDjsWk3oIy7ZHkpustOzA5dM86R+xpwqdoBpGK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xw0Rc8wRlUHL3riVXmfzKtGnk4+BHWp2Eo9QgYdMsmPmr5odxCwYb0Zb5cI82eW1i
         njZImAp/yzJieKJGl7vswQfSmL01OObTfU+GsW7LUdz0ufN276dcHFLq6bg3xoRfAX
         Q+1MuR03rzf+cQkYJJI0fVdhN4RS24FmAVn7O8Ck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiada Wang <jiada_wang@mentor.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 4.14 153/267] ASoC: rsnd: fixup MIX kctrl registration
Date:   Mon, 16 Dec 2019 18:47:59 +0100
Message-Id: <20191216174910.878531863@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 7aea8a9d71d54f449f49e20324df06341cc18395 upstream.

Renesas sound device has many IPs and many situations.
If platform/board uses MIXer, situation will be more complex.
To avoid duplicate DVC kctrl registration when MIXer was used,
it had original flags.
But it was issue when sound card was re-binded, because
no one can't cleanup this flags then.

To solve this issue, commit 9c698e8481a15237a ("ASoC: rsnd: tidyup
registering method for rsnd_kctrl_new()") checks registered
card->controls, because if card was re-binded, these were cleanuped
automatically. This patch could solve re-binding issue.
But, it start to avoid MIX kctrl.

To solve these issues, we need below.
To avoid card re-binding issue: check registered card->controls
To avoid duplicate DVC registration: check registered rsnd_kctrl_cfg
To allow multiple MIX registration: check registered rsnd_kctrl_cfg
This patch do it.

Fixes: 9c698e8481a15237a ("ASoC: rsnd: tidyup registering method for rsnd_kctrl_new()")
Reported-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-By: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/sh/rcar/core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1279,14 +1279,14 @@ int rsnd_kctrl_new(struct rsnd_mod *mod,
 	int ret;
 
 	/*
-	 * 1) Avoid duplicate register (ex. MIXer case)
-	 * 2) re-register if card was rebinded
+	 * 1) Avoid duplicate register for DVC with MIX case
+	 * 2) Allow duplicate register for MIX
+	 * 3) re-register if card was rebinded
 	 */
 	list_for_each_entry(kctrl, &card->controls, list) {
 		struct rsnd_kctrl_cfg *c = kctrl->private_data;
 
-		if (strcmp(kctrl->id.name, name) == 0 &&
-		    c->mod == mod)
+		if (c == cfg)
 			return 0;
 	}
 


