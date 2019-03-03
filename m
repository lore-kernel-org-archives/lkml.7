Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2412FC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EDF20835
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIkYsUGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfCCUQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:16:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34482 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfCCUQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:16:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id l5so2494404lje.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 12:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Ut5F1KmFjOQ0jlhN+14pQF+2tOrtJRs/T7GtTtJGCg=;
        b=lIkYsUGM4Xg27pXfFwWn5xbdRTlwk7pi8xXQqhLj/tyH20YeYEYSW2pmCmge+wX8j6
         u1SqZ9P1maRwIcNuFvqpA5M5k3AhE0e7ZIyLzYVQZluGnWBr24DVcfMz83T+VdE3K/nw
         FVulo1gDRlFBGOW9XPc93jj9vgcr9O5mARcGBNLKNzLSoCglXTll7AgHjHG0DN8zR4Df
         Ojv6v90GX1LDaLTyKLo8jZTMzKTMFDpbZy+LvAZW2xfiheGaAGiIX/4vRzHiWqWA7JnP
         dln4BPCZgG6P4Eg1iJYJtLtTiWjbjhtiWEQYSdNlolmciAaMuxmRfFw8cCF88bPCGsbK
         3xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Ut5F1KmFjOQ0jlhN+14pQF+2tOrtJRs/T7GtTtJGCg=;
        b=OlIjLFWoRB46jlOsAdDcKoGf9wP6DEqkhI+73ErD+B86CEM/FS9UnRFi/xLTm7xsbX
         fw+ShD7bcaLc1n7O1j2CJR17idbpHRWVgrgJ16qM8ZhCX2MVAhFTC4raBOxza478PxAp
         pZRN17kO3q66ApS/0gtKs24V05Ev21VOBK5FhoKTOhugZb0njT75nFVfpMMwdmBE6fpj
         wAQaZgJuhJFduhANWcWZOKfTtn0HK1a9VPizCdbeu2sVDBwhaKoehlUOpspISedQz2ev
         eplcQ/XRpcxRtAF5C1VZH8HTWr7MfPpbicr3/OyTJ3qFxRD/2fHLLm593De7VYpB1GcS
         g/4Q==
X-Gm-Message-State: APjAAAXqAXXtbA8FSYcfRGCqpLAjHPEdkj69hI1jx0FWyNFLL5KLcVYT
        +oC/wKVCcTzp8YzCxi8rZzrYX1aS
X-Google-Smtp-Source: APXvYqwaly/n/Uxg1yGT4mVYvzaIrRAy93toHddLRmabGdfSwAnLopA0Qbabb2LIOnlh/+FY/Rsyew==
X-Received: by 2002:a2e:93ca:: with SMTP id p10mr4101590ljh.16.1551644200560;
        Sun, 03 Mar 2019 12:16:40 -0800 (PST)
Received: from localhost.localdomain ([46.216.192.153])
        by smtp.gmail.com with ESMTPSA id o7sm1134914lff.73.2019.03.03.12.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 12:16:39 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1h0XXK-0005Bg-6M; Sun, 03 Mar 2019 23:16:38 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH v3 0/2] extcon: Intel Cherry Trail Whiskey Cove PMIC and external charger tweaks
Date:   Sun,  3 Mar 2019 23:16:11 +0300
Message-Id: <20190303201613.19884-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At implementation of charging support for Lenovo Yoga Book (Intel Cherry
Trail based with Whiskey Cove PMIC), two pitfalls were found:

- for detection of charger type by PMIC, bit 6 in the CHGRCTRL1 register
  should be set in 0 (and set to 1 for Host mode). Pick up its definition
  and logic from from Intel code drop[1];

- "#CHARGE ENABLE" signal of external charger (bq25892) in Yoga Book is
  connected to one of PMIC outputs controlled by CHGDISCTRL register.
  Enable charging at driver initialization. Pick up this from Lenovo's code
  drop[2,3].


v3 changes:
- Don't restore of initial state of CHGDISCTRL and CHGRCTRL0 at exit but
  switch them into HW-controlled mode (as discussed in mailing list);
- Use regmap_update_bits() instead of regmap_readi()/regmap_write() in
  the cht_wc_extcon_set_otgmode();
- Coding style and constant names changed as Andy and Hans recommended.

v2 changes:
- Disable HW control mode of CHGDISCTRL at driver probing and restore
  initial state at exit.
- Switch CE output off if OTG host mode is enabled.
- Save and restore CHGRCTRL0 register also.

[1]. https://github.com/01org/ProductionKernelQuilts/uefi/cht-m1stable/patches/0001-power_supply-intel-pmic-ccsm-driver.patch
[2]. https://github.com/jekhor/yogabook-linux-android-kernel/blob/b7aa015ab794b516da7b6cb76e5e2d427e3b8b0c/drivers/power/bq2589x_charger.c#L2257
[3]. https://github.com/01org/ProductionKernelQuilts/uefi/cht-m1stable/patches/EM-Charger-Disable-battery-charging-in-S3-and-enable.patch

Yauhen Kharuzhy (2):
  extcon-intel-cht-wc: Make charger detection co-existed with OTG host mode
  extcon intel-cht-wc: Enable external charger

 drivers/extcon/extcon-intel-cht-wc.c | 60 +++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 2 deletions(-)

-- 
2.20.1

