Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216C1C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88B0214AE
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAMq7WgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfFHJjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 05:39:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42546 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfFHJjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 05:39:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so2524794pff.9
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 02:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zUjxWxq5BrI2FdDPrseDzMNtgvtMjERhQiQzZo7nm7E=;
        b=TAMq7WgCUSTJYkkb+calodVXAtvnqOeZde9ehQHvFCXrubzN4fWZzQgbwa8bHq6C1M
         AtlxxKBDISu2nzuZWa7xYljbMFCEcOW2kExJ03L/SfOpiQzq5Ai0mx5W/TmR98lz+mpe
         88iVjnMKH+Xop89CHXoJOZv30UlNude7LIPzdm3mXq02qdVDII3LTCzxmihX2CGPZbSd
         hO4mazSLbrevzHNGJvMUtuImLT+94ajD0mJ7QdK3WORuMX0Pdm/aEDRWyHofxctadCmM
         5nwENFnPVVc+BtTwLLLMehuDKltXUs6zVZdOlqPgBnVVXlVYUnMy9mOZNmql49weDNe6
         hhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zUjxWxq5BrI2FdDPrseDzMNtgvtMjERhQiQzZo7nm7E=;
        b=apW2p0u5USjqilgtjnmSXIAz6MzmZ4dhRa38GJoOCmBsp9u0wiuu4iHuUgvJRHlXcx
         QwdJQGW7RtatOBQ+7ZM+0I6TCxyxM1j97JNtNviu5rNupxrkewti5lUCZAeZh/FpAAU/
         JxD1g88UJDYMqi3uytyGjrIwDRCFKpIzHgJoxt4etHj8iCrwpDdlZTKTtlixjdfr/QhS
         UCp5KAzzCQ7JW66gZ/OTZ31S2AgoEhiuF9Tjmi4b0zXYT9tVyQueJSQ5t4iyShfZof4S
         6cpcrjNu9y/wUTyvIP5bZU63ZlaR70Ll54aRUQz9gSEBeIq81MIjHOklJKvPS9WQ7WsV
         K0wg==
X-Gm-Message-State: APjAAAX8y3sJAoW1ZUVwDsTdXdtICrd6sLcTgoGzcg97UG1sUoBJ1xEt
        jjwkWZ5peSlN2yaXdHPVnP0=
X-Google-Smtp-Source: APXvYqwiTuXWweBI9kCIpvuh3BS9bBAfUi5CdTkOsKqi9kmZQJOXNb+PRo+WIyuorc2QmIo1ixGesA==
X-Received: by 2002:a62:4c5:: with SMTP id 188mr63276002pfe.19.1559986781709;
        Sat, 08 Jun 2019 02:39:41 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id 66sm4883523pfg.140.2019.06.08.02.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 02:39:41 -0700 (PDT)
Date:   Sat, 8 Jun 2019 15:09:37 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: erofs: fix warning Comparison to bool
Message-ID: <20190608093937.GA10461@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warnings reported by coccicheck

drivers/staging/erofs/unzip_vle.c:332:11-18: WARNING: Comparison to bool

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/erofs/unzip_vle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 9ecaa87..f3d0d2c 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -329,7 +329,7 @@ try_to_claim_workgroup(struct z_erofs_vle_workgroup *grp,
 		       z_erofs_vle_owned_workgrp_t *owned_head,
 		       bool *hosted)
 {
-	DBG_BUGON(*hosted == true);
+	DBG_BUGON(*hosted);
 
 	/* let's claim these following types of workgroup */
 retry:
-- 
2.7.4

