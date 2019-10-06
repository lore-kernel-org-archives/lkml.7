Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D90ECE58B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 20:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB7C2133F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 20:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blJ+tDl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfJFUDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 16:03:35 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36868 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfJFUDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 16:03:34 -0400
Received: by mail-yb1-f196.google.com with SMTP id z125so3974665ybc.4;
        Sun, 06 Oct 2019 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PIaX21W8I9U+EF8hoBafqL2VfdvHvRxIA6u3x9/TwM0=;
        b=blJ+tDl8nG+FSdKewzSogp8WX4feg6K4mc5o3Fp+NyudNHmPlRGHJKHYyi3Dj0xOkv
         Us73dYpeeXifqLcgdM7PX4S/pUTCneN+KVMetVEJaDNO7VZyM9xbHbUSQy7NGRtXOrhh
         h8StpYzvNVVKJofD45zTFy+8iSfQKp+UUWfuGkUt9Z30wAatg9QkDUCc68Dl92za0EMf
         WimwZNQ+QHrNuB8VCVgxJNs0PnHKUX6oveNe14tkFHHhvrAwHA5rGSCXF+7LylvHdl9k
         GEQYNkWZE7HlncbmWwGSiiCFJv0aOQilT1YY2FBk+wTx64Q3I5oMqK0HdJuIw+1Dh+te
         8KeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PIaX21W8I9U+EF8hoBafqL2VfdvHvRxIA6u3x9/TwM0=;
        b=OK5kXO6rvvs10GaXZwwoT6STuWuLCmlELrqQPmbLYnro1PXgDB/2KCM5ycMndwdZFs
         RWI7bmG26OPYj6wzwdPmjoOBTymr2UoY6ddmEwN8Bz4QMdR+2ydurUXs2HCMxUu8q3k8
         N5Nmy+J2dFtPM4Bvy4BpvAVSwiqZQcCB+lo9y4/E+HqJYJ9zhr3tZDtYKWw6ze/huaN4
         50sJCdueo2DwiVDwvEWFCxeWBUTQe1LG+n4PduaqSCwjaqRhdtmU9Pbxa0q3MVNqcAj/
         rENsRfNNR1sMqoubJ4USxVhpinr8lWbB2b/Vo3BqayOsoIFDikSOknINx+4pFygOxJIq
         B+Rg==
X-Gm-Message-State: APjAAAU9XJyjK+iBft0FSFEpQSK18rYmNou2r3TCtuhycQANeY+JWEkW
        BY+9MIDeY0HGHlXjibvqmFk=
X-Google-Smtp-Source: APXvYqz4mvN9s0757t230hmoQhGHOxs+DNUn1yMwWNnvg3C98M+iXwK0v5AeIOh5LLFcDlzwU/Briw==
X-Received: by 2002:a5b:b05:: with SMTP id z5mr9181818ybp.7.1570392213485;
        Sun, 06 Oct 2019 13:03:33 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id x16sm3765266ywx.103.2019.10.06.13.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 13:03:32 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, benjamin.gaignard@linaro.org,
        david@lechnology.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v5 3/3] counter: Fix typo in action_get description
Date:   Sun,  6 Oct 2019 16:03:11 -0400
Message-Id: <4d8dc1e31aaa02e2d0a1ea580f1923075967db5b.1570391994.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570391994.git.vilhelm.gray@gmail.com>
References: <cover.1570391994.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The action_get callback returns a Synapse's action mode.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/linux/counter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/counter.h b/include/linux/counter.h
index 32fb4d8cc3fd..9dbd5df4cd34 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -315,7 +315,7 @@ enum counter_signal_value {
  *			Count's functions_list array.
  * @action_get:		function to get the current action mode. Returns 0 on
  *			success and negative error code on error. The index of
- *			the respective Signal's returned action mode should be
+ *			the respective Synapse's returned action mode should be
  *			passed back via the action parameter.
  * @action_set:		function to set the action mode. action is the index of
  *			the requested action mode from the respective Synapse's
-- 
2.23.0

