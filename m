Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A5CC48BE8
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1FE2133F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+81I/pO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfFWRIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 13:08:07 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45511 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfFWRIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 13:08:07 -0400
Received: by mail-qk1-f194.google.com with SMTP id s22so8052304qkj.12;
        Sun, 23 Jun 2019 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EMFljB61wH3RBTPKWZ1GnJfV+sWdvfbnkWdZA5ukgAc=;
        b=D+81I/pOASXIwEKTD0Yy9pX88RNbR5Bg/OIOH6Ff/5TkeLiyCYCO8uIVbiCQaVCXwY
         orpo6w9lOto0hx+qd2n3MY7WikoN+1lYQD3dwMOGR08aU8eP0+Z1XlKCTV9gj2TTqRhU
         j1UWXuXc6jKW5u5NKamohOuQG9l4horQKJr3ueFpgqxL5uQdlezmiTmdLsYyW1PEopPs
         flAMuQg3cTydjyNcVHas2lYqlN3I/dkBjXDgKEzNzDcSuMveHY0OZWx8Sf5TTXIeAhx7
         69uO/cJ6gmCrb8XNxCwHnlWd0m9g0d1ZiDl70xetLL4YCSRhEhkkcO5bK3rPFxuyZO+R
         PZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EMFljB61wH3RBTPKWZ1GnJfV+sWdvfbnkWdZA5ukgAc=;
        b=NTsLMHIZui4a64XxeAq/M/i/hg417lzx4LV41hF7ns6crhADla87fwk5Kdx9gkS9ro
         xa+R8IalwTULo+4bSxcxhX6N1PXf2nUymt6AZSp53Tcg9Mvbn6hwcHHqdjZNiVib4lFG
         QFRMEUsqSwmL2Qe/puxfF+5eunwmm02gLyNd4O/xVkyirD6Vc4atBn4V8kFjTyfE6ezt
         Ed235DGNifasPlFDhMEm0JU/QhtZr1eshuTEl6ZrFCIAU8V2VyWJM2l9EjLLdLB9oozG
         xDFHLEhvw+fP5aaxx95aQQdk+X6+RQoDp6k+KhgcJfAd3hWs+TJZyhdsfsQQBpo6Za2E
         V6LQ==
X-Gm-Message-State: APjAAAU5YhwiDLorvK6oKdPR0UgplG0mYNiHoyNd2mwducJaqIC141y/
        XkjKf3ydrEJ/1J+GbMvGMn0=
X-Google-Smtp-Source: APXvYqygAqhU2nclhsb9tqgs7EEPC7l+G7UwtlBWitXR/rkvffzqte0tSuTPBOpvnDQ2N5h9zjPU7w==
X-Received: by 2002:a37:48d8:: with SMTP id v207mr49250965qka.316.1561309686028;
        Sun, 23 Jun 2019 10:08:06 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id o54sm5790756qtb.63.2019.06.23.10.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 10:08:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] ARM: dts: tegra30: Connect SMMU with Video Decoder Engine
Date:   Sun, 23 Jun 2019 20:07:24 +0300
Message-Id: <20190623170730.5095-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623170730.5095-1-digetx@gmail.com>
References: <20190623170730.5095-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable IOMMU support for the video decoder.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

No changes since v1.

 arch/arm/boot/dts/tegra30.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 934caa83c8db..ce162125e7bf 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -424,6 +424,7 @@
 		clocks = <&tegra_car TEGRA30_CLK_VDE>;
 		reset-names = "vde", "mc";
 		resets = <&tegra_car 61>, <&mc TEGRA30_MC_RESET_VDE>;
+		iommus = <&mc TEGRA_SWGROUP_VDE>;
 	};
 
 	apbmisc@70000800 {
-- 
2.22.0

