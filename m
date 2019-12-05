Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E654C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4416722464
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMfoztu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfLEGRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 01:17:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36757 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfLEGRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 01:17:08 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so443139pgc.3;
        Wed, 04 Dec 2019 22:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=acB2hbSrI/zngLNzQkvvnIL+83xSTPG9++dKEaaJLZI=;
        b=MMfoztu/Me1Emx3utyq1RxfTAtVGJV+pxoVthxAIxzySRn3ULEfJGGm/zQCjbJ+Uc0
         /w+L5N/X0YRc5D1MQsR3RSK6DcNIWtmze2FRs+dodbN2YDz9y0uQj1m5SempvA6XTH8R
         4Rpp78ULGV7ENXoC+ZG2Mf+iDZg08Dh1Z6yLPu2d9pry2vs/izzBdoLaUf3yngJAL0h+
         FrI+rqU7V8l/AQrCUBhUYrrUolSWwRNXKdNszBVfsSb2B1y5ZMGAg5sEdolfpFIxdGg2
         xH7il97FP/96+E4qqOpChByhMLjhTBgYCKTDUza1d0/SPLdnNAHg+1IOJsUSHov1SVGd
         FXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=acB2hbSrI/zngLNzQkvvnIL+83xSTPG9++dKEaaJLZI=;
        b=DSTYwQ1zhNVAh0uZA7kaVZqDDrllzGIhByrn0yDWwfpQXH5iDSx1XrmJzVXab3w4CV
         eKwNJ6tTRaI1oMZxIfau+AnfpwtnjUmpqSXwDC0e0+6lRN/qYeWPQ31y0dvwyb5vYYLp
         gpUaa0Z7sq9Ob5eJ1oNuD1doLmlsDWoA+vnkHEe0sq48blIQM8AoAy9REqdI4s2zWXwb
         1S16DwNMSXiBOw7FBxirPZ2dW1i7j944hp5wZetGfth05/yNk4HwtXXYp/7lqww4xIqi
         +msoV1jbCGSCFHN/9tu5aoYxtF1bIqWI8kTOaGJCiWPn6yO2RlYawUSfJU84nh2huZg+
         O4HA==
X-Gm-Message-State: APjAAAUmw31pku0bMzoAMiam9tSPK3PCnNQZL8b0betWs3i/T8JDMI0n
        zliyakysX2cOinjXoBEo1Xw=
X-Google-Smtp-Source: APXvYqxDr+PpCs5MKoXD6jjM1Uvo4Bh5Yhcs1dGBSTBdmJ4LfNN3nJBH/VQwK2QZZWYCjmV0KlQ69Q==
X-Received: by 2002:a62:486:: with SMTP id 128mr7409735pfe.236.1575526627809;
        Wed, 04 Dec 2019 22:17:07 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:cdb:3f28:3984:ab1:9b44:803])
        by smtp.gmail.com with ESMTPSA id s27sm10564375pfd.88.2019.12.04.22.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 22:17:07 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        oel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH 3/3] include: linux: rculist_nulls: Add docbook comments
Date:   Thu,  5 Dec 2019 11:46:49 +0530
Message-Id: <20191205061649.25339-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch adds docbook comment headers for hlist_nulls_first_rcu
and hlist_nulls_next_rcu in rculist_nulls.h.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 include/linux/rculist_nulls.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index bc8206a8f30e..111a90e98ad3 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -38,9 +38,17 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
 	}
 }
 
+/**
+ * hlist_nulls_first_rcu - returns the first element of the hash list.
+ * @head: the head of the list.
+ */
 #define hlist_nulls_first_rcu(head) \
 	(*((struct hlist_nulls_node __rcu __force **)&(head)->first))
 
+/**
+ * hlist_nulls_next_rcu - returns the element of the list after @node.
+ * @node: element of the list.
+ */
 #define hlist_nulls_next_rcu(node) \
 	(*((struct hlist_nulls_node __rcu __force **)&(node)->next))
 
-- 
2.17.1

