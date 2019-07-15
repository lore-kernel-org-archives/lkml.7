Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA9AC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A052171F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlSh31vI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbfGOTrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:47:08 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41865 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfGOTrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:47:07 -0400
Received: by mail-lf1-f65.google.com with SMTP id 62so6992175lfa.8;
        Mon, 15 Jul 2019 12:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bONjuUbtQQH5jLsZ8thDiBK4rEqYehcmK7UxMShUto4=;
        b=NlSh31vIROppItWXnHjJbFVJkxD0AyWAFmCqzruwRZ0IJ0IIUT9f+vJ2FWeoA9zJCH
         iwhFAxyaXpVwchzAxpBrrn1eactGWwmJHI+kFbz223SobJ59kOPKbO7iqbfBuk6lgVCB
         5Ght/sub9vvB3wavpA2f8t8Xci4Vs5H8BN3jJPsqsllE+mfkEb68N/vTIbLXqF179Y8v
         a6cckuF6i5JwzsS+3Wwb00Esr1iw4Zcg2jclRTVI2QpKmL4bhEopcHokISUbL+uCkiCr
         nOFM/lO7KhMumApjyG84oxTsbq+CXcTPTVNyazExbnxLcoe82uepb4KnRiMVw1gUFOr0
         4ycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bONjuUbtQQH5jLsZ8thDiBK4rEqYehcmK7UxMShUto4=;
        b=Qo8e4BIO3KGOI/gIf5WQya3h4366wz3JYb/j1H0+9TttFXDA/x/GAka2SuMVAO+1v7
         HO45gRrXBjd4sDjCaTRBv6VpEdlPBy7ALssFzcwZrNBd1lU/aTnn65c/8ND+fHDUrwuf
         vJa7v8GJZHq5ufNT7VgNIqvEuDPf69Z+oY587JnWXg741eHrt9N53J1SoOODuYu5c6nE
         zPHbOSFzogmFMJK5/aHeHSxAOBaKBMLfpAhpE6XLlnzKDQ4VXzYgfFAK9XBjgU/ovVPT
         Nkc0cLCmnN8FCYFUM3QXHapuYP+SK56/vR8xbSajTNmjtDLP0WLyXTkwB3Obd6Ra8RZl
         u2FA==
X-Gm-Message-State: APjAAAVNftvl5GhBFk5A9cSVWe3YelDkh4pZ5z8A1txhlGC+UwjPWYZq
        h6C3DEdD5KChAolmZRip+OY=
X-Google-Smtp-Source: APXvYqyrz4QTINSJX7yp2FooeWd7UWe+hqpIkShSDQICtMxLsN4gtSA8RJfqmLLZDps8UTQsPb21Zw==
X-Received: by 2002:a19:c1cc:: with SMTP id r195mr12068899lff.95.1563220024867;
        Mon, 15 Jul 2019 12:47:04 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id y15sm2457311lfg.43.2019.07.15.12.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 12:47:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Support regulators coupling on NVIDIA Tegra20/30
Date:   Mon, 15 Jul 2019 22:45:00 +0300
Message-Id: <20190715194503.19100-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The voltage regulators need to be coupled on NVIDIA Tegra20 and Tegra30
SoCs in order to provide voltage scaling functionality in a generic way.
All necessary regulator-core patches that added support for the regulators
coupling are already have been merge into mainline kernel. This series
adds customized voltage couplers for Tegra20/30 SoCs, paving the way for
a refined CPUFreq driver that will utilize voltage scaling and other neat
features. This is a resend of a leftover patches from a previous series
[1] that was partially applied by Mark Brown. Please review, thanks in
advance!

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=115626

Dmitry Osipenko (3):
  dt-bindings: regulator: Document regulators coupling of NVIDIA
    Tegra20/30 SoCs
  soc/tegra: regulators: Add regulators coupler for Tegra20
  soc/tegra: regulators: Add regulators coupler for Tegra30

 .../nvidia,tegra-regulators-coupling.txt      |  65 ++++
 drivers/soc/tegra/Kconfig                     |  10 +
 drivers/soc/tegra/Makefile                    |   2 +
 drivers/soc/tegra/regulators-tegra20.c        | 350 ++++++++++++++++++
 drivers/soc/tegra/regulators-tegra30.c        | 302 +++++++++++++++
 5 files changed, 729 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt
 create mode 100644 drivers/soc/tegra/regulators-tegra20.c
 create mode 100644 drivers/soc/tegra/regulators-tegra30.c

-- 
2.22.0

