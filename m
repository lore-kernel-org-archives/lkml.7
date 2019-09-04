Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186E4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 01:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED78022CF8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 01:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfIDBfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 21:35:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54446 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfIDBfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 21:35:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id k2so1397551wmj.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 18:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cVriKr46na9K66+qbHPCbYZK287/xFQJ6lf/grUOyVA=;
        b=dwLJAZqD8o78uabzPeAtz+z+KWEpDK3GKkmqMj5lf0xJkxkN+LSFmYv+bDGi2Phn1d
         iSDZcWT0uHMcplEjpvnpjV0JhE5w0xeE+oVWDRBXWzlz4Z0pp1+30GtPRLFTH0EG8xTE
         84NrfXTomp3mqyrNNNa5mcTbIECLmr5y8PGw+UXOScJGycdNBbckdUZKcFr5471ggeht
         HDurK12A+IQPhr59j5WBqBkHoPcjXjTNVAntuBq0hhTs0RcSyJgGRp/Ns44CkJf/gFWV
         NKmr3jSsRKrxvb8/1hRq60c5HxVGb1QaBymjZBA+uLGH1Hdfjivwshk1P6PoQnNg/EVH
         HPAg==
X-Gm-Message-State: APjAAAXSZnu4AT+omrHA35tlFLhQf7mqSC6qvwrSb76Id12xqJKJbIjB
        zHVxsH8S+ge9gV6toVv0P7a1dcd7
X-Google-Smtp-Source: APXvYqwTkQe0iNlryf7V5FTO30+pZa6wEDT/faxpYAu9NJ3kNQiIJ+qJky3Cllw5NpmC71aE/HPARw==
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr2065048wme.35.1567560934037;
        Tue, 03 Sep 2019 18:35:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id a16sm935287wmg.5.2019.09.03.18.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 18:35:33 -0700 (PDT)
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
 <73e3d2ca-33e0-3133-9dfb-62b07e5b09c4@grimberg.me>
 <20190902193341.GA28723@kroah.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f9204955-a1b3-796a-dc4f-fd7af7946635@grimberg.me>
Date:   Tue, 3 Sep 2019 18:35:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902193341.GA28723@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Still don't understand how this is ok...
>>
>> I have /dev/nvme0 represents a network endpoint that I would discover
>> from, it is raising me an event to do a discovery operation (namely to
>> issue an ioctl to it) so my udev code calls a systemd script.
>>
>> By the time I actually get to do that, /dev/nvme0 represents now a new
>> network endpoint (where the event is no longer relevant to). I would
>> rather the discovery to explicitly fail than to give me something
>> different, so we pass some arguments that we verify in the operation.
>>
>> Its a stretch case, but it was raised by people as a potential issue.
> 
> Ok, and how do you handle this same thing for something like /dev/sda ?
> (hint, it isn't new, and is something we solved over a decade ago)
> 
> If you worry about stuff like this, use a persistant device naming
> scheme and have your device node be pointed to by a symlink.  Create
> that symlink by using the information in the initial 'ADD' uevent.
> 
> That way, when userspace opens the device node, it "knows" exactly which
> one it opens.  It sounds like you have a bunch of metadata to describe
> these uniquely, so pass that in the ADD event, not in some other crazy
> non-standard manner.

We could send these variables when adding the device and then validating
them using a rich-text-explanatory symlink. Seems slightly backwards to
me, but that would work too.

We create the char device using device_add (in nvme_init_subsystem),
I didn't find any way to append env variables to that ADD uevent.

Did you mean that we should add another flavor of device_add that
accepts char *envp_ext[]?

What exactly is the "standard manner" to pass these variables to
the chardev KOBJ_ADD uevent? All other examples I could find use
KOBJ_CHANGE to pass private stuff..
