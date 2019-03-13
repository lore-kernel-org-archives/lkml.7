Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455AAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6C8206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dvtJKA6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfCMU0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:26:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43930 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfCMU0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:26:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id m35so2696090ede.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V51KgHJqDcmH3n4YkMMk7bssoj3lwJeAKxiDHn4QdkQ=;
        b=dvtJKA6mi3AEctnbLfslrx/D8JfOZ8NVCJ0cUS7Um8rXpTOhDz+lHx1ak747AMrASZ
         Rfz+WAWQ1ouxY5FwRd+vu5Kug3A2oBfrDCJj99wWcOzioOBPXPvELMGOEHbcLmXTebMR
         k9tG2N+Q/d/JFdq4XO1SrnxCzUk2sYGUuXlSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V51KgHJqDcmH3n4YkMMk7bssoj3lwJeAKxiDHn4QdkQ=;
        b=aWdwgiHi/Dr6qoiQAp4CTxLUOXvUzg1T6Vs3i2iWEvku/JOuWwvTcQlKZssJ3VW6yC
         kTcj7vVMXU/zTH/LuhnBTmii+T/BMWR79DgnjJLtCpSPzb3Xzz7q0xgY3zBvlnonuHXC
         yd8EdF/JUA+41E6W24V/+9mFsH1jFSOik9TY67cRK7lT+0PrlolIMeLDK72xM30yeEiB
         KapO1cuh8bobh5MPcr0eeLMgAThoEguhdUa6EtOEKp+YzN8BbN1HHHgvLU0KuHQkueN6
         WO1pXn6eghTps4E7HX8oqn8pui465R3UneWGq5/UaSxf3AgSbf/PZnBDOIkwHGA7DHPM
         +Lhw==
X-Gm-Message-State: APjAAAV3+izE42wrCyJC8E5nsw2AMzyjdz6dqPiSTP9s+h3cSKXo160D
        fYEh8YNqMiqy7NsQUiB5WnZQKw==
X-Google-Smtp-Source: APXvYqxglfdFwn/AJMXC40e8kGaDbQKKDncbSIcZQmoVckI3vJuw0wf4i5CKbg9TxHUD2un3HNVaWw==
X-Received: by 2002:a17:906:4347:: with SMTP id z7mr30738722ejm.190.1552508778630;
        Wed, 13 Mar 2019 13:26:18 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-119-202.cgn.fibianet.dk. [5.186.119.202])
        by smtp.gmail.com with ESMTPSA id m32sm940170edc.17.2019.03.13.13.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 13:26:17 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/4] leds: netdev trigger: allow setting initial values in device tree
Date:   Wed, 13 Mar 2019 21:26:11 +0100
Message-Id: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311144227.GA4404@amd>
References: <20190311144227.GA4404@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I asked whether it would be reasonable to be able to initialize a
netdev trigger from DT data and was told "patch welcome", so here's an
attempt at implementing that, adding some pieces of documentation
along the way that would have saved me some time figuring out how to
transition away from the deprecated CONFIG_CAN_LEDS.

Rasmus Villemoes (4):
  leds: netdev trigger: use memcpy in device_name_store
  leds: netdev trigger: factor out middle part of device_name_store
  leds: netdev trigger: add documentation to leds/common.txt
  leds: netdev trigger: allow setting initial values in device tree

 .../devicetree/bindings/leds/common.txt       | 20 ++++++
 drivers/leds/trigger/ledtrig-netdev.c         | 64 +++++++++++++++----
 drivers/net/can/Kconfig                       |  3 +-
 3 files changed, 73 insertions(+), 14 deletions(-)

-- 
2.20.1

