Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ABBC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59938208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XbjOcs4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfE1JDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:03:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44981 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfE1JDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id b8so4731560edm.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKOX602Fa7Fbm+vbgel7a44WqYHTJVV0M2SnTAYkwyc=;
        b=XbjOcs4dHqJnV+UpCk3n+c1kQCjrOCXQqy+ipr/hlU/6I1NQ5nHAEzGop2tsgNjl1i
         9Tu7wqCFwvpTcMG3rcRbnAtrjxRmaWQIlJSWJSG9NdgCSC8R+iKOe/dLKn7BQPvCbHiy
         Us7KBVkIhKGzrJgZJY2qZbATBvZ7UMCUA5Jrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OKOX602Fa7Fbm+vbgel7a44WqYHTJVV0M2SnTAYkwyc=;
        b=jBnl0szb5f1IWa4AtY30IfAFhVP3HV3oVTS7wextPtm1B3uyr8D7F2NSll7huIPefy
         1reWx5wMDMDkXt+fUJLA3/hlQ29oMzRuXnaJntzLE+nEA0T1Lj6jSH4HxsTceFGmgnen
         VaAxiTHuFkF5il8fwIlVznYdYSpAXH4cQJnVqOlID4cW/3oxkOe2dvW4HGan2wLH/FTq
         PEpLbrSFgAZNP1kL+DU8tpfMMiyZNFssnwL6DdCj57O0mWhWREqbwfCS/eJztobIsINv
         rgWq15YPUI5+FYJ6Q+wqI8RjtbhHweAt3iP9+BkCIaZoANozgkRw57EOrtJR4Mi1m1HY
         Xqag==
X-Gm-Message-State: APjAAAXczUO/SHTo0Pzxas6oquKxYp5BXhiD4v6GuWBWl7ZpaLC6BY0E
        3UNLyEN4AU1W8nUuLCWTLaA6EPQDa14=
X-Google-Smtp-Source: APXvYqyL24FlvYKpJYYc56lCsYATWOVbIhcR8IC7LZtm5HN5vQe4w00rjmH/HxYYsyvnxUX6o2yynw==
X-Received: by 2002:aa7:db0c:: with SMTP id t12mr128412092eds.170.1559034212171;
        Tue, 28 May 2019 02:03:32 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:31 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>
Subject: [PATCH 14/33] staging/olpc: lock_fb_info can't fail
Date:   Tue, 28 May 2019 11:02:45 +0200
Message-Id: <20190528090304.9388-15-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simply because olpc never unregisters the damn thing. It also
registers the framebuffer directly by poking around in fbdev
core internals, so it's all around rather broken.

Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jens Frederich <jfrederich@gmail.com>
Cc: Daniel Drake <dsd@laptop.org>
Cc: Jon Nettleton <jon.nettleton@gmail.com>
---
 drivers/staging/olpc_dcon/olpc_dcon.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
index 6b714f740ac3..a254238be181 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon.c
@@ -250,11 +250,7 @@ static bool dcon_blank_fb(struct dcon_priv *dcon, bool blank)
 	int err;
 
 	console_lock();
-	if (!lock_fb_info(dcon->fbinfo)) {
-		console_unlock();
-		dev_err(&dcon->client->dev, "unable to lock framebuffer\n");
-		return false;
-	}
+	lock_fb_info(dcon->fbinfo);
 
 	dcon->ignore_fb_events = true;
 	err = fb_blank(dcon->fbinfo,
-- 
2.20.1

