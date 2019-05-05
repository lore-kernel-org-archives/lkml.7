Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B513C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 07:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AFF206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 07:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI1Xunnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfEEH0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 03:26:50 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41480 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfEEH0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 03:26:50 -0400
Received: by mail-oi1-f196.google.com with SMTP id b17so190063oie.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 00:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=p2ELP52IjlSRBhCCg6cmkTQC+UANYchO6gHwo7zqQjo=;
        b=cI1XunnxRe/VDLJjo7QyDkvojB9kQWlvEtH8EteupRtostZWIPLc2m2KUrN6nQ0s2L
         +2vfMzzF5Ci32KSt00W7KHbeCSPE752TdAo0QbJiP9Ab3IUHQczT+VXToqBBzji8BYST
         HWGt1viZbdfLMN9NUfaBtY1gZfJJx2qua5zs4iO2AqwO+WQbqy++cRMM67qD+aj81iOs
         Tp40d2XCL4U5OkUT30aSGpKFhkT0kvKmwlcfadWF60zOKj26uSOLiGPfkEEvpK4j0/Ck
         fRHNUYS3NPitU5cH8WAGGuiXHKTVNvV7DPFtmHGDqMxDQfo9uReysQySTBqZawO/kc2o
         vpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p2ELP52IjlSRBhCCg6cmkTQC+UANYchO6gHwo7zqQjo=;
        b=snt+4yr8BRmkbrPoKkcDzGuMeGoV8ErYaQOl6+JHV33Fl2IfVL9CFy4dj1aj4CVwE9
         KZG9AxDO/fuxffEN4vDI/AxgAHE/wR/dpvwqxpG8lnadlpOb8Abrgb8PW5fLTcZJSJE7
         vy7hX3BBIQjCY9dyVQxITt2u/ruKfLF9msr9SqNfEJSZBLo/pXOnhYLVc+tX63ba1Fis
         NgvPs7jljOSi/C2LGIa+fLCPziLZrK7qsp52XRSdSKfA5OmydXax7eDoJFwE1xud9Pa9
         ql+Mn5KFVgtxb1UPRcGjHg0vMUnZSchbb6KNepNdBj33FPXvrB+Ke3YsmiFwhgxC2k7F
         z6ag==
X-Gm-Message-State: APjAAAUcn85wOo6+6EAUTJslYblSF0Kf4wF9Gi7nKoU8x9UOedgna35y
        Yl8wj2yfS54ZXTeA2E3MYR4=
X-Google-Smtp-Source: APXvYqy8rzneFtiDDDc+kBy9kcTyKhqHfeoclKB0izBpEeRsJDRCWrRykHksbgctZPtl+2paMI954g==
X-Received: by 2002:a05:6808:48c:: with SMTP id z12mr498896oid.36.1557041209184;
        Sun, 05 May 2019 00:26:49 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:2897:6cea:c841:53a2])
        by smtp.gmail.com with ESMTPSA id a23sm2256956oto.58.2019.05.05.00.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 May 2019 00:26:48 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        samuel.thibault@ens-lyon.org, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH] Staging: speakup: Replace return type
Date:   Sun,  5 May 2019 02:26:45 -0500
Message-Id: <20190505072645.3940-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace return type and remove the respective assignment.

Issue found by Coccinelle.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/speakup/i18n.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/speakup/i18n.c b/drivers/staging/speakup/i18n.c
index ee240d36f947..a748eb8052d1 100644
--- a/drivers/staging/speakup/i18n.c
+++ b/drivers/staging/speakup/i18n.c
@@ -470,8 +470,7 @@ static char *find_specifier_end(char *input)
 	input++;		/* Advance over %. */
 	input = skip_flags(input);
 	input = skip_width(input);
-	input = skip_conversion(input);
-	return input;
+	return skip_conversion(input);
 }
 
 /*
-- 
2.17.1

