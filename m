Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1FFC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E931820830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570123795;
	bh=Qrmdlh54a97G3v74uvBNhghLzDukho25jehHop0KfnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=na4bxNNnFbk7hGVFlhNYOfbasKHkjgUVo+gerwfgV/veQ9RI5Zj0A8uB3zoKUYnVm
	 eQtYjsjAjQKtReKBqjem2uRvgecoDHPPtGGiceER+tWPwlAx0UPwXGym1QDUHPNtz4
	 o29QWSyT2kDb7Z0Yj0KyxWhla315DeZm1n6Kietc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388021AbfJCQMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387998AbfJCQMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:12:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2782A20865;
        Thu,  3 Oct 2019 16:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119136;
        bh=Qrmdlh54a97G3v74uvBNhghLzDukho25jehHop0KfnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWN8bsHaDFzg3vLzbW6JWG9imlqHoIlXVrZ761PyrVYmolWh2IJJe6yvtE5C/NUDJ
         S0cBUPrRhLkeLSnJ9R9AjKlKWq9naoUedXxz2SedYMchcF8Ui3rKhY0/Tv9swUXK1n
         iEaPnG7qwaD6ftJLbANGE7yrjVRZHZE+c5bVQhrs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 140/185] ALSA: firewire-tascam: handle error code when getting current source of clock
Date:   Thu,  3 Oct 2019 17:53:38 +0200
Message-Id: <20191003154509.157505574@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 2617120f4de6d0423384e0e86b14c78b9de84d5a upstream.

The return value of snd_tscm_stream_get_clock() is ignored. This commit
checks the value and handle error.

Fixes: e453df44f0d6 ("ALSA: firewire-tascam: add PCM functionality")
Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20190910135152.29800-2-o-takashi@sakamocchi.jp
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/tascam/tascam-pcm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/firewire/tascam/tascam-pcm.c
+++ b/sound/firewire/tascam/tascam-pcm.c
@@ -57,6 +57,9 @@ static int pcm_open(struct snd_pcm_subst
 		goto err_locked;
 
 	err = snd_tscm_stream_get_clock(tscm, &clock);
+	if (err < 0)
+		goto err_locked;
+
 	if (clock != SND_TSCM_CLOCK_INTERNAL ||
 	    amdtp_stream_pcm_running(&tscm->rx_stream) ||
 	    amdtp_stream_pcm_running(&tscm->tx_stream)) {


