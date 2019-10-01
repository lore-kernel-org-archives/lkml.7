Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA05C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7079821906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBdmmIW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732895AbfJALrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:47:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37964 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfJALrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:47:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id l21so11595950edr.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 04:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Xd6UScQozp4QkRn+IKR4457aMOKd7VeVUkKwGNlTLM=;
        b=YBdmmIW7VxgCRAodwKgJ9puiPHFdtVxlzN8i72ToFE4Fd/kiOKwtN669DW/pnKVjdt
         hB1V7H+n/Xjvgc9cOvO9plNOMmeMXhKLRanwtgumHpjeE5bmErFl2P4D/3Moh52apLE4
         tTNGEdY/4rPpIxZ6e5VNh20QcsOFRCAtumFHRToqGgkR0a+FVTvYJlqSbWEKow4kohVD
         k2cV/XohXztNhvUhiKl7wAb6lnQ90xogyZLsqB1qUT26GeePSVi6zpNxSN8XWnvrmWgE
         O3vVMdkaG6SK/kNIt8YDhB/uWs1HBX++z2kjeSE2V15E0rHBUFCq0PTBiwuRLyfWPplN
         PZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Xd6UScQozp4QkRn+IKR4457aMOKd7VeVUkKwGNlTLM=;
        b=Qce2m3by466OnTCuR93a4js7brvVyNhaQrtjlodOz+BXNfs3WnrhCNpX7xvA6tqyyd
         6b0tJje4WOvXJ4LOsrE94OAujlOjhWckyCUteLkZOLRUGt5lQ3ow5TpOKXcD9+SPYn2I
         ILNqdThcqnl6V7ccP8tqfqih/laOiFPCT0c6UWx5BTLqhEIbTAIqmzDrimRTCRNqFe8H
         dmmiVxq39f1exADxA+yDFYJhF0T2ULB5NegY1p2fzNUyBy1rP25SS2O4SjyDIm+M+FDw
         b9H0YFENCzuVkOZuNSsormVEO4mXnIr4ONcg834IDKXrihdlVlTMhFB8B+Q5TJOpQxhG
         O5BQ==
X-Gm-Message-State: APjAAAVVkutKDc/AFloShuFr58Oc0TisiOH6waV8YVe2lhmXEWrBLNgW
        EjtUxwa7fB5Kkrl1o4Ud8CXVjzo+
X-Google-Smtp-Source: APXvYqwHqEXUoMR1cxL8ESQ8kRhGUPGoFQ4KzFUlO2sPDZorcrmpPOb8chGtFfvoa78gMQHiZqpyvw==
X-Received: by 2002:a17:906:6bca:: with SMTP id t10mr23948062ejs.64.1569930421410;
        Tue, 01 Oct 2019 04:47:01 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id g9sm1806523ejj.51.2019.10.01.04.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 04:47:00 -0700 (PDT)
Date:   Tue, 1 Oct 2019 11:47:00 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        dave.hansen@linux.intel.com, luto@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm: replace a goto by merging two if clause
Message-ID: <20191001114700.wqcglmbrajqkmc22@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190919020844.27461-1-richardw.yang@linux.intel.com>
 <20190919020844.27461-2-richardw.yang@linux.intel.com>
 <20190923092231.GJ2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923092231.GJ2349@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 11:22:31AM +0200, Peter Zijlstra wrote:
>On Thu, Sep 19, 2019 at 10:08:44AM +0800, Wei Yang wrote:
>> There is only one place to use good_area jump, which could be reduced by
>> merging the following two if clause.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  arch/x86/mm/fault.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index 9d18b73b5f77..72ce6c69e195 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -1390,18 +1390,17 @@ void do_user_addr_fault(struct pt_regs *regs,
>>  	vma = find_vma(mm, address);
>>  	if (unlikely(!vma))
>>  		goto bad_area;
>> -	if (likely(vma->vm_start <= address))
>> -		goto good_area;
>> -	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
>> -		goto bad_area;
>> -	if (unlikely(expand_stack(vma, address)))
>> +	if (likely(vma->vm_start <= address)) {
>> +		/* good area, do nothing */
>> +	} else if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)) ||
>> +		   unlikely(expand_stack(vma, address))) {
>>  		goto bad_area;
>> +	}
>>  
>>  	/*
>>  	 * Ok, we have a good vm_area for this memory access, so
>>  	 * we can handle it..
>>  	 */
>> -good_area:
>>  	if (unlikely(access_error(hw_error_code, vma))) {
>>  		bad_area_access_error(regs, hw_error_code, address, vma);
>>  		return;
>
>I find the old code far easier to read... is there any actual reason to
>do this?

Hi, Peter,

Do you have some comment for the Patch 1?

-- 
Wei Yang
Help you, Help me
