Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EABC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB0220B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RTZRwX5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbfHFMuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:50:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32866 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbfHFMup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:50:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so8887102wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 05:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i8yW7mVu+nN03VbqETwhpsoLUtIU4YcLbfhs55o7BvE=;
        b=RTZRwX5lhpwBk5ffpnQxAAYx7/cLanVfmlliMxc8iNALHbRdTPbkXa73FiQngVF4k2
         gSR0nOfzERuCwqrzYPvSe6lQofqNqPqmAIDQYitxE/mLl6BCuiy1cQSaNQfPw+V/7ShZ
         tnjlpMi5kgAstEAkSvRTFWs3Te4PCbUIiafni+sBHmgX7jOygkvQuhor9CBfI3jXaA+N
         qYJFwoWghWxkSlGmDwY4Ooltorgm5bfc65AOpvepNg1wS1RCvbIZRmCj0LVKqLMy03cg
         NPYjcOmyId0MlWnqhIp2J1V6qUTGUTpSHrJDxbxu4lRlPJ82xwQBpdT2BHMDT5IF/ItJ
         fEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i8yW7mVu+nN03VbqETwhpsoLUtIU4YcLbfhs55o7BvE=;
        b=SaH7+bxbOd4OLelqg+Gl4BSh3CYu4ynGeqstNUnYSRUuZG8Z8tCrVfjCgQ2gTItw3j
         pl6x8s0iX7nvEnie9/g9U1B/qwG8W5t/QmBLO8w4SiSkJnLt2N2V2038/c+1TmyQvBdK
         hyl0vB9KE63rT7dFIEXi0U1/pp1BAWUD4z0yVJd9SKoBDGy45fZvNIbUCpVWw8ONkU2w
         tnN2IXqYKx+U3Wo/eraOBx0r8t6Ms8Qr5nlVPmRBdwuzXx0dUBWKRxcLVWb/g92ZW74V
         LBtoiDc6z5wv16izAbv+UZvqdkEHXcIaiFZoda2VLV4G1zjLCgNKP2n+C+UqHOre8sia
         dXXw==
X-Gm-Message-State: APjAAAXm5nsQUxXsvKlyd75lEWnWovQruGs/cL9nlfMydsk9mWZGImZ0
        H3NkwcpmHdo27ASJZi4r/2hRgw==
X-Google-Smtp-Source: APXvYqyO9qfySQufHv8FTPVAmHGN0v/i1YcTHeQd2dt7QxoS3vNu24XyzJhi5stC39e658qAYY58Sg==
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr4611089wma.23.1565095843565;
        Tue, 06 Aug 2019 05:50:43 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e3sm109049221wrs.37.2019.08.06.05.50.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 05:50:43 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] dt-bindings: net: meson-dwmac: convert to yaml
Date:   Tue,  6 Aug 2019 14:50:39 +0200
Message-Id: <20190806125041.16105-1-narmstrong@baylibre.com>
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

Neil Armstrong (2):
  dt-bindings: net: snps,dwmac: update reg minItems maxItems
  dt-bindings: net: meson-dwmac: convert to yaml

 .../bindings/net/amlogic,meson-dwmac.yaml     | 113 ++++++++++++++++++
 .../devicetree/bindings/net/meson-dwmac.txt   |  71 -----------
 .../devicetree/bindings/net/snps,dwmac.yaml   |   8 +-
 3 files changed, 120 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/meson-dwmac.txt

-- 
2.22.0

