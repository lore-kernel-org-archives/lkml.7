Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15903C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D762067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0pffzvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbgAIT7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:59:04 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:51401 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732624AbgAIT7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:59:03 -0500
Received: by mail-qk1-f202.google.com with SMTP id 194so4895793qkh.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 11:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Jf5B4EbQ+30kjad3rYjf3nQGksGo1BPEiNIOzLgULXA=;
        b=S0pffzvIDcM3Erqu+B6kTPNDcpFqNGr5Lgn1Fru3tO/n7DHI2gxYrjybPEJWWCh8qJ
         Pq0rgh1x4T67aJo9Y/zOOMYHmaBy/jb6Su0M5dUAAiR9WjHyU+YkuKRtnzHYWGCyWKyE
         MqwTw1DzPgVrFVIXrMNlxC3ecz6b3un5RTrwDgI00pOnvxkf6Wy1J5pEUYd0lVc4izWr
         VWOj3Nyud4Ev6G1bkQDxfDiynv0ORLWJeBXNAAy1Xa4s5vRAYDSYRYx6SXZbxDu/s+fy
         17QqQeerEc+n7g0sUmMtpqMYLtTi71Zc7Mkp0zM6VJIhpvpLIV8t7L68BkFDNQTCyWfp
         85Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Jf5B4EbQ+30kjad3rYjf3nQGksGo1BPEiNIOzLgULXA=;
        b=SNgLNO0bwT72BdmQcyg9Lq3X/MFWE6W34LedwXhF6nMDcau5/AkF/vCeI9HLUzw0EQ
         iX7Df+L346XFIZ2s8pfQdois2m3I4kDl+LOFOTsAp3v2M/sp1bnBDNRUJfXh3SkhmEHj
         WbSGv19/9UVlEYoV6aL4hygkx4nkhlKv+14cClPyW25dlbZU0mC6qwVFolLTU6Ag4cjy
         XWSAHXC4N29kUkC+vktD/uKpA0gwrc7eLs9Y1+jwLPJ7u+gn1C4TmEH3gXwCVZv4D2r7
         pLpIGsOS0wGBdQTtgqoFmhgGJBd24ITPEz5T02vJJm/oH5LOWWwVjH1BC3Q+TmK/53eb
         18zA==
X-Gm-Message-State: APjAAAWjuGkJxUcmkCQsBH6UD53yeUjP6dapyuKaR3iYBTXA6xIjL51c
        FW8zkYKhbeOSBS1tWOiMvd3BtXcl
X-Google-Smtp-Source: APXvYqyFkOSjGrU2IETPDfcC3pAk3kZTILvTb6+kfTasc242E8aC+Ee9MsLPq6k3SOTw1KCiopXNnjnf
X-Received: by 2002:a37:e507:: with SMTP id e7mr11506262qkg.358.1578599942496;
 Thu, 09 Jan 2020 11:59:02 -0800 (PST)
Date:   Thu,  9 Jan 2020 14:58:55 -0500
Message-Id: <20200109195855.17353-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH] KVM: squelch uninitialized variable warning
From:   Barret Rhoden <brho@google.com>
To:     pbonzini@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If gfn_to_hva_many() fails, __kvm_gfn_to_hva_cache_init() will return an
error.  Before it does, it might use nr_pages_avail, which my compiler
complained about:

	virt/kvm/kvm_main.c:2193:13: warning: 'nr_pages_avail' may be
	used uninitialized in this function [-Wmaybe-uninitialized]

	   start_gfn += nr_pages_avail;

Signed-off-by: Barret Rhoden <brho@google.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d9aced677ddd..f8249b153d33 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2172,7 +2172,7 @@ static int __kvm_gfn_to_hva_cache_init(struct kvm_memslots *slots,
 	gfn_t start_gfn = gpa >> PAGE_SHIFT;
 	gfn_t end_gfn = (gpa + len - 1) >> PAGE_SHIFT;
 	gfn_t nr_pages_needed = end_gfn - start_gfn + 1;
-	gfn_t nr_pages_avail;
+	gfn_t nr_pages_avail = 0;
 	int r = start_gfn <= end_gfn ? 0 : -EINVAL;
 
 	ghc->gpa = gpa;
-- 
2.25.0.rc1.283.g88dfdc4193-goog

