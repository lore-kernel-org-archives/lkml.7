Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DD6C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FD723430
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ikb0+wyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfH3Sg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:36:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39981 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfH3Sg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:36:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so3946987pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zFvchfg+nfsCoDewMw9H5TfKo6aLBXeRTQaXaNc+Pts=;
        b=Ikb0+wyUjuqA7LjN6wXC6fetcE3CYhjhVggxBoUqWIpS3f08zNmc+cwRrqE75xzKUg
         So2TGRiXjGmmNCCWM5iJKYZx51m0qm8+s6IUPUnrY8F33/4rjK144u8SHUjzsgDkiNBI
         D7CNJAba/FabcETkoXXQZ6Tum/wUwrvC8CWe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zFvchfg+nfsCoDewMw9H5TfKo6aLBXeRTQaXaNc+Pts=;
        b=VuvcDqDZIMD1PbXqZWUB81XR1v+oqHFYIquVBzMmkS1P2nHLREUyIekFcPBc5AM8ej
         19B942Qf9fsSL7NY+G4GDM29wMm5ON+TjL1PG8ub1qNgmZhLI53E05feECBuef6CeSH9
         BA8TFffB+6YZigOQgz5tA7AADOJUqbadUYeRebffPui6ipBipGSs/mj9MKc4TDlk2Dlw
         /20DGwzyf8DR1nqls/XiZnbccAsudacn827bXcFWXsSmUVVVVYWoibv3k0BhYA8dz5XA
         aW93E1uo4V0woLZS8OLxNT1ek/y+4VCg4Ufy0rkGqJIoux4AEfSJGIIZJvsgkD5iHWXg
         6V7g==
X-Gm-Message-State: APjAAAXWRYhSzoprnjhWtGW3rqhOPJzy7/dcvPf+iq9iY8PlfpoaAuhA
        B1vJZoqR+1tKwnlboYV52tDbxA==
X-Google-Smtp-Source: APXvYqz7wDu3v2tbCoIivOmmuJtFFKphufCRZ2DZv86SqQDUSFVc6anUX0NIHVQafi2EOjbtvdkhtA==
X-Received: by 2002:aa7:8a98:: with SMTP id a24mr16690672pfc.101.1567190187123;
        Fri, 30 Aug 2019 11:36:27 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l7sm6635079pff.35.2019.08.30.11.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 11:36:26 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
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
From:   James Smart <james.smart@broadcom.com>
Message-ID: <3c58613f-9380-6887-434a-0db31136e7aa@broadcom.com>
Date:   Fri, 30 Aug 2019 11:36:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4555a281-3cbc-0890-ce85-385c06ca912b@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/2019 11:08 AM, Sagi Grimberg wrote:
>
>>>> Yes we do, userspace should use it to order events.  Does udev not
>>>> handle that properly today?
>>>
>>> The problem is not ordering of events, its really about the fact that
>>> the chardev can be removed and reallocated for a different controller
>>> (could be a completely different discovery controller) by the time
>>> that userspace handles the event.
>>
>> The same is generally true for lot of kernel devices.  We could reduce
>> the chance by using the idr cyclic allocator.
>
> Well, it was raised by Hannes and James, so I'll ask them respond here
> because I don't mind having it this way. I personally think that this
> is a better approach than having a cyclic idr allocator. In general, I
> don't necessarily think that this is a good idea to have cyclic
> controller enumerations if we don't absolutely have to...

We hit it right and left without the cyclic allocator, but that won't 
necessarily remove it.

Perhaps we should have had a unique token assigned to the controller, 
and have the event pass the name and the token.  The cli would then, if 
the token is present, validate it via an ioctl before proceeding with 
other ioctls.

Where all the connection arguments were added we due to the reuse issue 
and then solving the question of how to verify and/or lookup the desired 
controller, by using the shotgun approach rather than being very 
pointed, which is what the name/token would do.

-- james

