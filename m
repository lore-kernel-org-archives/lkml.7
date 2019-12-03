Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E883CC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6B82073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb/eqh+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfLCPOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:14:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39034 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCPOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:14:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so3886050wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 07:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=At8iFqCdCBYnD7o5MP8ED77hrI5cydOyTaRg33rZGY0=;
        b=Kb/eqh+TmcyP7ISv9YF1n9WOLPthOR59gjDrbO+aqdh0PKu63YqBFofOvFXUegSz0s
         +JnP7jzew187S51fP+wauP9QptTbIIev6OYOQjg8wC6I/Lfx9heH00Dv40V3fEC/cNFn
         xE4kEtos0sp1d1RjH+RQy42bUTRp+PkaRICSFwyg/8C87p5h4TvGNzfWAo+asgd6sjKn
         3NRVMstYQRDGY7jxwK1T20aX9z4FRhs0t+t+tEh3ckqA37fYvCZcTNy8CZSyJGUiEz2p
         eXv+lcXbPijPn92sVl80wIPKXezqrWSUS3Oj7xHZ/4lva1nn5v2LYoROJS5cIfOoApfJ
         IxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=At8iFqCdCBYnD7o5MP8ED77hrI5cydOyTaRg33rZGY0=;
        b=WNks2EwdgakP9dcN7LL/Eone60oTDVuJrxO6dMYVLVPsOjESU9yt/wwqvckH3+HIfk
         JLxh17x1xVwUwY0/bcpFd3nLufNfRdssUAcXX1ktQLLTv3T76zE9C4x7XhSh/pHKAyyy
         ZYoOftWNN8pdOTQCOeTYEabO2n5IGubA00GUSy5sTC3Io0A+c6nuBu6LXGWO5xM59Lzu
         TChVKcRDol1UK1cg7MSOXwh6B8PpwlvUeROwWfg3vFx+gITMLRRgfUXSylnF8MHpvlej
         kPKCzkujHQ71TOz3QTJKxAhfZlNrvr8eBPzbQjC3ITuL3uAHRzoI/lZoaEwW/VgMb0Mu
         Qfog==
X-Gm-Message-State: APjAAAWY7aGgvQ2Q5XkGzH2ZV0GoUkNSHpFh/jtdoCkPQOroGQKag0GB
        EnI8o5P36uKBgvYJcb3vLfg=
X-Google-Smtp-Source: APXvYqyn1eDIJhrVNE8kf9OU/5CbYkTPWMhI8hktvOaZ8lmkm+I4ulwHSwtA+b/6q7TkrkZX/sGJWA==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr10077752wmk.15.1575386083548;
        Tue, 03 Dec 2019 07:14:43 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id h2sm4157452wrt.45.2019.12.03.07.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Dec 2019 07:14:42 -0800 (PST)
Date:   Tue, 3 Dec 2019 15:14:42 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_vma_mapped: use PMD_SIZE instead of
 calculating it
Message-ID: <20191203151442.pftcc2azieulepzp@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20191128010321.21730-1-richardw.yang@linux.intel.com>
 <20191128083255.ab5rwj7gvktwunik@box.shutemov.name>
 <20191128212226.sfrhfs5m3q7m6tly@master>
 <20191202080315.oqtm3q7cyfkl5rma@box.shutemov.name>
 <20191202222151.xx4g3ry7mrcselh5@master>
 <20191203094730.7oh4j5juh3jsx5dk@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203094730.7oh4j5juh3jsx5dk@box>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 12:47:30PM +0300, Kirill A. Shutemov wrote:
>On Mon, Dec 02, 2019 at 10:21:51PM +0000, Wei Yang wrote:
>> On Mon, Dec 02, 2019 at 11:03:15AM +0300, Kirill A. Shutemov wrote:
>> >On Thu, Nov 28, 2019 at 09:22:26PM +0000, Wei Yang wrote:
>> >> On Thu, Nov 28, 2019 at 11:32:55AM +0300, Kirill A. Shutemov wrote:
>> >> >On Thu, Nov 28, 2019 at 09:03:20AM +0800, Wei Yang wrote:
>> >> >> At this point, we are sure page is PageTransHuge, which means
>> >> >> hpage_nr_pages is HPAGE_PMD_NR.
>> >> >> 
>> >> >> This is safe to use PMD_SIZE instead of calculating it.
>> >> >> 
>> >> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >> >> ---
>> >> >>  mm/page_vma_mapped.c | 2 +-
>> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> >> 
>> >> >> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> >> >> index eff4b4520c8d..76e03650a3ab 100644
>> >> >> --- a/mm/page_vma_mapped.c
>> >> >> +++ b/mm/page_vma_mapped.c
>> >> >> @@ -223,7 +223,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>> >> >>  			if (pvmw->address >= pvmw->vma->vm_end ||
>> >> >>  			    pvmw->address >=
>> >> >>  					__vma_address(pvmw->page, pvmw->vma) +
>> >> >> -					hpage_nr_pages(pvmw->page) * PAGE_SIZE)
>> >> >> +					PMD_SIZE)
>> >> >>  				return not_found(pvmw);
>> >> >>  			/* Did we cross page table boundary? */
>> >> >>  			if (pvmw->address % PMD_SIZE == 0) {
>> >> >
>> >> >It is dubious cleanup. Maybe page_size(pvmw->page) instead? It will not
>> >> >break if we ever get PUD THP pages.
>> >> >
>> >> 
>> >> Thanks for your comment.
>> >> 
>> >> I took a look into the code again and found I may miss something.
>> >> 
>> >> I found we support PUD THP pages, whilc hpage_nr_pages() just return
>> >> HPAGE_PMD_NR on PageTransHuge. Why this is not possible to return PUD number?
>> >
>> >We only support PUD THP for DAX. Means, we don't have struct page for it.
>> >
>> 
>> BTW, may I ask why you suggest to use page_size() if we are sure only PMD THP
>> page is used here? To be more generic?
>
>Yeah. I would rather not touch it at all.
>

Got it, thanks.

>-- 
> Kirill A. Shutemov

-- 
Wei Yang
Help you, Help me
