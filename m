Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF646C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5258227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lak+yufu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfLSKhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:37:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35237 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfLSKhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:37:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so5086907wmb.0;
        Thu, 19 Dec 2019 02:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dEvmcxcRbDnw5Esbmp5xNDj/bzEbhT/0+2MaiZbtS5U=;
        b=Lak+yufuDPx18PWvNvcNvX7vS14JJsdeRWOlHq1oL9NZg6j8lsNzYXzgBeW7vWY+Lg
         ma/zkuBkmnLq/u0ywSqh988wacsSEnKlu/TSPmH8bd8+L4DaRn5Am0msOuM7BNckWGND
         AUWASC5JgPjj726HcpjjhLZvPtqrfpg9JuIb5P5d3V01qs61RizLot36tNOmQK9NE5Yg
         Hk7M9OA1DwPUeD7zJZhlSgTOrsvCDUOpAUxgUxoG6leXKd7jDVz3mpaFWBke9ZzWiSUd
         0yRCKwXcRe9WnNmXZKNgk6U5fjKYCdG1qQ4FCSiS/wNJnNBuOC4JwjKxdDYkvjOhYBFu
         tEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dEvmcxcRbDnw5Esbmp5xNDj/bzEbhT/0+2MaiZbtS5U=;
        b=Jj52hyuu8Vb1vGF31ZH3LlBcJ8HJlnACl/o0TjFq0+uudfqMye2evgr9soU9jqJ+LE
         p4zKsowFpS64Uzz4zjLDxSz7oISAfXv55YdyIpIIjOdG6QdBdVT1x9yDRZrgHR6cIMRY
         mS6WoDvialFiB/cC4Es6aOqNT9KxQgeXOVRf34tsNaAxHvSgbREK1dDCnTREyPofZIGF
         k6zkJZ1A6jdMWbNmYka4UkZDy0vL5eWgFaomDvukG0imXhfY59EIMVEKrznQAwv0wfw6
         VAwBqEUsIQ9Q8MLsAaLMgCKTrfDnKDBcyyyvKXysjqlx3cMLkXP4w6BHYLnZ9epvn8rC
         mevw==
X-Gm-Message-State: APjAAAU+feILDY+tcDrHLELHvmcP9G2cn+PwLhkRCveWwatgNislc6Su
        jKVEun2Be+0vjR1A6fuDbdk=
X-Google-Smtp-Source: APXvYqwvTREV8saFCr0EAPE0obR3gxrSzVWmxDosp7ehqXK2yVaCvyLhE7uJIPB+kKC3nJsczB6ZhA==
X-Received: by 2002:a1c:9a52:: with SMTP id c79mr9149301wme.127.1576751850387;
        Thu, 19 Dec 2019 02:37:30 -0800 (PST)
Received: from localhost.localdomain (p5B3F677C.dip0.t-ipconnect.de. [91.63.103.124])
        by smtp.gmail.com with ESMTPSA id c68sm5735147wme.13.2019.12.19.02.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 02:37:29 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        heiko@sntech.de, shawnguo@kernel.org,
        laurent.pinchart@ideasonboard.com, icenowy@aosc.io,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/4] Add regulator support for mpq7920 
Date:   Thu, 19 Dec 2019 11:37:17 +0100
Message-Id: <20191219103721.10935-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support for PMIC regulator driver for Monolithic
Power System's MPQ7920 chipset. MPQ7920 provides support for 4-BUCK converter,
one fixed voltage RTCLDO and 4-LDO regualtor, accessed over I2C.

Thanks,
Saravanan

Saravanan Sekar (4):
  dt-bindings: Add an entry for Monolithic Power System, MPS
  dt-bindings: regulator: add document bindings for mpq7920
  regulator: mpq7920: add mpq7920 regulator driver
  MAINTAINERS: Add entry for mpq7920 PMIC driver

 .../bindings/regulator/mpq7920.yaml           | 149 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mpq7920.c                   | 376 ++++++++++++++++++
 drivers/regulator/mpq7920.h                   |  72 ++++
 7 files changed, 617 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mpq7920.yaml
 create mode 100644 drivers/regulator/mpq7920.c
 create mode 100644 drivers/regulator/mpq7920.h

-- 
2.17.1

