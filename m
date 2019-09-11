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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8276DECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A15721D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qa+8x6Vp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfIKFMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:12:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39836 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfIKFMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:12:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so10889012pgi.6;
        Tue, 10 Sep 2019 22:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G1atqJhw78fooRvvPUE8mHcp9MCaRCFgPOV+0K8V+Tk=;
        b=qa+8x6Vpu1yfaHZPLziOlsyW0Fut5ENSKVxo78iKAem8KThwudiHFWjAUnPu4svPxU
         oNKtxEEU/zGFO9apXP2IvAmaRew0YnDJPeNWaDlK++ouxuVibQdawzjlClxAKZCMJoFH
         tNyBvNnxBdd2Pvqfecd+G1eDYDdALqG/jKvSJHixyEE0DyW4V6EUrk3jsrHkTUt03BrT
         Iuqsa1BWuSZzJq6KxWW6JmsN1cRmrkf93l6uXGYF6p+UKj+CHQhIfJDVM2GOtXLOBMzb
         HYlI0QJKAkDKN8dZ5pZtgVbEaGDc4Eq62p+rRK62GIA/fU/xzt0bZ5tL/Sbld4YecQwK
         K61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G1atqJhw78fooRvvPUE8mHcp9MCaRCFgPOV+0K8V+Tk=;
        b=bmybXtwiZlP3ATnjBoAcWk8mxLP3NSpqmPBMyULfjJvWKyttcXJTD/kdjS9q+dnioO
         CDsIi91LNa2Ki5jXfRvfXMxc2oYNZWRYHChmodO2a24IktfCxRS8FGvXs9sRqU9+t5x8
         mBwKriO6edC/xA4mG4+M3js0YrKdkspg2bVRwwmAlfm5hVcmjBJsIA8H/KviCgL1/EdM
         bjxElrEy6TyQvWADGPtkmMzDst3bI+nkDIra6X7Ru10SXEdHiybzSGabFLLllL8T4Y2o
         aX++nEKTl4RSFX0tygXfKVp4K1WtqMeLrkNuigt94HEiM92PMY2OTo8trA9XQxOKhsMd
         WBNg==
X-Gm-Message-State: APjAAAXFMclvpR5tmI8rER9OsHpWUtjkfyV1tJYKQPFb1L0dfzDETA+B
        eB+/dnORd0vWtw9//vtSYzw=
X-Google-Smtp-Source: APXvYqxILVU512XQHtJ1q0HKDLEgPEioGglB+wpPg83nKUNahX4NpAToukPW0svopBQV58lS6l73RQ==
X-Received: by 2002:a63:b64:: with SMTP id a36mr31901398pgl.215.1568178756146;
        Tue, 10 Sep 2019 22:12:36 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p11sm22011149pff.136.2019.09.10.22.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 22:12:35 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 01/14] software node: remove DEV_PROP_MAX
Date:   Tue, 10 Sep 2019 22:12:18 -0700
Message-Id: <20190911051231.148032-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This definition is not used anywhere, let's remove it.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/property.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 9b3d4ca3a73a..44c1704f7163 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -22,7 +22,6 @@ enum dev_prop_type {
 	DEV_PROP_U32,
 	DEV_PROP_U64,
 	DEV_PROP_STRING,
-	DEV_PROP_MAX,
 };
 
 enum dev_dma_attr {
-- 
2.23.0.162.g0b9fbb3734-goog

