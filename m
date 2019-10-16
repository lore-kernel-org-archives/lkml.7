Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF98ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C61218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263262;
	bh=8UGPLitatbar9lY0sjf93t5sfez5gmzeYrIzRwk1FOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CY7ujOZUxvSWpaRLrbZQrr5G99Ao37kUNppB6qttM2NmsO16lyfUaRG1rEqQ52q+T
	 YRwo3Qt4ZpZWoCVwre969iKmjpYOfvSGvDmD1NXOm5/eqlGFAPOa7rzxLzzkLGLjhw
	 hc1RrgOvkIu/Th9WPaobDACfSDRPnY3CcX/TMKiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438930AbfJPWBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438617AbfJPV7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:59:45 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F20021D7A;
        Wed, 16 Oct 2019 21:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263185;
        bh=8UGPLitatbar9lY0sjf93t5sfez5gmzeYrIzRwk1FOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItGA3SQVUV1HsJYHNgwcGdu5PSWHc/xWSV4W9pkumqJ613rY3uk3Yfw4dRbB6f1eb
         R8MzL/XXbShhiXbEQjClyB+o8Qxnzi/5kIwr16ZLfSlFCVe2jlcmvLHem2xEiYx0cx
         SAXx+N8cQivvhXBeyGnEDh9dRHJGCiXjx615Zyds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.3 112/112] ASoC: sgtl5000: add ADC mute control
Date:   Wed, 16 Oct 2019 14:51:44 -0700
Message-Id: <20191016214907.599726506@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

commit 694b14554d75f2a1ae111202e71860d58b434a21 upstream.

This control mute/unmute the ADC input of SGTL5000
using its CHIP_ANA_CTRL register.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Link: https://lore.kernel.org/r/20190719100524.23300-5-oleksandr.suvorov@toradex.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/sgtl5000.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -720,6 +720,7 @@ static const struct snd_kcontrol_new sgt
 			SGTL5000_CHIP_ANA_ADC_CTRL,
 			8, 1, 0, capture_6db_attenuate),
 	SOC_SINGLE("Capture ZC Switch", SGTL5000_CHIP_ANA_CTRL, 1, 1, 0),
+	SOC_SINGLE("Capture Switch", SGTL5000_CHIP_ANA_CTRL, 0, 1, 1),
 
 	SOC_DOUBLE_TLV("Headphone Playback Volume",
 			SGTL5000_CHIP_ANA_HP_CTRL,


