Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB84ECA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEAB20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="mvpvVaZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfJUSDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 14:03:18 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39388 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUSDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:03:18 -0400
Received: by mail-qt1-f196.google.com with SMTP id t8so4834053qtc.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 11:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wyEp1kOdaCYzrwvdEM/kPkFxBB0Sg4gRdGjRJK/qdGA=;
        b=mvpvVaZFNZtubTKfQHrkzk+N5tFEJzXkNyBqBIs3pZ3zkZK3mabIbyDflu013jujfB
         e5vctsPQHk3tuswyq/oOs+kWRhM2nWogmkJ61jp/QjY6kwuVK3ylBA8sIIL3uNUVSDCx
         HK4x0bfd8m9zAN5LrzGqHzcEHECkkVIH1KbUc6fCKfKaWaCtAqICaAK9Xen2TkIRNmq9
         gEmYUJpCAZfaAP5kH1NIlJCW02OKZT8Jog5Mb7cSxUWKfNatckxZkVwXvsCNB3xE+e8d
         pZFKxvx7vuzVF8dHS49kJug9W1Wnb2i82nJ7jTiccu5BUcADyeJ59xd+d1KqbHVDwfU4
         h8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wyEp1kOdaCYzrwvdEM/kPkFxBB0Sg4gRdGjRJK/qdGA=;
        b=iAZLLSgF1M3LqQbxJ0sCjWQUb3wtmLazj9W9KEukZM/ikBZkuTz0+dmGHdyC5dVSMB
         PTYcWNZg+JJaXfB0wWuQHQkpZXGSgQT1k90ucf756C3qPno2K/N+BgT8vopiI7KNXf0g
         9eRh4tfDxOuKwOCOqbSVUGaQzNe4kEaeYMBUQ2XbUnly6WcMChkQTnOijVyb506nWkie
         1uvlQcaRfwzV37iclUYZhWeCfrD8BeCBtEFD8Wc0pYA6F9RraZXZbAn7n83Pl4nVCl3Y
         h5IIaSnj/s288oYDtPNdeXE12qsRFSHL6cocLAi0VBOaRI54yVSI4rCjWZQyKG/0zTo+
         0eGg==
X-Gm-Message-State: APjAAAXUb/jyKNmi4CUV85oFaiaq0Rg7xLsbCrB256NFz/cR6XkPWsPS
        dPPKBBMjGOwJPccgZFkn+DutVw==
X-Google-Smtp-Source: APXvYqz68/kqjdmLF8f0rHCHXaVIR95FOdV8pEtEZdEGeJGVjChL9WqcBJ04eXbqarquvsAy3MC8cw==
X-Received: by 2002:ac8:3a26:: with SMTP id w35mr25006063qte.211.1571680995603;
        Mon, 21 Oct 2019 11:03:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2d1])
        by smtp.gmail.com with ESMTPSA id 131sm8838166qkg.1.2019.10.21.11.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 11:03:14 -0700 (PDT)
Date:   Mon, 21 Oct 2019 14:03:14 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v3] mm,thp: recheck each page before collapsing file THP
Message-ID: <20191021180314.GA185593@cmpxchg.org>
References: <20191018180345.4188310-1-songliubraving@fb.com>
 <20191018181712.91dd9e9f9941642300e1b8d9@linux-foundation.org>
 <9DC29F5B-1DF5-408F-BEDF-FD1FBAAB1361@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9DC29F5B-1DF5-408F-BEDF-FD1FBAAB1361@fb.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 05:24:00AM +0000, Song Liu wrote:
> In collapse_file(), for !is_shmem case, current check cannot guarantee 
> the locked page is up-to-date. Specifically, xas_unlock_irq() should not
> be called before lock_page() and get_page(); and it is necessary to 
> recheck PageUptodate() after locking the page. 
> 
> With this bug and CONFIG_READ_ONLY_THP_FOR_FS=y, madvise(HUGE)'ed .text 
> may contain corrupted data. This is because khugepaged mistakenly 
> collapses some not up-to-date sub pages into a huge page, and assumes the 
> huge page is up-to-date. This will NOT corrupt data in the disk, because 
> the page is read-only and never written back. Fix this by properly 
> checking PageUptodate() after locking the page. This check replaces 
> "VM_BUG_ON_PAGE(!PageUptodate(page), page);". 
> 
> Also, move PageDirty() check after locking the page. Current khugepaged 
> should not try to collapse dirty file THP, because it is limited to 
> read-only .text. Add a warning with the PageDirty() check as it should 
> not happen. This warning is added after page_mapping() check, because 
> if the page is truncated, it might be dirty.
> 
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: William Kucharski <william.kucharski@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
