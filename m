Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8D6C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E9F2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kXiGqdmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfDISn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:43:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46793 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDISn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 14:43:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id q1so9805038pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 11:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VQum5xkYgWrLXwSjhxQf413Vq4UHlR9jwivyiD7Y/bg=;
        b=kXiGqdmhzGJFnZefmVu8+1fsPksdI4g02LjE7x28Geuj4AKDMzgJRrYp32h3ms6d3g
         0N49bR9pRDi/Lv0oFonXcgnyf1Jd7Zl+nBo1jWAzsHpyaKXvkHiVAfMd/WeSFAcNyNIg
         z646DH2Q9kIK4yvL5mpT4iN6IZ3O8IxA0+nt/PSkXPCAZXivhq16YB5hgNn2buWD71e3
         epQyVuKRsZpBixpARJt9lSF5qlj02PLMwJgtI7X5U+960mesQJkFOsiOKSUWDzO9BfwL
         8vlRAE8FlS2xgPx7Gag/erQ4VlWUYInzpcwNueaGDbfu8zb3OiikTHCZELb6/od9IpXk
         dqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VQum5xkYgWrLXwSjhxQf413Vq4UHlR9jwivyiD7Y/bg=;
        b=J1i3MIU+392XLYHnXjMaYLLM3ewkR+vClUtnkMRgF7LdIptNvC0wcGTOu4pqURlmLO
         AtKlNTe8HJ0O5j5bkVa1TlKqxKKQIVxKFvgE3sNH8UwircxYQbVnIngA6kEP9fGLtUz4
         cRGkVdqnfBLJLi3P8s8HUxXpnsQMtNYQ9syT7P3gSA5HvtuhZ6vIvbjSkMcpTUMKVElw
         fc5uKynAhFhH2tDFsz8PgcxwhMC2MI05ChsuBZxs/tBGZCC9MZHAwQ7ALR77upTA8D5X
         gcPTQwmu5OQR3/KDhw+Qf/qbcmNJ/m1yamv5mSLHtnNGrm/JDTdCysghQIfG2bN3k1lm
         UZgQ==
X-Gm-Message-State: APjAAAWvbWE0gg5d0up7R91SqvTzbcMLhFPK0Eai/8+Of/UknBEA8BOx
        JrWp15Y8oRrYZw3m+8Xov/eeKA==
X-Google-Smtp-Source: APXvYqyAUQtY4lQn95KRxjt3Hp0Tst4ecafBe59Qw7NS1ELgN6YNiVEfNzhOZlnA+sKKmUsgZkIW3g==
X-Received: by 2002:aa7:8453:: with SMTP id r19mr39172856pfn.44.1554835435382;
        Tue, 09 Apr 2019 11:43:55 -0700 (PDT)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id v15sm48210009pff.105.2019.04.09.11.43.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Apr 2019 11:43:54 -0700 (PDT)
Date:   Tue, 9 Apr 2019 11:43:30 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
cc:     Hugh Dickins <hughd@google.com>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Kelley Nielsen <kelleynnn@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] mm: swapoff: shmem_unuse() stop eviction without
 igrab()
In-Reply-To: <84d74937-30ed-d0fe-c7cd-a813f61cbb96@yandex-team.ru>
Message-ID: <alpine.LSU.2.11.1904091133570.1898@eggly.anvils>
References: <alpine.LSU.2.11.1904081249370.1523@eggly.anvils> <alpine.LSU.2.11.1904081259400.1523@eggly.anvils> <84d74937-30ed-d0fe-c7cd-a813f61cbb96@yandex-team.ru>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019, Konstantin Khlebnikov wrote:
> On 08.04.2019 23:01, Hugh Dickins wrote:
> > -		if (!list_empty(&info->swaplist)) {
> > +		while (!list_empty(&info->swaplist)) {
> > +			/* Wait while shmem_unuse() is scanning this inode...
> > */
> > +			wait_var_event(&info->stop_eviction,
> > +				       !atomic_read(&info->stop_eviction));
> >   			mutex_lock(&shmem_swaplist_mutex);
> >   			list_del_init(&info->swaplist);
> 
> Obviously, line above should be deleted.

Definitely. Worryingly stupid. I guess I left it behind while translating
from an earlier tree.  Many thanks for catching that in time, Konstantin.
I've rechecked the rest of this patch, and the others, and didn't find
anything else as stupid.

Andrew, please add this fixup for folding in - thanks:

[PATCH] mm: swapoff: shmem_unuse() stop eviction without igrab() fix

Fix my stupidity, thankfully caught by Konstantin.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
Fix to fold into mm-swapoff-shmem_unuse-stop-eviction-without-igrab.patch

 mm/shmem.c |    1 -
 1 file changed, 1 deletion(-)

--- patch4/mm/shmem.c	2019-04-07 19:18:43.248639711 -0700
+++ patch5/mm/shmem.c	2019-04-09 11:24:32.745337734 -0700
@@ -1086,7 +1086,6 @@ static void shmem_evict_inode(struct ino
 			wait_var_event(&info->stop_eviction,
 				       !atomic_read(&info->stop_eviction));
 			mutex_lock(&shmem_swaplist_mutex);
-			list_del_init(&info->swaplist);
 			/* ...but beware of the race if we peeked too early */
 			if (!atomic_read(&info->stop_eviction))
 				list_del_init(&info->swaplist);
