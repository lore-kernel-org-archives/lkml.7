Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C10C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A63F20C01
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfHEUHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:07:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39624 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHEUHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 16:07:22 -0400
Received: by mail-ot1-f65.google.com with SMTP id r21so80860704otq.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 13:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I+/FLS8eqxb1UNBY39cu1xBfCi8bcMalBd0zD3RfHPI=;
        b=OeEwhYV7B4iMfndbdM82jbZ4p9BFqRGdqLc1IuvkOgXSvF9CzgFQ408HLex96+aO+Z
         J/aKOzwLjtgHfIapm3US7tnLRI/hXpnlaqwf57shrfDqV7LLlw4WvBU6LGWd5WsWjxMu
         Eucfljs8iWHey23T+BelqWllsf+F0uTFjQmz1RDQOMAXsv/yHdXhleJTyC9iqVem54vA
         mQ/laI/F/Li7naHPYhHrpmYCx4NoSFvPXrqWvACpTSGo646mREAc6ea89Y//H651+MB7
         FjWhxj6fZHxVPijxuNx7TGKqiUrzit+Lm2EOQ8IxaGOItbXF9Nj+ez1KD/IGxLZpVM+l
         E9Jg==
X-Gm-Message-State: APjAAAWHcJrsQu1Gl381cNDPUuAxsHM/JgzBECzrVV0pGyYInl/Mrpjw
        phtjIVbgnbt3JKzRiGmU37U=
X-Google-Smtp-Source: APXvYqwsmaCa+TUefSLRaH3hqrkW4xgRLkwTOxsVlDP7lmha0tM7uItflkWu4DF0H3l34X//9d2PtQ==
X-Received: by 2002:a9d:5a82:: with SMTP id w2mr110989797oth.240.1565035641798;
        Mon, 05 Aug 2019 13:07:21 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id k10sm28318977otn.58.2019.08.05.13.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 13:07:21 -0700 (PDT)
Subject: Re: [PATCH v3] nvme-pci: Support shared tags across queues for Apple
 2018 controllers
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Pawlowski <paul@mrarm.io>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
 <20190730153044.GA13948@localhost.localdomain>
 <2030a028664a9af9e96fffca3ab352faf1f739e5.camel@kernel.crashing.org>
 <6290507e1b2830b1729fc858cd5c20b85d092728.camel@kernel.crashing.org>
 <20190805134907.GC18647@localhost.localdomain>
 <40a6acc2-beae-3e36-ca20-af5801038a1e@grimberg.me>
 <caa04d02-05a0-dd1f-2072-df41a21f2aa8@fb.com>
 <f34af208-2707-f326-0451-354a8b482586@grimberg.me>
Message-ID: <de65f6f8-afb5-ce54-eb8a-b04b2e59628b@grimberg.me>
Date:   Mon, 5 Aug 2019 13:07:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f34af208-2707-f326-0451-354a8b482586@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> Ping ? I had another look today and I don't feel like mucking around
>>>>> with all the AQ size logic, AEN magic tag etc... just for that sake of
>>>>> that Apple gunk. I'm happy to have it give up IO tags, it doesn't seem
>>>>> to make much of a difference in practice anyway.
>>>>>
>>>>> But if you feel strongly about it, then I'll implement the "proper" 
>>>>> way
>>>>> sometimes this week, adding a way to shrink the AQ down to something
>>>>> like 3 (one admin request, one async event (AEN), and the empty slot)
>>>>> by making a bunch of the constants involved variables instead.
>>>>
>>>> I don't feel too strongly about it. I think your patch is fine, so
>>>>
>>>> Acked-by: Keith Busch <keith.busch@intel.com>
>>>
>>> Should we pick this up for 5.3-rc?
>>
>> No, it's not a regression fix. Queue it up for 5.4 instead.
> 
> OK, will queue it up for nvme-5.4

Doesn't apply..

Ben, can you please respin a patch that applies on nvme-5.4?

http://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-5.4
