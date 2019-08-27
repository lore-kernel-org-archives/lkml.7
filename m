Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FECBC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58113217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CfWqhHro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfH0KDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 06:03:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43231 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfH0KDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:03:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8so18136295wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 03:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N3scpKO0Zzh4GV7gMEeSkZMIk4JwmB5WDbAZocPSw5A=;
        b=CfWqhHrooMAEoQGPlWt04PkQ0BwbFh9AB3BKZNcewA4CorL6RgjmekMXMp1JiAtJTQ
         1zvucYfsGTz5RTGEiC5UAg4uzv+sHB1bTLWOZmoDFuECJmIFdp4gCsmgd/NjVeC4g+e1
         gbWDLHUm9Gi2TWhmFoOrWwGAQeV1PQodjiqQN3zDRdptMCzai2iXaFnznGYJOqWa8GgR
         32NkepzHCO4QF1RaPf5KifZxphB5ayEx0vdsxmOZSb/K2h+TgP7tktAvlPj1Vzin3JF0
         tLNNx9+d0nacz1GPOPsa9g0U9Fs/veRzp69CAUO4bC+ITLOzukAMPPheKbIwwij9DgaR
         6y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3scpKO0Zzh4GV7gMEeSkZMIk4JwmB5WDbAZocPSw5A=;
        b=sUdy31/k46nZyD91KT86VpOeF1DKWaJPlfsksAYBSaInLDbR+q/wyqtQHfnX5hRoIn
         t2Bd/scGp0O/EwKZTIIx1XQnN05PvraYxOMjeVpP4IOJ3OSxGZHea+RoxLYYw20/tT+l
         ywSNWJWijC8ZugLOx3X+dbuTgcWjOKspGfv0aOP8cf2o9LBz3N8JmZzndQ8OCoJo4k8h
         8u+uAwqk+IBAXlUqRU4tyLWUkkk/a4BHFkarKp8pwnXAPBxQ0hvEe9ySkSU046GgtiSU
         ug1ZDCzniG274Lh7N23aluWijDTArRPwnw7/Wy5jCqm5USPOKGJDIJi56fnZKZbWsGFX
         Cb7w==
X-Gm-Message-State: APjAAAUrYhGO8JHhti23bCxnPlnUIfeTIVBioWNdt4+7O6ecGsbqLcmI
        F/4B6jZjV3wE8DzW/3jW/TW/lg==
X-Google-Smtp-Source: APXvYqz+ibjedBMsj+QgbZe3C3ACpAVhv4R3ODBxrUkdq28jETkegrCPCSVUALS3zqKZzfnd7/IouQ==
X-Received: by 2002:adf:a2cd:: with SMTP id t13mr26526511wra.251.1566900191587;
        Tue, 27 Aug 2019 03:03:11 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o25sm1816289wmc.36.2019.08.27.03.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 03:03:11 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/3] arm64: dts: meson-g12a: specify suspend OPP
Date:   Tue, 27 Aug 2019 12:03:05 +0200
Message-Id: <20190827100307.21661-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190827100307.21661-1-narmstrong@baylibre.com>
References: <20190827100307.21661-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag the 1,2GHz OPP as suspend OPP to be set before going in suspend mode.

It has been reported that using various OPPs can lead to error or
resume with a different OPP from the ROM, thus use this safe OPP as
it is the default OPP used by the BL2 boot firmware.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 733a9d46fc4b..57c880c06a07 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -81,6 +81,7 @@
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <731000>;
+			opp-suspend;
 		};
 
 		opp-1398000000 {
-- 
2.22.0

