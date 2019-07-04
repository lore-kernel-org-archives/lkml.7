Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA13AC46484
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1F7218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfGDO00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 10:26:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfGDO00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:26:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F00665AFE9;
        Thu,  4 Jul 2019 14:26:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EC46795AF;
        Thu,  4 Jul 2019 14:26:12 +0000 (UTC)
Subject: Re: linux-next: manual merge of the hmm tree with the tip tree
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20190704190352.417a34d1@canb.auug.org.au>
 <20190704124212.GH3401@mellanox.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <e10ac232-d21e-c231-e47f-f31bb770a922@redhat.com>
Date:   Thu, 4 Jul 2019 22:26:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190704124212.GH3401@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 04 Jul 2019 14:26:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, Jul 04, 2019 at 07:03:52PM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the hmm tree got a conflict in:
>>
>>   include/linux/ioport.h
>>
>> between commit:
>>
>>   ae9e13d621d6 ("x86/e820, ioport: Add a new I/O resource descriptor IORES_DESC_RESERVED")
>>   5da04cc86d12 ("x86/mm: Rework ioremap resource mapping determination")
>>
>> from the tip tree and commit:
>>
>>   25b2995a35b6 ("mm: remove MEMORY_DEVICE_PUBLIC support")
>>
>> from the hmm tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
>> -- 
>> Cheers,
>> Stephen Rothwell
>>
>> diff --cc include/linux/ioport.h
>> index 5db386cfc2d4,a02b290ca08a..000000000000
>> --- a/include/linux/ioport.h
>> +++ b/include/linux/ioport.h
>> @@@ -133,16 -132,6 +133,15 @@@ enum 
>>   	IORES_DESC_PERSISTENT_MEMORY		= 4,
>>   	IORES_DESC_PERSISTENT_MEMORY_LEGACY	= 5,
>>   	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
>> - 	IORES_DESC_DEVICE_PUBLIC_MEMORY		= 7,
>> - 	IORES_DESC_RESERVED			= 8,
>> ++	IORES_DESC_RESERVED			= 7,
>>  +};

This change should be OK. Thanks.

Lianbo

>>  +
>>  +/*
>>  + * Flags controlling ioremap() behavior.
>>  + */
>>  +enum {
>>  +	IORES_MAP_SYSTEM_RAM		= BIT(0),
>>  +	IORES_MAP_ENCRYPTED		= BIT(1),
>>   };
>>   
>>   /* helpers to define resources */
> 
> Looks OK to me, thanks
> 
> Jason
> 
