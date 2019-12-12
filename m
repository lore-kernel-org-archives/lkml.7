Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A409EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734AB21556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nAuBzaZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbfLLUIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:08:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42714 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730751AbfLLUII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:08:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so1419704pfz.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 12:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aJrWupuoqlaE+s8IR7dca1FQsV4mMbu8eS/d2O5egGs=;
        b=nAuBzaZ+M+jU9nrAWBIdAEOhgQaiL9q7FlV99s2L52qnyjGadAJ83ru2N1aLv4ymbI
         iVLz0nc9/aARTcufEm2u3ijh7pYZzCvqEVP4PMX5VTo71rUNDqyrRTjpiaixcRgds8I9
         VRkPInO7qAnHDfzLkFgt44gmER5AcTNO0w/gs/WBjtpQDhnllAIylznHTIlsopMn6df3
         auMaJiKcjyOeJk97/R6Xh6LncbaErvwiexu1ld6WqzUD/trx9J7mZP0Q5u4CT1I45snZ
         eVbXTPSXqOjg5grHcF9/d3UlX2UXs8/IjIF+hAGoyc8irYKiKTb7iAexn4HQ7NifbTCY
         xalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aJrWupuoqlaE+s8IR7dca1FQsV4mMbu8eS/d2O5egGs=;
        b=FHU5QM1Hwways4H/RkCzvXEca/DlZIOTKUAkQUNPyyxAOoD96csiGhwrW3FKxBwBEQ
         nJId1iPX36TwYcCndnaHGbO0h+XlYiZj4SXzhf9joS3M2gKQZl5wE1JQg1NBc90Cv6JG
         UVCkO+qT44/p1swaxImQiE+dty8i78NpTgRWmjclEm+aCbzKgCORRxaMsx0e2pRuD+ut
         QAtuZSFKh1M0CpRd7aNSnfpU2VhdKWMTUPOZsqQ76ZeVYjbzmbXL3ZafiXUv9z+iLOvU
         Ljs+un3L3R3VsvzhJilEj0asHXKh9zyPpwA12OtPPrR32A5Fr9D4V1O7G5rTym1LE+9P
         9xSA==
X-Gm-Message-State: APjAAAXJvm2/98KQaACdKCwvzpBlhIUHTrZxEqXiiNPIv6UFYCvBO0aO
        txz9dATqhbQ1Ewxv0Zy69nWHbg==
X-Google-Smtp-Source: APXvYqzwcu39VfGPwDpwrOKuS2wqc4pCHbQDMsKrEcbai6c25uGI5sp3lG7XYlmkvLROu8NJdfy3sQ==
X-Received: by 2002:a63:e17:: with SMTP id d23mr12668781pgl.173.1576181287757;
        Thu, 12 Dec 2019 12:08:07 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id g19sm8087571pfh.134.2019.12.12.12.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 12:08:07 -0800 (PST)
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Zeng, Jason" <jason.zeng@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20191211213207.215936-1-brho@google.com>
 <20191211213207.215936-3-brho@google.com>
 <20191212173413.GC3163@linux.intel.com>
 <CAPcyv4hkz8XCETELBaUOjHQf3=VyVB=KWeRVEPYejvdsg3_MWA@mail.gmail.com>
 <b50720a2-5358-19ea-a45e-a0c0628c68b0@google.com>
 <CAPcyv4h19dKGpz0XzEHz0nOddnRAefE=rOuhGTHEL6FPhqk8GQ@mail.gmail.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <7e3d9ac4-5577-c8a3-a23c-655266376101@google.com>
Date:   Thu, 12 Dec 2019 15:08:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4h19dKGpz0XzEHz0nOddnRAefE=rOuhGTHEL6FPhqk8GQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 2:48 PM, Dan Williams wrote:
> On Thu, Dec 12, 2019 at 11:16 AM Barret Rhoden <brho@google.com> wrote:
>>
>> On 12/12/19 12:37 PM, Dan Williams wrote:
>>> Yeah, since device-dax is the only path to support longterm page
>>> pinning for vfio device assignment, testing with device-dax + 1GB
>>> pages would be a useful sanity check.
>>
>> What are the issues with fs-dax and page pinning?  Is that limitation
>> something that is permanent and unfixable (by me or anyone)?
> 
> It's a surprisingly painful point of contention...

Thanks for the info; I'll check out those threads.

[snip]

>> I'd like to put a lot more in a DAX/pmem region than just a guest's
>> memory, and having a mountable filesystem would be extremely convenient.
> 
> Why would page pinning be involved in allowing the guest to mount a
> filesystem on guest-pmem? That already works today, it's just the
> device-passthrough that causes guest memory to be pinned indefinitely.

I'd like to mount the pmem filesystem on the *host* and use its files 
for the guest's memory.  So far I've just been making an ext4 FS on 
/dev/pmem0 and creating a bunch of files in the FS.  Some of the files 
are the guest memory: one file for each VM.  Other files are just 
metadata that the host uses.

That all works right now, but I'd also like to use VFIO with the guests.

Thanks,

Barret




