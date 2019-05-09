Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1EEC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BCA2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfEIPam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 11:30:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:42548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbfEIPal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 11:30:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75D39ACE3;
        Thu,  9 May 2019 15:30:40 +0000 (UTC)
Subject: Re: [PATCH] mptsas: fix undefined behaviour of a shift of an int by
 more than 31 places
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Colin Ian King <colin.king@canonical.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190504164010.24937-1-colin.king@canonical.com>
 <1557027274.2821.2.camel@HansenPartnership.com>
 <de7e3aaf-0155-5007-c228-510f0d0de428@canonical.com>
 <1557325468.3196.2.camel@HansenPartnership.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <9b4c84b5-31eb-6068-57c2-80ededc21b43@suse.de>
Date:   Thu, 9 May 2019 17:30:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557325468.3196.2.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/19 4:24 PM, James Bottomley wrote:
> On Wed, 2019-05-08 at 14:07 +0100, Colin Ian King wrote:
>> On 05/05/2019 04:34, James Bottomley wrote:
>>> On Sat, 2019-05-04 at 17:40 +0100, Colin King wrote:
>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>
>>>> Currently the shift of int value 1 by more than 31 places can
>>>> result in undefined behaviour. Fix this by making the 1 a ULL
>>>> value before the shift operation.
>>>
>>> Fusion SAS is pretty ancient.  I thought the largest one ever
>>> produced had four phys, so how did you produce the overflow?
>>
>> This was an issue found by static analysis with Coverity; so I guess
>> won't happen in the wild, in which case the patch could be ignored.
> 
> The point I was more making is that if we thought this could ever
> happen in practice, we'd need more error handling than simply this:
> we'd be setting the phy_bitmap to zero which would be every bit as bad
> as some random illegal value.
> 
Thing is, mptsas is used as the default emulation in VMWare, and that 
does allow you to do some pretty weird configurations (I've found myself 
fixing a bug with SATA hotplug on mptsas once ...).
So I wouldn't discard this issue out of hand.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
