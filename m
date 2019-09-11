Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850BCECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B895222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8THHl0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfIKFM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:12:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43480 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfIKFMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:12:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so9624444pld.10;
        Tue, 10 Sep 2019 22:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g1cvPRP3bs5HHsjzvaUvkDW77LPWNeyn8DJIQNndimA=;
        b=H8THHl0/mQmPZ4Ap7qcyQeAxlLKMV2wrAt4pVmbywN46Xk9xe9QqvPKGGWQHiJGUod
         jFAve0mJ07DTzjFpBCDRVoWxZouHGRY/G0PsgyegKp2ATERJGMhnebjZ0QEwtuBfL7tp
         0yFwFQiakZf73ITk7bDalhZxK34nkiioZwCjKG8C8JgR8Iy+grrCSO4hDEMBclcqLApR
         1iJQuXHTcxWcty7P1jb2DJRILwj5F8yw3HFHny26OoY9W3MqjaUdV4WsTih4muHi8gWt
         x11w9RmvI/qOnjUSWox4zJ9mx/prlNN9kOL6co69dBKSybcAhs5HibxvU57KVVDm35kI
         32lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g1cvPRP3bs5HHsjzvaUvkDW77LPWNeyn8DJIQNndimA=;
        b=iYuQQ9bzUlGR9Av7dWTYr2zZ/3AZYjr8Ak+91KLbQu9aiHpc64l/pD2ayY7pG1eJF5
         wlSv3KQ4I3a7/MaozQZzc6BCRb53XqmUkA5R3H5o9JXxfQj+IXGIDheQYVhkpk2LAS7W
         HHtZeG/JqV20gGo8QzGH3mPPMd6X//3SKi4v7VRps9maEcbXLSo9NNUsXCghi8RdWW5T
         Or2DLsa6JuXOukIXCzNZEKPB+lail4qZ5RIMWFqH7fWhLvdz9qFIWbotkUnW2OO0D5JO
         bairqk2UB5FewwYuix6jQZN5OMzsOeqVTu0wHs6PpQctjki4HSctlnEKKr+iwpl7EBEh
         OXlw==
X-Gm-Message-State: APjAAAVx3Jn/eO8bEVG2IdFnOYqJ5ijiHgTRyR4vbvT5+dmP0jXqVErs
        F7aE78Px/4ywUS2D6fVxjzc=
X-Google-Smtp-Source: APXvYqw1hqk7Z4iFGn5pqXwMJ0VKMJWsgTlBIweg7zfdobJL+r1pI2AQ0MGUSMw07DwvHj2B7G8m/w==
X-Received: by 2002:a17:902:4a:: with SMTP id 68mr29800569pla.196.1568178770678;
        Tue, 10 Sep 2019 22:12:50 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p11sm22011149pff.136.2019.09.10.22.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 22:12:49 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 11/14] software node: move small properties inline when copying
Date:   Tue, 10 Sep 2019 22:12:28 -0700
Message-Id: <20190911051231.148032-12-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When copying/duplicating set of properties, move smaller properties that
were stored separately directly inside property entry structures. We can
move:

- up to 8 bytes from U8 arrays
- up to 4 words
- up to 2 double words
- one U64 value
- one or 2 strings.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 83e2a706a86e..1aa6559993ec 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -277,6 +277,16 @@ static int property_entry_copy_data(struct property_entry *dst,
 		dst->value = src->value;
 	}
 
+	if (!dst->is_inline && dst->length <= sizeof(dst->value)) {
+		/* We have an opportunity to move the data inline */
+		const void *tmp = dst->pointer;
+
+		memcpy(&dst->value, tmp, dst->length);
+		dst->is_inline = true;
+
+		kfree(tmp);
+	}
+
 	dst->length = src->length;
 	dst->type = src->type;
 	dst->name = kstrdup(src->name, GFP_KERNEL);
-- 
2.23.0.162.g0b9fbb3734-goog

