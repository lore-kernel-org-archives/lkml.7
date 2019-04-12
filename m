Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9978BC282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6848E2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ka0UEP59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfDLKF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:05:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54178 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfDLKF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:05:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so10477199wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 03:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8B21jxwF8sZQNytLUqjosk49Ye95Q9ebb3aQMFPyxsM=;
        b=Ka0UEP59smKe0sxwNF6AQi5o9VRJHSz21ROarTFR8ppTUDcQPsdL6wmq0sJQbUKxVI
         aQ+QwQ3F5xFqJGAIIcUTjLqoCo/aHIPKYjvx2O4SEbOnZ474gLsvrq/dHx02oN3xjJMc
         TZ7JidDa1jX3JjFtmma9iFFPaJiT4hGrltiaBXm461jdAAgNTaWcNoGXGjvV5u/74rSi
         7X4qUrUcNur8qRIXm6AgKYaAK6CvGy5Hf2J5FTX2+co1ACVPwTao9kwsTuPWY++FBwWv
         8xNDpcxXXgiXimGfjFP8diOj+DBHB0huJSBLY46v8z72BUBr1PvNneSBVn+HPqZp2m+w
         W1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8B21jxwF8sZQNytLUqjosk49Ye95Q9ebb3aQMFPyxsM=;
        b=CDJW2rfsdF07I/NFvsBICrVytEYdkpOw4C59eqs+SckzikinqP8YhPn4SM5gTcvIw0
         gG3eYwv579otdrEcupD171IM78WUs/6/NEcy1vXbRu/5zzFRjkiv5XuiaD9zSEXUD/q5
         1/CSDbEDdPC/ClF2yN3OspnTkNUfDxYPBQZrtGDmk6t0An2ZYATiISGyy53N3twsTMrg
         dw3HblkRbHFuqE8Llqk76v7R8EypOeU3fe7h2/LEGkyduxoEhDsPr/Of96L9nvwmcP2S
         PIvufQ0ElMWrhsIE3k7lHndwQv2JEklrKkvQzL6ZQRGKrwn5urwjmcDwpYohpCno4Jus
         00/w==
X-Gm-Message-State: APjAAAV+G+dgFnHtB7YiCwD6uxxkGSwdRJkJ9v6ALvFXse+M7vXZYWJ9
        0zUelIP72WFnjYRrsh99K+LKrA==
X-Google-Smtp-Source: APXvYqwM9pxTGTOC2tGRZTwAwGjzv7HjH2I+QSHbXRzlXZULrRycBFSl14TsC6zfFsVlO/Y1NNv1EA==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr10679961wmc.76.1555063524348;
        Fri, 12 Apr 2019 03:05:24 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s10sm10545602wmh.0.2019.04.12.03.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 03:05:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: meson-g12a-u200: enable IR decoder
Date:   Fri, 12 Apr 2019 12:05:18 +0200
Message-Id: <20190412100518.24470-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412100518.24470-1-narmstrong@baylibre.com>
References: <20190412100518.24470-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the IR decoder input on the U200 Reference Design board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index cc86d6491af6..8dbf620affe6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -155,6 +155,12 @@
 	};
 };
 
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+};
+
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.21.0

