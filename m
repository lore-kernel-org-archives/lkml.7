Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A0AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587B02084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=nelint.com header.i=@nelint.com header.b="EU375j1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfCKQCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:02:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40837 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfCKQCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:02:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id u9so4363207pgo.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nelint.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s9xRnixyHVoINZU2BQB3v+lhu5gym36tZtZUEmGxQn8=;
        b=EU375j1/TQ7Ls7nu4cKj9o2NipC2dPOFc7H24hn7KbWgAsFrA8C9ik+oWgASUSWkcu
         yIulvsCBJUM0N5aZ6BdaJ5YVerdxylbzI34Cr5v+OEdnkm4gECWjlEiF86a9g8aso585
         D+SQ8KgCj33yzM1DmSYomU+K+bKCKt3VQk49c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s9xRnixyHVoINZU2BQB3v+lhu5gym36tZtZUEmGxQn8=;
        b=A2g0FvXSJD9XjHfKpLjRbE+MSREbMqrr+et9lQn4n5us3GjPbVsK2w7bLCqhonEGzN
         Hk1ROuuOAp9/7ZUnOHqi/ShrwSa2LflOXOd8UwdPlzLJpQV755LKrK8nBZfwCWmE0X3h
         g673+vlsUA1E3/R9TQ2Wxt7B9P89wIH4wgnH0iyMh/Nwm+929uV+oVSYFBr5Q+QuzzTA
         fn4/B/l6owSVAS2a1VG+MhI8krGlBAKaWbzbUXWLeiZ9Gz8K9G/OaOAOIDMwbkB14WD1
         Xgk99xBvAXPHaC7YtHfSCVS0wpcsbKYBDaNccoi+NxxyI7b9P7J5OqODl7L/XphNI25t
         nDJQ==
X-Gm-Message-State: APjAAAUyOXKnEv6BQD8bg4McrrNn9/MBFNK3dAoViQ84Pz48FvYJMXK8
        pPuIh3SOCOEFpLlu8kW2+UY18g==
X-Google-Smtp-Source: APXvYqxzIm+VE6EZaadIsiNYpap3CiKLck2C2Of8BRNB7GB0b0s4r4LE70n8ux0xEX1lhnrFHqgZNg==
X-Received: by 2002:a62:4290:: with SMTP id h16mr265653pfd.8.1552320121405;
        Mon, 11 Mar 2019 09:02:01 -0700 (PDT)
Received: from localhost.localdomain ([2600:8800:1301:2190:cc32:ad00:b1c0:818c])
        by smtp.gmail.com with ESMTPSA id v8sm8319722pfm.174.2019.03.11.09.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 09:02:00 -0700 (PDT)
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
Date:   Mon, 11 Mar 2019 08:59:55 -0700
Message-Id: <1552319997-24622-1-git-send-email-eric@nelint.com>
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

