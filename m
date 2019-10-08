Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C226C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DFF21835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8G5bARZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbfJHNVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:21:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46097 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730316AbfJHNVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:21:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id o18so19346653wrv.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 06:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4kY29G0Vv0LUgp77TY4nev0SFuE29dpeYRm9kekwuAs=;
        b=y8G5bARZUMAphF+R/07LfBMyRQOM3WLFLZtB1WmAPqNPLZIXJUU3T+n8svaRVbVXXu
         fSX0iRlglv3HdI9U7Q0BG/VcvMgxpjLBtlcMUoDlKX06EOjfoI1Yy8KUHuOqyo2WjWP3
         1BlNGvTlBgy1WaIf/OMofwgZxax85EDM4giKt1zHyXq8VvaKWpNU8TCcjlngahA/3rTG
         S6474/ShvWl1Qkw5H2YS++NelF3P9nlTN39EfmLrVTqDDDQvTHEXoXxFWPU8oc323mrS
         0rCULt0aSfd+5qQPPs2jb+P37REdOfPhBv4VM663cw+IxpEopgie9YBNUsxqMIiyf766
         b4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4kY29G0Vv0LUgp77TY4nev0SFuE29dpeYRm9kekwuAs=;
        b=k2COjrby/2sNtTcjkYysDBr4XjOz6GccBwoufYunQM24AR4HUOPruZlgDvq8AAJ+L/
         obpI1QpJJ1VFKE5zA+PKxAg3SwfqN1A7Pk2yR1UKn/2RFUbnXi5hO7zxCmIOqoHln5Qt
         o/+DoNB/5F0wYfMBZ5qpIevFu747O4wokOjDkNTgApsR5b8VQG6iJZ/YkZPeVttXql5+
         QU+XnjTolgZbkZ52kncmRrOJIn5ux/26yS6WUn/RkR6py2rq5VJJl2TU0oV3VlZEMbEQ
         aTVVHr4yUj+RJmN2P2PbuHInb4fbYGqUp1rfa1SYztsLnys39hGXQV1uoxh4S/L6GD3K
         r+BA==
X-Gm-Message-State: APjAAAUqDwL6bZzoQ6OFNtr04R3wHqJz0LlY/kqj0mhoASwjHgUP2YAH
        LEPxIvh+CZvfezlkEGAgtIKbcw==
X-Google-Smtp-Source: APXvYqxNmkd7+lu3m5HT68bq8+K8jXZJIhwyxO8fds7XHqED0zcAr0wrmRONAo9NJoIqfRGy4qAdMA==
X-Received: by 2002:adf:f684:: with SMTP id v4mr24398220wrp.155.1570540865110;
        Tue, 08 Oct 2019 06:21:05 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t8sm18237214wrx.76.2019.10.08.06.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 06:21:04 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v2 5/5] kdb: Tweak escape handling for vi users
Date:   Tue,  8 Oct 2019 14:20:43 +0100
Message-Id: <20191008132043.7966-6-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191008132043.7966-1-daniel.thompson@linaro.org>
References: <20191008132043.7966-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if sequences such as "\ehelp\r" are delivered to the console then
the h gets eaten by the escape handling code. Since pressing escape
becomes something of a nervous twitch for vi users (and that escape doesn't
have much effect at a shell prompt) it is more helpful to emit the 'h' than
the '\e'.

We don't simply choose to emit the final character for all escape sequences
since that will do odd things for unsupported escape sequences (in
other words we retain the existing behaviour once we see '\e[').

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 288dd1babf90..b3fb88b1ee34 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -158,8 +158,8 @@ static int kdb_getchar(void)
 
 		*pbuf++ = key;
 		key = kdb_read_handle_escape(buf, pbuf - buf);
-		if (key < 0) /* no escape sequence; return first character */
-			return buf[0];
+		if (key < 0) /* no escape sequence; return best character */
+			return buf[pbuf - buf != 2 ? 0 : 1];
 		if (key > 0)
 			return key;
 	}
-- 
2.21.0

