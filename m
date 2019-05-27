Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22D4C282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 00:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3332075C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 00:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C15dORW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfE0Aup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 20:50:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34025 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfE0Aup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 20:50:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id h2so5034069pgg.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 17:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=uVUGPkKOm4c0zQwgwv2vysCn0/MC1yfp3I0q+dsnZwI=;
        b=C15dORW1EPCALRsmlfoMQo0CT92qaJrPU+p74DaxQuW1CToHewJ8mh9CxUrA4SiLsM
         JeK/6NQNNgWwAioV+nRlxRVyLJd9E0jPI56z5J6UqMhJwqqJQXoJZzuIgSVnp3LaV9BR
         EQL8TFpOhBCHx1kEkZG47rV0CnBmpQEPqCNzNeD0sWEwqZP9inL8CQZ5Z7nVEuKr77RJ
         kR4uNcEcs/i4+pkcECytsjUjgS8WKkEnlWYpV9KIHXvOoRmSNf6UgjxL3a91fM/TOF9Q
         VCvjUuzO32b79Watq+saR6qexEzzfbA4Zcsa22fgf7kYIzQwc6o0XySjI4Uhrcrno4DH
         DCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uVUGPkKOm4c0zQwgwv2vysCn0/MC1yfp3I0q+dsnZwI=;
        b=Do4fpbkzEQwScieUchzqgBAbYiLTVawOA3tzQaewsfZvPJPn65a+SwSTFIgnk74P3z
         jxnx/KJqL8By3JV6RmumHKlq95mIKS+VIe5pJQM02neGs+zi3JlWLDq0PXBqiY+WtIkK
         qP7J3iHbWYPWLXaGM25ERWVSEp3Ymg8NERN7kc5G/XLnf4s7IfDL5+Whbj+efigMZNSF
         E7ff9YGWajgf4eB39AviLXzzQmyXZ1elzwaBZjUnux3C7NgpObKCY/DY71pXXGkukVWK
         IFmvRn1pQW+TcK+O09aj6Oc1HgxQTcJy0otRGfZN2JoBeWycPh6bPgLoLRJ321CtYqV2
         2vfA==
X-Gm-Message-State: APjAAAVEnRL4NTsYcGV9kz7doi1ZDikvMCVzqiJ/QIMTvu5G8n+DtDQ8
        Zj1DVm0QeKua8hhqMn92YAWrisY6
X-Google-Smtp-Source: APXvYqxr93AB+wl4Igg+5Pdms/MkJKL6oa8z6q+FSRrbvkwXX55+UN4MyDZH2K91TMr+M/hJ8HL69A==
X-Received: by 2002:a63:950d:: with SMTP id p13mr123027116pgd.269.1558918244895;
        Sun, 26 May 2019 17:50:44 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id g8sm7685137pgq.33.2019.05.26.17.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 17:50:44 -0700 (PDT)
Date:   Mon, 27 May 2019 08:50:34 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     agk@redhat.com, snitzer@redhat.com
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] dm-region-hash: fix a missing-check bug in __rh_alloc()
Message-ID: <20190527005034.GA16907@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function __rh_alloc(), the pointer nreg is allocated a memory space
via kmalloc(). And it is used in the following codes. However, when 
there is a memory allocation error, kmalloc() fails. Thus null pointer
dereference may happen. And it will cause the kernel to crash. Therefore,
we should check the return value and handle the error.
Further, in __rh_find(), we should also check the return value and
handle the error.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/drivers/md/dm-region-hash.c b/drivers/md/dm-region-hash.c
index 1f76045..2fa1641 100644
--- a/drivers/md/dm-region-hash.c
+++ b/drivers/md/dm-region-hash.c
@@ -290,8 +290,11 @@ static struct dm_region *__rh_alloc(struct dm_region_hash *rh, region_t region)
 	struct dm_region *reg, *nreg;
 
 	nreg = mempool_alloc(&rh->region_pool, GFP_ATOMIC);
-	if (unlikely(!nreg))
+	if (unlikely(!nreg)) {
 		nreg = kmalloc(sizeof(*nreg), GFP_NOIO | __GFP_NOFAIL);
+		if (!nreg)
+			return NULL;
+	}
 
 	nreg->state = rh->log->type->in_sync(rh->log, region, 1) ?
 		      DM_RH_CLEAN : DM_RH_NOSYNC;
@@ -329,6 +332,8 @@ static struct dm_region *__rh_find(struct dm_region_hash *rh, region_t region)
 	if (!reg) {
 		read_unlock(&rh->hash_lock);
 		reg = __rh_alloc(rh, region);
+		if (!reg)
+			return NULL;
 		read_lock(&rh->hash_lock);
 	}
 
---
