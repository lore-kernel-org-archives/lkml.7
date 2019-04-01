Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136A4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E552084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pCxXWN9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfDAR6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:58:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32932 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbfDAR6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:58:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so13237387wrp.0;
        Mon, 01 Apr 2019 10:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NIsstsLHXU9Ct92TAvs2WRZTq4h4a7o49yCQryjDdYI=;
        b=pCxXWN9ILOqUQtaaqVwVX5ZZudlFpiL+dAZgOHbxCj53xV2w03weIzp+0x4A8nWfP3
         KswrVT0yhtRLQ1dZrR5gTlgRZROhWGRHrCPXoq/M2/hZfuAoUSvESF2/E6afh0W8M2mu
         fPj6GpuQjFGQHLBbzaT9i6+NNr5+hxsETFl9EELM2O3/yIwkrdR8oQZpmvOtlCrrPZcC
         +L5QaeayQ+3p/zz2WBQwLUOpFtLLJsRoHcC+riZ/I83EhVB9Tvxsy0F12GH1iIukuVbL
         arpQjyejBolL680NxtNvD43FaBY/5DIozGyRgO6C9ea6C6TEOVkh0JWOISK+v4mahtND
         LDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NIsstsLHXU9Ct92TAvs2WRZTq4h4a7o49yCQryjDdYI=;
        b=LcfdOZglfFwTSvAYNwKRrUJAOK5Z1JwypWBmN1Lnk1mkj0RR/VD+M8MT8tZZNauyzd
         DQPca3fLq8gJil7OtZK7QueZnR+ynMO2jqS1Gc5qR5yh8tQ30Q0W/2bxDa3AzZf1F0GQ
         mroHjp73hrTSWwLUPeboeyhZKIbUQBrMSy/8pqOg+njT2jTLL9NPAhoWvISvkXeUxkkG
         aG/dDdiTK4QZjPMcwT1F/ytqhGAmTB/PIr/etUsyLVHLDFy2uc0ko1JJ49CGVagBrpaV
         FGyi/mY3Er2K2nCL5Y92+0tMRxLsjVKaeqqFMJONMQrQUS2cVXHz+AofWrt6m2lw7NSi
         ZZDA==
X-Gm-Message-State: APjAAAXaztcvBt+0MjgBXjc4MNT9/VxtraZPEZmtUyNdhX79wSPddZuK
        aEwfvRB2MKkwTpbkwuprk/k=
X-Google-Smtp-Source: APXvYqzpRXEsO4JmSVwj8Jr9zU5efB21av7Qsv/rlpCtQ+3+BXiUG/rvftQ5mqXhFwjjbqXoQV2Q7g==
X-Received: by 2002:adf:cf05:: with SMTP id o5mr5254195wrj.8.1554141492517;
        Mon, 01 Apr 2019 10:58:12 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD73A0800C9C8A7BE25478D36.dip0.t-ipconnect.de. [2003:dc:d73a:800:c9c8:a7be:2547:8d36])
        by smtp.googlemail.com with ESMTPSA id s189sm16655340wmf.45.2019.04.01.10.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 10:58:11 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u.kleine-koenig@pengutronix.de,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/1] pwm: meson: fix scheduling while atomic issue
Date:   Mon,  1 Apr 2019 19:57:47 +0200
Message-Id: <20190401175748.5376-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back in January a "BUG: scheduling while atomic" error showed up during
boot on my Meson8b Odroid-C1 (which uses a PWM regulator as CPU supply).
The call trace comes down to:
  __mutex_lock
  clk_prepare_lock
  clk_core_get_rate
  meson_pwm_apply
  ..
  dev_pm_opp_set_rate
  ..

Jerome has also seen the same problem but from pwm-leds (instead of a
pwm-regulator). He posted a patch which replaces the spinlock with a
mutex. That works. I believe we can optimize this by reducing the time
where the lock is held - that also allows to keep the spin-lock.

Analyzing this issue helped me understand the pwm-meson driver better.
My plan is to send some cleanups after this single fix is merged. The
goal of these cleanups is to re-use more of the goodies from the PWM
core in the pwm-meson driver as well as to address issues spotted by
Uwe Kleine-König (these issues violate the PWM API, but none of these
result in breakage of the boards/.dts that we currently have). These
follow-up patches can be found here: [1].

Dependencies: none

Target version: please queue this for -fixes so it makes it's way into
v5.1-rc (so we can get it backported from there, because this issue has
existed since the pwm-meson driver was introduced).


changes since v1 at [2]:
- added comment about usage of the spinlock as suggested by
  Uwe Kleine-König (thank you)
- collected Uwe Kleine-König's Reviewed-by


[0] http://lists.infradead.org/pipermail/linux-amlogic/2019-January/009690.html
[1] https://github.com/xdarklight/linux/commits/meson-pwm-for-5.2-v1
[2] https://patchwork.kernel.org/cover/10867757/


Martin Blumenstingl (1):
  pwm: meson: use the spin-lock only to protect register modifications

 drivers/pwm/pwm-meson.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

-- 
2.21.0

