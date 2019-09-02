Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD2CC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 05:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF49621897
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 05:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTxwNe23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfIBFto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 01:49:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35450 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfIBFto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 01:49:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so6902038pgv.2;
        Sun, 01 Sep 2019 22:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MHdxKsFqjn9JIHizAHLjgVQgY6D3oHhQhJ6Mqn2/Qis=;
        b=gTxwNe230a+264cG9c+8Feyt1MMUrqIZtlpV2gNcUSLYb9cGMxCXEDMCXl+5tiMyd7
         eUa/FrxSb3adsoXpZ3KxcgExKHRp+/hvRpiAZAxjenPJkjOYsUoRdTRILyEkmug4+JE2
         j7fCV8+2/+6M8w8pXHBB4FH11+PT9DpxczyrJ9TErw6BrQhiT9rQ071e82EHNCDawVrP
         260yQtXj7stBkcZtNNv0f8vUSfhlWQ9+vGNJuCK6il9nb8jb6d7MeBvK6yDblE353vUj
         3Fcz2nQzuhtim8yXoBxjdue88BRauI+qfekOrrHgbejP1bkdfe9VzvnN8/TmFSoHFjQM
         dqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MHdxKsFqjn9JIHizAHLjgVQgY6D3oHhQhJ6Mqn2/Qis=;
        b=b/09JFZzSghz3SLxxKsD//C3uP9c9qdk6m8RqeN0kHV7TIOFaQnBOrHVOZ3m/2tS0A
         9U4JsPFiHkTWILu4dvOQb9+Q/3jwTK27gow7Q12fQZX5F0ffFdduTMmA5MHh9cEfgkwY
         YGxY8Vp2V2Sy4XENQwxrbTsobuzvy5/9cmOSoHyIFkqiqGQ3DzJ2jaGo+24vXkcys5/Z
         d2WZybHSqtOulvNQCzqHRm2rMZGi3THoXPf8e/EyWxRK9GmGkiSOD88w3nqXYYd7I9M6
         UsFi3K2dCoMUZccWX6pWwJx8hWDYhToLtnuIgcYdznT4+UHTkW0SWT4OK8KoHQKJ4tGf
         3YnA==
X-Gm-Message-State: APjAAAWUnuxPBxLQ4oMYPTP4lIDQMUEBojZvdZskT3rLnbxE9Ke3dBeA
        ra55B4/XJwcaDXCIcd/2L/M=
X-Google-Smtp-Source: APXvYqxMMBohwzZ+xCjsgq6JKN2mBCiIwV8Sg2mHwLWuAJb5J6RTlHaoYhCkAJ03i20k7n9FGw3M1w==
X-Received: by 2002:a62:1808:: with SMTP id 8mr32564790pfy.177.1567403383986;
        Sun, 01 Sep 2019 22:49:43 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.203])
        by smtp.gmail.com with ESMTPSA id 136sm16533912pfz.123.2019.09.01.22.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 22:49:43 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv4-next 0/3] Odroid c2 usb fixs rebase on linux-next
Date:   Mon,  2 Sep 2019 05:49:32 +0000
Message-Id: <20190902054935.4899-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some time ago I had tired to enable usb bus 1 for Odroid C2/C1
but it's look like some more work is needed to u-boot and
usb_phy driver to initialize this port.

Below patches tries to address the issue regarding usb bus 2 (4 port)
while disable the usb bus 1 on this board.

Previous patch
[0] https://lkml.org/lkml/2019/1/29/325

Re send below series based re based on linux-next-20190830.
For review and testing.

[1] https://patchwork.kernel.org/cover/11113091/

Small changes from previous series.
Fix the commit message for patch 1

Best Regards
-Anand

Anand Moon (3):
  arm64: dts: meson: odroid-c2: p5v0 is the main 5V power input
  arm64: dts: meson: odroid-c2: Add missing linking regulator to usb bus
  arm64: dts: meson: odroid-c2: Disable usb_otg bus to avoid power
    failed warning

 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

-- 
2.23.0

