Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239BDC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AF6239D8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QBVD7UH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfHTH5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 03:57:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39403 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbfHTH5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 03:57:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so11315619wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 00:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tchdtmk5F7h2SP8mzdRtJmsq+fYnHuGWtMSSIw89WGE=;
        b=QBVD7UH61GHuPXpXQft/phCUoJkwNJ8e6e3nCTfc/1NqFxhFr4j7SeAnWxYD0GG1eH
         FxbH5XW57kDWs3fnFMongqoQ1DlvaP2HEF+QwPAVQ/lQo5GFUKwp/SVwc4BFQeTPD30K
         o0Miqmc2rj+PSNaKUrMIA2jxslfSsGPhlViWXng4HVm9przmpP98RN6ezcruNCRjDdFs
         FIoIFAwbfyjYsS9y6w/9wA7wyz/s/Rtmx2PuomRK8+nMZRr9Ege32OHBeVjZ7cegbc/z
         vKkrszkEVli6JHEU2P4bj0/hG/Ov8R38U/z0nQYeqal47JFkGa9XWbk9pl/x0gSf+6B/
         IsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tchdtmk5F7h2SP8mzdRtJmsq+fYnHuGWtMSSIw89WGE=;
        b=PX6nPw/d8aO4iZ9KHXny0CqgfZdNzD1CbN8tm0nUEAwhR4lXpso7nxYZmNYmod6XwY
         dnyz3832MKoX8vMN3ic3HmFGNhoP3D5NkdSO5AXMjgYCu9r9Q3mtTEhwbB2D717jeouF
         ehthdj6xA9qG9QIOMx4cMQlimcZT/KjOaSOFHStMApO73Fvl5OJJBfrimfCpa+JS06v4
         lVnto7B6v6/3iyR0YFB9dU7HkbEJTbrIeTNI/5IJZQOIYZHP4mm3fqQ5TCvY/+9UyLVe
         hZuBhpDFFGOTBR6fepguWeW0fg7PQlyT+DR+0m/eIIGZR8iBeWdodt2xhXdEyH1Xpj6w
         JLyg==
X-Gm-Message-State: APjAAAVJeH+kJ/UargphVYesJ3R7xmWv34kQseDkrcvMD6B1+sqDkC8n
        0IIYRzbLtler5S7UDC+aLv4ExQ==
X-Google-Smtp-Source: APXvYqz35DSpTf0iX8quJPKfw+8fSiZAcN4YJ2/eier/D7uQL2HGvfnfx43BsLej8/27j+Tkzhst0Q==
X-Received: by 2002:adf:dfc5:: with SMTP id q5mr33919384wrn.142.1566287869291;
        Tue, 20 Aug 2019 00:57:49 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q24sm1506467wmc.3.2019.08.20.00.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:57:48 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     davem@davemloft.net, robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/2] dt-bindings: net: meson-dwmac: convert to yaml
Date:   Tue, 20 Aug 2019 09:57:40 +0200
Message-Id: <20190820075742.14857-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchsets converts the Amlogic Meson DWMAC glue bindings over to
YAML schemas using the already converted dwmac bindings.

The first patch is needed because the Amlogic glue needs a supplementary
reg cell to access the DWMAC glue registers.

Changes since v3:
- Specified net-next target tree

Changes since v2:
- Added review tags
- Updated allwinner,sun7i-a20-gmac.yaml reg maxItems

Neil Armstrong (2):
  dt-bindings: net: snps,dwmac: update reg minItems maxItems
  dt-bindings: net: meson-dwmac: convert to yaml

 .../net/allwinner,sun7i-a20-gmac.yaml         |   3 +
 .../bindings/net/amlogic,meson-dwmac.yaml     | 113 ++++++++++++++++++
 .../devicetree/bindings/net/meson-dwmac.txt   |  71 -----------
 .../devicetree/bindings/net/snps,dwmac.yaml   |   8 +-
 4 files changed, 123 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/meson-dwmac.txt

-- 
2.22.0

