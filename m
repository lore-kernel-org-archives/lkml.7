Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6144EC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283D820818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEPnvYOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfDKWEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:04:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41413 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDKWEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:04:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id k8so6964791lja.8;
        Thu, 11 Apr 2019 15:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8kOiHton9XjNoDME7TA4eAnGiiD7GSpxhZNjS2xvlUY=;
        b=MEPnvYOnnKtFqUpgQM4ilIpHgLMR9E/d3tVcGf1J4tHnvR+3OAG9TrLf7548/pJNlu
         nAbWoiwzv8nvu8zyFOpq8D6K76gxRo3ZpgC0/Q6m5c0ZTNbXLmczUG/o15ddA9304LAE
         0ZA4CjP90DXGIR86GQNRq7GbMft78i5WEs5Khak5Pcaa5g5eSgJbrVd4iGPmZIPudFIZ
         1/q+H0TSGUKbx/wEQ3WXwXpMnu/yDComAtXyRl8uRgDf2n15zoE/c8uxy0O5aj5kPtzi
         jRSGwE3s65VK8siCXBx3LoW1XeS13cyBgNue8x7N84rK4y2cQiMA4CiD2jApCgcOim+A
         b24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8kOiHton9XjNoDME7TA4eAnGiiD7GSpxhZNjS2xvlUY=;
        b=s+Nhn+ZSxBhKLQDFSJMRRo7WsVJjXzH+BmI07+ZC7L++iN44Uh7KAzOu38swDTKj34
         PJ6I+fkn6X+OdIUr4ja3MIXKmqKZDB46OR8EUhfwP8BSJHT7h16kp5JUzcCZh7euV31G
         Pu+OvdANn1sZU7qV6SX4H+RFE/TwB3h6A7BKbA7AgK0jGx4l0hBdAibfPXd8l+ZWYrfQ
         nQ3ikT85sgdscediJKK6ieIA1iPn+JELYgQ8RyYESc3vxo21z1MW4SXRvqnykWQaslxe
         /NzCkrNRwe9/RqD+qjHGuf6A0xGglP9ZUHiU7JmV34XTCDO0vqyzvZMR3NbqAcRuP+fN
         sKZg==
X-Gm-Message-State: APjAAAX8OH+CIsYQbrxmumY0uF5z0r/8O+23RQmog804X/sjW8d8Bnek
        Htw6loj0HfYNauc2NR6REko=
X-Google-Smtp-Source: APXvYqyobIY1Ezoe9o8hcuJMyWc/5zlAoTGgmYT+H/1aKuxfFjVMBBzBdoKIehf6e54ML/HnRwGUTw==
X-Received: by 2002:a2e:864f:: with SMTP id i15mr29904580ljj.99.1555020262465;
        Thu, 11 Apr 2019 15:04:22 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id e18sm7887808ljb.12.2019.04.11.15.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:04:21 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] clk: tegra: EMC/MC clock fixes and improvements
Date:   Fri, 12 Apr 2019 01:02:25 +0300
Message-Id: <20190411220230.21726-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I was helping with fixing EMC clock scaling on T124 Nyan Big and
in process found some weak points in the code. Primarily the ram code
parsing didn't work if device-tree defines memory timings for multiple
ram codes and after fixing that I spotted few other things that could be
improved.

Dmitry Osipenko (5):
  clk: tegra: emc: Don't enable EMC clock manually
  clk: tegra: emc: Support multiple ram codes parsing
  clk: tegra: emc: Fix EMC max-rate clamping
  clk: tegra: emc: Replace BUG() with WARN_ONCE()
  clk: tegra: divider: Mark Memory Controller clock as read-only

 drivers/clk/tegra/clk-divider.c |  5 +--
 drivers/clk/tegra/clk-emc.c     | 57 ++++++++++++++++++++-------------
 2 files changed, 38 insertions(+), 24 deletions(-)

-- 
2.21.0

