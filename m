Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09615C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24FB20578
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="I+a/3Ifr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfHNJjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:39:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44921 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfHNJjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:39:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so52810536pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 02:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=r84qtxIuA7/blK51KqUqinmNMAkGTw/Qe9MaT+YbCuA=;
        b=I+a/3IfrZka+df+VqO9hj1OrRsHIccQpcN3wJL1M06I0MWZHAMgdReQ9u09u/xk5QT
         YH4G5KjoAs3u/+JfQIXMAdNw7d1S5TrrOBCp03qrJuzA++sRNm15SwkkknjFsufbEfsV
         Xbqc3ApEG/vIj1Cci+lUAnazDWSYFtLQUPtkrt6cL2JsgB5I9xGxzRHt3Vkf94Dbz34m
         ghXkXRhpZSvjyomABZ6z4PeASet4xx4OGRm6vzBrTBUCBAEHCoQ89YMIe+cnj20NSvid
         60gXOa7ILqXgpe7VFulvVxxGo2oDwblbJqizPoJWaTqWb77uP2AfZfWX0qqYP/4p7r9i
         6EsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=r84qtxIuA7/blK51KqUqinmNMAkGTw/Qe9MaT+YbCuA=;
        b=Z25C74CFP7iC/fkgqjD3bKU+MTsj30X3DkrnMsIDaHPZ+BK80jHdn/QCfbTVtvOZiT
         bNSk4xupAwMpghCQcPie7y8eoqqf9T2TgNvFYb5xB5w/Y3HEqWT6YnJTvE6qv99kzQ+R
         WV80rjLdK4fHC8ckXRaR6klb00Ix+LPT2FKaofaLK4+wjSEFaT91/09WaN5ubC0TuuiK
         lU0efgdhLqcPYEKCroZpQb8JMPZZAMU1dawXXVg+SR+09hXj5z6rj92G/W7YU1qW9BPv
         M/7i5c7RhPa7WKsuckem86Lv2t1KE/yS1IQdgrAE8IyZlNp7tHN7nXiu3klJf/gWV6ZX
         83Gg==
X-Gm-Message-State: APjAAAX+IP/ijA0RNY/86fLqKG/HMt61spN4eDNC42Z5kx6PPRZB5L3q
        +hKfr1bp8Tnt3s4Q+2SmrN42+w==
X-Google-Smtp-Source: APXvYqwteVY2sGfFJZ13FnbIh3pNMmFyoM8OwTJPd/Jr/1JBkTgUgmhx+Zai3JUK3Kchry/hm3UpxA==
X-Received: by 2002:a17:90a:246f:: with SMTP id h102mr6246079pje.125.1565775580607;
        Wed, 14 Aug 2019 02:39:40 -0700 (PDT)
Received: from localhost ([129.41.84.73])
        by smtp.gmail.com with ESMTPSA id j11sm10747882pjb.11.2019.08.14.02.39.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 02:39:40 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     Balbir Singh <bsingharora@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v9 4/7] extable: Add function to search only kernel exception table
In-Reply-To: <916d5741-a0bd-8860-4a38-7a5ef677214a@gmail.com>
References: <20190812092236.16648-1-santosh@fossix.org> <20190812092236.16648-5-santosh@fossix.org> <916d5741-a0bd-8860-4a38-7a5ef677214a@gmail.com>
Date:   Wed, 14 Aug 2019 15:09:37 +0530
Message-ID: <877e7gqe5i.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <bsingharora@gmail.com> writes:

> On 12/8/19 7:22 pm, Santosh Sivaraj wrote:
>> Certain architecture specific operating modes (e.g., in powerpc machine
>> check handler that is unable to access vmalloc memory), the
>> search_exception_tables cannot be called because it also searches the
>> module exception tables if entry is not found in the kernel exception
>> table.
>> 
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  include/linux/extable.h |  2 ++
>>  kernel/extable.c        | 11 +++++++++--
>>  2 files changed, 11 insertions(+), 2 deletions(-)
>> 
>> diff --git a/include/linux/extable.h b/include/linux/extable.h
>> index 41c5b3a25f67..81ecfaa83ad3 100644
>> --- a/include/linux/extable.h
>> +++ b/include/linux/extable.h
>> @@ -19,6 +19,8 @@ void trim_init_extable(struct module *m);
>>  
>>  /* Given an address, look for it in the exception tables */
>>  const struct exception_table_entry *search_exception_tables(unsigned long add);
>> +const struct exception_table_entry *
>> +search_kernel_exception_table(unsigned long addr);
>> 
>
> Can we find a better name search_kernel still sounds like all of the kernel.
> Can we rename it to search_kernel_linear_map_extable?

I thought search_kernel_exception_table and search_module_extables were
non-ambiguous enough :-) But If you think name will be confusing, I can
change that as suggested.

Thanks,
Santosh

>
>  
>>  #ifdef CONFIG_MODULES
>>  /* For extable.c to search modules' exception tables. */
>> diff --git a/kernel/extable.c b/kernel/extable.c
>> index e23cce6e6092..f6c9406eec7d 100644
>> --- a/kernel/extable.c
>> +++ b/kernel/extable.c
>> @@ -40,13 +40,20 @@ void __init sort_main_extable(void)
>>  	}
>>  }
>>  
>> +/* Given an address, look for it in the kernel exception table */
>> +const
>> +struct exception_table_entry *search_kernel_exception_table(unsigned long addr)
>> +{
>> +	return search_extable(__start___ex_table,
>> +			      __stop___ex_table - __start___ex_table, addr);
>> +}
>> +
>>  /* Given an address, look for it in the exception tables. */
>>  const struct exception_table_entry *search_exception_tables(unsigned long addr)
>>  {
>>  	const struct exception_table_entry *e;
>>  
>> -	e = search_extable(__start___ex_table,
>> -			   __stop___ex_table - __start___ex_table, addr);
>> +	e = search_kernel_exception_table(addr);
>>  	if (!e)
>>  		e = search_module_extables(addr);
>>  	return e;
>> 

-- 
if (( RANDOM % 2 )); then ~/bin/cookie; else fortune -s; fi
#cat ~/notes/quotes | sort -R | head -1 | cut -f2- -d " "
