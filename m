Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E023C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE982171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="t3TeMuZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfDLKFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:05:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39038 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfDLKFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:05:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so10263052wmk.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 03:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9oRU67TXfzeCkq2JVzW+KPcLdM2vd0o+Xe4sIhUQ0Y=;
        b=t3TeMuZJhreM+IMmCK7XXWabF0K1fk+4iC5ZqaPY4p4ZZJX0RMYZ5L10jL4Gz3lbm2
         wAh+T9S9lDdw38kSJ/r6OmUrrFNpNwb/NYi6d+kJB5JCKzu9xlYoZ9w0eM3S3Yj3eiqd
         D/7crDj4jOqvOnkWolbZVhzDKE3/BmOLWzC3aRy48MsPqIGx/L3DD+FKePXHV6MGvA7i
         lwQGa7KklkaMuqsgVpxlAbRthGrXYaDgkObHWK+9RVXvNe6EfVWcj6vEfyuwS2a1m4wD
         6nBCdgnAjsNlPiujTVM3gct3LkH7plsMwYXDOuwzJKMe7v8RWdxtegizwALlB9DNAiLG
         uApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9oRU67TXfzeCkq2JVzW+KPcLdM2vd0o+Xe4sIhUQ0Y=;
        b=tCi1oGnU0xgqCQ+rx+u8fSuOZsUWkG5dYL+sqtwdqZvTu/fFf/JGd25MOL0ZzozRDG
         1VpCwxhA2ZWAvHfjeY758VUfVu+bsNIp+VNZMSvVseeq98McEyqTfEJuNarQhM05Z/EN
         pkcm2wpoFLO4u03ptFcpqz/s6YiOwfW7KShCjp/D86q4dkPjMifT14RVMWBnWb1X7aPL
         p45G/kg5bJRhQFYPY/ujMvU165yoovawWjTt20hb5kbsX1objoUaOssrK+id5O2wOiev
         q68j8k/6gJV0udK89PFZ5oNCKEWiUdYxFEwbaXH+8hmMuZ4GW0DSotfVxlwvroP5bvE4
         0ujw==
X-Gm-Message-State: APjAAAWGkCjKBwjKaZde4kHAj118HcUG5krvaacNdQN4maNgogkA5pf0
        au2pdG6MFGtYFk8wS1YThaLPSc2695/H1Zxi
X-Google-Smtp-Source: APXvYqzvCkhWmt4EPwvJ6bwcIPF7UffB7hQRZHVhI03hbEURPw95CowtQWLw6eN3XaZd24YmaaKqeQ==
X-Received: by 2002:a1c:a00a:: with SMTP id j10mr10997480wme.15.1555063520140;
        Fri, 12 Apr 2019 03:05:20 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s10sm10545602wmh.0.2019.04.12.03.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 03:05:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: meson-g12a: Add Infrared Decoder support
Date:   Fri, 12 Apr 2019 12:05:15 +0200
Message-Id: <20190412100518.24470-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Infrared Decoder support for the Amlogic G12A and enable it on the
X96 Max and U200 Reference Design boards.

Neil Armstrong (3):
  arm64: dts: meson-g12a: Add IR nodes
  arm64: dts: meson-g12a-x96-max: enable IR decoder
  arm64: dts: meson-g12a-u200: enable IR decoder

 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts    |  6 ++++++
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts |  6 ++++++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi        | 14 ++++++++++++++
 3 files changed, 26 insertions(+)

-- 
2.21.0

