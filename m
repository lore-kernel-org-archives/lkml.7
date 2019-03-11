Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C69AC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF79218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=nelint.com header.i=@nelint.com header.b="IwH44vRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfCKPmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:42:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34141 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfCKPmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:42:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so1334474pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nelint.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s9xRnixyHVoINZU2BQB3v+lhu5gym36tZtZUEmGxQn8=;
        b=IwH44vRgMPKuiG9iNmsRyK/Qjd5jSr45uCckQstvG5if5ko6Gjm64O5jMisjaCzPx6
         OCwrHna8cX0c/4LKcqtGrYfvUdK0LlwHNeIEcy1ZU59US0rqu74/JvC2FjaRQ3VkNhTi
         GoQhbPygHgYWIf9TbhWvTyywQ3Tut0rgBH4sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s9xRnixyHVoINZU2BQB3v+lhu5gym36tZtZUEmGxQn8=;
        b=BWtnqkmdVXAXmzXoaP01FxL7yryT3KuzmiTVGvyh82sIln0UhTxKPsa6Z1zKw97Mtk
         Ujw7bj0yNfukCqYB8zEw9Nrp+pYcoxeh+5g5myTLTYyvwrjBsnvK1eJV8MCJf6rs5NiY
         nLiouSmHJWWN1KG+XsqA9I1672dREMxZyPE5r6e+A8S7feLEHUdeA/ThSZOi3QcImuZv
         rQ7fkQFTfeexLt6tPhfaxZe3CQYnJYxE3MY7gc686J5+fciVYN19QPGzUAAStQjm39qo
         6CGAqwRA/v22vnAc5BB7vHnWKijt5rJONX4aP8lT3yI4/LKc/Y0B5NhETMIPRsAFlukr
         LMcw==
X-Gm-Message-State: APjAAAWYKBPrSecT+DfLbJiLnYIxYfdkclmhmKFXyOBq8wA5XFxBo651
        tXm6AQEJ7iK/dFk9yv+p+HrKRA==
X-Google-Smtp-Source: APXvYqwUKvhIvTrkXmpcshHM0lOrDzYR+PkR6aJhfJuIn53CaJfJiATAZjCKVt5qo78ApIA0bYukIw==
X-Received: by 2002:a63:d502:: with SMTP id c2mr8899921pgg.290.1552318921674;
        Mon, 11 Mar 2019 08:42:01 -0700 (PDT)
Received: from localhost.localdomain ([2600:8800:1301:2190:cc32:ad00:b1c0:818c])
        by smtp.gmail.com with ESMTPSA id z67sm14349347pfi.152.2019.03.11.08.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 08:42:01 -0700 (PDT)
From:   Eric Nelson <eric@nelint.com>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     anson.huang@nxp.com, colin.didier@devialet.com, festevam@gmail.com,
        kernel@pengutronix.de, l.stach@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, sboyd@kernel.org, shawnguo@kernel.org,
        tiny.windzz@gmail.com, Eric Nelson <eric@nelint.com>
Subject: [V2 0/2] ARM: imx6qdl: remove PLL4_AUDIO_DIV clock
Date:   Mon, 11 Mar 2019 08:39:50 -0700
Message-Id: <1552318792-22565-1-git-send-email-eric@nelint.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552304271.2453.12.camel@pengutronix.de>
References: <1552304271.2453.12.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes the unsupported PLL4_AUDIO_DIV clock which appeared
in early versions of the i.MX6DQ reference manual, but doesn't function
as described in the current clock driver (i.e., it's a divide-by-1).

Since the clock node is also used to control the topology of the clock
tree, the PLL4_POST_DIV node is used to control parenting of downstream
SSI, CKO1, and ESAI/ASRC/SPDIF peripherals.

The first patch removes the clock, and the second updates several
device tree files to use PLL4_POST_DIV to select proper parents.

Eric Nelson (2):
  clk: imx6q: remove unsupported pll4_audio_div
  ARM: dts: imx6q: remove references to PLL4_AUDIO_DIV

 arch/arm/boot/dts/imx6q-cm-fx6.dts        |  4 ++--
 arch/arm/boot/dts/imx6q-novena.dts        |  2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi  |  2 +-
 drivers/clk/imx/clk-imx6q.c               |  7 +++----
 include/dt-bindings/clock/imx6qdl-clock.h | 10 +++++++++-
 5 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.7.4

