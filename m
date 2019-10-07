Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFDFC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223BB20867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U93WlJGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfJGNQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:16:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35068 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfJGNQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:16:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so8670851pfw.2;
        Mon, 07 Oct 2019 06:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PwiaLPNEero/RDkqXHKNpda6jyXODSLqhlH8GfScxo4=;
        b=U93WlJGywOW4GYdmFpjLSbINCeD5e5GpJ2UlnKRkpeLbKA45F/xZjIQjq0CqmxWaRc
         rYF0hBu+qMVKCBEvYbVAEykbc/A21OMZHembtBRw3nR29KuAVu8WLk1p3euuN3vDw0H9
         h9tzVebTCZgobqlu8/sjCsg9Pq9stdW/1AYzLxTmNBLHnRJ6srFQrpw44A3TgwUHnbwt
         W7YQJpxSa4WvSTanPX6pG+mVVKLdr9OdP5PqhKoVXp8VbPAg2FRoSFb5qRayfQisyMf7
         iEnYEWz46FCUjnTIM1/pUI9OHquzBjIVoNtejSSZckTud93bBGD7/TqoMDuFTzu3QbWI
         ThEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PwiaLPNEero/RDkqXHKNpda6jyXODSLqhlH8GfScxo4=;
        b=KMXQK9+B9oc/ffZjEJiiY73Y5/hhxdum83mbnwCPjfzqBCzgE0gIARs+vqBJIrYtN/
         GYRXq8e/a4MtYaEGCHTp4RwN3owcZx82vKUOfO1KNV8V9nVAHQQVAt/p/HRynGI8V85D
         yNnz8v0SZqfPbco0MvaNLroIXuEZI+mO85jEc5KmXFJcImjUNKClVZF4SFQJQ31NgQeF
         8pWdANYCpSek3HjhD9LJTGCYU0s5NXHgvs6BbwwsJwr6l52A1LuzZvsZjShp+MNBKgqO
         J+xmozQ+CZ9jJVvhVWzqQ+mU4pYsOjbyoq0gRQCjRkoLm34UAcRi99mIwattrPGw8YqK
         k7HA==
X-Gm-Message-State: APjAAAXzznkImC31cFEcji3D1B8TGyl81JwOdPMK3dP0GOIkkRX2bu/f
        P398uFx131ST+IV5UYfd/AE=
X-Google-Smtp-Source: APXvYqyvHEaEyr+JjSbY/h5Ukr9XMbNo6ALxq6sKOkJD/pII8Vb1ifPUfHXL2MqvRnu0ESu3/zKdCA==
X-Received: by 2002:a62:82c8:: with SMTP id w191mr31574553pfd.99.1570454218199;
        Mon, 07 Oct 2019 06:16:58 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.138])
        by smtp.gmail.com with ESMTPSA id r186sm16938650pfr.40.2019.10.07.06.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 06:16:57 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 0/5] Odroid N2 failes to boot using upstream kernel & u-boot
Date:   Mon,  7 Oct 2019 13:16:44 +0000
Message-Id: <20191007131649.1768-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We am trying to build the upstream u-boot and upstream kernel,
but it fails to pass the initialization of PWM_MESON driver.
So these patches help boot the kernel on microSD card.

Patchs based on Linux 5.4-rc2

Boot log failed are shown below.
[0] https://pastebin.com/cEtWq2iX

[    1.569240] meson-gx-mmc ffe05000.sd: Got CD GPIO
[    1.599227] pwm-regulator regulator-vddcpu-a: Failed to get PWM: -517
[    1.600605] pwm-regulator regulator-vddcpu-b: Failed to get PWM: -517
[    1.607166] pwm-regulator regulator-vddcpu-a: Failed to get PWM: -517
[    1.613273] pwm-regulator regulator-vddcpu-b: Failed to get PWM: -517
[    1.619931] hctosys: unable to open rtc device (rtc0)

My guess their is not much issue with eMMC module, if their is
other approach to resolve this issue, I will give this a try.

Best Regards
-Anand

Anand Moon (5):
  arm64: dts: meson: Add missing 5V_EN gpio signal for VCC5V regulator
  arm64: dts: meson: Add missing pwm control gpio signal for
    pwm-regulator
  arm64: dts: meson: Add missing regulator linked to VDDAO_3V3 regulator
    to FLASH_VDD
  arm64: dts: meson: Add missing regulator linked to VCCV5 regulator to
    VDDIO_C/TF_IO
  arm64/ARM: configs: Change CONFIG_PWM_MESON from m to y

 .../arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 13 +++++++++++++
 arch/arm64/configs/defconfig                        |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.23.0

