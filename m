Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80072C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EEE2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="QfS4Zl1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbfJALcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:32:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35720 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfJALcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:32:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id v8so11591962eds.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 04:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lCGrxhcB/+iEshHFfidiQ7x9s/rMo7Q8hflUr8m+6po=;
        b=QfS4Zl1/GsIweSpHy1jVGdzJo/9HTx+ebgDpkvOyF+x3JNID3/YW722nrsLK0GRPMM
         bgyuVyo3Y5oKUWYcRCSFnlfRSo/RNjrlHNmYJalwEyVUd5xC73XZHT8C/6/KaXOZ5QIE
         ELEhYTJvYWi8+QZiRVTTXnOZFDC/kepWgWk1dqRYj48F2zmTPgmoD7Ee7oKQJSLcwaCQ
         0QqXuA9kJecUYaqKwt/zoXCbDpPT647LyZ4cGMDZcRx7CfFMZIxrabbTJXm7L7ZUZzay
         LmCdcUOt1LdqUIYN4nRDwQccsSbw5bEXPo4YaIJhHHhWNdifcuXEtE2esqFaBMyxtI3D
         aKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lCGrxhcB/+iEshHFfidiQ7x9s/rMo7Q8hflUr8m+6po=;
        b=A6v2jR+FKi4+4C4VhtK1uI21MDZc4wu0/deU2iX2FSWGc7r3BZFuMknGfzCvaAL2Ly
         05Vgib3KQb8xgpXN5V5lGtveXdnC1235xLESMXmvxWS2D13aqmO+yq69YCzqruGxeMdy
         9qQRUd1O6f7xHFfXX5GSAAC53G/O++cJ893jAtv7fIChM/QWb7oRcBPHtVBcoTZjafnT
         pWkYscL6siQIr3PI/Yscv2ikkC4B7GxCF/mmW+PK7413eSIzSeXby2UXTuTwYT2t5loF
         KQ9ywkrgsjT4SkV1tEqfNGkaLw7cCHANlsYF8zriVsBAteVSLMg54JPdFavzqOlsqJK7
         2QaQ==
X-Gm-Message-State: APjAAAUS0ivh2KPlfsS0SNRNEgvWe0L96TSab2FFdhN9RTZA53tyNW1u
        Ns7L9yy8LjnTCdxaW/ZK7Xo6s9qZOfU=
X-Google-Smtp-Source: APXvYqxUu7r9KkLSUQ4qzyBtyXTZoSMDeyCZcpbwZlxw26HMZjQAZjkMxKkrWlcyrlww3lQL7ZOGzg==
X-Received: by 2002:a50:f0d4:: with SMTP id a20mr25567858edm.149.1569929536456;
        Tue, 01 Oct 2019 04:32:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w16sm3089185edd.93.2019.10.01.04.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 04:32:15 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 33253102FB8; Tue,  1 Oct 2019 14:32:16 +0300 (+03)
Date:   Tue, 1 Oct 2019 14:32:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] mm: Align THP mappings for non-DAX
Message-ID: <20191001113216.3qbrkqmb2b2xtwkd@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-15-willy@infradead.org>
 <20191001104558.rdcqhjdz7frfuhca@box>
 <A935F599-BB18-40C3-90DD-47B7700743D6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A935F599-BB18-40C3-90DD-47B7700743D6@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 05:21:26AM -0600, William Kucharski wrote:
> 
> 
> > On Oct 1, 2019, at 4:45 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > 
> > On Tue, Sep 24, 2019 at 05:52:13PM -0700, Matthew Wilcox wrote:
> >> 
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index cbe7d0619439..670a1780bd2f 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -563,8 +563,6 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
> >> 
> >> 	if (addr)
> >> 		goto out;
> >> -	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
> >> -		goto out;
> >> 
> >> 	addr = __thp_get_unmapped_area(filp, len, off, flags, PMD_SIZE);
> >> 	if (addr)
> > 
> > I think you reducing ASLR without any real indication that THP is relevant
> > for the VMA. We need to know if any huge page allocation will be
> > *attempted* for the VMA or the file.
> 
> Without a properly aligned address the code will never even attempt allocating
> a THP.
> 
> I don't think rounding an address to one that would be properly aligned to map
> to a THP if possible is all that detrimental to ASLR and without the ability to
> pick an aligned address it's rather unlikely anyone would ever map anything to
> a THP unless they explicitly designate an address with MAP_FIXED.
> 
> If you do object to the slight reduction of the ASLR address space, what
> alternative would you prefer to see?

We need to know by the time if THP is allowed for this
file/VMA/process/whatever. Meaning that we do not give up ASLR entropy for
nothing.

For instance, if THP is disabled globally, there is no reason to align the
VMA to the THP requirements.

-- 
 Kirill A. Shutemov
