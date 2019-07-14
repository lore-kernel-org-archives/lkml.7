Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07412C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06C92063F
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3FbQxlU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfGNRY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 13:24:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34105 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbfGNRY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 13:24:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so391593pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 10:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2pbMNaC4Dad7U4b1ohLm6/S8pl6bc6ilVpOGqbkUqAU=;
        b=L3FbQxlUt6QOMgJibrCgsFLEMZaCbxHxYOTNTouv4U83dvyhQXBwR5wKoArg5xPdk5
         8oq8VgPUrj/guQV9+qVLGARPN7/eDjO5Yb6DLuJ7N0E4HvmHuyt/Z8AwbpUFyhGOYvn8
         mLJlHyjLcQ0cbBzqeWg4U0OUxHwohTJj2DtxI7QB6jOiELCdt3SHrztCnBWUZoRkMXhv
         FDJRexUpjWMzLxXN2bkAL2ogNWP7SNY4N1ZptSXImBTTZFLj74GHoyrFYxRx8bNVJLPz
         NJa2zdh1uhx6yr2K4T6UJ1jCH3kuo6s0v72iaAsMRroTncW0+J1JgdVEzew7hfhCbiMb
         AaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2pbMNaC4Dad7U4b1ohLm6/S8pl6bc6ilVpOGqbkUqAU=;
        b=ToWJxwi4L0wQuU85GblxHbAiFfH375p2afacV46X66k/nzrnXFjBf+cG0cEXRABVPo
         UtIa2UZqrnunuPb0L1gtDICpXkm0onmCa37Z5yuo7qaUEVWcMgfHR3uohROQ+V8xTP3r
         yaENOUzPtjcG3L6mOYTUIAEeXW9KhpqEPjsLIDkJOsmw8VZOVj1NgtEPwLKT14+42pup
         uMiQFA4mVLBfowbHCAXEColQkoe8v93FJHhmZm1Kjl2hMNZJ8PGL66r3Yt3FBBoZiP1z
         /9JrPe918AwK2lb740p7Xd4nT4EnpSZVCeewNMltEw7YxRpyjs+tS9j2nC18y7lJwrCK
         Uaiw==
X-Gm-Message-State: APjAAAVVZjBsHSkjvmbasX1Og+uJ2a5iroe86ZKA0y5Vm/LHdn+TMvgN
        N0Tl7A32PTMCdr17fu9DklY=
X-Google-Smtp-Source: APXvYqzCK6ajuqxRT2CT9FfwiHtOC2hGmLuxh2yCafolp/fS1quAbQAuUWDYfuhArNTT6pjxjvl+5A==
X-Received: by 2002:a63:3d8f:: with SMTP id k137mr22863673pga.337.1563125098142;
        Sun, 14 Jul 2019 10:24:58 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id c26sm14189820pfr.172.2019.07.14.10.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 10:24:57 -0700 (PDT)
Date:   Sun, 14 Jul 2019 22:54:51 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: hal: Remove code valid only for 5GHz
Message-ID: <20190714172451.GA6779@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per TODO ,remove code valid only for 5 GHz(channel > 14).

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 638b12a..eddd56a 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -152,10 +152,7 @@ bool HAL_IsLegalChannel(struct adapter *Adapter, u32 Channel)
 {
 	bool bLegalChannel = true;
 
-	if (Channel > 14) {
-		bLegalChannel = false;
-		DBG_871X("Channel > 14 but wireless_mode do not support 5G\n");
-	} else if ((Channel <= 14) && (Channel >= 1)) {
+	if ((Channel <= 14) && (Channel >= 1)) {
 		if (IsSupported24G(Adapter->registrypriv.wireless_mode) == false) {
 			bLegalChannel = false;
 			DBG_871X("(Channel <= 14) && (Channel >= 1) but wireless_mode do not support 2.4G\n");
-- 
2.7.4

