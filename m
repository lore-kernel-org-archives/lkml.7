Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F47C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A0020872
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmVry1PR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbfDACY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 22:24:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34834 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfDACY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 22:24:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id g8so3943946pgf.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 19:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bwek2lW/mZUAi+kUhEqboTH9lpaEl7m316w92RabMBc=;
        b=dmVry1PR9/dqHNxLOyORfdn9RwK/onhIJOhe+J4mzGiSSuRTg1bAQ5uXgBVEAmuWW/
         6mKhoLMHCIHDuD+dPC/yqxJdvkOuzDF8dS8LJzp+Qk2G8tv0EZThA5NV3MTjFqc9+OBl
         EO14NRBVU/GVNdiF98IpD12xXiY5b7M0ankMuzuATzji2lPC4+e2IpAy2DNK+EzwdUNN
         av5HCmki3rXkk4BiDFiF0LMRdl48OQvWQaEDAHlG3l/oX4daVpNJSRf5hNfhdnKCoE3h
         Xi+BwlwC7GfkYciwwwF7HLA0X76yeqM1qe9bTm+a0lL0cbfBk8XB0VxLljFV686MLe2r
         AiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bwek2lW/mZUAi+kUhEqboTH9lpaEl7m316w92RabMBc=;
        b=g/xko4IeAx0NNvuHzVo+5jwOBpcuqw+vOB/DeJsDzo3+ja1/1Q3/OjKYobM1leNQjF
         mKW7Eqx+j/Y/7ZN6GqM81Z3k4MdF2Be6NKSfNSTFCimTjAcqUQ+Ubmw/+hIZu6hdRl3s
         jo+cG6pbUmljdl1b/ow6uFirmLZopRkXRdZ3PnWb/vTqaZ8fIFuT24SIhN/B0C/h/jx7
         AC9rrKbhqlcvvhhC4pQA+M7TkWfzBDxetJhHiuRmKeXKeFjVJELEy9J/uwrKC20TYqDu
         fDjzo9m7deJvrHK9b9gDBXjFvpYZd3CE3LiIzy1daUlBfLdntsPo0FRKxshbljfu5v99
         hOLA==
X-Gm-Message-State: APjAAAUp2nvDy0tITJrtzP+AmWO39F5QI6fwq0WJSdANNJ5PYDj98D0T
        14iQYqjxp8daGY+sSHtnXHk=
X-Google-Smtp-Source: APXvYqz/fyv+C+SQdi6B/Lm03v5y7wv7NIn8v8kK59bboc7PzzxHTReUEyMNIPuiJcR+/Dt8mYwFVg==
X-Received: by 2002:a63:c34c:: with SMTP id e12mr4020520pgd.279.1554085467771;
        Sun, 31 Mar 2019 19:24:27 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id n82sm13597289pfi.63.2019.03.31.19.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 19:24:26 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] PCIE support for i.MX8MQ (DT changes)
Date:   Sun, 31 Mar 2019 19:24:08 -0700
Message-Id: <20190401022413.6682-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series contains all of the i.MX Device Tree changes I made to
enable support of PCIe on i.MX8MQ EVK.

Feedback is welcome!

Changes since [v3]:

    - Added "num-viewport" to PCIE nodes in "arm64: dts: imx8mq: Add
      nodes for PCIe IP blocks"
      
    - Rebased on latest for-next of i.MX tree
    
    - Collected Reviewed-by from Lucas for "arm64: dts: imx8mq-evk:
      Enable PCIE0 interface"

Changes since [v2]:

    - Fixed various nits pointed out by Lucas

    - Collected Acked-by and Reviewed-by from Lucas

    - Moved EVK's WiFi reset pin configuration into a separate pinmux
      entry.

Changes since [v1]:

    - Dropped unsupported IRQ from PCIe nodes (a leftover from vendor tree)

    - Added "pcie_aux" clock and moved clock configuration to board
      file since "pcie_bus" clock is now board specific

Thanks,
Andrey Smirnov

[v1] https://lore.kernel.org/lkml/20190131204333.31846-1-andrew.smirnov@gmail.com/
[v2] https://lore.kernel.org/lkml/20190208002941.30343-1-andrew.smirnov@gmail.com
[v3] https://lore.kernel.org/lkml/20190220015857.7136-1-andrew.smirnov@gmail.com/

Andrey Smirnov (5):
  arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
  arm64: dts: imx8mq: Add a node for SRC IP block
  arm64: dts: imx8mq: Combine PCIE power domains
  arm64: dts: imx8mq: Add nodes for PCIe IP blocks
  arm64: dts: imx8mq-evk: Enable PCIE0 interface

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 42 ++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 87 +++++++++++++++++++-
 2 files changed, 127 insertions(+), 2 deletions(-)

-- 
2.20.1

