Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6CECA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739A1205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U77v+xrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503617AbfJXQjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:39:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36200 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503547AbfJXQjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:39:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so24185857qto.3;
        Thu, 24 Oct 2019 09:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBkAEAHyhcMPhU/HM87Wnb8+AYbsPLYrzfZ2kbcSds4=;
        b=U77v+xrQBX5EgzRNSk0HwGcyC7fd1Fr8Ij5+E9THHVZwterT/Vq+sgvSm9y7Jabwbd
         Tj7s2JGAD73155WXh7726JQLEum1Qm6cWiJBfsWasVtT61Ts8fUaRrJiNsE0s5rS+jjV
         7LQzcK8yaQFiODf6uh84hqCSnGxG570yDuWQRRddOZk2rgql770Hn+KEXoGfPQ0tu8NE
         80h5rQUI14/ApIyzx15gFnmgLMZmslLqpVwBn1epXMD/34V2Y6gIRDd0esp/DgcgmUlz
         HxvKUSst3EOUNdzpLq1c9LdEgKUk5yHFzIYxL1jqlRNxXjUji/4IDbkPFXdl+NgVuSjU
         CJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBkAEAHyhcMPhU/HM87Wnb8+AYbsPLYrzfZ2kbcSds4=;
        b=Vo7xAyS3xy03nZRL0KNN9a0Eu8nZZ6elHWWKQSf5TcZs8n1KBQdXRWdcYTRQhoZSMX
         EdzSXKlzPANTagwOPGIy4xu/CMlu3ezD2HtkKLeRRWp9Walcn6jEMoNeQYhZA5PDRWyx
         IcpqYz6ycHSn3knhMkmA6BuwP/WRTUCc7DkIsWC4ikK8SETGZDYObWGXM0zJ4WT2SbpU
         nsWufkE4X9g1nuCBXDis/Exbwa740jZ3c43zBqN+DaDRdWjpdeTZzShJ+iiofuLeRfmR
         tTHtbsvnyZnenm/wZz/h3xmimYOq/mV9GEVpRZw0nbABWm+VRs9vDHjpBXCnL8eP2tpO
         dwXg==
X-Gm-Message-State: APjAAAUhi9dYh3lSazbnu8k45ILXjssXs+MLR6v3Drlkd8RaYYMhpe1k
        kThvOuzltXhGdblb8aj1gNU=
X-Google-Smtp-Source: APXvYqwsyAuKL1oNUlTF/saCGiUkUfhTm47TCg9IXrbcJpfJqFln8YXoQD6i5Tl5ddPVsi3KTJUoSQ==
X-Received: by 2002:ac8:ac4:: with SMTP id g4mr5103867qti.326.1571935137807;
        Thu, 24 Oct 2019 09:38:57 -0700 (PDT)
Received: from localhost.localdomain ([201.53.210.37])
        by smtp.gmail.com with ESMTPSA id l15sm14660121qkj.16.2019.10.24.09.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:38:57 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH 1/3] staging: sm750fb: align arguments with open parenthesis in ddk750_sii164.c
Date:   Thu, 24 Oct 2019 13:38:20 -0300
Message-Id: <20191024163822.7157-2-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024163822.7157-1-gabrielabittencourt00@gmail.com>
References: <20191024163822.7157-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Alignment should match open parenthesis"
in file ddk750_sii164.c

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index bee58edc84e7..73e0e9f41ec5 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -141,7 +141,7 @@ long sii164InitChip(unsigned char edge_select,
 
 	/* Check if SII164 Chip exists */
 	if ((sii164GetVendorID() == SII164_VENDOR_ID) &&
-			(sii164GetDeviceID() == SII164_DEVICE_ID)) {
+	    (sii164GetDeviceID() == SII164_DEVICE_ID)) {
 		/*
 		 *  Initialize SII164 controller chip.
 		 */
-- 
2.20.1

