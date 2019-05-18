Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1B9C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6427C20848
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6iVTUcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfERGe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 02:34:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41940 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERGez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 02:34:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so4726185pfq.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 23:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tfIilT2Dk8Ch0JJk6m3jz6rz/B2rmLh1tKfEeGpFF5Q=;
        b=N6iVTUcTKDgb7kap1rJ7kyIaAKTa4aehB2CkvFSDEUO24f4c7v0wj2hGNyrriTEsid
         hfpsZvutmYrtCJ6D8PKQNoWG7YMOiDvxS8T1Mxn/P/IEwG02TrqjjOS6MjIeCtLxOrXq
         +85KNS0d3uFy12TjnN/26Q1AvvvJkm18M7C+2fjvAoOEbUbvMaLmcUpi6jAJd+hNFqFS
         HNjJ/9IUAvDL29QgH+L9SsbI4C+OPghz9KH+/Z3KN3nlkLbRqbwTw/tajGiDsqxQYuFN
         DWHH4MR3St7/OR5uSlfJ90+D/x9gIDGf4xn+YNMVdKqXWTGqLDypEyIxN8rWQRjCU8eG
         ZfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tfIilT2Dk8Ch0JJk6m3jz6rz/B2rmLh1tKfEeGpFF5Q=;
        b=WHZmqGaJ6+dIwYIahdE4WYz2HOwsom+aQP7Mif9u99DiTmP8pmdEaWzfCvsPANpIKb
         wC3eoW1tv42cMx1zYebaoeaxyZ8EpEroCT01riHCV6FQFQc3bgb0IGssRxeywKeEKML9
         8OK6lEgy2WbnmyvSnmNr/BBmmNP2qqsSi44aREtMiQvjynDmTqeuoL36IlLQqBnGCEDA
         RltXCCtV/9hga5Gfmt/r6hCl7sHM5GJMQ1dJV6DhAYXPNxXHUmwQIPk9l96KcwfHYPwZ
         W7mmDvcQuh9/DUcTz18f7rriWcJFcXHJQ5OThL3sB7TuuPQ6UVufd/m7piMfbGSdP02f
         GBJQ==
X-Gm-Message-State: APjAAAWfuAgLYiL2BjNQpLGrJUGMT8e+3fCeO6fAZD0auw/5H/BQ/QS1
        NoPOVD1yFuZXevCg35MNF14=
X-Google-Smtp-Source: APXvYqwsj3AvQNNxV2hS+9CFlRon+hwhMEOu7XorWWjr/pRqdXAr5c+gYAOyS4qlJwiEAioyyjPXkw==
X-Received: by 2002:aa7:93a7:: with SMTP id x7mr65967796pff.196.1558161295206;
        Fri, 17 May 2019 23:34:55 -0700 (PDT)
Received: from localhost.localdomain ([103.227.98.84])
        by smtp.googlemail.com with ESMTPSA id h26sm14347874pgh.26.2019.05.17.23.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 23:34:54 -0700 (PDT)
From:   Moses Christopher <moseschristopherb@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Larry.Finger@lwfinger.net, david.kershner@unisys.com,
        forest@alittletooquiet.net, davem@davemloft.net,
        ruxandra.radulescu@nxp.com, yangbo.lu@nxp.com, arnd@arndb.de,
        christian.gromm@microchip.com, insafonov@gmail.com,
        hdegoede@redhat.com, devel@driverdev.osuosl.org,
        sparmaintainer@unisys.com,
        Moses Christopher <moseschristopherb@gmail.com>
Subject: [PATCH v1 4/6] staging: rtl8188eu: use help instead of ---help--- in Kconfig
Date:   Sat, 18 May 2019 12:03:39 +0530
Message-Id: <20190518063341.11178-5-moseschristopherb@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518063341.11178-1-moseschristopherb@gmail.com>
References: <20190518063341.11178-1-moseschristopherb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Resolve the following warning from the Kconfig,
    "WARNING: prefer 'help' over '---help---' for new help texts"

Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
---
 drivers/staging/rtl8188eu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/Kconfig b/drivers/staging/rtl8188eu/Kconfig
index 4f7ef287a0f2..970d5abd6336 100644
--- a/drivers/staging/rtl8188eu/Kconfig
+++ b/drivers/staging/rtl8188eu/Kconfig
@@ -8,7 +8,7 @@ config R8188EU
 	select LIB80211
 	select LIB80211_CRYPT_WEP
 	select LIB80211_CRYPT_CCMP
-	---help---
+	help
 	This option adds the Realtek RTL8188EU USB device such as TP-Link TL-WN725N.
 	If built as a module, it will be called r8188eu.
 
@@ -17,7 +17,7 @@ if R8188EU
 config 88EU_AP_MODE
 	bool "Realtek RTL8188EU AP mode"
 	default y
-	---help---
+	help
 	This option enables Access Point mode. Unless you know that your system
 	will never be used as an AP, or the target system has limited memory,
 	"Y" should be selected.
-- 
2.17.1

