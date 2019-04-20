Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99301C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CF521479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPvXhmN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfDTNup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 09:50:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40917 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTNuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 09:50:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so3718205pfc.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QLeGJFuLxQqSr+hrr+ncR0/AZmCWVrFuK9P7lBzxR0c=;
        b=gPvXhmN+k92EqRCcw6u+lb9e4GSE2kRp6pPCaeLzQMVwxsNFEgZ9L40Y9aWA9oe+AN
         gmTwjvxhczUN9JHSI85TIpuyMwKQPefzVFylrLZAFI2bNQ10p1yY3nnVjOwpsPkoolgE
         e9C7F/3Bp0X+NaqwVykGCUtmN39dOg5sEKfi45t9bICwKcA3uTkNw06sPIPzbK08sPZ9
         9O7TBRUCU2QVaPNj4ubT0mM648zS4nvazWgvFlgk7UV34c/0tZFovFIPNUmrFjvJTZx7
         5oeLRzc6tlIcEbNj62JWyXRpC7Xu1viA6SgJNSZeYsUM6TCMBgyTna7ag0OlnCc/N4WX
         TCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QLeGJFuLxQqSr+hrr+ncR0/AZmCWVrFuK9P7lBzxR0c=;
        b=s8urz1m6r7uc/gDuU1kV9rFiiU6WXtuYY7hukF9k2yyPkEM0M6O36ZAd+Ah1xnkmkV
         VJsEm+ccpKs7tiJkb5p/igBWpJak2imyyKvGenz7c7xSY67HeiSCy03F5YX/2gg7aGU7
         zJISNoVXO9qtdlsUWCHxxfFddQwGyCyIFggCxbnarn4p2UxOfkTp34JcN5JnedkG9Nux
         3vnL13GWQCc1Glm4UgqI/A/GPxhHAaThJZkB29RfoukwwoaPan9Gny3QSr6sgvkRWQ+A
         qmjwz66Io/zo1i/SGwjtzpNTMYXiQ4Ogms5HPAvJZ9W+KC+iw7V+Rb7FgOi1zMzZSF+a
         sswg==
X-Gm-Message-State: APjAAAWCJ4Ot2RWmHfhQbQP1piFQREa5HZffkmHSaCmhSDH561A0/wOq
        6IBtZVW5SsqIWNIeR5GETdA=
X-Google-Smtp-Source: APXvYqzaBQHJ4waiNVteMPhu7AfZk7ZzmQ6K5nuxTVoyPLq7wM7kewOVdH+dRhAcBvdScY53OplwHQ==
X-Received: by 2002:a62:e50a:: with SMTP id n10mr10056422pff.55.1555768244338;
        Sat, 20 Apr 2019 06:50:44 -0700 (PDT)
Received: from willow72 ([122.45.59.17])
        by smtp.gmail.com with ESMTPSA id e126sm18503235pfh.35.2019.04.20.06.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 06:50:43 -0700 (PDT)
Date:   Sat, 20 Apr 2019 22:50:40 +0900
From:   Youngjun Yoo <youngjun.willow@gmail.com>
To:     jaegeuk@kernel.org
Cc:     yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fs: f2fs: Replace spaces with tab.
Message-ID: <20190420135040.GA7404@willow72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify coding style
ERROR: code indent should use tabs where possible

Signed-off-by: Youngjun Yoo <youngjun.willow@gmail.com>
---
 fs/f2fs/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 63e599524085..a10b5abc1eb2 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -326,7 +326,7 @@ static int f2fs_acl_create_masq(struct posix_acl *acl, umode_t *mode_p)
 	}
 
 	*mode_p = (*mode_p & ~S_IRWXUGO) | mode;
-        return not_equiv;
+	return not_equiv;
 }
 
 static int f2fs_acl_create(struct inode *dir, umode_t *mode,
-- 
2.17.1

