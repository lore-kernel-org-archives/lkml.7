Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9C3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E30206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gO8mfx0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfGaSBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:01:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37795 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfGaSBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:01:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id i70so21689172pgd.4;
        Wed, 31 Jul 2019 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uc5jwJklnJNO+SO7UIEO8rMk1YcQmTcBnS2sF72FTD4=;
        b=gO8mfx0Bxe2dxij++YpcsM3Sa5nSlhLQE0ZKDTw/hHi31gj8cbCSCNAio3hEwSlGWZ
         Ojb6VeechO7IfifaNjrjrwZibn+zdNmD89yI9mswEMt8opxnf5WGebrkRAsK/kaNvQ5d
         STGUJPr0c+xePspbNV08JEOOpOwM9TCqxTt8NIahn/pSthgGLdwn20OmtF8xyOXKmPgz
         71F93jSN6YcS/bWm0qYzIUUtKboibdlT27F6hxd9tg9LuvZjWxXVLpuT6QNPDpaHzSOP
         6NEn10gG/fAG+7BmQM9veAXsNEi9gSf+Biz6oFru/LM5tOsGRBn4eMbtVlRHd/BchhiP
         DGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uc5jwJklnJNO+SO7UIEO8rMk1YcQmTcBnS2sF72FTD4=;
        b=XLFz885CKBYMS8VKAiwFcHitY0md1nNRkqE9Qkm13BBOs5DLIJ6/HSl59jDfd+aZfb
         7KE/34Dh1Xe3jtc56a4sOUkK628dDzV3RsRbdCtM5Z7kGGT+g6fEKZUGaYi/nSF2C7qC
         Tw6FePHJ4zF3s/ESEw8oCg4s7fFl0BP+kbRpa8t8UAjuYlAXrW8Q7M6OYJg5TgCuPDYV
         q7fj3d5qIyAKN3eP4vxxJmfWkgkhBP89Agr4rNDRsdvRRT/Qe2OyhZO8odLo+K17D5tQ
         I9RZ2WI/QMUvkYIqKEojD8NhA7ZhD3pfVrxppfn33Ml06ghz+bhho0F6jS014N2R1rI0
         baiw==
X-Gm-Message-State: APjAAAWD0nBJ7mfx9TVXAnHTb0OWDl0bUOpG2+a/txvvK0yItFSuw6gZ
        Nzq1Dk8TbHzdJcPLALV0OVA=
X-Google-Smtp-Source: APXvYqze1/83nMpL8uB6451tOE4ZN6kEkl1Lb4W1Cl9uslzXzrIJdUtBMTmICBFdjlKVUBvf4TC04Q==
X-Received: by 2002:a63:8ac3:: with SMTP id y186mr114569747pgd.13.1564596080955;
        Wed, 31 Jul 2019 11:01:20 -0700 (PDT)
Received: from host ([183.101.165.200])
        by smtp.gmail.com with ESMTPSA id x9sm45606683pgp.75.2019.07.31.11.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 11:01:20 -0700 (PDT)
Date:   Thu, 1 Aug 2019 03:01:10 +0900
From:   Joonwon Kang <kjw1627@gmail.com>
To:     keescook@chromium.org
Cc:     re.emese@gmail.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        jinb.park7@gmail.com
Subject: [PATCH 1/2] randstruct: fix a bug in is_pure_ops_struct()
Message-ID: <2ba5ebfa2c622ece4952b5068b4154213794e5c4.1564595346.git.kjw1627@gmail.com>
References: <cover.1564595346.git.kjw1627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1564595346.git.kjw1627@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this, there were false negatives in the case where a struct
contains other structs which contain only function pointers because
of unreachable code in is_pure_ops_struct().

Signed-off-by: Joonwon Kang <kjw1627@gmail.com>
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 6d5bbd31db7f..bd29e4e7a524 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -443,13 +443,13 @@ static int is_pure_ops_struct(const_tree node)
 		if (node == fieldtype)
 			continue;
 
-		if (!is_fptr(fieldtype))
-			return 0;
-
-		if (code != RECORD_TYPE && code != UNION_TYPE)
+		if (code == RECORD_TYPE || code == UNION_TYPE) {
+			if (!is_pure_ops_struct(fieldtype))
+				return 0;
 			continue;
+		}
 
-		if (!is_pure_ops_struct(fieldtype))
+		if (!is_fptr(fieldtype))
 			return 0;
 	}
 
-- 
2.17.1

