Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B6DC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCE520815
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPwomXx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfJBRqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:46:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44813 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfJBRqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:46:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id i14so12227985pgt.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e09g4DE4GMBAg/LjnbwQq27CQNtOo7EPR5oJ0HS2cqg=;
        b=tPwomXx9uELPa6HaIJ+/E2c2pNZUBjZgwoXe+GSk/+PxubNo+giOXWasw0tzbm3nBz
         f7EFDGNPFGlCsOhF3YQybOfjz9/Khu0pWWjtkJKNAwprBHAegBd5vrKoINsFL48pFM+P
         j8ytCRJyvzx3XQtE3ZyExB+lC0yDI+RIY6Bcy1V+NUM2pK027zbJ9REWZ/1vsZ97kaUa
         xdCbGuRk+VUO9abBlnhqbR9Fjs8JwpA42CwNU1V473pNNZFG+hNuzRydyPd1F2HXYwEO
         jFPlgDx7lhry6LoWKHd5IqUZJHp47KKl3W01VNpnofNBpI6ueMTk7kE3o2Y2SHj7JyPq
         BkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e09g4DE4GMBAg/LjnbwQq27CQNtOo7EPR5oJ0HS2cqg=;
        b=IFOXyDMj8aMnMWoF2yqhxuNK+vO+NGBt8mcwmfhlUb3gN5URGR+vgO5avYGQr+hpdn
         2So/kXjkDamWoVjExAqKRBns/U7Jmnnl8JyBPvCUZQ99EbSud/xrANSXJp74Fu43pe3f
         UDIjeXTev0rWEDFjyFwNKGUxudsQBnzD30rQXrwmZ6VXCvnIY+0vbK9FtdWhMiFcMVsy
         qxsfo3gjp1DNtl23miAOWJKPE6kIOdC5A5CxF/l0efIO3iaBKiMa6vbXfL+Vto0N8zNB
         lRW2W5HepBdHkKaIJkzzd3+piojLNUttTj6RjibKNnyKsCguaArv3S39NE3XWIC5/YgN
         shHg==
X-Gm-Message-State: APjAAAWIsXnyplpZ+EXYq2Acx7onvqtBLQYtqnBHbbj4jXrqzVtdfp23
        C22ct66EZAhnwvuk8rsXHN4=
X-Google-Smtp-Source: APXvYqxY7kb2N/WuKOe4+BNcW7O6HglZX64dx4Fz/DXyylZOIMn/uwmIIjhO0q1VxQIGR5nl/OG5ug==
X-Received: by 2002:a63:fb55:: with SMTP id w21mr5003272pgj.267.1570038401462;
        Wed, 02 Oct 2019 10:46:41 -0700 (PDT)
Received: from localhost.localdomain ([103.241.225.67])
        by smtp.gmail.com with ESMTPSA id 202sm74561pfu.161.2019.10.02.10.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 10:46:40 -0700 (PDT)
From:   aliasgar.surti500@gmail.com
To:     rpeterso@redhat.com, agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Aliasgar Surti <aliasgar.surti500@gmail.com>
Subject: [PATCH] gfs2: removed unnecessary semicolon
Date:   Wed,  2 Oct 2019 23:16:31 +0530
Message-Id: <20191002174631.15919-1-aliasgar.surti500@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aliasgar Surti <aliasgar.surti500@gmail.com>

There is use of unnecessary semicolon after switch case.
Removed the semicolon.

Signed-off-by: Aliasgar Surti <aliasgar.surti500@gmail.com>
---
 fs/gfs2/recovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index c529f8749a89..f4aa8551277b 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -326,7 +326,7 @@ void gfs2_recover_func(struct work_struct *work)
 
 		default:
 			goto fail;
-		};
+		}
 
 		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
 					   LM_FLAG_NOEXP | GL_NOCACHE, &ji_gh);
-- 
2.17.1

