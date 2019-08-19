Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F9CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C5622CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfHSVRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:17:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38114 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHSVRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:17:47 -0400
Received: by mail-ot1-f68.google.com with SMTP id r20so3048649ota.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iaf9uTw5RRpqXWMcFy0w3sEb9pCbcDKI4jRiTBEYduE=;
        b=XuXnXpn6OCKSKULN43QSZMedHC+z26oThr/B4AdGTxz3Gs1gMyiuaphgRh0q55WJdR
         byah2/2anbUx3D8R7dwXU93ng0ZH1IQoPINTCf4Cpp1og+Z+hR1nZgfc34WW75UvlQ3r
         W8jhEL0ksz8vZmTGyRW6uFuZIQnhvAxhZvSqyOrn113jdHYobjOMtDbm8JpRoHXJ5QwU
         pnlqEltNvx8o/3vkWzqTP6P8iBxUkgcSAZwuxp05/TE/Yb1gbujsy8ShBpbdkgqZJAUk
         WQ+K6vl7HcYBz+bAiK8bvqTzm0YuVpm50IG/dZTooEarUvW0GyoyLWeRq+/m4+oVcvyb
         T66w==
X-Gm-Message-State: APjAAAWGsJOkPEunD/qthIo9yWLRTgVrw42g2u2pFPhFTL65ZX7pds1n
        UbSIUj/ayaJkLCsuZGT+RKk=
X-Google-Smtp-Source: APXvYqzVklZHzjmbCvcyjX8kF8qoGJddjflSMpPgKnPeOL6Rzo0XqqEYgmht/PsFTogegcWZRjgaqg==
X-Received: by 2002:a9d:5d18:: with SMTP id b24mr20248731oti.264.1566249466955;
        Mon, 19 Aug 2019 14:17:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 20sm5979925otd.71.2019.08.19.14.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 14:17:46 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: allow 64-bit results in passthru commands
To:     Keith Busch <kbusch@kernel.org>
Cc:     Marta Rybczynska <mrybczyn@kalray.eu>,
        Christoph Hellwig <hch@lst.de>, axboe <axboe@fb.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Samuel Jones <sjones@kalray.eu>,
        Guillaume Missonnier <gmissonnier@kalray.eu>
References: <89520652.56920183.1565948841909.JavaMail.zimbra@kalray.eu>
 <20190816131606.GA26191@lst.de>
 <469829119.56970464.1566198383932.JavaMail.zimbra@kalray.eu>
 <20190819144922.GC6883@localhost.localdomain>
 <1d7819a9-9504-2dc6-fca4-fbde4f99d92c@grimberg.me>
 <20190819185749.GA11202@localhost.localdomain>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e639f7ce-5f1a-d4a5-f80e-9bf3bc1ff638@grimberg.me>
Date:   Mon, 19 Aug 2019 14:17:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819185749.GA11202@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> ----- On 16 Aug, 2019, at 15:16, Christoph Hellwig hch@lst.de wrote:
>>>>> Sorry for not replying to the earlier version, and thanks for doing
>>>>> this work.
>>>>>
>>>>> I wonder if instead of using our own structure we'd just use
>>>>> a full nvme SQE for the input and CQE for that output.  Even if we
>>>>> reserve a few fields that means we are ready for any newly used
>>>>> field (at least until the SQE/CQE sizes are expanded..).
>>>>
>>>> We could do that, nvme_command and nvme_completion are already UAPI.
>>>> On the other hand that would mean not filling out certain fields like
>>>> command_id. Can do an approach like this.
>>>
>>> Well, we need to pass user space addresses and lengths, which isn't
>>> captured in struct nvme_command.
>>
>> Isn't simply having a 64 variant simpler?
> 
> Could you provide more details on what you mean by this?

Why would we need to pass addresses and lengths if userspace is
sending the 64 variant when it is expecting a 64 result?

Or maybe I'm missing something...
