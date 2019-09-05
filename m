Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BDEC3A5AA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2A820870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzLpXBBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbfIEBQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 21:16:09 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:33868 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfIEBQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 21:16:09 -0400
Received: by mail-pg1-f172.google.com with SMTP id n9so423309pgc.1;
        Wed, 04 Sep 2019 18:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z3Ei8FyHzXCEAswMjYYL2sgHBCg2TC7hkQhTjvYG8KY=;
        b=mzLpXBBSjIfPoEznzDVi8hEGCoi8iPdVtV8Hzs4xr0PPj03usX/NK85vi1/SC3DNJ8
         cbZm8aJV/muvSP7U5x2czXSHfhO8XhBRtYzUArCTgPG2U9p6fC9vhcLGmJCOq9QXy/9t
         CqH78HGJ00MSIcznSifqNso3bpZsBijFDPVDgPHJ6++c9yIaodj1B+YLBgFe+97RUrOJ
         sxIpfha+z/sQQqJAKYoxfeq+BT3sVV1vSsS5gEArAfjltMN1X7UnOWbwlraaWgwArNeq
         UoQiewIqDIxmx42RFeNT2rw7VX8+4GIdY0qDdLSI2SIDPTkhU7xpEkVJGYxnEmFYLjP1
         waRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z3Ei8FyHzXCEAswMjYYL2sgHBCg2TC7hkQhTjvYG8KY=;
        b=GLLNn92FgYIYBZbnqNlMFAUaQRpGIUVx2SEFhCedixYy/8fxhU4eh4wPoDp/CNjgsw
         WlMFRIJ4eFrwB07Cond4OldNMQHOnKj4KfT/KYmNFSxSvSaMcF18e3M0W5jcb9vJP8U/
         I3dNKbqfltC5enmySZR+wj9nCUSNeCYuIZW4rzk9N5icv1uPzqWvOg31xKYzGBncmHSj
         Y04wSX08M1RzU+CKniboNFxfuwiiPot4W0GFpd3MOafVrETl1kr4WkbOlrV0O73cLfiQ
         cz3+DkhpZQjpJMyCPZOrU0YSgA+GfowtFKCRYHsAToyY3pMJYa+uNHmCtKhp+thCc2Rw
         4UqA==
X-Gm-Message-State: APjAAAXbz00WEH9wG/FyA6BLxtUlzbCoVhP9JFrKtj6f8ZiAA5HzssXC
        xrJIqyK44Ol6j9cNCTkjLE4=
X-Google-Smtp-Source: APXvYqzTqKmk34vcZ/2Fksg66IicendpcLZGFN0xLJvxlsd5PmuspSmVqBJQBYhJ3l6UV1K7WLBbzA==
X-Received: by 2002:a65:4304:: with SMTP id j4mr837941pgq.419.1567646168290;
        Wed, 04 Sep 2019 18:16:08 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id v43sm6300914pjb.1.2019.09.04.18.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 18:16:07 -0700 (PDT)
From:   Rashmica Gupta <rashmica.g@gmail.com>
To:     linus.walleij@linaro.org
Cc:     Rashmica Gupta <rashmica.g@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Add ast2600 gpio support 
Date:   Thu,  5 Sep 2019 11:16:00 +1000
Message-Id: <20190905011600.15821-1-rashmica.g@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: More verbose commit messages, using DIV_ROUND_UP().

Rashmica Gupta (4):
  gpio/aspeed: Fix incorrect number of banks
  gpio/aspeed: Setup irqchip dynamically
  gpio: Add in ast2600 details to Aspeed driver
  gpio: dt-bindings: Update documentation with ast2600 controllers

 drivers/gpio/gpio-aspeed.c                    | 48 ++++++++++++++-----
 .../devicetree/bindings/gpio/gpio-aspeed.txt  |  3 +-
 2 files changed, 38 insertions(+), 13 deletions(-)

-- 
2.20.1

