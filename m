Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0237DC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B6C20872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfIYVhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 17:37:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43596 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfIYVhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:37:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id q17so38151wrx.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 14:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Arpb7Z2qCWrvUpdQDRByL+W1qOFw5hIlNoD93W6h7A=;
        b=PwRQjFbFq8C00kdufKVpOlKWBoL3nb8G4bxTw0xmCXuXIEe2EyFdLmN3Rlvq/vD2Kx
         k0NHNf2DDuoOTPp3FL6gwWq5aduo9gk/b1X/OB58PxrRRScmSf69FqKTVYGyBUV0hU8D
         fkPvDqMjKLXOaYQorf6usYQWRTRlB4j0CztT9SXijteJTJ/4LOkOouvPXnzEP9R60Os9
         GVk8lC0+3Z6TRFVhLSeVRcbF6YvXAi8M6fQERIkid3w5e02895xvNtfqJaxg2HF+b1EM
         iPHj0KDOAQnPKClvvTDTiI06nftAA16oj76cVr95BqppW81qHkr+XwTKrYHwSAJzulRs
         Zg7A==
X-Gm-Message-State: APjAAAXKiz7uTOHN7XzZZdFLpmCz6jWzi700V4D5OI1jaJUz4+HsrIEw
        v+sDin9Bk41qXmhbvNHl/1U=
X-Google-Smtp-Source: APXvYqwTir5mlYqHNsTh7HEWd4dnpDtTNbkGNUs/LIxQBNONU+QqI1TNukzj3ZU2GH4nbXmmb8Dy/Q==
X-Received: by 2002:adf:ee50:: with SMTP id w16mr298441wro.93.1569447422763;
        Wed, 25 Sep 2019 14:37:02 -0700 (PDT)
Received: from localhost.localdomain (99-48-196-88.sta.estpak.ee. [88.196.48.99])
        by smtp.googlemail.com with ESMTPSA id t203sm188889wmf.42.2019.09.25.14.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 14:37:02 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Denis Efremov <efremov@linux.com>, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] greybus: remove excessive check in gb_connection_hd_cport_quiesce()
Date:   Thu, 26 Sep 2019 00:36:56 +0300
Message-Id: <20190925213656.8950-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function pointer "hd->driver->cport_quiesce" is already checked
at the beginning of gb_connection_hd_cport_quiesce(). Thus, the
second check can be removed.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/greybus/connection.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/greybus/connection.c b/drivers/greybus/connection.c
index fc8f57f97ce6..e3799a53a193 100644
--- a/drivers/greybus/connection.c
+++ b/drivers/greybus/connection.c
@@ -361,9 +361,6 @@ static int gb_connection_hd_cport_quiesce(struct gb_connection *connection)
 	if (connection->mode_switch)
 		peer_space += sizeof(struct gb_operation_msg_hdr);
 
-	if (!hd->driver->cport_quiesce)
-		return 0;
-
 	ret = hd->driver->cport_quiesce(hd, connection->hd_cport_id,
 					peer_space,
 					GB_CONNECTION_CPORT_QUIESCE_TIMEOUT);
-- 
2.21.0

