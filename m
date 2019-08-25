Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E60AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 14:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D9C20850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 14:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3BjAdJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfHYOTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 10:19:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43925 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbfHYOTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 10:19:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so8777957pgb.10;
        Sun, 25 Aug 2019 07:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtYk7exTF7NfCD8WVZ5loNoPWEQYfaksEbf8ILjY4KQ=;
        b=O3BjAdJkNpamh1SmbCMA1Bzi6HhC+cUCkqC7QLbjPCkm51Ep5jVb4UAe6KoQhTxQbC
         1RvTU9evIGER0O0LJVvFEdZUW0RapKuldVzLsZR7aL+UzsZhZwpxgGXHBPABGJpMBnlw
         ZWAcsgxFfHCbIqJP/zWmESqilkuefaMSlU8sxFzmgxCFfGFwtTIWjt7JyXfK+S6r1A6v
         vCOH1TYFdS4tyOO0D2t/NtR0w6w1jCmVXbuXr6zTQDHNDKGeAy1JbazapR0bR22q4URD
         ZB1mH459wif49S4XnE670N4/zmMGR+B90TN56WGDMgSl3LUEXJVfjcD/5sbkyR4U//D3
         xRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=RtYk7exTF7NfCD8WVZ5loNoPWEQYfaksEbf8ILjY4KQ=;
        b=qtAY91OXPGczrJwYy7idXKAywavq5YmUP8Y4Vvq/imCDARmeuwu1URaZ6pUpgf27eb
         NJiiMVTWdBZLssZ9aLkD87KW/cNim+vKe6l7tLqoezkVJI1fn2MjHIHtSt1A776FIdQq
         XglA583I8200ubxMbVqAJAbbOb/3HLMnPZKJmA4BgjNGZT82illi+zX6boioSF/J8aC7
         Rtn2D8APl7LtAoH+FW+Zz1pTcd4FBj9mMfGi7vlmBLi1UC26WudhoXnugBEeaO+Wu0xj
         v4uPB2PLCLjabU4XPpd39NyjKI1Zy2x0aSnZBcmUWk2qoNAG4FOBbybO50ahGl/SvRPY
         JPig==
X-Gm-Message-State: APjAAAVec8LdDNIW/HgEhch0JmNc9pcrwtsHbdG9yUuc/x8hMpJ6Szq0
        AfEn/PTYKk5XKoESL+Xl8zI=
X-Google-Smtp-Source: APXvYqw+BdGM2bYgXLSTAm2CCYaNa7tim2PpUW6H7sQva3iK/gVHzmXGpFoQosg2DoIgat46BIqllg==
X-Received: by 2002:a63:bf01:: with SMTP id v1mr11997789pgf.278.1566742746257;
        Sun, 25 Aug 2019 07:19:06 -0700 (PDT)
Received: from voyager.ozlabs.ibm.com (pa49-199-217-21.pa.vic.optusnet.com.au. [49.199.217.21])
        by smtp.gmail.com with ESMTPSA id w1sm7734562pjt.30.2019.08.25.07.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 07:19:05 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 0/2] clk: Add driver for ast2600
Date:   Sun, 25 Aug 2019 23:48:46 +0930
Message-Id: <20190825141848.17346-1-joel@jms.id.au>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello clock maintainers,

v2 of the clock driver addresses most review comments from Stephen, and
contains a few fixes found while testing on hardware.

Stephen, I did not get a chance to move to the new parent registration scheme.
If you would be comfortable with taking these patches for 5.4 I can work
on to moving to the new parent scheme next merge window, for both the
ast2600 and the existing driver.

Joel Stanley (2):
  clk: aspeed: Move structures to header
  clk: Add support for AST2600 SoC

 drivers/clk/Makefile                      |   1 +
 drivers/clk/clk-aspeed.c                  |  67 +-
 drivers/clk/clk-aspeed.h                  |  82 +++
 drivers/clk/clk-ast2600.c                 | 704 ++++++++++++++++++++++
 include/dt-bindings/clock/ast2600-clock.h | 113 ++++
 5 files changed, 903 insertions(+), 64 deletions(-)
 create mode 100644 drivers/clk/clk-aspeed.h
 create mode 100644 drivers/clk/clk-ast2600.c
 create mode 100644 include/dt-bindings/clock/ast2600-clock.h

-- 
2.23.0.rc1

