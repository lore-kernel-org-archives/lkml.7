Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4614DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FCE2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbfHET4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:56:41 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42629 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfHET4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:56:41 -0400
Received: by mail-oi1-f195.google.com with SMTP id s184so63097321oie.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 12:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Phj5qHRlX7O4d97X44pT5RUSua7c85Z/2K1/c6MyGLs=;
        b=AmuZmkTo2pcly006JQobelFrxF4z+W5B8B6btZFfDbprYsxGnEB4SJ8iAUeGBZkI2b
         8cTsTrs26JCBa0ZMU1oIbbZtD5uWlxV81QCmFBT9Rt9LM2hboWcWATghTg7w2rH1wjE3
         CnZGkXiBQAR5mDX6LyJSB+e9O9rIB7ziMRtvK8eEzaICDb1hRYtg/p2avtG4Eo8BRTxE
         BQ0/DkjKg0wxFLOIyqgerHPj4WYQLAugM+O5K0geSh04MzgBNOr55B14L5r94JnKRBI6
         LfY5ZPtbb6fEsiwFtXZVzkZijoTdejaCDKSclO2AgRwQkhlodVHmiTuyUV8hw5Z4y9Wa
         ZTCA==
X-Gm-Message-State: APjAAAV627gUkTcgiXEUzEsAnM/ZNPVsd/XaOzTWpPXzDP/hs1KNZ0l7
        FY7lMj2QR+KVbaRPm9BvOOk=
X-Google-Smtp-Source: APXvYqzDp96cSr1/DDb8K9q4A5Lcr/JEeiAgxYZwnLD9r4Gt8BvO2/KuswrGm6z9BmDULQBxa13zdw==
X-Received: by 2002:aca:5744:: with SMTP id l65mr42751oib.159.1565035000407;
        Mon, 05 Aug 2019 12:56:40 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id b188sm29160832oia.57.2019.08.05.12.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 12:56:39 -0700 (PDT)
Subject: Re: [PATCH v3] nvme-pci: Support shared tags across queues for Apple
 2018 controllers
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f34af208-2707-f326-0451-354a8b482586@grimberg.me>
Date:   Mon, 5 Aug 2019 12:56:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <caa04d02-05a0-dd1f-2072-df41a21f2aa8@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> Ping ? I had another look today and I don't feel like mucking around
>>>> with all the AQ size logic, AEN magic tag etc... just for that sake of
>>>> that Apple gunk. I'm happy to have it give up IO tags, it doesn't seem
>>>> to make much of a difference in practice anyway.
>>>>
>>>> But if you feel strongly about it, then I'll implement the "proper" way
>>>> sometimes this week, adding a way to shrink the AQ down to something
>>>> like 3 (one admin request, one async event (AEN), and the empty slot)
>>>> by making a bunch of the constants involved variables instead.
>>>
>>> I don't feel too strongly about it. I think your patch is fine, so
>>>
>>> Acked-by: Keith Busch <keith.busch@intel.com>
>>
>> Should we pick this up for 5.3-rc?
> 
> No, it's not a regression fix. Queue it up for 5.4 instead.

OK, will queue it up for nvme-5.4
