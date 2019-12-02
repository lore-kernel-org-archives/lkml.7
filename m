Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC634C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB2B2073C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKeTDSTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfLBWVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:21:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56282 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLBWVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:21:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id a131so973985wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 14:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=czs8sdBA/sHPCWDkIWdbqK/qXxxuF+2nb4aU5nz/4aQ=;
        b=FKeTDSTeK4Ops62th+i3KGYu31KHBGHSCR1EpkNSQHfRaBR3H/1WzSwTz0oRbnlSWo
         YPVoCjaFhdS/gHmLGhCqhrwgQUfJCs1cgAm1Qd9TKszJyGJ51dSZgsN8ku49i4eDYxzd
         ZneeTAhJfdMqOP7lKkB1KoZs8u5A/eldm/fD6MyZkaJt+O88xttwq9wqq8jBdHk0M1n+
         10ylITCIMtaN7d3k7pJN+sNYdQ46/SR3I2S3uEumUsGy56j1ays13gIIgaZIdZMI/vIJ
         T7cuJC/qo/HOKj6xFMqJxaKei/p5Dxc+rKmGAd4E4qmxHSios96WQGDeBEHHTxwZA0mx
         T6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=czs8sdBA/sHPCWDkIWdbqK/qXxxuF+2nb4aU5nz/4aQ=;
        b=aF/zX1WAEGA06ignk7NPVygsNHuI476BGdjdY9xkZqvGMlnIWGzC2Ons7/oZcSs6pE
         26CnPPmETCOf8kYIgJM+9L19UswBykCnO1itopRoBeDJwL7DFemvHFT62jgZ1TRTNPi2
         ehMgPOklaLvXBh1fEo5oWmB6oXI+nWIdf+33V0wc+7ezHpK2fBZN2krAQpgytXGDIsuO
         k12Q/gmVwpwUym0xt0sXV1ecKjyHSZuwtkg41gGgsDkcXQri5xO53Q31U94TkTSHR4vt
         XqV7UN/Qtv5VgAxixGpPntvvTQunxgIxHeiH4NvwL67VcXjWm0ltsZlyEUj6r7fF/X2s
         +59A==
X-Gm-Message-State: APjAAAVz2/QF60l7ZhxfGAoBe8nCZq0CkhlfkjAe5cGY8Rsh7+iMBkf7
        R8bCIGAhBjyQUmfSSzxE5Js=
X-Google-Smtp-Source: APXvYqxnIkZmublYgiMmgRlGkKyyjNYgFaG8tIcog+gMgExU1kHo5gu5Ex090bDuXJbn1Ong+gHcNA==
X-Received: by 2002:a1c:1dc9:: with SMTP id d192mr23483147wmd.92.1575325312929;
        Mon, 02 Dec 2019 14:21:52 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id b63sm760833wmb.40.2019.12.02.14.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 14:21:52 -0800 (PST)
Date:   Mon, 2 Dec 2019 22:21:51 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_vma_mapped: use PMD_SIZE instead of
 calculating it
Message-ID: <20191202222151.xx4g3ry7mrcselh5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20191128010321.21730-1-richardw.yang@linux.intel.com>
 <20191128083255.ab5rwj7gvktwunik@box.shutemov.name>
 <20191128212226.sfrhfs5m3q7m6tly@master>
 <20191202080315.oqtm3q7cyfkl5rma@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202080315.oqtm3q7cyfkl5rma@box.shutemov.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 11:03:15AM +0300, Kirill A. Shutemov wrote:
>On Thu, Nov 28, 2019 at 09:22:26PM +0000, Wei Yang wrote:
>> On Thu, Nov 28, 2019 at 11:32:55AM +0300, Kirill A. Shutemov wrote:
>> >On Thu, Nov 28, 2019 at 09:03:20AM +0800, Wei Yang wrote:
>> >> At this point, we are sure page is PageTransHuge, which means
>> >> hpage_nr_pages is HPAGE_PMD_NR.
>> >> 
>> >> This is safe to use PMD_SIZE instead of calculating it.
>> >> 
>> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >> ---
>> >>  mm/page_vma_mapped.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> 
>> >> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> >> index eff4b4520c8d..76e03650a3ab 100644
>> >> --- a/mm/page_vma_mapped.c
>> >> +++ b/mm/page_vma_mapped.c
>> >> @@ -223,7 +223,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>> >>  			if (pvmw->address >= pvmw->vma->vm_end ||
>> >>  			    pvmw->address >=
>> >>  					__vma_address(pvmw->page, pvmw->vma) +
>> >> -					hpage_nr_pages(pvmw->page) * PAGE_SIZE)
>> >> +					PMD_SIZE)
>> >>  				return not_found(pvmw);
>> >>  			/* Did we cross page table boundary? */
>> >>  			if (pvmw->address % PMD_SIZE == 0) {
>> >
>> >It is dubious cleanup. Maybe page_size(pvmw->page) instead? It will not
>> >break if we ever get PUD THP pages.
>> >
>> 
>> Thanks for your comment.
>> 
>> I took a look into the code again and found I may miss something.
>> 
>> I found we support PUD THP pages, whilc hpage_nr_pages() just return
>> HPAGE_PMD_NR on PageTransHuge. Why this is not possible to return PUD number?
>
>We only support PUD THP for DAX. Means, we don't have struct page for it.
>

BTW, may I ask why you suggest to use page_size() if we are sure only PMD THP
page is used here? To be more generic?

>-- 
> Kirill A. Shutemov

-- 
Wei Yang
Help you, Help me
