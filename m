Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BD2FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E1E21835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGYmSpcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394057AbfJPRIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:08:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39445 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731357AbfJPRIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 13:08:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id 195so5156943lfj.6;
        Wed, 16 Oct 2019 10:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2P/J10KlExGhDcB/BIJubTdscdcTfMDb1fvy/oTWkxE=;
        b=ZGYmSpcC+3Ytg3A4d6uhwt45ZuOLxHufU1G0+taRHgxS3toGOBjb2JzbcSWfMNmpTU
         KeFH2531iE4BbVgauuva6vCMqk6x1S+j2FGJ7d0qxr18PUOa0ShTbfsqI/IfX5VZY56E
         V4GW/AFw9LXBobpOBAibIjTVR05CM5vsrXocFOVmvr8d0XVtkQb0GPMyNaETKXecPXge
         6IwX8fwx79qyuk63skOebNKrBeVxgS62nCUSPSenSY1JBm5m/9LwA9gaADdn1bCzyX98
         u4RvdYPMryzI6wAXT3UR3zJvI5CIHgO4kFjeDF9Z8kdJ/k6KxBbdksBz23uYBMlvXT+m
         XhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2P/J10KlExGhDcB/BIJubTdscdcTfMDb1fvy/oTWkxE=;
        b=eHdHS9BWuOPNz6WUCS90d8fF1bWrdehPZioM6vKxA8go7rp6s2bR2xnBjTgbeiRQ51
         EAWCePWJAesPvs9MedGuOc6NrMhcRZfDbPHzFVMrMl9pp3Z01hKdp1Je9auFqyRuHBLc
         3gG+F3v2JjSFg2nDxaLdAgHvlND7OHZ/DzMV0oY7lS7rx6BtY7g+BgVjYRz/y9X1lUO6
         sqGMqQg1+yYNGuRMB914mMQDAzUMkUdf4sfl5Rrez2Q3id4eOp7Hyt8nOfhtg+M7f5CE
         4ZIeXuHvZGTuiUJF2qehc2OXOwQzu8/hzEKoQ1CLt2EV6F16ZjvGW0s3QU0dTriROuSc
         VZ5Q==
X-Gm-Message-State: APjAAAX2dcF0qdPolvtds0CqqQFr3IkiRdOSiMffJbHRoq4o8BOqDPEz
        ecvOmImxEQ3nXLPPccpdD2GjQs6fw0nKNl6C+O4=
X-Google-Smtp-Source: APXvYqzlz5fV6bpUwwy0e8WQAyU1+u5vJPm1G3iUaorsGa524M1CGUWd8NgCE96FPsw76VqbLrnH9w==
X-Received: by 2002:ac2:4550:: with SMTP id j16mr8421098lfm.126.1571245707268;
        Wed, 16 Oct 2019 10:08:27 -0700 (PDT)
Received: from localhost.localdomain ([87.101.228.250])
        by smtp.gmail.com with ESMTPSA id q24sm6299182ljj.6.2019.10.16.10.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 10:08:26 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/2] arm64: dts: meson: Tronsmart Vega ir keymap updates
Date:   Wed, 16 Oct 2019 21:07:35 +0400
Message-Id: <1571245657-4471-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tronsmart Vega S95 (S905) and S96 (S912) Android STBs use the
same IR remote. The rc-vega-s9x keymap has been accepted for Linux
v5.5 [0] so add the keymap to the respective dts.

[0] https://patchwork.linuxtv.org/patch/59434/

Christian Hewitt (2):
  arm64: dts: meson-gxm-vega-s96: set rc-vega-s9x ir keymap
  arm64: dts: meson-gxbb-vega-s95: set rc-vega-s9x ir keymap

 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts   | 4 ++++
 2 files changed, 5 insertions(+)

-- 
2.7.4

