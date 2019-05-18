Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70551C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 17:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A59420872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 17:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auLY2NMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfERRdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 13:33:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46565 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfERRdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 13:33:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so5180841pfm.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pBUOpcZZhVnAEMzK2Qi13gp5BqUlujzgGPYXraDy+LU=;
        b=auLY2NMGRP93XGfuqVGmCFv10ilgSNvE32chNovFfE3hNYk+VsNegdj6oqOIFK73I8
         nyRJu8ucZYf9s/GnyxmcyL1TYCVAB8kgcSbw2EBPUo1O27isB1yk6MS1MoqMAXBD4tyt
         0o/2CbJmzo8YtOYlwlReJ2LTMk3330zP9twY45DZrszNfoE33pyL5rUYIYgZeKd9XUmD
         wdRxsywK2ENZRtEyaBQpGCWr5teezmZIRu83oMej7Cer77vKEQdQ5jv8UIiba4yaFrVK
         ZbheqtkH6gSt8mF/FDGh0HjKmeHUgjwWuD/oHMX52RIBM0oCj3XQz2PH6CtLkwnzARoT
         blZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pBUOpcZZhVnAEMzK2Qi13gp5BqUlujzgGPYXraDy+LU=;
        b=KhzAeSy0oh+PJ7PB4TMu1LMTwdEkl9htaCz3weg67wGYqwKOGEbK5E0j6t/oVQIHTW
         X3A3IU0Pacib4bMJOVZFxFtwv3RP0IP8JkzaWs8DCcwV+mr2pOnuk/5bQK5EEPaYn1Wv
         LYmmBVIjCB3OUFc81YxHnXTnUpOECuHdOeFPRZRoblPmLOpfuf/NmBIXVhWZNvkle5az
         fopdoz7ahLWlpvky/oakOmegVYi/Ck1ClsLxK2HxTYWcoujBV/NJhVTDMpjak2OLfki2
         y/qlXdLk6ml92RAkWYOaArVb3xQI5IdM1nAEvThpINaxngL0/aqm/Lar4IwQII1JMvNb
         DViA==
X-Gm-Message-State: APjAAAVkd3aAqs0L1xMVRMeNYz3IceSeD2HzZZmVRr+ubLWrtne2DQHw
        m/KG3sG7akP+7EO8L2rT7SIhog1S
X-Google-Smtp-Source: APXvYqxWJTJIdCpHS0U/FnQzuWH0oWUVKu8hlU6RfRmLRWX081s6/gamZSeSuCmsOfOw34bD/oX0jQ==
X-Received: by 2002:a63:c54d:: with SMTP id g13mr65078775pgd.376.1558200817033;
        Sat, 18 May 2019 10:33:37 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id n21sm15160229pgf.28.2019.05.18.10.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 10:33:36 -0700 (PDT)
Date:   Sat, 18 May 2019 23:03:31 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: erofs: fix Warning Use BUG_ON instead of if
 condition followed by BUG
Message-ID: <20190518173331.GA1069@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warning reported by  coccicheck

drivers/staging/erofs/unzip_pagevec.h:74:2-5: WARNING: Use BUG_ON
instead of if condition followed by BUG.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/erofs/unzip_pagevec.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/unzip_pagevec.h b/drivers/staging/erofs/unzip_pagevec.h
index f37d8fd..0f61c54 100644
--- a/drivers/staging/erofs/unzip_pagevec.h
+++ b/drivers/staging/erofs/unzip_pagevec.h
@@ -70,8 +70,7 @@ z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor,
 			return tagptr_unfold_ptr(t);
 	}
 
-	if (unlikely(nr >= ctor->nr))
-		BUG();
+	BUG_ON(nr >= ctor->nr);
 
 	return NULL;
 }
-- 
2.7.4

