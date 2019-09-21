Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8540DC49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 13:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D37B20C01
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 13:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uV1iPiYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394182AbfIUNTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 09:19:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41870 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388184AbfIUNTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 09:19:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id q7so6336711pfh.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=W+8ekTa9bxVsBuWJwU/8AJ+YtRXTgXJvM5aflsiRw9k=;
        b=uV1iPiYQk1e6NbfNJ8We8iK7oluOWL0Hk/ZMhuNR/wjLhXsjJTusXf9UaZmH2Q0smn
         XtW9GB/AJkWCGsk8XFi4goxBDmeexyzPbU8dolM29bc2w10bdNX1OZ8FHmhb83mBoFfr
         cZRPBsw6cFySPnUfGpXU2GXwraRqgtPx9YeG6qXrVCBfVp1rL0kqadMOa83zSH7CnTF5
         kxholiBotGcFAj8yDqBO/onLZEDfdwRjQ+10a+NS2vlPl5xnim4sOyWVZRvzgcxevPxQ
         TJn2z6Ny9m282Ymd9CipIPgk7VvugoclMMFIvSxEH4mRjnNi5qQAHyNSAhmuGzuhpJCN
         me9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=W+8ekTa9bxVsBuWJwU/8AJ+YtRXTgXJvM5aflsiRw9k=;
        b=IyLri+6pL43whE+zncDY6Y7wyHiYt3JL8UnjSLzQs4HIIgfVPaVcCF+yAb9c71SCBh
         WkRsNeZbyaoVEi8QoEPGPqgVY9boNIg2GyCuLd6h2WnWRvxxeyikixtyWSVDKyr1OFAq
         0ytoGRlfot1wYTAYaxl1Pfj3C1uCHhES3HNdUCl0Wn9tFCO5SqzAwEc3yHpU97bOihZV
         z0wQ0VxMPB9C0RkOLumXm3KJ+WXKn62ipdorGXzdHXx7JeBncVsZrhEVuf21e/aZyvPY
         EbVr0BKx0AlmOWh305jeT7Pek1L/NQnEu+rcH1shLshqlqDUTgTJI+19otlfIbT9CKrj
         Y52Q==
X-Gm-Message-State: APjAAAUveIKBpy3bVptWZbAYQyWMLmGXvSw+K+m1/a/i+yOWjQpk1Ba8
        f06F5Etphj/cHVs9uw6B638=
X-Google-Smtp-Source: APXvYqxWEUGpJd2yL4QrtTGoorZe0rFzJ80dXXaylsMldnIkT9DQkSFOhoFFuZ/0b5RKiu4t41Ut7g==
X-Received: by 2002:a17:90a:3387:: with SMTP id n7mr10004663pjb.26.1569071993741;
        Sat, 21 Sep 2019 06:19:53 -0700 (PDT)
Received: from [0.0.0.0] (104.129.187.94.16clouds.com. [104.129.187.94])
        by smtp.gmail.com with ESMTPSA id d76sm7941194pfd.185.2019.09.21.06.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Sep 2019 06:19:52 -0700 (PDT)
Subject: Re: [PATCH v7 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
To:     Matthew Wilcox <willy@infradead.org>, Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Kaly Xin <Kaly.Xin@arm.com>, nd@arm.com
References: <20190920135437.25622-1-justin.he@arm.com>
 <20190920135437.25622-4-justin.he@arm.com>
 <20190920155300.GC15392@bombadil.infradead.org>
From:   Jia He <hejianet@gmail.com>
Message-ID: <dbfc9da4-6650-5c9e-59c6-16e0f234b9c8@gmail.com>
Date:   Sat, 21 Sep 2019 21:19:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190920155300.GC15392@bombadil.infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[On behalf of justin.he@arm.com]

Hi Matthew

On 2019/9/20 23:53, Matthew Wilcox wrote:
> On Fri, Sep 20, 2019 at 09:54:37PM +0800, Jia He wrote:
>> -static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
>> +static inline int cow_user_page(struct page *dst, struct page *src,
>> +				struct vm_fault *vmf)
>>   {
> Can we talk about the return type here?
>
>> +			} else {
>> +				/* Other thread has already handled the fault
>> +				 * and we don't need to do anything. If it's
>> +				 * not the case, the fault will be triggered
>> +				 * again on the same address.
>> +				 */
>> +				pte_unmap_unlock(vmf->pte, vmf->ptl);
>> +				return -1;
> ...
>> +	return 0;
>>   }
> So -1 for "try again" and 0 for "succeeded".
>
>> +		if (cow_user_page(new_page, old_page, vmf)) {
> Then we use it like a bool.  But it's kind of backwards from a bool because
> false is success.
>
>> +			/* COW failed, if the fault was solved by other,
>> +			 * it's fine. If not, userspace would re-fault on
>> +			 * the same address and we will handle the fault
>> +			 * from the second attempt.
>> +			 */
>> +			put_page(new_page);
>> +			if (old_page)
>> +				put_page(old_page);
>> +			return 0;
> And we don't use the return value; in fact we invert it.
>
> Would this make more sense:
>
> static inline bool cow_user_page(struct page *dst, struct page *src,
> 					struct vm_fault *vmf)
> ...
> 				pte_unmap_unlock(vmf->pte, vmf->ptl);
> 				return false;
> ...
> 	return true;
> ...
> 		if (!cow_user_page(new_page, old_page, vmf)) {
>
> That reads more sensibly for me.  We could also go with returning a
> vm_fault_t, but that would be more complex than needed today, I think.

Ok, will change the return type to bool as you suggested.
Thanks

---
Cheers,
Justin (Jia He)

