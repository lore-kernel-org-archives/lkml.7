Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A73C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 19:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365D220851
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 19:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LI/UOUKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfEYTCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 15:02:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53939 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfEYTCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 15:02:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id 198so12388316wme.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 12:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FMgRwBoum0Ejn339EXDQoU9BYTUMpQqabDlvOkJFkRA=;
        b=LI/UOUKEetrDqZGCWdjAdtJcMs/WfNEF/yvH0JEZyz9Bs4zcUNdVEcw5EX9KDVAK0I
         Hmp8mN3pH1u6IKYCMkFQ7FNhBx5xhAiVUB8KjboEdh2NsZG8eKLdtzRkltjRKiTp/Cs1
         Y6dncQe7+lN/1Ia9pYnByRlCp1sPe1IkVhKzUczHmlHn0z84O7RHWJGRI0qzG0ZNBiK9
         LGm8sDARfU4nAVttZAXUXxABSceTuj7pflgl8fUWEJnekuRma/b4GXocdaHFk7pHqtIH
         zK6w+le3nOIyHZwlCNRD7y9FPQhbo3Ogv5/0TG7O6tg1+A2zdEtizmI9k90fIgYW67tD
         PmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FMgRwBoum0Ejn339EXDQoU9BYTUMpQqabDlvOkJFkRA=;
        b=VudPokIwf3cwHu/YTpXKlEcUqvs9VUPZP7lq8YIPSxvHDU1LAt5XceVyQK79t2PHu0
         e9eWcGHySKs50M0iqK/C6DJRBmmQrxlatw8x23fVQh1A1JpJOCkC1ND/4549RiFkZhH4
         YncExwsC4F2XJCpzXFzB/LqbDHcgxJMwWzLwmbb10txbzGVXAKhncW1L6fyBsjejRmPQ
         HDGtwuh4yPUNgVyIyEx6jhrcbMIWiUKoZl22haz5dyjv4eCY6rq2bxU/RIowwj6vr2/t
         Ud4+GA3Fldm89QH5b7vN1+azO1WBZHd32sBOGk3FQpok7QzE3UTxbmiNdbdUBiCN3arO
         TbhA==
X-Gm-Message-State: APjAAAV7wCRklloXlTeS4Q5QNP6KB2rb709+dmPiE2ypdVa9+kkb0Prv
        kWYmorGPUN+rjwcH2y41OLk=
X-Google-Smtp-Source: APXvYqzsGZFaNFf0zprRY/s7WMFdZxHwCQ2PrEP35RUVc95UKMBki5ybO45bWRmlM2Em8nC8+Ua8Fw==
X-Received: by 2002:a1c:2dcd:: with SMTP id t196mr20662035wmt.141.1558810929981;
        Sat, 25 May 2019 12:02:09 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id f2sm6870426wme.12.2019.05.25.12.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 12:02:09 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/4] ARM: dts: meson8b: add VDDEE / mali-supply
Date:   Sat, 25 May 2019 21:02:00 +0200
Message-Id: <20190525190204.7897-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EC-100 and Odroid-C1 use a "copy" of the VCCK regulator as "VDDEE"
regulator. VDDEE supplies the Mali GPU and various other bits within
the SoC.

The VDDEE regulator is not exclusive to the Mali GPU so it must not
change it's voltage. The GPU OPP table has a fixed voltage for all
frequencies of 1.10V. This matches with what u-boot sets on my EC-100
and Odroid-C1.

Dependencies:
- compile time: patch #4 depends on my other patch "ARM: meson8b-mxq:
  better support for the TRONFY MXQ" from [0]
- runtime: we don't want the kernel to change the output of the VDDEE
  regulator to the maximum value. Thus the PWM driver has to be able
  to read the PWM period and duty cycle from u-boot. This is supported
  with my series called "pwm-meson: cleanups and improvements" from [1]


[0] https://patchwork.kernel.org/patch/10960283/
[1] https://patchwork.kernel.org/cover/10961073/


Martin Blumenstingl (4):
  ARM: dts: meson8b: add the PWM_D output pin
  ARM: dts: meson8b: ec100: add the VDDEE regulator
  ARM: dts: meson8b: odroidc1: add the VDDEE regulator
  ARM: dts: meson8b: mxq: add the VDDEE regulator

 arch/arm/boot/dts/meson8b-ec100.dts    | 31 +++++++++++++++++++++++---
 arch/arm/boot/dts/meson8b-mxq.dts      | 26 ++++++++++++++++++---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 27 +++++++++++++++++++---
 arch/arm/boot/dts/meson8b.dtsi         |  8 +++++++
 4 files changed, 83 insertions(+), 9 deletions(-)

-- 
2.21.0

