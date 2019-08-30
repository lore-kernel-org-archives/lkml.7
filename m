Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3D7C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298662087F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfH3SIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:08:23 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37361 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbfH3SIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:08:22 -0400
Received: by mail-oi1-f194.google.com with SMTP id b25so6027241oib.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 11:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8WcqhFY+HXLsWaR9k6uq7mqcDR/FvX17iR08vwKJNkg=;
        b=G5ymsekN8/igprKfwHjY4aMNtia01sF+JrCxeSnGqil0QqA1ecjfPPIKTnh4hr1SWS
         zI26CcfNny8bi1gPZwJs7fx2SHvBFh6l63tldKQeikJMmw2smN86bOZ1uPe5Rh/gT9bW
         UeqmZfeJSh0ITrgt79sY9Acp13oTlG+hmb+M0PPRIXxixtbBEW5UxOpjVqFfTOgzJcj6
         YDcDAhDHltL9UDQTYwKjzaCJxYVUsI9qMeaXkVKMwxjxfP3ERxtpidCGKF5mIVuy1sve
         0/On8CW6ksdMV/e/JZJ+qfDXT2d0yXLkr9Pcdf2ZeUFqmJ2xaB2XSP1FhBMAOpMrbxWm
         Q3Cw==
X-Gm-Message-State: APjAAAVlNsUM69WwcfaGQj3RDCAQI1325hEwV2aoXyj6AoxOj/QxmDtM
        zCkM4BE53DnTXH2tHDvXApE=
X-Google-Smtp-Source: APXvYqy/r+B34kWyM1uoSMAGuaDOErtirv5P6iSD1QVBLVfIYjMhC3Jv/g6vrbd1ORP6cWObumfZAQ==
X-Received: by 2002:aca:75c2:: with SMTP id q185mr10615384oic.134.1567188501705;
        Fri, 30 Aug 2019 11:08:21 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 59sm2340442otq.9.2019.08.30.11.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 11:08:20 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        James Smart <james.smart@broadcom.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me> <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de> <20190826075916.GA30396@kroah.com>
 <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
 <20190830055514.GC8492@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4555a281-3cbc-0890-ce85-385c06ca912b@grimberg.me>
Date:   Fri, 30 Aug 2019 11:08:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830055514.GC8492@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Yes we do, userspace should use it to order events.  Does udev not
>>> handle that properly today?
>>
>> The problem is not ordering of events, its really about the fact that
>> the chardev can be removed and reallocated for a different controller
>> (could be a completely different discovery controller) by the time
>> that userspace handles the event.
> 
> The same is generally true for lot of kernel devices.  We could reduce
> the chance by using the idr cyclic allocator.

Well, it was raised by Hannes and James, so I'll ask them respond here
because I don't mind having it this way. I personally think that this
is a better approach than having a cyclic idr allocator. In general, I
don't necessarily think that this is a good idea to have cyclic
controller enumerations if we don't absolutely have to...
