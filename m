Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B54C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C0120678
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dedZSRuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbfIIIQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:16:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38789 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388894AbfIIIQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:16:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id d10so7379858pgo.5;
        Mon, 09 Sep 2019 01:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1NaGIdifoHoi5DE8UKrKYLjoFcMpvhfjVaM5arPhhJQ=;
        b=dedZSRuCxvBtNKqMlhNtJ9Mv6MXa8vFcQIkGB9h+GKgF+urQR6PjlTYF5D7tcgiRxL
         +0QFdz/+FnFzi14dgllD4FIhFqfeh02GjSE80OKWiolLPCJAPKbL0lF1xBe6YXvwST+0
         gXwwAYZDMJ3S3USCdqCG4CmsHtbIQXdjt14AHsCKiiuuof7R596taP/i5dDePZM6cz7I
         gnsyTBfQd1W2SCGT02lpFIKtP42ISxVZ68Cu9gL37WYJ0e5v+W4pXCWYat3iQ3RPVKmi
         APp5cfhcvXKDD9lTQjCNmtcx89RHKFXQnHXoRpW8WsLiQ/eRlv7wPv9kP55iGt5GJ5RV
         XpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1NaGIdifoHoi5DE8UKrKYLjoFcMpvhfjVaM5arPhhJQ=;
        b=rHeefabNxf64VoHTFVL49/PFoQ0WLNLEk8b6anaRkwdJ+sxAMR3lDM/dvZXppJrFDc
         cqFtTrOHwlU5UWKE4pFqrehcEBCysOJ8zLQccOw3OfRyOhiXZm44gAepGetgKl5pMLCz
         RcF89+K/hzsujG1WwpgjycVY5bWCOsbiWxjapUFkcx2heYD4SLd55pdPJlGZfOeSuOmw
         YpZ74RYi2h8I/QAQdjJuqRFDBm+SBfUfmYtfVMOcmUdH3bChqE/qC7r5paswvtXYwdpA
         LeYq22aepO8zOG/9/k9rXwX8bGvAUivT4b8gIufplZqP5PQM++nPD9La4sJLNlwFIwzP
         nZ6Q==
X-Gm-Message-State: APjAAAXRYlX+33qOFlogjzgF+7AWts18qWFty1JIuZKZz3exv5kZxnTG
        Daosmo28v7BLk/4Uw2km/88=
X-Google-Smtp-Source: APXvYqxV8z1N8yFextKJa8+KzcBC+66SKHPqSxeN5GMbIyYQZN2N2xUPasPAOu7Ek3MH0hdmb6hEXg==
X-Received: by 2002:a63:204b:: with SMTP id r11mr20453931pgm.121.1568016963971;
        Mon, 09 Sep 2019 01:16:03 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u65sm12686669pfu.104.2019.09.09.01.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 01:16:02 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 02/13] software node: clean up property_copy_string_array()
Date:   Mon,  9 Sep 2019 01:15:46 -0700
Message-Id: <20190909081557.93766-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
References: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because property_copy_string_array() stores the newly allocated pointer in the
destination property, we have an awkward code in property_entry_copy_data()
where we fetch the new pointer from dst.

Let's change property_copy_string_array() to return pointer and rely on the
common path in property_entry_copy_data() to store it in destination structure.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index ee2a405cca9a..7bad41a8f65d 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -337,8 +337,8 @@ static void property_entry_free_data(const struct property_entry *p)
 	kfree(p->name);
 }
 
-static int property_copy_string_array(struct property_entry *dst,
-				      const struct property_entry *src)
+static const char * const *
+property_copy_string_array(const struct property_entry *src)
 {
 	const char **d;
 	size_t nval = src->length / sizeof(*d);
@@ -346,7 +346,7 @@ static int property_copy_string_array(struct property_entry *dst,
 
 	d = kcalloc(nval, sizeof(*d), GFP_KERNEL);
 	if (!d)
-		return -ENOMEM;
+		return NULL;
 
 	for (i = 0; i < nval; i++) {
 		d[i] = kstrdup(src->pointer.str[i], GFP_KERNEL);
@@ -354,12 +354,11 @@ static int property_copy_string_array(struct property_entry *dst,
 			while (--i >= 0)
 				kfree(d[i]);
 			kfree(d);
-			return -ENOMEM;
+			return NULL;
 		}
 	}
 
-	dst->pointer.str = d;
-	return 0;
+	return d;
 }
 
 static int property_entry_copy_data(struct property_entry *dst,
@@ -367,17 +366,15 @@ static int property_entry_copy_data(struct property_entry *dst,
 {
 	const void *pointer = property_get_pointer(src);
 	const void *new;
-	int error;
 
 	if (src->is_array) {
 		if (!src->length)
 			return -ENODATA;
 
 		if (src->type == DEV_PROP_STRING) {
-			error = property_copy_string_array(dst, src);
-			if (error)
-				return error;
-			new = dst->pointer.str;
+			new = property_copy_string_array(src);
+			if (!new)
+				return -ENOMEM;
 		} else {
 			new = kmemdup(pointer, src->length, GFP_KERNEL);
 			if (!new)
-- 
2.23.0.187.g17f5b7556c-goog

