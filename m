Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEA7C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0330D217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCOBoICU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbfHHOdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:33:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41890 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732741AbfHHOdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:33:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id w5so2448565edl.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1+hRXOJC+ZDM/4/kVVufU5PRo9dpiWo2Z8YGtmpPW2I=;
        b=cCOBoICU8CNt81EgZopFsi62bJmq0dCGhRRyOBZrHz6x4zgZMVW0I0qIH4tqKn99Ch
         KCuglEQChTF0oNH1RULG7gBFl9ROMSdkWPvDjWYgtyOrwC7lBeww1a4RHafAsavxSbuz
         Fm5M+8QkjJbkTLchwoDqDiNyYbvLWr++v5jvUHZn519FGt5V8pAxBJ4xQpWhD/gIuloD
         XKVlh5ov7P2gm1HzEQ48jtXVuZeHjUX32eyJr6Bqts2hiTE9KbIsnJiV+CpxXmKThH2e
         wmRBJg1RkKYjzuvNjK7zAtt1JAO3piFKSeZxcWyHrAMwdAXPw6YlB+ETRwL/ZUXfkWia
         2s4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1+hRXOJC+ZDM/4/kVVufU5PRo9dpiWo2Z8YGtmpPW2I=;
        b=qgyiQnj9YDMvD3ggUrdJ2lhNsj3M6OSr1hutHK6Aw1eNvSTbFEQS4mX80MlPr9UpjB
         OL/wJgGKNbx6q5tDREkJI7FKSPSBuWPKqoIQq0mbhLpHe0qrmSdkFugmmS3750Jf2Uyi
         C/ShSfl6OR8Ozm4P/ltkvf6d4tl2B0vw7GUgCcj3mJcZKSLGTQYa402GAhoBZmBltG6p
         BQ7uCmL+49gE9gQhc7oNPmAt7a436Rd6BB9GdrilzGt4ajyJIOHvtK1kZ0k/GaljE5jZ
         kq6sC8llPduDWeZNHM2RbQvgMO+tjEy13CDDFn4NWVZnKUlfS9ZVPIakC+lstpl46xWC
         hnmQ==
X-Gm-Message-State: APjAAAUfSdp2FoKPTwzQCfUfEXIK9TiQpkpOH8LB2c7aoq6uYfG/8zKW
        gtaarzETyuifPM32seEHjd0=
X-Google-Smtp-Source: APXvYqw60Qv6BR5nyiLLGJOB6JFXkK8yFSkjUH6a9VxpLPc86WgYOyY4BHMmwi1P9oj0mhGac7YRMA==
X-Received: by 2002:a17:906:4354:: with SMTP id z20mr13315954ejm.163.1565274817932;
        Thu, 08 Aug 2019 07:33:37 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id m17sm255658ejc.91.2019.08.08.07.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 07:33:37 -0700 (PDT)
Date:   Thu, 8 Aug 2019 14:33:36 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap.c: refine data locality of find_vma_prev
Message-ID: <20190808143336.kgq4f6j5gfixtcb4@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190806081123.22334-1-richardw.yang@linux.intel.com>
 <3e57ba64-732b-d5be-1ad6-eecc731ef405@suse.cz>
 <20190807003109.GB24750@richard>
 <20190807075101.GN11812@dhcp22.suse.cz>
 <20190808032638.GA28138@richard>
 <d4aab7f0-b653-8636-b5a7-97d3291f289d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4aab7f0-b653-8636-b5a7-97d3291f289d@suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 10:49:29AM +0200, Vlastimil Babka wrote:
>On 8/8/19 5:26 AM, Wei Yang wrote:
>> 
>> @@ -2270,12 +2270,9 @@ find_vma_prev(struct mm_struct *mm, unsigned long addr,
>>         if (vma) {
>>                 *pprev = vma->vm_prev;
>>         } else {
>> -               struct rb_node *rb_node = mm->mm_rb.rb_node;
>> -               *pprev = NULL;
>> -               while (rb_node) {
>> -                       *pprev = rb_entry(rb_node, struct vm_area_struct, vm_rb);
>> -                       rb_node = rb_node->rb_right;
>> -               }
>> +               struct rb_node *rb_node = rb_last(&mm->mm_rb);
>> +               *pprev = !rb_node ? NULL :
>> +                        rb_entry(rb_node, struct vm_area_struct, vm_rb);
>>         }
>>         return vma;
>> 
>> Not sure this style would help a little in understanding the code?
>
>Yeah using rb_last() would be nicer than basically repeating its
>implementation, so it's fine as a cleanup without performance implications.
>

Thanks, I would send this version with proper change log.

>>> -- 
>>> Michal Hocko
>>> SUSE Labs
>> 

-- 
Wei Yang
Help you, Help me
