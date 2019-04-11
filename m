Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E6AC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6575A2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR0rQiGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfDKPe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:34:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37216 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDKPeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:34:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so7241846wmf.2;
        Thu, 11 Apr 2019 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M9Ty46Kv1qypbu4g8tT5XDrw/pdKeMbrnD7NrZnvQeI=;
        b=AR0rQiGbf8GXBi5fsapn0gvF/DQNzX9v3OEeidQseT6wqycuSYkJL2eeg/Z5W98amS
         ddbkEhazGgc2lgobTdZUG2xsi7Z1OlnGlg9keZydxkxjukONHHHXeK1GNspAAFQo3agS
         dz1mGmaJrQtzsbJvBE5tdlUQUXn4IaoU0wZz81xMR96kn+Q9eT2VY0z2bA6pGpHGQORd
         hOSD6dZMdGhe2/ssdlru37ZqxWn3NuusfVe3yR2ZUg3SmKIvNasxJWdQISa6OLUvP2ke
         N5CEuQ2jcuweUrbgTn0qbWaA+kCECIovLOlmGL30l8IILykItmwLeAHdwsmteDXWA03f
         68uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M9Ty46Kv1qypbu4g8tT5XDrw/pdKeMbrnD7NrZnvQeI=;
        b=gqSIOkBifnyQezykZ9TVoQAhzqTDRcEQtI/2jh6GhGFO+sCpQT1gVCb5RTQeLudk7A
         TJcHUAGI4Sf7rAfOToBLB5GrN56GkmIxVNMstnz4w33Mt6lVnmNXlTSKRJemjGQDPHVb
         5dRJtWcyzVsilfMCz/3Ab1tEMRPJKE6wnkBMqg4pRAy4hT3LVGrBtRNHoKzfp3CxY6ay
         nZBPTjCEBYHL4xd6Zsnwyu/jw7jHhhN8cdyYcdomhlKrf+nO8/avVIfXu06A4m1or9HR
         Z19Z31Quvgd2T3wBL8ORdPs0SiAyleW8mWvIsToST+NNmayPcEeXqX/V8eawrclTqaBS
         gopA==
X-Gm-Message-State: APjAAAUWlZTEcEtqwxKEootGRvbchIlk6Bxk92pAAUmnv9r+ZA+vsMMb
        sz49fThvdTot1OvG3mN6nMpESocqcCnILw==
X-Google-Smtp-Source: APXvYqzSCwzobIRfjleSuY8UVZ5ULkbGkZ3vtuy0zMEx48SprLNDputFK8TOjGrPZoOYSGghK0liNQ==
X-Received: by 2002:a1c:1d4:: with SMTP id 203mr7558205wmb.101.1554996863141;
        Thu, 11 Apr 2019 08:34:23 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id e12sm38327342wrt.94.2019.04.11.08.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:34:22 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 0/3] Add Watchdog for H6
Date:   Thu, 11 Apr 2019 17:45:31 +0200
Message-Id: <20190411154534.25563-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Allwinner H6 SoC has two watchdogs. The documented watchdog is identicaly
the same reading the user manual as the one used in the A64.

After investigation it seems that on some SoC the first watchdog doesn't
make the board reboot.
Some tests has been performed and it seems that first H6 version aren't
affected only the latest one.

Chen-Yu Tsai's boards:
Pine H64 - H6 V200-AWIN H6448BA 7782 => OK
OrangePi Lite 2 - H6 V200-AWIN H8068BA 61C2 => KO

Clément Péron's board:
Beelink GS1 - H6 V200-AWIN H7309BA 6842 => KO

I think it could good to add it with a comment anyway.
In case a user want to activate it and isn't aware of this issue.

The r_watchdog is still available and usable on all the H6 boards.

Thanks,
Clément

Clément Péron (3):
  arm64: dts: allwinner: h6: add watchdog node
  arm64: dts: allwinner: h6: add r_watchog node
  arm64: defconfig: Enable Sunxi watchdog

 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 16 ++++++++++++++++
 arch/arm64/configs/defconfig                 |  1 +
 2 files changed, 17 insertions(+)

-- 
2.17.1

