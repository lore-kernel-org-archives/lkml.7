Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A15C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA90216B7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfGZODF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:03:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48287 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfGZODF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:03:05 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hr0oI-0006AQ-WF
        for linux-kernel@vger.kernel.org; Fri, 26 Jul 2019 14:03:03 +0000
Received: by mail-pf1-f199.google.com with SMTP id 6so33261339pfz.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 07:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zgKsD0vS61TwqaiMc5Bxbo+tuGL4q/knIykLeSFgHUE=;
        b=I4v+GF9mB+eCvTvUGfXUQ9oqRdalEZ1+dkbjuXr1WGOl1vGKO/Q5o2S+dFgaYO9NNo
         aGlOIAqrgDpT2KCBijr2U+ljUXlSLlsJB8EYMuVf2s4uPR+Y059zNWX2y/ZJ2esvoaQB
         qoo8goTT3iuTQu3PdneVqegOFICu0JzudIch+Y1vUllZOr0phH7e1Ft06El2EYkdl97z
         KYoWCv9sCjEWH1za3RSXYIztFgE1TV2XvlE7pVgrDgeRYGJqQ2XF7LdG4Lvtk6eWC9Eq
         dZFuY66w4rwXLRzCPpwV4RpAr/ID41er1zvbRfNBuJKQcA8EDqSNquRkn3iEB1Ey7nXH
         sXMQ==
X-Gm-Message-State: APjAAAXVVntbyM73dIMWEpsl7nKUj/6+vhJnCVORmLPqh1IHeJfwEgdv
        t2G5ZRcmWE3lySshMDEWDENIPDUNeHP+Ajo5BrC6P7heXtGnf+ou/Q0TdNqspwrjDvCkcVyeWk+
        Beg7sjbA2FRUJnSnOXCifBKX33l0tEAz5QKU7DjHfpQ==
X-Received: by 2002:a17:90b:d82:: with SMTP id bg2mr55822737pjb.87.1564149781707;
        Fri, 26 Jul 2019 07:03:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxGjVFm3iMZdHa8/bpEy8jQL6sS/HSuRjQlLlbJZHDjj7/gKO7kf1TjhItkgv13p7LIplasGw==
X-Received: by 2002:a17:90b:d82:: with SMTP id bg2mr55822693pjb.87.1564149781331;
        Fri, 26 Jul 2019 07:03:01 -0700 (PDT)
Received: from 2001-b011-380f-37d3-3494-cf95-ca69-bfbd.dynamic-ip6.hinet.net (2001-b011-380f-37d3-3494-cf95-ca69-bfbd.dynamic-ip6.hinet.net. [2001:b011:380f:37d3:3494:cf95:ca69:bfbd])
        by smtp.gmail.com with ESMTPSA id n26sm56226280pfa.83.2019.07.26.07.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 07:03:00 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <15043168.halW6uqc8m@kreacher>
Date:   Fri, 26 Jul 2019 22:02:57 +0800
Cc:     Keith Busch <kbusch@kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <D33632F4-E119-4833-816C-79084DA03DE4@canonical.com>
References: <2332799.izEFUvJP67@kreacher> <2428826.VBuqOhikiK@kreacher>
 <20190725195258.GA7307@localhost.localdomain> <15043168.halW6uqc8m@kreacher>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 04:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> On Thursday, July 25, 2019 9:52:59 PM CEST Keith Busch wrote:
>> On Thu, Jul 25, 2019 at 09:48:57PM +0200, Rafael J. Wysocki wrote:
>>> NVME Identify Controller:
>>> vid     : 0x1c5c
>>> ssvid   : 0x1c5c
>>> sn      : MS92N171312902J0N
>>> mn      : PC401 NVMe SK hynix 256GB
>>> fr      : 80007E00
>>> rab     : 2
>>> ieee    : ace42e
>>> cmic    : 0
>>> mdts    : 5
>>> cntlid  : 1
>>> ver     : 10200
>>> rtd3r   : 7a120
>>> rtd3e   : 1e8480
>>> oaes    : 0x200
>>> ctratt  : 0
>>> oacs    : 0x17
>>> acl     : 7
>>> aerl    : 3
>>> frmw    : 0x14
>>> lpa     : 0x2
>>> elpe    : 255
>>> npss    : 4
>>> avscc   : 0x1
>>> apsta   : 0x1
>>> wctemp  : 352
>>> cctemp  : 354
>>> mtfa    : 0
>>> hmpre   : 0
>>> hmmin   : 0
>>> tnvmcap : 0
>>> unvmcap : 0
>>> rpmbs   : 0
>>> edstt   : 10
>>> dsto    : 0
>>> fwug    : 0
>>> kas     : 0
>>> hctma   : 0
>>> mntmt   : 0
>>> mxtmt   : 0
>>> sanicap : 0
>>> hmminds : 0
>>> hmmaxd  : 0
>>> nsetidmax : 0
>>> anatt   : 0
>>> anacap  : 0
>>> anagrpmax : 0
>>> nanagrpid : 0
>>> sqes    : 0x66
>>> cqes    : 0x44
>>> maxcmd  : 0
>>> nn      : 1
>>> oncs    : 0x1f
>>> fuses   : 0x1
>>> fna     : 0
>>> vwc     : 0x1
>>> awun    : 7
>>> awupf   : 7
>>> nvscc   : 1
>>> acwu    : 7
>>> sgls    : 0
>>> mnan    : 0
>>> subnqn  :
>>> ioccsz  : 0
>>> iorcsz  : 0
>>> icdoff  : 0
>>> ctrattr : 0
>>> msdbd   : 0
>>> ps    0 : mp:6.00W operational enlat:5 exlat:5 rrt:0 rrl:0
>>>           rwt:0 rwl:0 idle_power:- active_power:-
>>> ps    1 : mp:3.80W operational enlat:30 exlat:30 rrt:1 rrl:1
>>>           rwt:1 rwl:1 idle_power:- active_power:-
>>> ps    2 : mp:2.40W operational enlat:100 exlat:100 rrt:2 rrl:2
>>>           rwt:2 rwl:2 idle_power:- active_power:-
>>> ps    3 : mp:0.0700W non-operational enlat:1000 exlat:1000 rrt:3 rrl:3
>>>           rwt:3 rwl:3 idle_power:- active_power:-
>>> ps    4 : mp:0.0070W non-operational enlat:1000 exlat:5000 rrt:3 rrl:3
>>>           rwt:3 rwl:3 idle_power:- active_power:-
>>
>> Hm, nothing stands out as something we can use to determine if we should
>> skip the nvme specific settings or allow D3. I've no other ideas at the
>> moment for what we may check.
>
> Well, do ASPM settings matter here?

Seems like it's a regression in the firmware.

The issue happens in version 80007E00 but not version 80006E00.
I am not sure how to downgrade it under Linux though.
The firmware changelog [1] is very interesting:
- Improves the performance of the solid-state drive (SSD) by distributing  
power into the SSD efficiently according to the power state of the system.

[1]  
https://www.dell.com/support/home/us/en/04/drivers/driversdetails?driverid=mcxm8

Kai-Heng

