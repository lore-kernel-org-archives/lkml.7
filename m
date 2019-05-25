Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213D5C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA71E20815
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OGJNTZfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfEYSLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 14:11:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37765 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfEYSLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 14:11:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id e15so12964516wrs.4;
        Sat, 25 May 2019 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Yb/S5cquO/qD7cZ8y/Ty2KEWw38/es4qeSEZUyR+jc=;
        b=OGJNTZfDrBzPN439RB++aRKeudPMkKmAnuPSKbCnLRPL0eV+S2U2ujtLWuKIW3R1/V
         tR+Vi1PNTFdC3hGP5egqzB5KZrLyec9thl7qdXa7ZIVQeM50/fuANNeD/xx2+zjavcfh
         Sot/dtNJhrUJ3CN3JWpD0bZEgn1Xr1TDXlo4Y3rXszL9ELsilnxHcpQutZ5dmQ95q+da
         O+cChUMRweL+GBgKmh1Swu+H8mtFOj4Ri6QVjHAt5zCjyhpT6mXWZBSD+SU+1eh04PNv
         rZm1iK+/8a/D9sCSzxE+GWi1gyxowb2WaeDIN2BLFZgY4xFUTPexkmSwSdQnPV+9iF8d
         jSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Yb/S5cquO/qD7cZ8y/Ty2KEWw38/es4qeSEZUyR+jc=;
        b=Jc2dhpYx9V7kQ5ZI2OUyT4e6bLYd3NC8y0bGCUXNWhhCRQB/NRNJ1b+JsJyG1i7N4Y
         Qyz5PFhJ6+lx/ScXhAozx7JCJ3PTZyLH+/nsbnp5J5ijGh95WncJLd1/empH2rE8/UAp
         Rq4ZVmVoGAyxOZNmyWG5Ksc6whbRMnCo1HEJDaSEcoxgpi7b6Rxxx3TTEZYQsTxXG8VQ
         8KHU6cOL6IjVB/7n7I0VLu3eS4INweywEtxaMKTbsTNEsR9D+RbCCMVnFqhOuygHyGyn
         ksbHxxDDYWCGnDsEIXx8Mk4QFI6tLfEcyQNffZSSov6G1z+09ZgCGtyKwcnzPHlsL/GG
         9nbg==
X-Gm-Message-State: APjAAAXja7O3Dgsdl5xBBgWxv6ynHlD/4t1kjDNX6ZN+ZxATDlf+dtnW
        qAXdRyHsuobagXeh0EXy/DDJZfjQ
X-Google-Smtp-Source: APXvYqxBZiRxV8q08TSMKchVl/GQr4AJB1E/7X1Qboxu7UaF1qNqvJ7pwpHbrpQvTRZKOmexP2cjYw==
X-Received: by 2002:adf:f78d:: with SMTP id q13mr20308734wrp.220.1558807903867;
        Sat, 25 May 2019 11:11:43 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id o8sm12794540wra.4.2019.05.25.11.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:11:42 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 00/14] pwm-meson: cleanups and improvements
Date:   Sat, 25 May 2019 20:11:19 +0200
Message-Id: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series consists of various cleanups and improvements for the
pwm-meson driver.

Patches 1 to 6 are small code cleanups with the goal of making the code
easier to read.

Patches 7 to 9 are reworking the way the per-channel settings are
accessed. This is a first preparation step for adding full support to
meson_pwm_get_state() in the pwm-meson driver. Patch 7 makes struct
meson_pwm_channel accessible from struct meson_pwm because
meson_pwm_get_state() cannot use pwm_get_chip_data(). Patch 8 removes
redundant switch/case statements and ensures that we don't have to
add another redundant one for the upcoming full meson_pwm_get_state()
implementation. Patch 9 gets rid of meson_pwm_add_channels() and moves
the pwm_set_chip_data() call to meson_pwm_request() (like all other PWM
drivers do - except two).

Patch 10 is based on a suggestion by Uwe to simplify the calculation of
the values which the PWM IP requires. The nice benefit of this is that
we have an easier calculation which we can do "in reverse" for the
meson_pwm_get_state() (which calculates nanoseconds from the hardware
values).

Patch 11 implements reading the period and duty cycle in the
meson_pwm_get_state() callback.

Patch 12 removes some internal caching which we don't need anymore now
meson_pwm_get_state() is fully implemented. The PWM core now takes care
of not calling pwm_ops.apply() if "nothing has changed".

Patch 13 adds support for PWM_POLARITY_INVERSED when disabling the
output as suggested by Uwe.

Patch 14 completes this series by adding some documentation to the
driver. Thanks to Neil for summarizing how the hardware works
internally.

Due to the changed PWM calculation in patch 10 I have verified that
we don't break any existing boards. The patch itself contains two
examples which show that the new calculation improves precision. I
made screenshots of the measurements in pulseview [0] for the second
case ("PWM LED on Khadas VIM"):
- old algorithm: [1]
- old algorithm: [2]

Dependencies:
This series applies on top of Neil's patch "pwm: pwm-meson: update with
SPDX Licence identifier" [3]


[0] https://sigrok.org/wiki/PulseView
[1] https://abload.de/img/old-algormjs9.png
[2] https://abload.de/img/new-algo4ckjo.png
[3] https://patchwork.kernel.org/patch/10951319/


Martin Blumenstingl (14):
  pwm: meson: unify the parameter list of meson_pwm_{enable,disable}
  pwm: meson: use devm_clk_get_optional() to get the input clock
  pwm: meson: use GENMASK and FIELD_PREP for the lo and hi values
  pwm: meson: change MISC_CLK_SEL_WIDTH to MISC_CLK_SEL_MASK
  pwm: meson: don't duplicate the polarity internally
  pwm: meson: pass struct pwm_device to meson_pwm_calc()
  pwm: meson: add the meson_pwm_channel data to struct meson_pwm
  pwm: meson: add the per-channel register offsets and bits in a struct
  pwm: meson: move pwm_set_chip_data() to meson_pwm_request()
  pwm: meson: simplify the calculation of the pre-divider and count
  pwm: meson: read the full hardware state in meson_pwm_get_state()
  pwm: meson: don't cache struct pwm_state internally
  pwm: meson: add support PWM_POLARITY_INVERSED when disabling
  pwm: meson: add documentation to the driver

 drivers/pwm/pwm-meson.c | 323 +++++++++++++++++++++-------------------
 1 file changed, 169 insertions(+), 154 deletions(-)

-- 
2.21.0

