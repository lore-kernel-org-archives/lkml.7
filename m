Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB5DC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C142342E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfH3SOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:14:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35871 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbfH3SOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:14:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id k18so7810817otr.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 11:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tcZ7CbFDJuL2UIE4e1E/mRyvfTkPs0zewzMOwmkGiT4=;
        b=ZOSDP37aDPF+p49nr/Gv1hu2TLa45LVS6+t7kN6/bo2+7Ys5ky7k9aAjsvWQyWcuA0
         2j2iFXMxuvNFIY0+83dVBRiCn4rbZxpYzItwwoBWX8bUVeuIeZ5oJnGT6ZC+hRK1swoN
         IrYkb+/ox9lvt55kUIsOLBAIAMKX1kerrjfPW4H+wh9c0yTARh7N6BdeFaeEvTVW2h5f
         bSFyRZHiUy0dH5kGtqw0rIXJkpOEzYG0+O/Hi15cD2moR3oZIOICYzHmwIyWyo1a7Jg0
         1wuaKNKCo2hn5i1P3TPpJzb2utnc2C/oM4pEGySOoJOS8N70ZBa/l39uARj5TINgbdbh
         z9WQ==
X-Gm-Message-State: APjAAAWSwrxnJB2v27WtvYOgEMGVgB+LyW8PCpEsjqYPSJqelWzuwwaP
        v5bzgoVLai59KHtb9aNLIjPzml19
X-Google-Smtp-Source: APXvYqzJrSypv8jdgqcjkdqz7JMqUKmism7bakP3K5KtbmwuRNzlmboECazuu8tNvKzgIcHkH/dRvw==
X-Received: by 2002:a05:6830:130e:: with SMTP id p14mr13486506otq.339.1567188881552;
        Fri, 30 Aug 2019 11:14:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 34sm1469032ots.47.2019.08.30.11.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 11:14:40 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        James Smart <james.smart@broadcom.com>,
        linux-kernel@vger.kernel.org
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me> <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de> <20190826075916.GA30396@kroah.com>
 <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
 <20190830062036.GA15257@kroah.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <73e3d2ca-33e0-3133-9dfb-62b07e5b09c4@grimberg.me>
Date:   Fri, 30 Aug 2019 11:14:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830062036.GA15257@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>>> You are correct that this information can be derived from sysfs, but the
>>>>>> main reason why we add these here, is because in udev rule we can't
>>>>>> just go ahead and start looking these up and parsing these..
>>>>>>
>>>>>> We could send the discovery aen with NVME_CTRL_NAME and have
>>>>>> then have systemd run something like:
>>>>>>
>>>>>> nvme connect-all -d nvme0 --sysfs
>>>>>>
>>>>>> and have nvme-cli retrieve all this stuff from sysfs?
>>>>>
>>>>> Actually that may be a problem.
>>>>>
>>>>> There could be a hypothetical case where after the event was fired
>>>>> and before it was handled, the discovery controller went away and
>>>>> came back again with a different controller instance, and the old
>>>>> instance is now a different discovery controller.
>>>>>
>>>>> This is why we need this information in the event. And we verify this
>>>>> information in sysfs in nvme-cli.
>>>>
>>>> Well, that must be a usual issue with uevents, right?  Don't we usually
>>>> have a increasing serial number for that or something?
>>>
>>> Yes we do, userspace should use it to order events.  Does udev not
>>> handle that properly today?
>>
>> The problem is not ordering of events, its really about the fact that
>> the chardev can be removed and reallocated for a different controller
>> (could be a completely different discovery controller) by the time
>> that userspace handles the event.
> 
> So?  You will have gotten the remove and then new addition uevent in
> order showing you this.  So your userspace code knows that something
> went away and then came back properly so you should be kept in sync.

Still don't understand how this is ok...

I have /dev/nvme0 represents a network endpoint that I would discover
from, it is raising me an event to do a discovery operation (namely to
issue an ioctl to it) so my udev code calls a systemd script.

By the time I actually get to do that, /dev/nvme0 represents now a new
network endpoint (where the event is no longer relevant to). I would
rather the discovery to explicitly fail than to give me something
different, so we pass some arguments that we verify in the operation.

Its a stretch case, but it was raised by people as a potential issue.
