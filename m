Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2530C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963CC2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Tg/uhL+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437836AbfFLKJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:09:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42495 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437611AbfFLKJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:09:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id z25so24849659edq.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 03:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IFDigL4vy3b62qjT1WszXB3PDewotHj2dqglzXL17hc=;
        b=Tg/uhL+iL9PuNKj7XqCbh3ZlwnLo3Bkb5j6KENo20u6kFaYzi532JwLfbpnW1eZKEn
         qg/O9uyq8wQk4gj/Lpi0h1MpOw3w9F5BoCTyMcJdkPEwqLRDn/s6v2Metm2m9kCUBo40
         xGWjB/G5W4hGI6GA+FOM2MkB8IrBmZciapsN0KRQaX3C/Vg3EdL8wOnroO77kkmOlL79
         mClDpnY4zoMtcRhJr0uE22Wdfo+yAkT8PNyQGB3TEaidmVa2qs5YWFnbdgSrcFEHmPyw
         yjNiLnvfO8k23ResCBgbXP/gSUZgTBmozNcdxSAYu3Ju0S0ckgmdJ1e9/fCZptLcwZkE
         WrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IFDigL4vy3b62qjT1WszXB3PDewotHj2dqglzXL17hc=;
        b=n97J5Wstz5ZPItSg3jHJRA9C899eurvceddc8+1/+tXJ64FAD1NsHVaB5TChFx+Nr0
         uyYlPdk8a+CiLShc/Kx7y4Oz8xMkrN2WPlle5qdawiWP2PfoiVJHOZmArjN5XW0RFHAK
         ar1OxmYtgFRdN+Wn9/Qsq6E+D6Y4oPp8tgaAhFynOYJPCuG/1OV3krlWau9rRAmSZ4eM
         S7FBzML+NJS/Czsde70XgwWyoVIUBpZugwF5p2foCtZN/muvQNP93yIAQmLD1YF4dNj1
         uWu0qHkx9d7JtFqT59wK4bJYic1UBcvBGzl2WcoWLHxE5cLxemkH4QnPfBVeRzPCyUP9
         +LvA==
X-Gm-Message-State: APjAAAWD266UbxRRxXLqTpNf0TOzA+/sM6HLnfqc77KGYwHhWoAgg2Fx
        F/uMGlGMmMk4Ys9/+kj7lzfo8g==
X-Google-Smtp-Source: APXvYqxLR+/UiDQosNM49+jAIr4tIfd9cSPCVBqomYavVwUMuZ0jfVhYTiMeBZXpDB37wwwcRWjQrQ==
X-Received: by 2002:a17:906:6056:: with SMTP id p22mr7266053ejj.171.1560334145847;
        Wed, 12 Jun 2019 03:09:05 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c8sm2674841ejm.55.2019.06.12.03.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 03:09:05 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1914A102306; Wed, 12 Jun 2019 13:09:06 +0300 (+03)
Date:   Wed, 12 Jun 2019 13:09:06 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: thp: make deferred split shrinker memcg aware
Message-ID: <20190612100906.xllp2bfgmadvbh2q@box>
References: <1559887659-23121-1-git-send-email-yang.shi@linux.alibaba.com>
 <1559887659-23121-3-git-send-email-yang.shi@linux.alibaba.com>
 <20190612024747.f5nsol7ntvubjckq@box>
 <ace52062-e6be-a3f2-7ef1-d8612f3a76f9@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ace52062-e6be-a3f2-7ef1-d8612f3a76f9@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:06:36PM -0700, Yang Shi wrote:
> 
> 
> On 6/11/19 7:47 PM, Kirill A. Shutemov wrote:
> > On Fri, Jun 07, 2019 at 02:07:37PM +0800, Yang Shi wrote:
> > > +	/*
> > > +	 * The THP may be not on LRU at this point, e.g. the old page of
> > > +	 * NUMA migration.  And PageTransHuge is not enough to distinguish
> > > +	 * with other compound page, e.g. skb, THP destructor is not used
> > > +	 * anymore and will be removed, so the compound order sounds like
> > > +	 * the only choice here.
> > > +	 */
> > > +	if (PageTransHuge(page) && compound_order(page) == HPAGE_PMD_ORDER) {
> > What happens if the page is the same order as THP is not THP? Why removing
> 
> It may corrupt the deferred split queue since it is never added into the
> list, but deleted here.
> 
> > of destructor is required?
> 
> Due to the change to free_transhuge_page() (extracted deferred split queue
> manipulation and moved before memcg uncharge since page->mem_cgroup is
> needed), it just calls free_compound_page(). So, it sounds pointless to
> still keep THP specific destructor.
> 
> It looks there is not a good way to tell if the compound page is THP in
> free_page path or not, we may keep the destructor just for this?

Other option would be to move mem_cgroup_uncharge(page); from
__page_cache_release() to destructors. Destructors will be able to
call it as it fits.

-- 
 Kirill A. Shutemov
