Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8C6C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 21:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8313421774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 21:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgDPhWsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfK1VJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 16:09:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33968 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfK1VJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 16:09:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id j18so8269588wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 13:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fvP7YYOdK1ePA2WQ5BUbpUZAWIQExoAhCyARQj2svqk=;
        b=ZgDPhWscTy1hbhcPyyEQwl2dtVvvQJOUYREXFDWJAfgLmaFE5ZLOoL9eb7qwl7Krc3
         Yobp6fO7nlHvnfpScoKpEFnNqsl8A7DbIkMd263E0HCBZyzIYXEunm1I4aG5ZUHY28jA
         60QB6yTy+Xu+OSjhnr/wPXjf+N35U/8Gt+358nlaJHVTsmoN6mke/L3L+hXXS5QNsVLL
         SQTTcMarglQf4C+OWn4pEcEbAV2xQCNHwgAd5+loikj0WPhqDMJDmD6tLABFS6uVsFfR
         nYmUIm/p9C7Vlxnhs7Et3fBmKkXsfmShsTtrhPmryoiBBr+XslqN1VddzLgorqlBa1dw
         WDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fvP7YYOdK1ePA2WQ5BUbpUZAWIQExoAhCyARQj2svqk=;
        b=AuyjPaMxL1HViwe3y2c9+f0W+HRaC+WjXDfwVNpdp5IJVJ2K4JhaGiwr400Kd9P3pP
         UBxnhBvSYitkDw1EhnHKV4Q0HYNTAhzRZZaiPdtZcNjgBMh+1gf34XexQWT1UaL2SWfm
         zSAmL6eKUBy/MPR16c08epEIontl5Z0oh9BLFCLCWc02Z6aK5q8KVGSKwXOet+eNglgg
         sjEMldJryKythx0G5M3P522SD/oBxojCUrpscKgYwIyrkCOXsVsMndywqVtRGlhc+kIC
         gSn6u5CvdmZTWahKI6l66zN0ummGfLpW+0gTr7tggSy1nvFDbBo7/ilVW0txQCBLsdjR
         g8+A==
X-Gm-Message-State: APjAAAVBNFGw7Sf4C13OvuJPky2UYEFHh9fz2fMqh7ox7QsTtUG5U3Xr
        5N5Z9+wyKAK+GiyeM0Jb2+r6pvVx
X-Google-Smtp-Source: APXvYqyS89F0s6JFqZytNEucDsM0gk9nocHLgmJ/EpitSZoWjoHjvq46Dtb1SXtNxY24JweOx4dD8g==
X-Received: by 2002:a7b:c757:: with SMTP id w23mr11055593wmk.63.1574975386427;
        Thu, 28 Nov 2019 13:09:46 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id u22sm5861161wru.30.2019.11.28.13.09.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Nov 2019 13:09:45 -0800 (PST)
Date:   Thu, 28 Nov 2019 21:09:45 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/page_vma_mapped: page table boundary is already
 guaranteed
Message-ID: <20191128210945.6gtt7wlygsvxip4n@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20191128010321.21730-1-richardw.yang@linux.intel.com>
 <20191128010321.21730-2-richardw.yang@linux.intel.com>
 <20191128083143.kwih655snxqa2qnm@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128083143.kwih655snxqa2qnm@box.shutemov.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 11:31:43AM +0300, Kirill A. Shutemov wrote:
>On Thu, Nov 28, 2019 at 09:03:21AM +0800, Wei Yang wrote:
>> The check here is to guarantee pvmw->address iteration is limited in one
>> page table boundary. To be specific, here the address range should be in
>> one PMD_SIZE.
>> 
>> If my understanding is correct, this check is already done in the above
>> check:
>> 
>>     address >= __vma_address(page, vma) + PMD_SIZE
>> 
>> The boundary check here seems not necessary.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>NAK.
>
>THP can be mapped with PTE not aligned to PMD_SIZE. Consider mremap().
>

Hi, Kirill

Thanks for your comment during Thanks Giving Day. Happy holiday:-)

I didn't think about this case before, thanks for reminding. Then I tried to
understand your concern.

mremap() would expand/shrink a memory mapping. In this case, probably shrink
is in concern. Since pvmw->page and pvmw->vma are not changed in the loop, the
case you mentioned maybe pvmw->page is the head of a THP but part of it is
unmapped.

This means the following condition stands:

    vma->vm_start <= vma_address(page) 
    vma->vm_end <=   vma_address(page) + page_size(page)

Since we have checked address with vm_end, do you think this case is also
guarded?

Not sure my understanding is correct, look forward your comments.

>> Test:
>>    more than 48 hours kernel build test shows this code is not touched.
>
>Not an argument. I doubt mremap(2) is ever called in kernel build
>workload.
>
>-- 
> Kirill A. Shutemov

-- 
Wei Yang
Help you, Help me
