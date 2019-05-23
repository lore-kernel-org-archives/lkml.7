Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DDBC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36CE20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG3hNOAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbfEWTxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:53:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34168 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387433AbfEWTxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:53:19 -0400
Received: by mail-io1-f67.google.com with SMTP id g84so5899574ioa.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 12:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VwwctvLi8lHf/da6NNPwV0bi9ifgHdYgUIi1NMjqNzc=;
        b=fG3hNOAVmvEjft12yzYA0H4+VLHBBy08XCV07Jbccv5yXCtOyE3aiVXZrvHjU+phqy
         BjDgig5ZA7ayN1i/sEObFnJYSZjXcl+kGsVjoI8u6CCwAJziy4RXtqA1NV7Dk8QaRGE4
         ivWBsktHy6SERLiwQ/IM+KcDoZdgBGdea3uDgPerZCsjkrdjLkW+ZfiOkgYofjYqZgwe
         BtXjsLXBnKSJjO5MPpP+fAtkAGQumyJg0xtoja3yzqqgAxnZLet1JSI5DyYRruRpW+3+
         Sf3RP4JTSKQybpNQMXlgtonOvi35p5YNof5F2xzm3iE+NUicnXKi2UmwLY0rFBa08Szt
         SmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VwwctvLi8lHf/da6NNPwV0bi9ifgHdYgUIi1NMjqNzc=;
        b=iCp8JNLlZSncFBcg0HEk5vEs+DU3I4K6pDOgxQqYcFAgTTSVjbGAMrGABPUijEGkF8
         9Xj+TOoPPW0Ou/mHzZVgPusrrshzkFCZs8C97Vp8WMsZy6XeZgo+pAUyGS/JYTciKRzl
         Q1o1OkuWFbvwrqQcEpdPcWadniUFa3zfb4AZXs51dvmeILVe3pXpA7UnpVxkIafEfyI7
         Kk9fSFu/L4xLNFGvkEACZdoEk8wBWYmrpMph5luqQj1qhqDxhptsVNwshvt0oaj7WHPe
         QRALaPtjo8RiIGOhJ/YGJYyBJ/hrOQwQBptYq9JSge5n+ZaSCNKqcgpigFo5FRAjbO7h
         ZSTw==
X-Gm-Message-State: APjAAAWluBExPhFK+mBzf69gcui37HV01qjizK2w5wNY9jKqA9PB3zeF
        f5qwGLIy7DlKRdjE1+9OmNM=
X-Google-Smtp-Source: APXvYqx8C6F7hrf+pam/MfyUykBrSZUYAFI9ERx/B0RRW3eYtT9Rrb1y/B7S1A0tuYlm4UVs1vDZlQ==
X-Received: by 2002:a6b:8e56:: with SMTP id q83mr12770670iod.295.1558641198620;
        Thu, 23 May 2019 12:53:18 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id w194sm206638itb.33.2019.05.23.12.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 12:53:18 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] MAINTAINERS: Add entry for anybuss drivers
Date:   Thu, 23 May 2019 15:53:13 -0400
Message-Id: <20190523195313.31008-2-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523195313.31008-1-TheSven73@gmail.com>
References: <20190523195313.31008-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as the maintainer of the anybuss bus driver, and its client
drivers.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cac53bced08..68d49623186f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14910,6 +14910,11 @@ M:	Sven Van Asbroeck <TheSven73@gmail.com>
 S:	Maintained
 F:	drivers/staging/fieldbus/*
 
+STAGING - HMS ANYBUS-S BUS
+M:	Sven Van Asbroeck <TheSven73@gmail.com>
+S:	Maintained
+F:	drivers/staging/fieldbus/anybuss/
+
 STAGING - INDUSTRIAL IO
 M:	Jonathan Cameron <jic23@kernel.org>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

