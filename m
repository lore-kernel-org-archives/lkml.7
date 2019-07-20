Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A542C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 06:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAD421872
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 06:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UOqEDx5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfGTGRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 02:17:21 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:54050 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfGTGRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 02:17:17 -0400
Received: by mail-pf1-f202.google.com with SMTP id 191so19978966pfy.20
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 23:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XHZhcOCJhaOJlDHmwmoOr4DNUGpZjh/DgPbCgvVVpt0=;
        b=UOqEDx5Bi4XIR97mxVHJYqDas/gsviEa+U5OwWS5eTKp23OgwAL8BATExEQrvB5K3e
         Ac5paop5IS6XUhdjTZWHgpDoDoOWqQi2476Ysg+MGrfgVAzjXMld8YKcJJHViAa1SGdX
         hUkYrdANakYTdX/zk5IO2S3mEAx8rXP3gNNE7HZjzxm4i2cCs2y3EQN9EWVdMCNnEBFz
         TpU/TMt9MQC+Ptilkiks31OWbz2LLdF0QU4/jbIyoYugEgz7isdRkNSSt9l9uvzBHksG
         rTwMTpV8jj00BNiu3t7MVWhQkTM61rPqYZoKZ3V1kwSsCQRysU/IpzFXBOUyyoWjFjvT
         HH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XHZhcOCJhaOJlDHmwmoOr4DNUGpZjh/DgPbCgvVVpt0=;
        b=kYZHmnCQ/W7euI+PQBrMT1/DUBNUVoixYpwX6tIK55qLTpOA/7J+LX2GB/jNgm7Ap7
         uwmfKWOE28NJKjZqVrwOaSlwaxUQiqEoSZtLLDxHiKYl+KH/ECt3SV+xDDB2QMl9ETtI
         DCt06KvFfYQTwkzWO3wPkQLMLWgnfAme03XNoZHLENnfjn0wpKq+eF07KM0c/HyH0PR9
         JwlaiujGMXX7HMoOjYE4ptfhAnpf4FFegwLPAPOwNHATeZL7eqoNjp5u6VRFuwuNvp7F
         JImY1Cc5iUyFsRBXp1tG0Z8RqdPj1UcxWC7aNz4TcUdINMbJaa67SePDclSYHvqERM9G
         BAYQ==
X-Gm-Message-State: APjAAAWoIapQBfIzcAkMDKq/s0O4mPdWtDXk/dSEQNZVU0LzId3sfPzh
        Dy4DIjLCxK4LXcwuz1tsRJnqpXQSn6MjTjw=
X-Google-Smtp-Source: APXvYqzAzcE5vBjP6RCbXmbEeN0ZSnHHEiMT4lXXkWB1Ez6n0o/JsYvE1WUbpT4tc6ua9le+jI6/+snaGAzggFc=
X-Received: by 2002:a63:1950:: with SMTP id 16mr58157917pgz.312.1563603436732;
 Fri, 19 Jul 2019 23:17:16 -0700 (PDT)
Date:   Fri, 19 Jul 2019 23:16:46 -0700
In-Reply-To: <20190720061647.234852-1-saravanak@google.com>
Message-Id: <20190720061647.234852-8-saravanak@google.com>
Mime-Version: 1.0
References: <20190720061647.234852-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH v6 7/7] of/platform: Don't create device links for default busses
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
index c1a116f7a087..8bf975ee2ff7 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -676,6 +676,8 @@ static int of_link_to_suppliers(struct device *dev)
 		return 0;
 	if (unlikely(!dev->of_node))
 		return 0;
+	if (of_match_node(of_default_bus_match_table, dev->of_node))
+		return 0;
 
 	return __of_link_to_suppliers(dev, dev->of_node);
 }
-- 
2.22.0.657.g960e92d24f-goog

