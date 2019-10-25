Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0D4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A0C21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="dBV0e+5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440788AbfJYQj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:39:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45093 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387769AbfJYQj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:39:59 -0400
Received: by mail-lf1-f65.google.com with SMTP id v8so2256411lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 09:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jV9Dch1raHLsR25+85GoE5QfCe+OjbyMqmvOYwAWD34=;
        b=dBV0e+5igWnSIMH1I6cQAvvrajXF+IEkWbQyiwSisCvIeS7meFZ8+VlqXSz4lJjZTa
         /WjfBsFQoxbdX6t9CttZ0+GZZ59fszJtb9U50q8CLZDNgEHv7naw8Tz/GNqbVtRrkkt6
         q8k4ZNWzh/Ri9QdNRp1aQcsWpKpcr+HAKl44epACJqNVMe9pYnXZ1licMv0rhotHOt1n
         SNz2FgOGVppp9Ac6Nn3tqLvJl1aQdPOjS3yUI46efVhb8p6yg0LwX9EMDHGdj/rVBBG2
         YqMiort3N0Qnl/mzBaHWnJvK/ZN79Yvv9lFKA5fitUOAXasdEOZ3WZ1ixdvTsyv3KQBQ
         UbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jV9Dch1raHLsR25+85GoE5QfCe+OjbyMqmvOYwAWD34=;
        b=GNiCfnDg5ksHTJr3fOxN4UjGTEbEvL4lYYsGRR2OHiQkHN2q0Z+AtTESlUxEDkyYqj
         SEgDTMmcr9/ETZCj7Sa3Ors6Ry3cOdp+FqSEqiXeyTJ0ab26utqJKaF+Zj9tw+AAye5Y
         rtNZY7d34dRX5jbRLz/2qkqCPek/dWzZFwdJwUdsN5lgZAVbJOCOxJOGtA7s7nwtHd6K
         c4+6zyN4FtIVLIEoIPLtTLp+mE0CrBRCX5d/Lqj2BptEYzAjNu4oabOXIyvJj2Sbh+aE
         I3ycQ+tMZIXaU8yKPCE1XeqZKoD5rd/fEaiKA2rkpUf/8hh9DESLh1KyeGdTcYWHd8F6
         Tpzg==
X-Gm-Message-State: APjAAAUTRflrwwg1PFT22EWhZ9ZFWcsEImf2hDqIbZxe1JWmzFog1O4v
        9Mpvb9qcMwrO/t7B88o/johebw==
X-Google-Smtp-Source: APXvYqzhZ1oyOrj7QMbQz64HdHoSo1XvXp9txpsMpF1u8EkNVKOrigodpgTZKdocwM7HRO0vj/nqPA==
X-Received: by 2002:a19:c219:: with SMTP id l25mr167994lfc.174.1572021596893;
        Fri, 25 Oct 2019 09:39:56 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i17sm1064349ljd.2.2019.10.25.09.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 09:39:56 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id F172210267F; Fri, 25 Oct 2019 19:39:55 +0300 (+03)
Date:   Fri, 25 Oct 2019 19:39:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hughd@google.com, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: clear PageDoubleMap flag when the last PMD map
 gone
Message-ID: <20191025163955.qsvkqic2hrorvdzj@box>
References: <1571938066-29031-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191025153618.ajcecye3bjm5abax@box>
 <74becfc0-3c34-bdd2-02cd-25b763c92f3b@linux.alibaba.com>
 <20191025163233.myl7kcgz25qsbnwm@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191025163233.myl7kcgz25qsbnwm@box>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 07:32:33PM +0300, Kirill A. Shutemov wrote:
> On Fri, Oct 25, 2019 at 08:58:22AM -0700, Yang Shi wrote:
> > 
> > 
> > On 10/25/19 8:36 AM, Kirill A. Shutemov wrote:
> > > On Fri, Oct 25, 2019 at 01:27:46AM +0800, Yang Shi wrote:
> > > > File THP sets PageDoubleMap flag when the first it gets PTE mapped, but
> > > > the flag is never cleared until the THP is freed.  This result in
> > > > unbalanced state although it is not a big deal.
> > > > 
> > > > Clear the flag when the last compound_mapcount is gone.  It should be
> > > > cleared when all the PTE maps are gone (become PMD mapped only) as well,
> > > > but this needs check all subpage's _mapcount every time any subpage's
> > > > rmap is removed, the overhead may be not worth.  The anonymous THP also
> > > > just clears PageDoubleMap flag when the last PMD map is gone.
> > > NAK, sorry.
> > > 
> > > The key difference with anon THP that file THP can be mapped again with
> > > PMD after all PMD (or all) mappings are gone.
> > > 
> > > Your patch breaks the case when you map the page with PMD again while the
> > > page is still mapped with PTEs. Who would set PageDoubleMap() in this
> > > case?
> > 
> > Aha, yes, you are right. I missed that point. However, I'm wondering we
> > might move this up a little bit like this:
> > 
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index d17cbf3..ac046fd 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1230,15 +1230,17 @@ static void page_remove_file_rmap(struct page *page,
> > bool compound)
> >                         if (atomic_add_negative(-1, &page[i]._mapcount))
> >                                 nr++;
> >                 }
> > +
> > +               /* No PTE map anymore */
> > +               if (nr == HPAGE_PMD_NR)
> > +                       ClearPageDoubleMap(compound_head(page));
> > +
> >                 if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
> >                         goto out;
> >                 if (PageSwapBacked(page))
> >                         __dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
> >                 else
> >                         __dec_node_page_state(page, NR_FILE_PMDMAPPED);
> > -
> > -               /* The last PMD map is gone */
> > -               ClearPageDoubleMap(compound_head(page));
> >         } else {
> >                 if (!atomic_add_negative(-1, &page->_mapcount))
> >                         goto out;
> > 
> > 
> > This should guarantee no PTE map anymore, it should be safe to clear the
> > flag.
> 
> At first glance looks safe, but let me think more about it. I didn't
> expect it be that easy :P

How do you protect from races? What prevents other thread/process to map
the page as PTE after you've calculated 'nr'?

I don't remember the code that well, but I believe we don't require
PageLock for all cases... Or do we?

-- 
 Kirill A. Shutemov
