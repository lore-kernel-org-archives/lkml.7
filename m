Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F39CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8EB2089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="xrIqHLjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634394AbfJRQ6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:58:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34650 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392929AbfJRQ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:58:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id k20so3708459pgi.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KugndHRsdwfYfF7YNG0cCcIA+ytNiB82EhhskIQFjhM=;
        b=xrIqHLjzTDeKKuviVwPfyXGsHV79MdU11oTTSY5TtqSlr8T1GqoOzgCfeyiR5/ZTkJ
         /zgp0cB0yJ60SAjtWvF6bscx4LcvqPuX0JpN4Y20aGd6xqQul2HbIQFgPVtbFgs1JSFO
         GvbPbg3ISZPKujiwxdQvCttehcLvoq84oeN6A8b4imT9U2VVoLS65owqJhfPCqIVKHqb
         lLyNaZCnM3TEoWfgu9EpSvU4y5qlYYW2VfVsnVe0FCrhOk1OfF2xLNDqY20CjhT+vpVW
         rddMSKEWkNs+FhGGYoY9BxHnNCcJJ69lwtB9iOH3X6KrlIA1RwO7a1gqPjd2JhP3K3ZN
         Yqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KugndHRsdwfYfF7YNG0cCcIA+ytNiB82EhhskIQFjhM=;
        b=mvfX/Cwulc39z1F8AqSgTw1kIe4C9qDet8YuAzYOk8SznQGWaYZuHtcy06GIIU5ELB
         Cgws5UObk/xpiPKOKPgeI+k73Zun6wXP+i/Vs/UGyNgXHKXhcBBYnnRHyuRX3JbpqGzg
         rtAyi5vYejGsuFSa0nc1yQ1d5JBsJuynZpcASA1TtdaUs9sjiSymj22UmyQ8lQssXVpy
         KirYvJ0WWwCmMB6n1dZ7fHMWh5kqE4Y595Ks72ksAJR4ec7Z81rDoCxRdx8SIYZ3Glat
         xX7krsnGDPYrQu+b9vp1JHCD+iFaNUleJnbMkFRuMfSqkvxtpytqTOxfGB+yRGvY0Ffh
         NrdQ==
X-Gm-Message-State: APjAAAVIJP3rmYjUNELzZan7GDy/DegNyajA8ziM0GiedELfBHAGOaZv
        MzUg1hvS6h3DbWznxvcgMbHPKns+s1U=
X-Google-Smtp-Source: APXvYqwGGUHqSe/K+1crHrk5Gkm3rlrbkZZhgXAFcSTBm2IDxKaKWZSj3FpaOKq1/JKWYNm5A5HshQ==
X-Received: by 2002:a63:e156:: with SMTP id h22mr11009903pgk.266.1571417927158;
        Fri, 18 Oct 2019 09:58:47 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::ac1a])
        by smtp.gmail.com with ESMTPSA id q76sm12231699pfc.86.2019.10.18.09.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 09:58:46 -0700 (PDT)
Date:   Fri, 18 Oct 2019 12:58:44 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kernel-team@fb.com, william.kucharski@oracle.com,
        kirill.shutemov@linux.intel.com, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm,thp: recheck each page before collapsing file THP
Message-ID: <20191018165844.GB179426@cmpxchg.org>
References: <20191018163754.3736610-1-songliubraving@fb.com>
 <20191018164943.GA179426@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018164943.GA179426@cmpxchg.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 12:49:46PM -0400, Johannes Weiner wrote:
> On Fri, Oct 18, 2019 at 09:37:54AM -0700, Song Liu wrote:
> > In collapse_file(), after locking the page, it is necessary to recheck
> > that the page is up-to-date. Add PageUptodate() check for both shmem THP
> > and file THP.
> > 
> > Current khugepaged should not try to collapse dirty file THP, because it
> > is limited to read only text. Add a PageDirty check and warning for file
> > THP. This is added after page_mapping() check, because if the page is
> > truncated, it might be dirty.
> > 
> > Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: William Kucharski <william.kucharski@oracle.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Song Liu <songliubraving@fb.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

We should also be able to remove the unlocked tests for those two
conditions, right?

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0a1b4b484ac5..a3ef6ce86bfa 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1601,17 +1601,6 @@ static void collapse_file(struct mm_struct *mm,
 					result = SCAN_FAIL;
 					goto xa_unlocked;
 				}
-			} else if (!PageUptodate(page)) {
-				xas_unlock_irq(&xas);
-				wait_on_page_locked(page);
-				if (!trylock_page(page)) {
-					result = SCAN_PAGE_LOCK;
-					goto xa_unlocked;
-				}
-				get_page(page);
-			} else if (PageDirty(page)) {
-				result = SCAN_FAIL;
-				goto xa_locked;
 			} else if (trylock_page(page)) {
 				get_page(page);
 				xas_unlock_irq(&xas);
