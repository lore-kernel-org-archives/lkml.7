Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAF6C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1382147A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bIpUOE8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfDMRPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:15:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46420 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfDMRPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 13:15:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so15960044wrw.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OZ3paJ4iaXOzR0Hh0oek905P7Hhbe2Wppg/n8TWnHTU=;
        b=bIpUOE8jEzfxn96g3+L1cxFhVg5eOBg6wm3FOY1b4ni8R4YIqZAXDQ4ViGxB2s13vn
         oaRJorQjEvbqQcyt0vDtc11KV7eQOhUvrm1FxYbP+LAeRv2mybvLaDNi71/UfbDTq9NX
         1qwg/yByJLwZc1WCL+zpVKfWmrHw9X8w5gGdL5Riikk6nwdbxQWCQuWAxpAddDk4Ujm3
         xnDDFPtw+oCdnQdbOF+YxfpWsZsAgwPQvHAgAQgdgSc/ckC2ZrzAGI0fz42HIBMwL5Os
         8Ne4gEchcHb94vIrZVucFlw17V3FhfzSkjhSPVN89bLExBQ2QFhSfP4PnfxUfdnWjbAb
         aCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OZ3paJ4iaXOzR0Hh0oek905P7Hhbe2Wppg/n8TWnHTU=;
        b=Es6e3+wkoiQ1G+R9c8L0L4DBWMpCw06G52Ml3sW4xU1nWxCRCq2uNOf4AsmsVScs2o
         fh4kRYHObw0aGlR0BIlEkG8mLpbcJh+yQv+wD0mLc59yEM2OhZTo6plcVJXZEROgYmFE
         ENKvsveS+NDULy/54JE4+eMaL95THIJKpsXCNbWBFD4gPXnk+EOI4ckBSWeMa0wNcoS3
         Cr4YQYHUr8g8drtlfvp2AvME4NrKjjWuk3LyvI+D8F2vLdjpQWEoyZe5FrKK7yuP7KAK
         NRMxdMlkzzi9adLfw3eL8L91tCAZwTPfc57GQgw1RimhfZ1erXh4D6c1wvfWtUXj3L3m
         3KWQ==
X-Gm-Message-State: APjAAAXMbZC6qPlQ7K/1liYfxPZC4SKC36OGBjKwCSGog9EAv8wLIkTe
        6QrYEIgulOxapQ78LkBFPLU=
X-Google-Smtp-Source: APXvYqyLPrN8SL0qAjae7+xkaQ+fhy/5hHAS1Hp4VgGprS/2qeUOPbPT5Kvl71xDIZa0Fsg6V2ynJg==
X-Received: by 2002:adf:e443:: with SMTP id t3mr13640311wrm.257.1555175745527;
        Sat, 13 Apr 2019 10:15:45 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD0010B8127C043607D1.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:10b8:127c:436:7d1])
        by smtp.googlemail.com with ESMTPSA id h84sm16745965wmf.15.2019.04.13.10.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 10:15:44 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mjourdan@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/3] 32-bit Meson: add the canvas module
Date:   Sat, 13 Apr 2019 19:15:29 +0200
Message-Id: <20190413171532.25967-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the canvas module on Meson8, Meson8b and Meson8m2. The canvas
IP is used by the video decoder hardware as well as the VPU (video
output) hardware.

Neither the VPU nor the video decoder driver support the 32-bit SoCs
yet. However, we can still add the canvas module to have it available
once these drivers gain support for the older SoCs.

I have tested this on my Meson8m2 board by hacking the VPU driver to
not re-initialize the VPU (and to use the configuration set by u-boot).
With that hack I could get some image out of the CVBS connector. No
changes to the canvas driver were required.

Due to lack of hardware I could not test Meson8, but I'm following (as
always) what the Amlogic 3.10 vendor kernel uses.
Meson8b is also not tested because u-boot of my EC-100 doesn't have
video output enabled (so I couldn't use the same hack I used on my
Meson8m2 board).

This series meant to be applied on top of "Meson8b: add support for the
RTC on EC-100 and Odroid-C1" from [0]


[0] https://patchwork.kernel.org/cover/10899509/


Martin Blumenstingl (3):
  ARM: dts: meson8: add the canvas module
  ARM: dts: meson8m2: update the offset of the canvas module
  ARM: dts: meson8b: add the canvas module

 arch/arm/boot/dts/meson8.dtsi   | 21 +++++++++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi  | 21 +++++++++++++++++++++
 arch/arm/boot/dts/meson8m2.dtsi | 10 ++++++++++
 3 files changed, 52 insertions(+)

-- 
2.21.0

