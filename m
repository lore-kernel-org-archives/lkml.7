Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F702C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECD720B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbfHES2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:28:01 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34993 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbfHES2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:28:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id a127so62706265oii.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 11:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t+Q6uig8GQl75GX9gOvHtdvhxcvWmzLY8qotUHhpLFw=;
        b=UZ9/O47l1k9em7MrPC2wq28LI5ZnzgVGqE9EpK167MBj4yFk5aV6JBsgYxsadFXJU2
         zF6ZqSUv4iANEOgfB8gf4RYgrrAjMdhm5Ic7y3oh3TWVdLWd0SOlWanGhxqTfvydR+82
         KJIAO2l433zpA+OpXhvvODI8o6l+cVf5mD14Q4KIaL3MroBt5sUvZ130lw0gGxqZaJ+k
         gZ7sp0fldlypT5F70LVCs88Ys/PnEL6BdzP5pUfFwnsBi7hxeiSGHU+LXXfjmKp999kb
         jcJpF9BtgeeSh843+qJ94FcsL7OY8TuYGOZG7IwRYgiPn+Zd9suwYvBCoSbM688lLZE0
         rwvQ==
X-Gm-Message-State: APjAAAVXZY391ocx8enbm2J7NK0FxC9nEIHgPH645ECoJyxsBLwmUFwO
        hIkY13wO0uAkDBrv5OAAoYo=
X-Google-Smtp-Source: APXvYqy0AdIg1TbX+5qncwETkk+MlyCN79PvaUMyylIycvK6nvJq5NrNBH/UB19pIZTaGbP5Nhxgag==
X-Received: by 2002:aca:abd8:: with SMTP id u207mr11765780oie.136.1565029679508;
        Mon, 05 Aug 2019 11:27:59 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id 17sm14133875oip.26.2019.08.05.11.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 11:27:58 -0700 (PDT)
Subject: Re: [PATCH v3] nvme-pci: Support shared tags across queues for Apple
 2018 controllers
To:     Keith Busch <keith.busch@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-kernel@vger.kernel.org, Paul Pawlowski <paul@mrarm.io>,
        Jens Axboe <axboe@fb.com>, Minwoo Im <minwoo.im.dev@gmail.com>,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
 <20190730153044.GA13948@localhost.localdomain>
 <2030a028664a9af9e96fffca3ab352faf1f739e5.camel@kernel.crashing.org>
 <6290507e1b2830b1729fc858cd5c20b85d092728.camel@kernel.crashing.org>
 <20190805134907.GC18647@localhost.localdomain>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <40a6acc2-beae-3e36-ca20-af5801038a1e@grimberg.me>
Date:   Mon, 5 Aug 2019 11:27:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805134907.GC18647@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Ping ? I had another look today and I don't feel like mucking around
>> with all the AQ size logic, AEN magic tag etc... just for that sake of
>> that Apple gunk. I'm happy to have it give up IO tags, it doesn't seem
>> to make much of a difference in practice anyway.
>>
>> But if you feel strongly about it, then I'll implement the "proper" way
>> sometimes this week, adding a way to shrink the AQ down to something
>> like 3 (one admin request, one async event (AEN), and the empty slot)
>> by making a bunch of the constants involved variables instead.
> 
> I don't feel too strongly about it. I think your patch is fine, so
> 
> Acked-by: Keith Busch <keith.busch@intel.com>

Should we pick this up for 5.3-rc?
