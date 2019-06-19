Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198B6C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F5D21655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4fgvRqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbfFSF14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:27:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44228 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730996AbfFSF1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:27:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so8961108pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATz0PKN5mMI3tZTn9m6sVSXJRibqX2VwjRpjRqO0NpI=;
        b=m4fgvRqa4w0gKfGgr7Tb09fl1z18of53RtVPlYZGhKyS7wbkFjCIRgIS+vyRIt6SuR
         YW+IiW8RaYLcJxH2wyJblqm9nDO9wXTN036Vd1hgBAiJp96t7VrLWOksoNlN2rT8/PNh
         jOd0EpBkFzw6LEB+bMVWcik61tXwq5f/oV6bMEIhTYZ0NSxJcxOKpjmC0VUaKCu3TCRU
         m6nWe540I40nzXXmB+eYMfP9tRSsSgpqEumt/2fznRqYh1S0FYGuFmXhwtkJAi6Jbb4z
         rto8IX/dIU8lE7JfZ74NFMjoQHspso0MRGd8eagvxSUChfq7IvtTRpecoKlLuW75FiF+
         jBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATz0PKN5mMI3tZTn9m6sVSXJRibqX2VwjRpjRqO0NpI=;
        b=XlN/jj4bDxl93L7STRJvkkqTIx96fiVoVmBzh3ANZj+5x5n7hqCzHArilBelbBGkYM
         iN2oKReMjhwhxn2wcTmM0o02UU6TJp04Ci7fdVpjmzaod5x/juOyYqfHaKQXmSNhs5/d
         Uu1qY5HAOdWBWDvCJMVgsmC4YPbVJJRBgQ+J1BeGJUoxBuXlzHMdVHTjmVQplrS7toW6
         abADHcrdEkpH/pVUI/Bmkfcyr/woenIia9iVNohS1K0T4a76BYz81XzCcHjt6RVP7vQr
         NFeZgcuT8DI61aler6hYLFGMSnxZOUXIwjnhmo1IaMVgb8qDFReZ0UR+S5qAV6KZ9BzQ
         RJmQ==
X-Gm-Message-State: APjAAAWQTx7iozoJu35ZjBu0pNsYBoM9lq48o+H5o5gy5Fg/oy4smi5F
        2TpLAvt5GyyxprKBb26pT34=
X-Google-Smtp-Source: APXvYqyIjCuk5pABgGgNn0ewTnJGgTKriaInZyUbbTGmzPKqXlHj7H8C7t8R81dnpBNAO8bPNF9U7Q==
X-Received: by 2002:a63:195b:: with SMTP id 27mr6112948pgz.223.1560922070504;
        Tue, 18 Jun 2019 22:27:50 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l44sm534742pje.29.2019.06.18.22.27.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 22:27:49 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/15] drm/bridge: tc358767: Simplify tc_aux_wait_busy()
Date:   Tue, 18 Jun 2019 22:27:13 -0700
Message-Id: <20190619052716.16831-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619052716.16831-1-andrew.smirnov@gmail.com>
References: <20190619052716.16831-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never pass anything but 100 as timeout_ms to tc_aux_wait_busy(), so
we may as well hardcode that value and simplify function's signature.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index fe672f6bba73..7cc26e26f371 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -292,10 +292,9 @@ static inline int tc_poll_timeout(struct tc_data *tc, unsigned int addr,
 					sleep_us, timeout_us);
 }
 
-static int tc_aux_wait_busy(struct tc_data *tc, unsigned int timeout_ms)
+static int tc_aux_wait_busy(struct tc_data *tc)
 {
-	return tc_poll_timeout(tc, DP0_AUXSTATUS, AUX_BUSY, 0,
-			       1000, 1000 * timeout_ms);
+	return tc_poll_timeout(tc, DP0_AUXSTATUS, AUX_BUSY, 0, 1000, 100000);
 }
 
 static int tc_aux_write_data(struct tc_data *tc, const void *data,
@@ -339,7 +338,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	if (size == 0)
 		return 0;
 
-	ret = tc_aux_wait_busy(tc, 100);
+	ret = tc_aux_wait_busy(tc);
 	if (ret)
 		return ret;
 
@@ -367,7 +366,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	if (ret)
 		return ret;
 
-	ret = tc_aux_wait_busy(tc, 100);
+	ret = tc_aux_wait_busy(tc);
 	if (ret)
 		return ret;
 
-- 
2.21.0

