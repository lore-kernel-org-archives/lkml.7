Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320C0C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA1E20678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431174;
	bh=s4dJlHfvG3lTvGvTHMdUwLLQc2nWQ+zsBKgEgl7p50k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XF+297nA2OXo0WwIueSW6IEPgZxKQt+d0yLfIon4e3y/BDdTxQrt16yh2k70Z4c7V
	 aGUUyElmvYMgvT1e1/TC722RUyd3Yf5ARW0cAQV07Zd0/frFONpkrJVNeducnHboHp
	 xW0gyYFRDII4trdsXaNSA0kzVqXAL8xzO0Anw+zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgAGVGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:54584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729352AbgAGVGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:06:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA9FE20678;
        Tue,  7 Jan 2020 21:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431170;
        bh=s4dJlHfvG3lTvGvTHMdUwLLQc2nWQ+zsBKgEgl7p50k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KdemxxQi2IskTBrceczBOPeik8wVEsqdWtqf8Vj8HhqpoTDVyJ+449ZmhERbaBXwE
         flMsc1GcbRvSNgRImzs6N7xrlwqwW2c8H2YYrUzOez1zpPqH/VORUb88smkKmxsK65
         Xl5Jstdx51ovcc3929yZJikGIlpQMOLUKgdktUIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 045/115] ALSA: hda/realtek - Add headset Mic no shutup for ALC283
Date:   Tue,  7 Jan 2020 21:54:15 +0100
Message-Id: <20200107205302.088634775@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit 66c5d718e5a6f80153b5e8d6ad8ba8e9c3320839 upstream.

Chrome machine had humming noise from external speaker plugin at
codec D3 state.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/2692449396954c6c968f5b75e2660358@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -513,6 +513,7 @@ static void alc_shutup_pins(struct hda_c
 	struct alc_spec *spec = codec->spec;
 
 	switch (codec->core.vendor_id) {
+	case 0x10ec0283:
 	case 0x10ec0286:
 	case 0x10ec0288:
 	case 0x10ec0298:


