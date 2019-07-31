Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36C4C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B892C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqaTxhRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfGaWRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:17:53 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:46107 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730164AbfGaWRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:17:50 -0400
Received: by mail-pg1-f202.google.com with SMTP id u1so43742969pgr.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Fle61vPJ2CgF1ZWEm2BgqpUqqKQrrfp1g/3hZXhBAk8=;
        b=nqaTxhRofcFBWxS5KV3bTh0/mFTwJ6GGQRRbYUnLgbrgS2BvuZuu1R0kLCjqJIwl+V
         opGYrKeXTGaIg4Um9sH2UJO0gWCV/TEuf6DMTJxXn3JtsRxNtMkQnYHwV94Fm+1RM3CS
         BQlgsKPTdD21JVzX5zxSkKOX5bPQQN4M1rdBO1H2uXGXuqe1TU3wiqIAwYpjzdVdio0b
         quWjsq8T85BYZJjirNpZNUDNLw88c02LJhb/6cGFnSecYnUy2nGQtVBqRQibDvdMBF4U
         YFGzGsc5ibxxJOQ4TK5ChE9OKUSrM8vOHOHZ58ouC0NblMJixvRlLQi7b2Bdyp3skAev
         +jZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fle61vPJ2CgF1ZWEm2BgqpUqqKQrrfp1g/3hZXhBAk8=;
        b=JkddeQXBN/V//+9ffbQkBQqfMSV8ylrAiOLjX+OjabGEsTpScaqYQ9IpS3MeJpQn3g
         J0zkKkgWQwM+DllmAliw5idlpG0MD3LB883yyFsN394muJ5u2lTvRM1nPaeslHyz+9fo
         5Fh0Q58y0wDRa1OCXdGvXKmYw/U4PIuRyLL217+1cA0U0hT2tjz7vnktjakjXVre7khM
         ePnaJf5nx0OrRayEmZQ+QTihBR4n3mzxT+z5KPmXxqurk6xmT9NpsSGxm5JxdswMV63c
         VwfhJpNoRn4JeMfn5slRTN763AGPve6CiKgCpCuf+hqfnT4oFAzMvgLau+ur8TC6p1VP
         2Hlw==
X-Gm-Message-State: APjAAAXoK+9NnsjUE1Rpl6M5sjjX4cg8ZjsMk8YjRFI8gGdVEBTGLsm7
        Y0ODS2w7tZ+nxgM4lUGE9W6DPzoTCY4yZuw=
X-Google-Smtp-Source: APXvYqxNTYEUITyUwn6GDLByMZFsij2bVHdtvK1JPN4+FWR688CFRK3H0bgrIM/X0wWVsRmHxcak7Y1MsgFhBiI=
X-Received: by 2002:a65:5a8c:: with SMTP id c12mr4729150pgt.73.1564611469231;
 Wed, 31 Jul 2019 15:17:49 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:17:20 -0700
In-Reply-To: <20190731221721.187713-1-saravanak@google.com>
Message-Id: <20190731221721.187713-8-saravanak@google.com>
Mime-Version: 1.0
References: <20190731221721.187713-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v9 7/7] of/platform: Don't create device links for default busses
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Default busses also have devices created for them. But there's no point
in creating device links for them. It's especially wasteful as it'll
cause the traversal of the entire device tree and also spend a lot of
time checking and figuring out that creating those links isn't allowed.
So check for default busses and skip trying to create device links for
them.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 36e25136e807..33cac801e50b 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -682,6 +682,8 @@ static int of_link_to_suppliers(struct device *dev)
 		return 0;
 	if (unlikely(!dev->of_node))
 		return 0;
+	if (of_match_node(of_default_bus_match_table, dev->of_node))
+		return 0;
 
 	return __of_link_to_suppliers(dev, dev->of_node);
 }
-- 
2.22.0.709.g102302147b-goog

