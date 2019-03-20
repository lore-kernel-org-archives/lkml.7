Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23492C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03E52184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU+oLl9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfCTRsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:48:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36770 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfCTRsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:48:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id d18so2584518lfn.3;
        Wed, 20 Mar 2019 10:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CGQh4afoDBme1hb62DaNdpATkJ+u8Yt7kgWs9YFM8bo=;
        b=nU+oLl9NF+D0KpBfJNI+o+hWrtS7HNpfcZqyuKG3qeP+WnsV/3LDQKRdg7LxQ3z4cX
         CcKVlKipMidRpIh2orR8syFA31dC2RGsYoHOYX+J8lKznUYK7gLy+pl6Hz9hGgXgW5T8
         TnKg+KF2wdRkNTNlRyWKYPLrCFT+DnXxuqkSz0KYXu2cGAm5/sd35DjK5r80smzzqhL/
         tXuCs/qiciEac7BMLU777orf126NZ4mTNAXIzmoMoSzKKOZQCzFW9v0A3xD5VeHYktgT
         +x1sQx25rtOpAFFWUEAGRr+BF1lIGIl17Hp8K9Dflrc+ofzNzYD4VrPSFsJv4mJ+huen
         zzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CGQh4afoDBme1hb62DaNdpATkJ+u8Yt7kgWs9YFM8bo=;
        b=pEYqjLNnAqrNu5gJde4+3Zwg4t+0ZEYtHlGafpXrF1Xt21bEQWCzxKdeJZzO7fbvB+
         P7nd/vK71TS1z+j8UjUPR6z5ffdcCot2bWaR7v+ILtCedW5m6aekBUvMS73wgW8ywYlu
         MfUTn1txcUqNxYmqHbZi3N+J/ysx4u+amnYKb6jc1nC2o6SEF6hThpVtjyJseuFCkn3q
         WWSAHno7WvJp4avII9568VzXWvbUZ354yVL8BRHG2sAchsDV7O4TeJAy7fvsIMXq/Swn
         DRvugQnpj6ryT8RMOwGJa77s1H+bpQUa1LZC1Koe0De+5eRNCk9oTrUs5iHLSN+ZwzFn
         d+5g==
X-Gm-Message-State: APjAAAV6COcJ0BckPuNEmERkCMHpgAGh2zesDoIXbM1VwcbuB0McupBk
        4DgNiqG2aMFHszaMw+I4dgM=
X-Google-Smtp-Source: APXvYqzK1dqOxV+fIT8xGgKX7Z3/BFSRRpWo5jN5HBZsyAjH6mVKjb+Yn6Lr0v5mFrxOdInYr2hZsQ==
X-Received: by 2002:a19:c209:: with SMTP id l9mr16205797lfc.68.1553104101447;
        Wed, 20 Mar 2019 10:48:21 -0700 (PDT)
Received: from ubuntu.lintech.local ([80.87.144.137])
        by smtp.gmail.com with ESMTPSA id m19sm479959lfb.78.2019.03.20.10.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 10:48:20 -0700 (PDT)
From:   Alexander Kochetkov <al.kochet@gmail.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH 0/2] Fix eMMC hang on rk3188 and earlier
Date:   Wed, 20 Mar 2019 20:48:03 +0300
Message-Id: <1553104085-32312-1-git-send-email-al.kochet@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I found, that sometimes dw_mmc driver stop transfer data to
eMMC card on my rk3188 based board. One of tranfers hangs then
doing EDMA transfer and controller gives HTO. And here is a fix.

Alexander Kochetkov (2):
  mmc: dw_mmc: add init_slot() hook to platform function table
  mmc: dw_mmc-rockchip: fix transfer hangs on rk3188

 drivers/mmc/host/dw_mmc-rockchip.c |   19 +++++++++++++++++++
 drivers/mmc/host/dw_mmc.c          |    4 ++++
 drivers/mmc/host/dw_mmc.h          |    2 ++
 3 files changed, 25 insertions(+)

-- 
1.7.9.5

