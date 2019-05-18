Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C40C04E87
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 00:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD5D218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 00:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GlE7XEqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfERAeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 20:34:22 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:56319 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbfERAeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 20:34:21 -0400
Received: by mail-it1-f193.google.com with SMTP id q132so14655149itc.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 17:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b5n7JVWK5PuLohx//2v3Z4Nb24OaLEF5cXMyzmq0tM4=;
        b=GlE7XEqWvOqu/OtX/1y2E0QJBn6hrlGBMC8yIDsoTJF6ExJjZWnG01OBozF/DTGVBg
         kVzmD06beTzOFeBh90emoul3tZd+TXYcHy4sOvoE1lGfQhYX3GAN1iy6QZj6UAQQS0Ed
         Wa2Xwy6zgkDCz8PCeDvi+YqLjVnTfE4CZid44mStA//kSCHnstIBSespZSBxndf0/r9I
         7nhD5rrmGwX4wUx19p/6jKhnxYojyf8o2XjHfHON8fuHiF9lEe4yjIRlcx9KNoY67x34
         caDNYWTSGeWUvCjqwFjH71mmObQAXCsPunQ6yxlxx9kzRVitT4M453xWc5u8f4LpKKrw
         xhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b5n7JVWK5PuLohx//2v3Z4Nb24OaLEF5cXMyzmq0tM4=;
        b=drlOlPrGj1iQnYtl9ZEgM++bE8GqVYzUquK0kaS0Hl41iqv31mT4bbe9py/Rr4O+hk
         8cldEGL1Ai/IUxGGC4/6klg/IfdfN6V9bFKwX3OKp4KodTTnH8OYlCgzNZ/U/JV8ysLE
         5MiB+MevN/EP+2o5kSfs6h83yr+cy+1QSGSjm/wOAQaxPvrz/D1EBQYOho2HYt9oTaqQ
         3BiCKAoBWj/PJ7ffycmbSIjkW5NrEU4p1rhO5SWuvjX+mc3XQ+ZHTMbqSAyxi+tnxmuL
         x8tOsEy6buzYj1V/xd+BOxkeCoAN6gaYXQfs/L/iEMMKAOZVzFQpXlxDJmSORFKlUuxu
         Qv0A==
X-Gm-Message-State: APjAAAVMEeZIEbuLzRF/L/NqhgyJmucm4mz2J5Nz/FuMjU/HY3cnOPNm
        ySwiiHo33szNgFiBAK79cBt2BNxFHUQ=
X-Google-Smtp-Source: APXvYqx4hl+SRkHHdCAeG1l9KxK8OFx7BpiR8P+P4fNj187t7LAz5tHMU1dKAnhyzDzsEwAe5Ox3mQ==
X-Received: by 2002:a02:9f8f:: with SMTP id a15mr3884926jam.99.1558139660230;
        Fri, 17 May 2019 17:34:20 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id c11sm880548itj.31.2019.05.17.17.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 17:34:19 -0700 (PDT)
Subject: Re: [PATCH 12/18] soc: qcom: ipa: immediate commands
From:   Alex Elder <elder@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-13-elder@linaro.org>
 <CAK8P3a3v2fzSBmYk1vG7sKJ9jnAWGt_u91EuLC7f5jq_PqrKXQ@mail.gmail.com>
 <f92bfb59-07bb-e8c0-c307-cd69da7ccd8a@linaro.org>
Message-ID: <5d948d74-f739-0cfa-8fae-b15c20fbe7ec@linaro.org>
Date:   Fri, 17 May 2019 19:34:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f92bfb59-07bb-e8c0-c307-cd69da7ccd8a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 7:35 AM, Alex Elder wrote:
> On 5/15/19 3:16 AM, Arnd Bergmann wrote:
>> On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:
>>
>>> +/* Initialize header space in IPA local memory */
>>> +int ipa_cmd_hdr_init_local(struct ipa *ipa, u32 offset, u32 size)
>>> +{
>>> +       struct ipa_imm_cmd_hw_hdr_init_local *payload;
>>> +       struct device *dev = &ipa->pdev->dev;
>>> +       dma_addr_t addr;
>>> +       void *virt;
>>> +       u32 flags;
>>> +       u32 max;
>>> +       int ret;
>>> +
>>> +       /* Note: size *can* be zero in this case */
>>> +       if (size > field_max(IPA_CMD_HDR_INIT_FLAGS_TABLE_SIZE_FMASK))
>>> +               return -EINVAL;
>>> +
>>> +       max = field_max(IPA_CMD_HDR_INIT_FLAGS_HDR_ADDR_FMASK);
>>> +       if (offset > max || ipa->shared_offset > max - offset)
>>> +               return -EINVAL;
>>> +       offset += ipa->shared_offset;
>>> +
>>> +       /* A zero-filled buffer of the right size is all that's required */
>>> +       virt = dma_alloc_coherent(dev, size, &addr, GFP_KERNEL);
>>> +       if (!virt)
>>> +               return -ENOMEM;
>>> +
>>> +       payload = kzalloc(sizeof(*payload), GFP_KERNEL);
>>> +       if (!payload) {
>>> +               ret = -ENOMEM;
>>> +               goto out_dma_free;
>>> +       }
>>> +
>>> +       payload->hdr_table_addr = addr;
>>> +       flags = u32_encode_bits(size, IPA_CMD_HDR_INIT_FLAGS_TABLE_SIZE_FMASK);
>>> +       flags |= u32_encode_bits(offset, IPA_CMD_HDR_INIT_FLAGS_HDR_ADDR_FMASK);
>>> +       payload->flags = flags;
>>> +
>>> +       ret = ipa_cmd(ipa, IPA_CMD_HDR_INIT_LOCAL, payload, sizeof(*payload));
>>> +
>>> +       kfree(payload);
>>> +out_dma_free:
>>> +       dma_free_coherent(dev, size, virt, addr);
>>> +
>>> +       return ret;
>>> +}
>>
>> This looks rather strange. I think I looked at it before and you explained
>> it, but I have since forgotten what you do it for, so I assume everyone else
>> that tries to understand this will have problems too.
> 
> This is a bug.  I think I misunderstood why you were
> puzzled before.  Now I get it.  I need to save that
> DMA address and not free it at the end of the function
> (except on error).

OK, now I'm going to correct myself.  I hope I don't make
any mistakes here because things are confused enough...

Part of what I described previously is still true, namely
there are tables that need to be initialized (i.e., the
IPA needs to be told where they reside), and there is a
separate step is available to zero the content of the tables.

But there really is no need for the AP to hang onto this
DMA memory after this immediate command has been issued.
I will add comments in the code to make it less surprising.

But here's a summary of why.

I think there are two things at play that make it confusing.

The first thing is that these "header tables" are actually
located in a region of shared memory ("smem") that is local
to the IPA (not the AP).  The the IPA_CMD_HDR_INIT_LOCAL
immediate command is meant to:
1) define the header table location in IPA local memory
2) define the header table size
3) provide a buffer used to fill the table with its initial
   contents

The location and size are encoded in the flags field
of the payload (offset and size).

The initial contents are filled via DMA from a buffer
in main memory, whose DMA address is supplied in the
hdr_table_addr parameter in the payload.  The initial
contents we supply are all zero.  So this is why we
need to allocate DMA memory.

The second thing is that this is an instance where the
AP is responsible for performing some initialization
of resources it may not "own" thereafter.  The IPA
hardware owns this table, even though the AP needs to
tell it where it sits in IPA local memory.  The AP is
able to copy (using DMA) content into that table, but
doing so involves a DMA transfer.

More advanced features of the IPA would make more use
of this header table, but those features not yet
supported so this initialization (and a subsequent,
seemingly redundant zeroing) is all we do.

Does that make sense?

					-Alex


> Here's what I think happened.  There are two parts of
> initializing these tables.  One part tells the hardware
> where the table is located.  Another part zeroes the
> contents of those tables.  (The zeroing part could be
> accomplished when the table is allocated, but there
> are cases where they have to be zeroed again without
> needing to tell the hardware so we need to at least
> be able to do that independently.)
> 
> I think I was assuming this was the function that did
> the zeroing, and I thought that adding the comment about
> "all we need is a zero-filled buffer" addressed what
> you thought should be made clearer.
> 
> I will definitely fix this, and I'm glad you repeated
> it so I was forced to take another look.
> 
> If I again misunderstand your point, please let me know.
> 
> 					-Alex
> 
>> The issue I see is that you do an expensive dma_alloc_coherent()
>> but then never actually use the pointer returned by it, only the
>> dma address that cannot be turned back into a virtual address
>> in order to access the data in it.
>>
>> If you can't actually use payload->hdr_table_addr, why even allocate
>> it here?
>>
>>      Arnd
>>
> 

