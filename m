Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBE5C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0A724679
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="n+0QxgTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgAGMDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:03:39 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43885 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgAGMDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:03:38 -0500
Received: by mail-lf1-f68.google.com with SMTP id 9so38686913lfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 04:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gkoRQx7irojuK+AWr/fLDGMtpmCItYQJTiOcOz48ACA=;
        b=n+0QxgTRTK+O2mf2FrXFPMjkxXK9rEctLCKl7/Qmdza+cwZhJP09nDM8rSsQvEbBbJ
         l9xAT2cPkb+XZ0T0MifRSWx6pRTHnotF/Y9gp6eYSjbB/B7EXbzm9EBD/hq0H4nO60lC
         +KJMLmBHQQAZ/RgGzCcwDgOJRtXNo/60Tea7sAaUgmmLAQzOdA3OPj264qTC3azIlMzK
         KtkeHjSvBDRs765nessxAHlEJ5mILJMIDdoVr8pP2O6PWEzWgBkO79FETFM1KYAoPRWM
         u9lb5vWXaaBx68VTSOXu0w08x06BeeIVvnCnwtlMgRqOeja8rVsBL/miBa1IAMQNhtRf
         W8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gkoRQx7irojuK+AWr/fLDGMtpmCItYQJTiOcOz48ACA=;
        b=e/WNsb+JnLql8WyriN/2bLPGSvLHZl1kF+G+ScWUFIYtE/dRPtBXD6iRpryDom9IqO
         WpGu3S9wK97PZD+5T24blbpWKV2XJLbLS7WEu0e7oVIhrSob9fjxGZ9R4dYAUs7dmPz3
         zJxg6KaZo35iHSVlXOrqhmsAx1Z1e3/M0VqsIlFwb80BN/kt+Yds7AtVSZAPafTR1EBt
         C/pHADccGbZ1VTMCEVzOHIpzRGYNDJRTT28H4FbA3H43lSI9RVZrsfzAENp3RKq74nAm
         GCyXDwKwF1uBWxiAVYv+IsP151jQjPvkaEcIHN2Uh588Flx3Xa5iaZEHqzwu+UePc4T+
         2CQw==
X-Gm-Message-State: APjAAAXwJkDCs4U9VBRAYi65inFEQ1odeGlFeQqSkBVV25vX9fPWOT3g
        fCeuWkLSHQgweFSj3ymP5KcqL9EQf6U=
X-Google-Smtp-Source: APXvYqzTBgc3YByXYy02WwN48Cp1z5N43Low+Z32HRlP66qeJ6xWFSJ5GppAsWUMBTFCnMxxTNpkFg==
X-Received: by 2002:ac2:44ce:: with SMTP id d14mr60046304lfm.140.1578398616746;
        Tue, 07 Jan 2020 04:03:36 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i19sm30413526lfj.17.2020.01.07.04.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 04:03:35 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5F9341009CA; Tue,  7 Jan 2020 15:03:33 +0300 (+03)
Date:   Tue, 7 Jan 2020 15:03:33 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        willy@infradead.org
Subject: Re: [Patch v2] mm/rmap.c: split huge pmd when it really is
Message-ID: <20200107120333.ncvds3atyfiilxi3@box>
References: <20191223222856.7189-1-richardw.yang@linux.intel.com>
 <20200103071846.GA16057@richard>
 <20200103130554.GA20078@richard>
 <20200103132650.jlyd37k6fcvycmy7@box>
 <20200103140128.GA26268@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103140128.GA26268@richard>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 10:01:28PM +0800, Wei Yang wrote:
> On Fri, Jan 03, 2020 at 04:26:50PM +0300, Kirill A. Shutemov wrote:
> >On Fri, Jan 03, 2020 at 09:05:54PM +0800, Wei Yang wrote:
> >> On Fri, Jan 03, 2020 at 03:18:46PM +0800, Wei Yang wrote:
> >> >On Tue, Dec 24, 2019 at 06:28:56AM +0800, Wei Yang wrote:
> >> >>When page is not NULL, function is called by try_to_unmap_one() with
> >> >>TTU_SPLIT_HUGE_PMD set. There are two cases to call try_to_unmap_one()
> >> >>with TTU_SPLIT_HUGE_PMD set:
> >> >>
> >> >>  * unmap_page()
> >> >>  * shrink_page_list()
> >> >>
> >> >>In both case, the page passed to try_to_unmap_one() is PageHead() of the
> >> >>THP. If this page's mapping address in process is not HPAGE_PMD_SIZE
> >> >>aligned, this means the THP is not mapped as PMD THP in this process.
> >> >>This could happen when we do mremap() a PMD size range to an un-aligned
> >> >>address.
> >> >>
> >> >>Currently, this case is handled by following check in __split_huge_pmd()
> >> >>luckily.
> >> >>
> >> >>  page != pmd_page(*pmd)
> >> >>
> >> >>This patch checks the address to skip some work.
> >> >
> >> >I am sorry to forget address Kirill's comment in 1st version.
> >> >
> >> >The first one is the performance difference after this change for a PTE
> >> >mappged THP.
> >> >
> >> >Here is the result:(in cycle)
> >> >
> >> >        Before     Patched
> >> >
> >> >        963        195
> >> >        988        40
> >> >        895        78
> >> >
> >> >Average 948        104
> >> >
> >> >So the change reduced 90% time for function split_huge_pmd_address().
> >
> >Right.
> >
> >But do we have a scenario, where the performance of
> >split_huge_pmd_address() matters? I mean, it it called as part of rmap
> >walk, attempt to split huge PMD where we don't have huge PMD should be
> >within noise.
> 
> Sorry for my poor English.
> 
> I don't catch the meaning of the last sentence. "within noise" here means
> non-huge PMD is an expected scenario and we could tolerate this? 

Basically, I doubt that this change would bring any measurable perfromance
benefits on a real workload.

-- 
 Kirill A. Shutemov
