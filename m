Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFACC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEAC20863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="uwN5cQla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfETUDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:03:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39408 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfETUDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:03:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so561307wmk.4;
        Mon, 20 May 2019 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7xT9LsbSrOL4FALnwbx2ofAhC4bhcSjUh2MzuU+lqDs=;
        b=uwN5cQla9irCx0v4W2hkNijVJtfeA9waG/LHN1YD0qXyMNu6GkrZbBIb6DJORVeUny
         p4SwwAmj/s6Tj4HNjwS6mDcaXJG6tdz28eSMPFoF3WGcC79XmcN9yp1lNmjdMSEtvAym
         JO8MK4Dy+DaLnsA2jipx5mYqBYM5Qc17fIikbMCnZHOUtRIP35+QZlkEKw7t6TFsUnNg
         KPclioq3Lybqyw3QeeMhLRshNhTo3WWyH47bf6sxkT2Y2n7Qp3A2wY5FJFsm8W+eVv/7
         xBkjhE1lg7ZGH+ff+DDuTdz5Kl3QEc/7Ca7ssZoKkcgyZ0zstqc98b7nUo0HOjglJ1H5
         m0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7xT9LsbSrOL4FALnwbx2ofAhC4bhcSjUh2MzuU+lqDs=;
        b=L3yRVZz5atgmQYq/V6B9yRXlZnjjM0nGS2JvHvIZ9Xmmo6tP6s64DGBgcMFLTRN51Y
         ZnxSckeXe0882wGAKFTRRePerqbynpamTpE2OEIyYBp4uJ1Z8J2/lFAi49DQUGShXmU6
         nGXBDaOSVSSKCR6FkCQVemE8J6n+AZYdUlAvs6on78MnXnU/dOCepw7svPZgkD49y30x
         6EeMsgZrAdyR47rFgXghMeg2bv/EAjjwK7h7UTY1/G1EQN1q3hMUkWNsdeYowhuMhrns
         im9RtYY8O6n86o203ndfOslu+TE9p9xBU7jfLJxKxK1KhCeIbw19qK5+i7kNIke31Oe+
         rdug==
X-Gm-Message-State: APjAAAVHbyp47d/ldrxMRdF5BCaXs1fea9SEJ4/ysC0pO3Gjzw0G86eO
        ecmbR0PPWAX3/EuTbYf4/SY=
X-Google-Smtp-Source: APXvYqyIBv3ZBYENvn1vZbkmjXYL3k1GAmMzrTiWl9qygnfnwTHVClk1T7WYtr5kFVF0lErt4XfxyQ==
X-Received: by 2002:a1c:c016:: with SMTP id q22mr600345wmf.6.1558382608612;
        Mon, 20 May 2019 13:03:28 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133EE71009C356FA1F0E19AF9.dip0.t-ipconnect.de. [2003:f1:33ee:7100:9c35:6fa1:f0e1:9af9])
        by smtp.googlemail.com with ESMTPSA id t7sm23583379wrq.76.2019.05.20.13.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 13:03:27 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/4] 32-bit Meson: audio clock support
Date:   Mon, 20 May 2019 22:03:15 +0200
Message-Id: <20190520200319.9265-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio clocks on the 32-bit Meson8, Meson8b and Meson8m2 are
(probably) identical to the ones on GXBB, GXL and GXM.

The first piece of evidence is that Amlogic's vendor kernel is using
the same basic driver (just slightly modified) for the 32-bit SoCs [0]
and 64-bit SoCs [1].

Then there's buildroot-openlinux-A113-201901 which ships
kernel/aml-4.9/drivers/amlogic/clk/m8b/clk_misc.c. It contains the same
registers and bits (just slightly different naming) than the mainline
GXBB/GXL/GXM clock driver.

There is no working mainline ALSA driver for this yet so I am not 100%
sure that everything is correct. However, due to the evidence listed
above I'm sure that the basics are correct so this is a good starting
point.


[0] https://github.com/endlessm/linux-meson/tree/d6e13c220931110fe676ede6da69fc61a7cb04b6/sound/soc/aml/m8
[1] https://github.com/khadas/linux/tree/1bd6972cd0093725c0b1dc87f6546648bbb22452/sound/soc/aml/m8


Martin Blumenstingl (4):
  dt-bindings: clock: meson8b: add the audio clocks
  clk: meson: meson8b: add the cts_amclk clocks
  clk: meson: meson8b: add the cts_mclk_i958 clocks
  clk: meson: meson8b: add the cts_i958 clock

 drivers/clk/meson/meson8b.c              | 154 +++++++++++++++++++++++
 drivers/clk/meson/meson8b.h              |   8 +-
 include/dt-bindings/clock/meson8b-clkc.h |   3 +
 3 files changed, 164 insertions(+), 1 deletion(-)

-- 
2.21.0

