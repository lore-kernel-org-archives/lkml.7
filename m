Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39045C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057AD20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lt9Q1dOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfDJXPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:15:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36014 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDJXPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:15:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id y13so4862421wrd.3;
        Wed, 10 Apr 2019 16:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GPzNtnkRyn+MiB4Ec7DqFVngVv5MsehcY3ptD4yn/uY=;
        b=lt9Q1dOtEmzOWkTgmE+vtCL5eGi8VPi/zQRHuNbNnQSwLCXz49RYijqJM0E7ufu3kW
         C3i5aWi3CSgiz9EZ9Q89eb86W93og5px1fzIwvU+GhKg7TKrbdEsaBzlBpO7i5HaQcVM
         XtyFkBdMpv5OYqT52uYK6qGh3iV/wqeIGKtqsEtJJsHv+IfPSfsFyHBUWii3BFyN74ae
         IecxWL0h8POfRSTT9eSweHGvZqkBOHOPjMnmJwIjoWClApAE7jssKj2yDKM0YHvEQYvu
         5hEs+MnU5AJsR48AbQ564ibojtQbeYZulVs52SONknrtKxgW95gnxqBkPwO41DXPOycP
         mwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GPzNtnkRyn+MiB4Ec7DqFVngVv5MsehcY3ptD4yn/uY=;
        b=W0f6ShgW68ht2/ZxeGIwwryRwPd1TaglJnIKN/phz2zzv4Q9fdhCy1OKi34HamjJgX
         SK3gKQxPYW9TaUz8KXCIgEi4S5IuzjvOisOflRqA4nUl7t+ob0sbWoGrn9HmonocOi0m
         JHlQjZdRhNvMHNRxoQDDOZaSSDU5ZIx0kSzfUNMZxqWqIW7qn6PzhSy8EEp59/Lttphr
         zIWqd3TTDi/J7D0A3XR+dUA/GF2XTS5mGvGRQPQEBpRla/gNA3LdmfjgBy9wq4P+awXL
         rWXgHLeTPNkxXgQKQmuGCv+bnxGBuXEK/pHBSjSJ/7ZNhrgZpCX0NZD4qPQmmTw+pP8p
         hzFg==
X-Gm-Message-State: APjAAAXgnRslrVoSpoHSSKUbOZEvZZCP1NOsNfvVxHdzLq7AUI/mmFoO
        IJumM5LL67ve2xzXVtxZqENrqdhEFRkl3Q==
X-Google-Smtp-Source: APXvYqzKnlXFLcf2rNIUMhElAYZD4wIYqU5U6V+nF1dEfGBUO1eMU0q1PyDGph7EHzeOhSgIRzXdFA==
X-Received: by 2002:a5d:618b:: with SMTP id j11mr25271088wru.123.1554938129175;
        Wed, 10 Apr 2019 16:15:29 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id n6sm8504947wmn.48.2019.04.10.16.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:15:28 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 0/8] Add Allwinner H6 Mali Midgard gpu node
Date:   Thu, 11 Apr 2019 01:25:35 +0200
Message-Id: <20190410232543.13297-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Allwinner H6 has a Mali-T720 MP2. The drivers are
out-of-tree so this serie only introduce the dt-bindings.

The first patch is from Neil Amstrong and has been already
merged in linux-amlogic. It is required for this serie.

The second patch is from Icenowy Zheng where I changed the
order has required by Rob Herring.
See: https://patchwork.kernel.org/patch/10699829/

The GPU opp table is taken from Jernej Škrabec's patch
on LibreELEC.tv.

Thanks,
Clement

Clément Péron (7):
  dt-bindings: gpu: add bus clock for Mali Midgard GPUs
  dt-bindings: gpu: mali-midgard: Add h6 mali gpu compatible
  arm64: dts: allwinner: Add ARM Mali GPU node for H6
  arm64: dts: allwinner: Add mali GPU supply for Pine H64
  arm64: dts: allwinner: Add mali GPU supply for Beelink GS1
  arm64: dts: allwinner: Add mali GPU supply for OrangePi Boards
  arm64: dts: allwinner: Add mali GPU supply for OrangePi 3

Neil Armstrong (1):
  dt-bindings: gpu: mali-midgard: Add resets property

 .../bindings/gpu/arm,mali-midgard.txt         | 26 ++++++
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  5 ++
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  5 ++
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  5 ++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  5 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 80 +++++++++++++++++++
 6 files changed, 126 insertions(+)

-- 
2.17.1

