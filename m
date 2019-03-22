Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE86C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A1C2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258972;
	bh=2h6ZU8jygn12nBYYtowqaDdEIvNt52X6nSvw4C/WooY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j2e4mRTUctQq1QEZSOkfAivaYMTLGVJGs6rtmseb2Sqj1yZPjXrNfgIqe6k2xLEhe
	 XjjS4AmNoUqcUX7tR6Gh7aTOHtaS8DNaHlgY3cmIVM4YYOTqJfMM7SMQ1PiD5saWh/
	 6tdgnr5V5N/dDHER6BBvOx1LclkhJtUDK6HRdPDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbfCVL44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732560AbfCVL4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:56:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E5252195D;
        Fri, 22 Mar 2019 11:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255811;
        bh=2h6ZU8jygn12nBYYtowqaDdEIvNt52X6nSvw4C/WooY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rs9WsfP03c88ZmID+NMEnEvDSu7ij3poVjiHzDfPZT0oKiQyQGHM0nVjkEkPeU6f/
         /3Eaq0p1w0XNW9+lAO8OH/vBGR0tOCfQ2Go2pwrYuPXNqp/6ceudwI2B/W7ct4IvID
         ZW16yh99u5/UQ+IM1UnCXiPez9A8Vbfs4OYGdmlA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 005/280] ASoC: codecs: pcm186x: fix wrong usage of DECLARE_TLV_DB_SCALE()
Date:   Fri, 22 Mar 2019 12:12:38 +0100
Message-Id: <20190322111306.648242394@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


