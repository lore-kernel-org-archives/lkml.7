Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CFEC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142AE20578
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXtxs0pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfEOM0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:26:02 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36053 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfEOM0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:26:01 -0400
Received: by mail-io1-f65.google.com with SMTP id e19so2054155iob.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qz4qrTn7Cf+BiC5DJ1WzPKLMl95+joBwJ0jpAKu4zeg=;
        b=JXtxs0pez9nJTssmqWmCtJVH40WAR8vvXsZ0QZG5WQCdPp+Z6G0oM0DxrVY6TYVePH
         abdxBRt+gmTdpKUx5FAUDZovwwOIVx9twjBzeIbQaYAMroZfkPDDM2CxKKKip+HnSJRO
         uyEWMIX0JpRValyRO76cxnYcTj1eXPmv2t5C2wf/9UMZYHb93vMeDfBXkZtWp9ZCpPON
         6XtEtt7AnzlF46GPyPPdC/8zSWX6p4v2c2EtOGSr6kwUB5cj/nLyjEMp4aviODq8LLSn
         ODZp1NGbwG3PB6g4XjdUgWZBLUr1CfV3c8HsNYZ2x9jv2JT8oTnVHIwF9Ray4wMlHgnp
         w2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qz4qrTn7Cf+BiC5DJ1WzPKLMl95+joBwJ0jpAKu4zeg=;
        b=mxcH4N1mkXiWd4Rg74uHJAxS/rnOpg0CbV20hgGYIY7xirIZqMu2asAMhszvsa1Ad5
         wxMkcN+DAf5qhgyrVdFfNlxBdiXBpIms4cf7DnVr4+SVshxrbAo5SGQ+KUhLLdu+O7uB
         Twy3buu7EL8ZjATeXi0+UjDyR1Dmv9TGSd72b/7UeAp/P+uiKc7f1QWhAudMH8pVEfL9
         k3pD13qK4dXjvAZMMdPataWW63ByApTXd8FNGCyNl52wEj13H29n7TbTN7EQLUvlcyDP
         IKC1KRW8CNV8EkE9TGqP9XVS63CkkFI8ZN13/evFmscJHPLmbkqhpRZ6TRy8mMf6i5NN
         +YLg==
X-Gm-Message-State: APjAAAXFZi5KzkMbd2h68qhil6edrXjbSP+w+i8M7JEpSMud59LqssBp
        g/Rdtzd22AP/SMFxWMTxm4lag8C09zU=
X-Google-Smtp-Source: APXvYqzQtg3eT16dvumK8CSYm5CzS2Y7oGPIhxOEgoQIjBBdbyCF0oc1Gj79NxyulgR/GMY8wCVE5w==
X-Received: by 2002:a6b:8f51:: with SMTP id r78mr24596455iod.110.1557923160465;
        Wed, 15 May 2019 05:26:00 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id n138sm42265itb.32.2019.05.15.05.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 05:25:59 -0700 (PDT)
Subject: Re: [PATCH 09/18] soc: qcom: ipa: GSI transactions
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-10-elder@linaro.org>
 <CAK8P3a0eYWN6mMwft5OSu8wQQo=kWh5safGFFNkDCELZJyiMmQ@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <58b03138-d99f-b22f-5f8a-969612163135@linaro.org>
Date:   Wed, 15 May 2019 07:25:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0eYWN6mMwft5OSu8wQQo=kWh5safGFFNkDCELZJyiMmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 2:34 AM, Arnd Bergmann wrote:
>> +static void gsi_trans_tre_fill(struct gsi_tre *dest_tre, dma_addr_t addr,
>> +                              u32 len, bool last_tre, bool bei,
>> +                              enum ipa_cmd_opcode opcode)
>> +{
>> +       struct gsi_tre tre;
>> +
>> +       tre.addr = cpu_to_le64(addr);
>> +       tre.len_opcode = gsi_tre_len_opcode(opcode, len);
>> +       tre.reserved = 0;
>> +       tre.flags = gsi_tre_flags(last_tre, bei, opcode);
>> +
>> +       *dest_tre = tre;        /* Write TRE as a single (16-byte) unit */
>> +}
> 
> Have you checked that the atomic write is actually what happens here,
> but looking at the compiler output? You might need to add a 'volatile'
> qualifier to the dest_tre argument so the temporary structure doesn't
> get optimized away here.

No, and I really should have checked, since I'm assuming that's
what will happen.  I will check, and may well add the volatile
regardless.

>> +/* Cancel a channel's pending transactions */
>> +void gsi_channel_trans_cancel_pending(struct gsi_channel *channel)
>> +{
>> +       struct gsi_trans_info *trans_info = &channel->trans_info;
>> +       u32 evt_ring_id = channel->evt_ring_id;
>> +       struct gsi *gsi = channel->gsi;
>> +       struct gsi_evt_ring *evt_ring;
>> +       struct gsi_trans *trans;
>> +       unsigned long flags;
>> +
>> +       evt_ring = &gsi->evt_ring[evt_ring_id];
>> +
>> +       spin_lock_irqsave(&evt_ring->ring.spinlock, flags);
>> +
>> +       list_for_each_entry(trans, &trans_info->pending, links)
>> +               trans->result = -ECANCELED;
>> +
>> +       list_splice_tail_init(&trans_info->pending, &trans_info->complete);
>> +
>> +       spin_unlock_irqrestore(&evt_ring->ring.spinlock, flags);
>> +
>> +       spin_lock_irqsave(&gsi->spinlock, flags);
>> +
>> +       if (gsi->event_enable_bitmap & BIT(evt_ring_id))
>> +               gsi_event_handle(gsi, evt_ring_id);
>> +
>> +       spin_unlock_irqrestore(&gsi->spinlock, flags);
>> +}
> 
> That is a lot of irqsave()/irqrestore() operations. Do you actually call
> all of these functions from hardirq context?

The transaction list is definitely updated in IRQ context,
but I think it is no longer updated in hardirq context (the
softirq was a recent change).  This particular function is
definitely not called in a hardirq context, so I can remove
the irqsave/irqrestore.

I'll survey my spinlock use throughout the driver and will
remove any irqsave/irqrestore used in non-hardirq contexts.

Thanks.

					-Alex


>       Arnd
> 

