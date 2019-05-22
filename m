Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC6EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DA920675
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFJHY4yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfEVMOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:14:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38920 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbfEVMOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:14:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id y42so1976452qtk.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bOnEH385qJy9U7avXqjM772xN5YJNh9FhvyEe0IH62U=;
        b=CFJHY4yhlQ8WQ5VT/j2XOQS/u1Np/qwPH2yZ6t8jRZGLiOFavQ6OwOmcDWhCUGalia
         Z8KOh4+8r39JgEf3TCB/tjv+Kuc/YvwZRebqCVE0NaGnkeZLPsHZJ0wgtctUP3OP7j7D
         eDTFvgCljMUkqfhcMfbx17oN49L3RTF2hviHToYGZ0lkJ5Ps7TQyP+Y1+eAsQviQgcoa
         H85NybTYPQvYyk8BDmKm273oc+SwqN74xhcM5SD4w3zo8LAGDwS8T2jmdgPVnNBjUbrr
         PWbqlomebl+j6JEs6i/jxH9yD1wHRMbTfgWoUzWOcfHX+s0NnX1CTgiRMtbiijTf6YmF
         hWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bOnEH385qJy9U7avXqjM772xN5YJNh9FhvyEe0IH62U=;
        b=pDmNK2z14nnfaqpYyJu31a3zrFV2zqN+2KIAqwi7nwuqoAx+8ugEED0HBifn+K/o4Z
         FisL3yayd3engxAGvgtQ4PEQvZFJx9vircUicHMaatgCWaHWR/VdMRo5saN+/2kSjIjd
         2sLgbDguO61I7OtW5FLJeYMbPlxL1zDb6EYlDUqLhqBXz3xQwUTnp2MtT/ns5rRZh1vH
         rl5TPnicboF5Lc6OtfI5osFhA9MfF2/Ill7bNG6rII2QP6TNhEUB8pYcuqu99fuUe3Kk
         sDYw3xRiZyT4zAVYSf2o0/OF/YMrx8r9zz7ZSK3JJ1yfXewJ8pMb+sOEzhlPBmyKZH6r
         oHCw==
X-Gm-Message-State: APjAAAVodgaUWbl3O1C7Ex3v2+V6JV06lDtTShXoxhVdeCuqHLJO1OP6
        0KV0Hq4hDFbPWy31nhJRAX4P0R75/N8=
X-Google-Smtp-Source: APXvYqzD14dCaLcFyDsK5YSTE9RD8xNQd9rCyeu87tr5lpVZ9BQvmmRvsgRxMnIonL5aZMbC3hMVgg==
X-Received: by 2002:ac8:720a:: with SMTP id a10mr62057724qtp.164.1558527290518;
        Wed, 22 May 2019 05:14:50 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.dc.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id w2sm8742070qto.19.2019.05.22.05.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 05:14:49 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Matt Sickler <Matt.Sickler@daktronics.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geordan Neukum <gneukum1@gmail.com>
Subject: [PATCH 2/6] staging: kpc2000: kpc_i2c: remove unused module param disable_features
Date:   Wed, 22 May 2019 12:13:58 +0000
Message-Id: <a4bbf48414a9b7cc2f2880ea1bf06f5d0b7719c3.1558526487.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558526487.git.gneukum1@gmail.com>
References: <cover.1558526487.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module parameter 'disable_features' is currently unused. Therefore,
it should be removed.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index 42061318d2d4..40a89998726e 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -126,10 +126,6 @@ struct i2c_device {
 /* Not really a feature, but it's convenient to handle it as such */
 #define FEATURE_IDF             (1 << 15)
 
-static unsigned int disable_features;
-module_param(disable_features, uint, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(disable_features, "Disable selected driver features");
-
 // FIXME!
 #undef inb_p
 #define inb_p(a) readq((void*)a)
-- 
2.21.0

