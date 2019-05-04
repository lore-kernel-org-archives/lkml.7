Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9222C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 09:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0FB206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 09:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrcU8u/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfEDJkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 05:40:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44867 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfEDJks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 05:40:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so4142128pfm.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 02:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2uilnzXCeksaulpRoxwMEHkC2mONo60sbbSMcDlkRbc=;
        b=KrcU8u/R5+edhHZWus3oEGQr3U5HmMRiF+s0XaCQpKTUzOudUZm+8fmwzxq/vtKe5j
         r1CJ+ky61UdMucl1a3CFb4+ZPll6DckwmfwAdYLIzXsVU/CtptLQOVYv1jIhF59wnMKo
         Xc0pslluFApTkiGG73MyaCiLGKWg8yVquKr28Y6SO0l8Uptjm88JjuLDvMsVgWXkwp1b
         9OiseK0S8TV5Kz1uZ9K6+6lqFOXJPAwoF75ESWwEn0xOZbPh+1SvybAi82v0UHyhkINu
         9gstlfhFcl0La6rq0euIUPFJOzSZMKenThg+wLFhfSAPtu0ix7CuYVhx2ynUginCyffn
         1afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2uilnzXCeksaulpRoxwMEHkC2mONo60sbbSMcDlkRbc=;
        b=ieFQp72OudO0VzVQIn0EgOUij4qn0GpJ/Ywa0gLmvl9AnNJgWukeJ6hVuVbSRM7Dqy
         nI72E9NFuowJMYD+4lvTjpnR9kghRuYj102pWGDa/IjXTXyS1jmmMznLaOUYK+nYOayg
         XzeUkATcvOs7dcyRcO1WHp4LAtZFOG1qZFQ7i96+9HLhCQ9w1sq2BAqAwyx7U8RXAPvF
         RVoKpnq7/Kfdl078XNJQ/cZxWkPzWXOn5ZM8NiAo4fTcGXn9gKK0i0DbK+v9prZme7+o
         Yep7dy7BfADQjTXxD11mXAz14K9yi9oRxcWSEl2Q8SgoP9LhsWHs+TUbf03u6PQQYe/O
         RAeQ==
X-Gm-Message-State: APjAAAUXkz8Wb5pgGtaJMn24ZI0WyxPo8s/BDHg/B9xnW3ira78x1nIX
        xBzZv8fLCitMPG2VVwhZO6ld7Z9VYpc=
X-Google-Smtp-Source: APXvYqyhNm3CXqv6xUdan58fg5cb7I4EmRxComV5otSP3kACJln0cPgj0XKfJGk+ZqNmoXBB/P3LPw==
X-Received: by 2002:a63:6604:: with SMTP id a4mr17595254pgc.104.1556962847986;
        Sat, 04 May 2019 02:40:47 -0700 (PDT)
Received: from [192.168.0.6] ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id a6sm5909626pfn.181.2019.05.04.02.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 02:40:46 -0700 (PDT)
Subject: Re: [PATCH 0/4] nvme-pci: support device coredump
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
 <20190502125722.GA28470@localhost.localdomain>
 <CAC5umygdADGrYeJy=F53Mm4bNPHmo+WY4SD3HFSRqi_cLrz9jw@mail.gmail.com>
 <20190503121232.GB30013@localhost.localdomain>
 <20190503122035.GA21501@lst.de>
 <CAC5umyiGbDNCtzhJioR_2EV6-6xMuZXOMThCizwJEMHi+KqxAw@mail.gmail.com>
From:   Minwoo Im <minwoo.im.dev@gmail.com>
Message-ID: <61bf6f0b-4087-cfb3-1ae6-539f18b5b6ea@gmail.com>
Date:   Sat, 4 May 2019 18:40:42 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAC5umyiGbDNCtzhJioR_2EV6-6xMuZXOMThCizwJEMHi+KqxAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akinobu,

On 5/4/19 1:20 PM, Akinobu Mita wrote:
> 2019年5月3日(金) 21:20 Christoph Hellwig <hch@lst.de>:
>>
>> On Fri, May 03, 2019 at 06:12:32AM -0600, Keith Busch wrote:
>>> Could you actually explain how the rest is useful? I personally have
>>> never encountered an issue where knowing these values would have helped:
>>> every device timeout always needed device specific internal firmware
>>> logs in my experience.
> 
> I agree that the device specific internal logs like telemetry are the most
> useful.  The memory dump of command queues and completion queues is not
> that powerful but helps to know what commands have been submitted before
> the controller goes wrong (IOW, it's sometimes not enough to know
> which commands are actually failed), and it can be parsed without vendor
> specific knowledge.

I'm not pretty sure I can say that memory dump of queues are useless at all.

As you mentioned, sometimes it's not enough to know which command has
actually been failed because we might want to know what happened before and
after the actual failure.

But, the information of commands handled from device inside would be much
more useful to figure out what happened because in case of multiple queues,
the arbitration among them could not be represented by this memory dump.

> 
> If the issue is reproducible, the nvme trace is the most powerful for this
> kind of information.  The memory dump of the queues is not that powerful,
> but it can always be enabled by default.

If the memory dump is a key to reproduce some issues, then it will be 
powerful
to hand it to a vendor to solve it.  But I'm afraid of it because the 
dump might
not be able to give relative submitted times among the commands in queues.

> 
>> Yes.  Also not that NVMe now has the 'device initiated telemetry'
>> feauture, which is just a wired name for device coredump.  Wiring that
>> up so that we can easily provide that data to the device vendor would
>> actually be pretty useful.
> 
> This version of nvme coredump captures controller registers and each queue.
> So before resetting controller is a suitable time to capture these.
> If we'll capture other log pages in this mechanism, the coredump procedure
> will be splitted into two phases (before resetting controller and after
> resetting as soon as admin queue is available).

I agree with that it would be nice if we have a information that might not
be that powerful rather than nothing.

But, could we request controller-initiated telemetry log page if 
supported by
the controller to get the internal information at the point of failure 
like reset?
If the dump is generated with the telemetry log page, I think it would 
be great
to be a clue to solve the issue.

Thanks,
