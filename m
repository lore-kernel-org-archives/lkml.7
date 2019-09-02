Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6208DC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3018B20644
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbb0X2d+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbfIBI6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:58:30 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:45820 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbfIBI6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:58:30 -0400
Received: by mail-pf1-f173.google.com with SMTP id y72so1084526pfb.12;
        Mon, 02 Sep 2019 01:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qNKkEatiJoZRzu3l7+tCiW/lbxptuU32yXwmrhQiGjw=;
        b=cbb0X2d+8o6qvDEi5+eUjNHtnp8B4P2+Bpa/eMT09/s83FMYUNjWDUf7DuL2em3yND
         6X0ZhAa0Tu8oYm0xrR2KMNPqWQKrW8E7Iogz63mHSQpmKzWMlAuwvayi+7ZWlkiTi+vf
         rYAlD/DSPisHTEQaYKPIzWh9Tu3cayXp4d7dLUm8n2cChVxivAwD3VBSPbndXbZo6657
         UXaj13IZ8ftwiJOZe0tke4LlZO0BFu8bdm8cGl7zWeWiPkWYiPKsXMPXSnfblsoAVw+0
         BF8c/caIajOxZW1Ad5vL7egQGOvZNbTtMzB3hvQB9cxQ5T/STwHh7SlixheJNR8ICG8e
         fRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qNKkEatiJoZRzu3l7+tCiW/lbxptuU32yXwmrhQiGjw=;
        b=GCu6KR31NAKwCWkZqZ/1fFA4KHVLYCsp3vfkozaon08waVGQn2jTscI2pPzX454j6L
         ZD3Y4bWgLHKIQkS1JgnXRC6g95+wMg4v06M80pMz6vCeSJbjHohs5nteS+0bekEUDgi9
         xAgLhpOW9NDku+rYYMAmyZtIVpmwmZC1P8p+hnm7mAB0lmJaUhN9Pq+GjRcVtXSSOEZV
         5HB52W0M0yHNCy6WHRN3IFYKb0PRRb8XNDg5rcXQjfNDNPlaFJqpbJJIYtk/jYwzPXVC
         60+mFaj3YOQ5JdHmhVTqmGGVg6LHsHMeIjXrqqbNpL/nB5ZVadEwrAnmbY9H3fJIZoat
         gRgw==
X-Gm-Message-State: APjAAAXKrjSf8giu46tl4GzIm05V0TTXSLDr81apzkT6bGT3oti6pRnt
        zJKx2+EaL/MnS07YFVa0d+c=
X-Google-Smtp-Source: APXvYqz+ki+D4n1A3ykcoqOa5nft6U8cBaJd+tedI5eD+VnnpGUSbpoErI9k9eWEYk9iujG1E8MmPw==
X-Received: by 2002:a65:504c:: with SMTP id k12mr24593144pgo.252.1567414709776;
        Mon, 02 Sep 2019 01:58:29 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.203])
        by smtp.gmail.com with ESMTPSA id y6sm6313117pfp.82.2019.09.02.01.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 01:58:29 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2-next 0/3] Odroid c2 missing regulator linking
Date:   Mon,  2 Sep 2019 08:58:18 +0000
Message-Id: <20190902085821.1263-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below small changes help re-configure or fix missing inter linking
of regulator node.

Rebased on linux-next-20190830

Changes based top on my prevoius series.
[0] https://patchwork.kernel.org/cover/11125987/

Changes for prevoius changes.
Fix some typo.
Updated few patches as per Martin's suggetion.

Best Regards
-Anand

Anand Moon (3):
  arm64: dts: meson: odroid-c2: Add missing regulator linked to P5V0
    regulator
  arm64: dts: meson: odroid-c2: Add missing regulator linked to
    VDDIO_AO3V3 regulator
  arm64: dts: meson: odroid-c2: Add missing regulator linked to HDMI
    supply

 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 53 +++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

-- 
2.23.0

