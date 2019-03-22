Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC990C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC40B20830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256738;
	bh=SnVD/eR8xg31yLvxM6GYWPhra0WTpc0/RI95NEO40us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c52oR0CTMeKOCqfva30/mnMkVM+53rqc4Gck7dM4qty8bf/HjBfh+VvK5eDkV9ELd
	 hJTBVgPukfvhIRcKPjMnU+bCqSmhL9PfIArkj8x4gnMVER+YpJxeh12NfwWnLtWVR1
	 0hqyhmS1jNrl+63wv1YltclKzSQC0RSgMVcWe7+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389318AbfCVMMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389128AbfCVMMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:12:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 153D721929;
        Fri, 22 Mar 2019 12:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256732;
        bh=SnVD/eR8xg31yLvxM6GYWPhra0WTpc0/RI95NEO40us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bv8X1Kj79LUXW3SIxMyJt3zjcSgf8672e2yVTQN9T/th6I8CQUrUr+0yXTNnGlEN3
         UYgEJaYAn+K/HhTYLfiO1pNAL90uWZyKrOWA0Q2Wed+k/fILMLL66hbSlubUS/NbYD
         e7OvoYTvpsjb/qJH/UjO9ky9A1sztpBc5PYkVRvQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.0 004/238] ASoC: codecs: pcm186x: fix wrong usage of DECLARE_TLV_DB_SCALE()
Date:   Fri, 22 Mar 2019 12:13:43 +0100
Message-Id: <20190322111258.597234748@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

commit fcf4daabf08079e6d09958a2992e7446ef8d0438 upstream.

According to DS, the gain is between -12 dB and 40 dB, with a 0.5 dB step.
Tested on pcm1863.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Acked-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/pcm186x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/codecs/pcm186x.c
+++ b/sound/soc/codecs/pcm186x.c
@@ -42,7 +42,7 @@ struct pcm186x_priv {
 	bool is_master_mode;
 };
 
-static const DECLARE_TLV_DB_SCALE(pcm186x_pga_tlv, -1200, 4000, 50);
+static const DECLARE_TLV_DB_SCALE(pcm186x_pga_tlv, -1200, 50, 0);
 
 static const struct snd_kcontrol_new pcm1863_snd_controls[] = {
 	SOC_DOUBLE_R_S_TLV("ADC Capture Volume", PCM186X_PGA_VAL_CH1_L,


