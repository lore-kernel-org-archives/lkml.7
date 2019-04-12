Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5577CC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198732084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mXUl9y90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDLKC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:02:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33890 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfDLKCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:02:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so11188772wrq.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=PWA/6bc7S3X2RU/kU2dEd3MIRRUaBhXLv9YSg4/IqAw=;
        b=mXUl9y90Pwsu7J/lJWeKJtYPi9ea+6CUmDDpl/1zN3+lzc1NmqBhscDYd9KqpZbVbs
         BT84EixGkPo7CkjMqLigFjNbpv9IHJji8RsT4MUH8EIj3xDN5m7ecxHBlol1jhLzBwvp
         UWSK6NFygyrRQtgfIDirr3eUpVM4lZl4qJsrpjCAI5s7fx9sQaHmHr9UPuQRKlt/htLG
         xHGSAWAn4VTwrvHjzjs1o9ZaWi9IZHBmmHJDUirarqhMMw1FbzQF4YqvnRrAYxD00XkH
         zQiMc7UQrCM3UHQ89z8GboRRFoKrqfc9ZwdG8Tk+WYMHuJeXyDMtDXNxg+SXRwBJu2xA
         qlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=PWA/6bc7S3X2RU/kU2dEd3MIRRUaBhXLv9YSg4/IqAw=;
        b=IMxQi20B2i6/iWzb/Rp+cDQByr/C9YnrLElLU5WWn+wIAkmA7o8rRE6MRLLU2mTgDi
         y8IFLEo8kk25soJ4ZdZCwR17Pp1HSf1XTyr5tpSSF4YR+0FlUOHmm6thl9qvy9QClwOm
         8SA8lDjM3EX0kANCaALZJYWk1NxbWdz03bjLSwYSqAEqASqpa0Vd+vew9sbuxAv400Us
         3nYn5XmCkVl2V6zrmPOUBYaue4Qn1rRzLc7yMtpb2wn1lJAXkEu8DZF35QuMMT3dv/31
         Wb8yfX0zKEKeXduTNcIdCKghaEVWaEO6A9rKDMdRnbzMQdXoOdRvbWg9zHvxw1nnEDey
         AuOw==
X-Gm-Message-State: APjAAAVB6YWNXq0yMprSA7DMs4aol6jZaR5XTGQcEd/uBquLrbgG0cSK
        28hmo45jlKpVUfX0TS/gP9Uw3Q==
X-Google-Smtp-Source: APXvYqzaF57fqkpnTt6y1DY4hx4laKgodR8kNw5bpKrHDrYAvH2tMFjrPpkA+tU6S87Bg5GUt5qVnQ==
X-Received: by 2002:adf:b6a3:: with SMTP id j35mr33344741wre.25.1555063343241;
        Fri, 12 Apr 2019 03:02:23 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t14sm5961031wmi.16.2019.04.12.03.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 03:02:22 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     jbrunet@baylibre.com, narmstrong@baylibre.com,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] Add support of Temperature sensor Clock for G12 SoC
Date:   Fri, 12 Apr 2019 12:02:19 +0200
Message-Id: <20190412100221.26740-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support of Clock for temperature sensor
on Amlogic G12a SoC.

Guillaume

cahnges sinve v2:
- rebase on good branch

changes since v1:
- fix .width value

Guillaume La Roque (2):
  dt-bindings: clk: g12a-clkc: add Temperature Sensor clock ID
  clk: meson-g12a: Add Temperature Sensor clock

 drivers/clk/meson/g12a.c              | 31 +++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h              |  3 ++-
 include/dt-bindings/clock/g12a-clkc.h |  1 +
 3 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.17.1

