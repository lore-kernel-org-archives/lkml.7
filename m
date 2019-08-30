Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41274C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC3823439
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfH3VHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:07:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46518 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfH3VHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:07:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id h7so6911467wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 14:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w4hvEqHJLEa1mvGULDNj9eO45SqJ3qnxmWk/VetQNSk=;
        b=nJ3dUc18kw/5S+lDtVVnK10jMBCLxIzgSJubSsEGYDz4aqBTqtiMdEIrPs2q5Rio4r
         HnQltW+apF8oNAqQeYHSdS/0Qs9HztFn488Bhp3smaqbpJBNTAA24jsDf/LsYh5OQVtr
         YtMkecba+aK1I2S2jyslg+nqIuSS0z4P2FIH0aw363tu1F9eqA6iKqVm2hdgki0Rd02i
         BFD/ZjieKyraTZwpsgZ/mlWQb/KFymwr7UDo3sAW8lMjRRNpLI7FDhfldSIlX1uTidLk
         lqtu7ko3+M9IzPPuywI3sY9uhYgPrgBn6t+1IXMUF4TcXnR4i9Mw8ZfrTsZIQcRRVa7e
         Eepw==
X-Gm-Message-State: APjAAAVLEOW0XC/MhoiK+zvzwZhGsr9GxY4jT/eyC9oE0X3OvFzaVDms
        YceQOapwtFnfZx9ICGXADDk=
X-Google-Smtp-Source: APXvYqxGL0ccEg29MqqNIg64URvCvazEH9a2xSZY2QlxYdBD+ARFTN8+N38kSUXxGRclw/YqOh6g/w==
X-Received: by 2002:adf:dc43:: with SMTP id m3mr5271653wrj.118.1567199229860;
        Fri, 30 Aug 2019 14:07:09 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id w13sm16030538wre.44.2019.08.30.14.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 14:07:09 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
To:     James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me> <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de> <20190826075916.GA30396@kroah.com>
 <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
 <20190830055514.GC8492@lst.de>
 <4555a281-3cbc-0890-ce85-385c06ca912b@grimberg.me>
 <3c58613f-9380-6887-434a-0db31136e7aa@broadcom.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c50cbc24-328f-35b7-5c74-c66a9bd76128@grimberg.me>
Date:   Fri, 30 Aug 2019 14:07:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3c58613f-9380-6887-434a-0db31136e7aa@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> Yes we do, userspace should use it to order events.  Does udev not
>>>>> handle that properly today?
>>>>
>>>> The problem is not ordering of events, its really about the fact that
>>>> the chardev can be removed and reallocated for a different controller
>>>> (could be a completely different discovery controller) by the time
>>>> that userspace handles the event.
>>>
>>> The same is generally true for lot of kernel devices.  We could reduce
>>> the chance by using the idr cyclic allocator.
>>
>> Well, it was raised by Hannes and James, so I'll ask them respond here
>> because I don't mind having it this way. I personally think that this
>> is a better approach than having a cyclic idr allocator. In general, I
>> don't necessarily think that this is a good idea to have cyclic
>> controller enumerations if we don't absolutely have to...
> 
> We hit it right and left without the cyclic allocator, but that won't 
> necessarily remove it.
> 
> Perhaps we should have had a unique token assigned to the controller, 
> and have the event pass the name and the token.  The cli would then, if 
> the token is present, validate it via an ioctl before proceeding with 
> other ioctls.
> 
> Where all the connection arguments were added we due to the reuse issue 
> and then solving the question of how to verify and/or lookup the desired 
> controller, by using the shotgun approach rather than being very 
> pointed, which is what the name/token would do.

This unique token is: trtype:traddr:trsvcid:host-traddr ...
