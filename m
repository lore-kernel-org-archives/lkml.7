Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CEBC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6705B206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yUWrufIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfEOMfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:35:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46232 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEOMfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:35:39 -0400
Received: by mail-io1-f65.google.com with SMTP id q21so2027342iog.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l0txRmhZpTXPFEYlXXcIARzB+1tYN7OtpRlVR6Oaqao=;
        b=yUWrufIZZAF8K5Zc6gWsvLLVaMBEHSOhDuP4zx/RxjVQMIByA1A4MzhgkQNsvcq89Z
         OdvwbNlGLkouv4uLXC3eKAGwTfldmEulkBCNJOe+9BCWLSfynps7GDdNbeuxhtCbTQEq
         m+5BZGcdK9lI0vrggjIPoeAGLQyi8ZFIRG2KfX6biclPH3drUl2ecwt0w297OkL3s0Sb
         xM2P+8DYMgUbSEmVA3U0YNBD6A0JsJmk9O21gQMXojqEXGvXpF6RYuIpayZ7J/r++wqE
         6k8jWr8AphOFPoxLRF7LnhkHd1MaaFlnwlg6XT4irSvt8i7CdW8nZEpoLL6Pk0qdW/gw
         d7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l0txRmhZpTXPFEYlXXcIARzB+1tYN7OtpRlVR6Oaqao=;
        b=ZXHCUMTtJfG65I/3Uk8xDrw23OPZa/mQJeYKyBzV3XOx26ylRibtCkSOM02MXrqwfU
         3EDcfLk8cUoprBndN6p+bInOW1z1H1THFIXznEG/KWqa40s8N3oBHk6Ld/FDoAC/JYhd
         A39V3pFFyCe4k3Qkv44L/ZFSb4fiSUBdI/CfS2Gepqf5nkIA35B4OoPY3O5pFElN2Ai3
         yzlXfJjWK81yd2C2IU/HiH0ATi3qSFzNjJFCVEtoBiSbJ4DB6G7OE58rlZ10pkRsgjCm
         YpOxmgeNpX5nkARZsrnMLdzft31grOLvdhXCfdyAJT//09PNUc+3rKiss9VHBodsLozk
         boBw==
X-Gm-Message-State: APjAAAUjKCRyf1yyfpfGb08gXG4o9eTIhyqUFq+vrfZPtCaeOiDKudvf
        5RQE/ffubrUcrgdNTu+LgwHubw7khxI=
X-Google-Smtp-Source: APXvYqy+C6YzaETSthh0IGl0YIX+TI6WSuuKNXVAkRyGFeuqJIMgPW8I16VhlgQvtTduzMrJ6rAkCg==
X-Received: by 2002:a5d:9a11:: with SMTP id s17mr13304438iol.267.1557923738513;
        Wed, 15 May 2019 05:35:38 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id r12sm74282itb.2.2019.05.15.05.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 05:35:37 -0700 (PDT)
Subject: Re: [PATCH 12/18] soc: qcom: ipa: immediate commands
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
From:   Alex Elder <elder@linaro.org>
Message-ID: <f92bfb59-07bb-e8c0-c307-cd69da7ccd8a@linaro.org>
Date:   Wed, 15 May 2019 07:35:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3v2fzSBmYk1vG7sKJ9jnAWGt_u91EuLC7f5jq_PqrKXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 3:16 AM, Arnd Bergmann wrote:
> On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:
> 
>> +/* Initialize header space in IPA local memory */
>> +int ipa_cmd_hdr_init_local(struct ipa *ipa, u32 offset, u32 size)
>> +{
>> +       struct ipa_imm_cmd_hw_hdr_init_local *payload;
>> +       struct device *dev = &ipa->pdev->dev;
>> +       dma_addr_t addr;
>> +       void *virt;
>> +       u32 flags;
>> +       u32 max;
>> +       int ret;
>> +
>> +       /* Note: size *can* be zero in this case */
>> +       if (size > field_max(IPA_CMD_HDR_INIT_FLAGS_TABLE_SIZE_FMASK))
>> +               return -EINVAL;
>> +
>> +       max = field_max(IPA_CMD_HDR_INIT_FLAGS_HDR_ADDR_FMASK);
>> +       if (offset > max || ipa->shared_offset > max - offset)
>> +               return -EINVAL;
>> +       offset += ipa->shared_offset;
>> +
>> +       /* A zero-filled buffer of the right size is all that's required */
>> +       virt = dma_alloc_coherent(dev, size, &addr, GFP_KERNEL);
>> +       if (!virt)
>> +               return -ENOMEM;
>> +
>> +       payload = kzalloc(sizeof(*payload), GFP_KERNEL);
>> +       if (!payload) {
>> +               ret = -ENOMEM;
>> +               goto out_dma_free;
>> +       }
>> +
>> +       payload->hdr_table_addr = addr;
>> +       flags = u32_encode_bits(size, IPA_CMD_HDR_INIT_FLAGS_TABLE_SIZE_FMASK);
>> +       flags |= u32_encode_bits(offset, IPA_CMD_HDR_INIT_FLAGS_HDR_ADDR_FMASK);
>> +       payload->flags = flags;
>> +
>> +       ret = ipa_cmd(ipa, IPA_CMD_HDR_INIT_LOCAL, payload, sizeof(*payload));
>> +
>> +       kfree(payload);
>> +out_dma_free:
>> +       dma_free_coherent(dev, size, virt, addr);
>> +
>> +       return ret;
>> +}
> 
> This looks rather strange. I think I looked at it before and you explained
> it, but I have since forgotten what you do it for, so I assume everyone else
> that tries to understand this will have problems too.

This is a bug.  I think I misunderstood why you were
puzzled before.  Now I get it.  I need to save that
DMA address and not free it at the end of the function
(except on error).

Here's what I think happened.  There are two parts of
initializing these tables.  One part tells the hardware
where the table is located.  Another part zeroes the
contents of those tables.  (The zeroing part could be
accomplished when the table is allocated, but there
are cases where they have to be zeroed again without
needing to tell the hardware so we need to at least
be able to do that independently.)

I think I was assuming this was the function that did
the zeroing, and I thought that adding the comment about
"all we need is a zero-filled buffer" addressed what
you thought should be made clearer.

I will definitely fix this, and I'm glad you repeated
it so I was forced to take another look.

If I again misunderstand your point, please let me know.

					-Alex

> The issue I see is that you do an expensive dma_alloc_coherent()
> but then never actually use the pointer returned by it, only the
> dma address that cannot be turned back into a virtual address
> in order to access the data in it.
> 
> If you can't actually use payload->hdr_table_addr, why even allocate
> it here?
> 
>      Arnd
> 

