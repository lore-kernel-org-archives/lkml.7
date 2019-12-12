Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4FBC00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6958B22527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="swMATU3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfLLO73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:59:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54322 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbfLLO72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:59:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so2699186wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 06:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Q8cDD1h6Kbt+wm67+7ymZTLscWfxx20xc71x85bi1V8=;
        b=swMATU3v8KmM1+9GIdXKQR6jSiOWRMCOPd5Xl01rpFArfJ3XAfwd8XMvQ1jGf7EYvH
         S7MyPMiaWUjl2NpRaTx0B/o0QlP/ReDBkqJZ494uKUJZM04o8MM4jHdRMtaA9rGbcxH5
         md7ZfDoyr0+K5+Ds4FRCXnDr05l58y/YgLN/xVSuCdUTQ6J3M0y9atPTykJGq013MPKy
         taPvYnxGEb/o4PfaH6zsEyDl7nndMkomGvzcJKRL7jDZPI79kpFik1saoJHdGqJNgh+u
         lyqOOG8mSXuI/iktQ2xEuGxTypgZB83oAz+GqolP2EGv77BXqSSbpi/2IpH756bGcB87
         2MtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q8cDD1h6Kbt+wm67+7ymZTLscWfxx20xc71x85bi1V8=;
        b=rKLyvfzg1anz7j2hEX9tX3hZ4yEbbCGdwUEH4JlfW+W4T99LV6Jkd/u3nhyloAnK5B
         6bN/6amozgtlU61CoDjfO1bXpDbnvE45w3T88UXpJ4swlbJaN0yIqsbwyLeOlOyorZ3X
         d3ATy9si//GqIBLnEgOys/+kT8+tN6apk44p2G38DX+ZaY1+bZ0Sdh2EM9oFFsKy1fpt
         cPaVLif4Q7bFxhAbzoffL0RtiM7d2tWn0vyGjPjeXLmxd0lddsKcj+e7TFbkozHbcUdE
         tF+sBtHqFkabtkGTNy3HhOAYChR6GwoDv7dGmI+rAN8pLMGcW+TRUI4wg+8I378SGTV6
         uxxg==
X-Gm-Message-State: APjAAAVK3Hql8N7Wh6nG1ywexYw4RULyAfcmJwXD6uImCfofEykeK0YV
        k8gNWhbQyx+PuCU3/qG7rLEiLg==
X-Google-Smtp-Source: APXvYqxQvIfo9ValD2pZteRv78WUJy9Ja4QFpldqUrLBkg8LV7Tf3HWrTT9klIIijQsPl9BRZGoXrA==
X-Received: by 2002:a1c:1987:: with SMTP id 129mr6978284wmz.112.1576162767185;
        Thu, 12 Dec 2019 06:59:27 -0800 (PST)
Received: from glaroque-ThinkPad-T480.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h8sm6670292wrx.63.2019.12.12.06.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 06:59:26 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     narmstrong@baylibre.com, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, khilman@baylibre.com,
        devicetree@vger.kernel.org
Cc:     linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add support of CEC wakeup on Amlogic G12 and SM1 SoCs
Date:   Thu, 12 Dec 2019 15:59:22 +0100
Message-Id: <20191212145925.32123-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patchset add support of CEC wakeup.
We need to set logical address and activate some options in registers before going in suspend.
Registers address and options values come from amlogic driver.

Guillaume La Roque (3):
  media: dt-bindings: media: meson-ao-cec: Add support of ao-sysctrl
    syscon
  arm64: dts: meson-g12g12: add syscon phandle in cec node
  media: platform: meson-ao-cec-g12a: add wakeup support

 .../media/amlogic,meson-gx-ao-cec.yaml        |  4 +++
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  1 +
 drivers/media/platform/meson/ao-cec-g12a.c    | 33 +++++++++++++++++++
 3 files changed, 38 insertions(+)

-- 
2.17.1

