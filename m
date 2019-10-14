Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B13C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA2B2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YM1MA4Ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbfJNPqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:46:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38748 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387766AbfJNPqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:46:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id y18so10857155wrn.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Av3ioNZKtn1IoIkmuPv2cbQ6HyfD+1rS28OweGIOdo=;
        b=YM1MA4Ug496qhJG5JvBKwtecmdfgxLvwt5inayWrP/lErf4KHykJ7C09zxlGL0sWGR
         0BnL+DDPzZ1Ou6v+pY6BgmI+BkfA78ismkjLcC6D2QSxNMhAOLEdIMUDYx5gQLr652V1
         uVl2mEp4TXv7sAqmay1F1z/HsX4N4Sr0bs6/d5bYPqBsaHPxgjSDzqufNnCbIUMpKGCp
         1ElUPBkbaWpiV8m2jBrqZCkeNk+J4bHJvy0gNwI/KQy3DQ6D+mmqKgIr+F1qwg6I9LOK
         9ddvnBHnmgIdnTjWTelfyj2NDxWX2akx+aLMXaYRmYL+10Vwxzpb0Y+5um9HeV4sSNYz
         hm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Av3ioNZKtn1IoIkmuPv2cbQ6HyfD+1rS28OweGIOdo=;
        b=H7ayTKVYqiieF0xQAOLqGKBq6h5OxEjPzaiI9TJcpR+KA2xDf2b1Ii4oCoIf73TzVe
         N0ORFgGzIsIiQBCrS6zM0/FAihWf2g3cN66SsWCfvKYj1OvQV7b2GKQ+SBXOvSAd5UUh
         +zvFD6Yo9qtrOnXHrXd/Y2Pe4AZcYCvXGjysIr9Ezck4NCVMZ11bc4RQ1dIIiZJxSsnG
         sVy+i4BUzTbcwqdbMXnLqaNirn/0mkzg5ZClYXHfOp1O90KGvNyIE20Nja0EwFMH0Y1d
         5jnW48ol2+kS1cDC/sapWAd1UouLSdf2770X/EKrbIYtHp4LBB1XN8n3d9kYbuBOcY3T
         wvtQ==
X-Gm-Message-State: APjAAAVKmgGZXbfit+FJnzXz3vGJoX2GZofqgMXoOejels4CizBU5wgb
        EJB4o2bLCTZ0Kka7MsaEQuJhvw==
X-Google-Smtp-Source: APXvYqzYJrKpnk39yJydikl6aLQWQKXotCoJvyK9bK+1KGh5xXAPc24eb58KOqbLaiBk+LpAw9+nCQ==
X-Received: by 2002:a5d:5271:: with SMTP id l17mr27011147wrc.19.1571067996855;
        Mon, 14 Oct 2019 08:46:36 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q22sm16539738wmj.5.2019.10.14.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 08:46:36 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v3 5/5] kdb: Tweak escape handling for vi users
Date:   Mon, 14 Oct 2019 16:46:26 +0100
Message-Id: <20191014154626.351-6-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191014154626.351-1-daniel.thompson@linaro.org>
References: <20191014154626.351-1-daniel.thompson@linaro.org>
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
index f9839566c7d6..5e71bb2596ed 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -161,8 +161,8 @@ char kdb_getchar(void)
 
 		*pbuf++ = key;
 		key = kdb_handle_escape(buf, pbuf - buf);
-		if (key < 0) /* no escape sequence; return first character */
-			return buf[0];
+		if (key < 0) /* no escape sequence; return best character */
+			return buf[pbuf - buf == 2 ? 1 : 0];
 		if (key > 0)
 			return key;
 	}
-- 
2.21.0

