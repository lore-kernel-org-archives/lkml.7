Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA9DC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CA72084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEd6eRqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfDHVom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:44:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44647 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfDHVnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:43:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id h16so12592310ljg.11;
        Mon, 08 Apr 2019 14:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vxf6jf0I3TNkNsrZiapyq8fbjujSIosIG2y16ynybBA=;
        b=kEd6eRqE0z2WuDnDs75PDb7FoCwTYeelkZLzX0z2TqwCfxh+waChPeEgq6aCK9OpoY
         h1kHL8aToAd026GdN3VUqTlMVxIU4z3oKOYKy8CVU3VpIKibmaGb6bnXhJGDbyefryx+
         2bz4M5FxHg8R+qOzBo94YmUIvXUd/owjrvC62SC78g5apa+I5rwqKHpv8gQmYhbGENB/
         PFzqcMEM8HNnTVvkrCphbfcnbzi4AKxs+L5otKtXHkzpbZGECc6N2enxLPja9RHftexX
         cMPbqaYNs9y51xZMsxMiakKFSDB75KlV2M99BDdL6peg2sqkedDm0BZUTcKb80UeFUea
         0nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vxf6jf0I3TNkNsrZiapyq8fbjujSIosIG2y16ynybBA=;
        b=uQxbzsBMqth+EFVwXxNl8BFoEV7DIMUW2OPr+Ze/zWSHBQMWN9ZxFTJNQfIAbbc0Mp
         94a0tDc61Cd9mu6NwOKxHFJHCJO+0PYWeZNs0iTyv+U/HOzg9NE0WZb2jrtbzKA3Cach
         lnF5Eqa9hd3FRHrWDuPuQ2J3PGKbazsI94GSCQNhM+87L0w8Alhm58qaNXkLh3af1us7
         j3m6NVQSEf5xJf4x57fPxjhX3FHUSWQhmcYjrdb9+5c9v0NWPr5nm1ZCR43YENh7ZLsn
         1FZUr/C0gmjcPFne8jSZHB1H/ynIMBM+4Lsp2PhKZ7EfQkFyXD5Nj7CssQtzbkuOZkD+
         9BTQ==
X-Gm-Message-State: APjAAAWcNgA/qqrAOiwSxSwDjEmTDESgCBSZ0eI0CeEOOE0B558LPsFx
        d0ssCW6EDJZxRT6lZzjqWRU=
X-Google-Smtp-Source: APXvYqzF+x9ytABIqa1o88uB0Zp0yJSvBJXKEgO47uCtT1EVk1NKFlUbXcwp1Q/VV6hlVh6c+HPwTA==
X-Received: by 2002:a2e:380c:: with SMTP id f12mr18327410lja.116.1554759788393;
        Mon, 08 Apr 2019 14:43:08 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id j6sm5286048ljc.0.2019.04.08.14.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 14:43:07 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 02/14] media: ov6650: Fix control handler not freed on init error
Date:   Mon,  8 Apr 2019 23:42:30 +0200
Message-Id: <20190408214242.9603-3-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408214242.9603-1-jmkrzyszt@gmail.com>
References: <20190408214242.9603-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit afd9690c72c3 ("[media] ov6650: convert to the control
framework"), if an error occurs during initialization of a control
handler, resources possibly allocated to the handler are not freed
before device initialiaton is aborted.  Fix it.

Fixes: afd9690c72c3 ("[media] ov6650: convert to the control framework")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/media/i2c/ov6650.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index a3d00afcb0c8..007f0ca24913 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -992,8 +992,10 @@ static int ov6650_probe(struct i2c_client *client,
 			V4L2_CID_GAMMA, 0, 0xff, 1, 0x12);
 
 	priv->subdev.ctrl_handler = &priv->hdl;
-	if (priv->hdl.error)
-		return priv->hdl.error;
+	if (priv->hdl.error) {
+		ret = priv->hdl.error;
+		goto ectlhdlfree;
+	}
 
 	v4l2_ctrl_auto_cluster(2, &priv->autogain, 0, true);
 	v4l2_ctrl_auto_cluster(3, &priv->autowb, 0, true);
@@ -1012,8 +1014,10 @@ static int ov6650_probe(struct i2c_client *client,
 	priv->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 
 	ret = v4l2_async_register_subdev(&priv->subdev);
-	if (ret)
-		v4l2_ctrl_handler_free(&priv->hdl);
+	if (!ret)
+		return 0;
+ectlhdlfree:
+	v4l2_ctrl_handler_free(&priv->hdl);
 
 	return ret;
 }
-- 
2.21.0

