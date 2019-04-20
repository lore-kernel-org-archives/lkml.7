Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA57C282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDED21855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6dwo0zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfDTNvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 09:51:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39503 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfDTNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 09:51:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id e92so2020313plb.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 06:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XynzhmtITJHP/WQaSKsW6IKG8qkbSVM2zinZVwyTXiM=;
        b=e6dwo0zvGZ+YO/DSQ3q+MvyB6G/AQXcaWCzSMCL/GK1Msdgk9TFr3Tq3l6fLx6xvk7
         E0CrTxRzu6v6a6cgLnCRNv82i5fxAFGsMDLNU4Bes9sE5iJXqHFfKwlzd/PTvorObIJR
         fOVhCklpxDFO5WZAiQIdIDiqBRc9V57XOMJRjX4bftP2ndjlQxqmXeyIBayJLE204FNc
         GeVnbczuGUE0Iuiwn2f4h1q7OjkssdNb/iMFnvHSvkwFUuuBEFb7Hs9Mvw1Z/HTe1LPN
         6aRuvzuLPfkH/rphS9acpxT1fZBPmhc/OQkMpfFBQqE1rduaNT3mDVt4fKqp0jeNVMuq
         +Qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XynzhmtITJHP/WQaSKsW6IKG8qkbSVM2zinZVwyTXiM=;
        b=VGMHGVk8TYfvX+KxvmNjpI0ZWDcxwj0cVwUsBwNpXalZpWzfDFeCctcXQQ/c4ENmJn
         RmNgDTMYrNzRmsqy6kZcPOKKM9i/nsSeNDUlwMkbV02x7BDvuj+OAEE9CKACAOzhGZPN
         v12hElMYXWmNyFAU4gVegvG0yzhoxUbI7Oj+/OCOTZCbYRRTkB+P+ude9R9ZYdCG003s
         dHozErvA/J2H8fb5W4VLGFqunLoGh4uHX4AAKdiAFJhcCD7NzpxS9GBWqTN5hfcXXXIP
         yhegyZLUOunt2tfxrk/oukbwZM1cd9MfS7Ik6/BpuqF7VL8YkxyDw2ogx6Nog59KDiQH
         c+HA==
X-Gm-Message-State: APjAAAWUxIqXSNYRVkFxwQoN8w16W5GrOjUtnlHZaoSg84HVKOx5rgQl
        r1J6qufQylY74QUvWLR/T9E=
X-Google-Smtp-Source: APXvYqyDJiqoLdpSbtvP7GR0/Sf+0D6uCu6VNuJjTQRF0uamwVzdQVK3tcDmKfxVFbUaRCbjvy0L+w==
X-Received: by 2002:a17:902:9686:: with SMTP id n6mr9936665plp.282.1555768300965;
        Sat, 20 Apr 2019 06:51:40 -0700 (PDT)
Received: from willow72 ([122.45.59.17])
        by smtp.gmail.com with ESMTPSA id h19sm13676987pfd.130.2019.04.20.06.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 06:51:40 -0700 (PDT)
Date:   Sat, 20 Apr 2019 22:51:36 +0900
From:   Youngjun Yoo <youngjun.willow@gmail.com>
To:     jaegeuk@kernel.org
Cc:     yuchao0@huawei.com, linux-f2fs-devl@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fs: f2fs: insert space before the open parenthesis '('
Message-ID: <20190420135136.GA7426@willow72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify coding style
ERROR: space required before the open parenthesis '('

Signed-off-by: Youngjun Yoo <youngjun.willow@gmail.com>
---
 fs/f2fs/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index a10b5abc1eb2..217b290ae3a5 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -285,7 +285,7 @@ static int f2fs_acl_create_masq(struct posix_acl *acl, umode_t *mode_p)
 	/* assert(atomic_read(acl->a_refcount) == 1); */
 
 	FOREACH_ACL_ENTRY(pa, acl, pe) {
-		switch(pa->e_tag) {
+		switch (pa->e_tag) {
 		case ACL_USER_OBJ:
 			pa->e_perm &= (mode >> 6) | ~S_IRWXO;
 			mode &= (pa->e_perm << 6) | ~S_IRWXU;
-- 
2.17.1

