Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6EFC3496D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2468E246B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576269384;
	bh=WlD17jKAQ9CMe2iR0cO+7SDqqvCCeKLDgUqLXoxpIlw=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=lnI1u7wGHxVIiaqteznBHN/FawLWUHcA+iu0J0+UefsaalUUvrAuGgahg6gFT6Bk4
	 DOTuM5KFpK2yCnQbunBQo+/DmgGbP8YU3RkkL6aQ1rsK1wxgLQUtpn+KJ9QKUBeaCD
	 SyDgQKTdDH7HRgG+97XaoIk8aRG913LEpJ5DdFDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLML2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 06:28:50 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:33168 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbfLML2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 06:28:49 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ifj7k-0004JA-4j; Fri, 13 Dec 2019 12:28:44 +0100
To:     Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH] KVM: arm/arm64: vgic-its: Fix restoration of unmapped  collections
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Dec 2019 11:28:43 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>
In-Reply-To: <d36b75e7-bd83-e501-3bd4-76bf0489c5ce@huawei.com>
References: <20191213094237.19627-1-eric.auger@redhat.com>
 <d36b75e7-bd83-e501-3bd4-76bf0489c5ce@huawei.com>
Message-ID: <9e9e3ed65ddf40ab72528187089e0997@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, eric.auger@redhat.com, eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 2019-12-13 10:53, Zenghui Yu wrote:
> Hi Eric,
>
> On 2019/12/13 17:42, Eric Auger wrote:
>> Saving/restoring an unmapped collection is a valid scenario. For
>> example this happens if a MAPTI command was sent, featuring an
>> unmapped collection. At the moment the CTE fails to be restored.
>> Only compare against the number of online vcpus if the rdist
>> base is set.
>
> Have you actually seen a problem and this patch fixed it? To be 
> honest,
> I'm surprised to find that we can map a LPI to an unmapped collection 
> ;)
> (and prevent it to be delivered to vcpu with an 
> INT_UNMAPPED_INTERRUPT
> error, until someone had actually mapped the collection).
> After a quick glance of spec (MAPTI), just as you said, this is 
> valid.

Yes, this is one of the (many) odd bits in the architecture. And there 
is
a bizarre wording in the MAPC description when V=0:

"Behavior is unpredictable if there are interrupts that are mapped to 
the
specified collection, with the restriction that further translation 
requests
from that device are ignored."

It is really odd that:

- it is unpredictable to unmap the collection with mapped interrupts,
   but mapping interrupts to an unmapped collection is fine

- the notion of "interrupts from that device" doesn't match any of the
   MAPC parameters

Do you hate the GIC already? ;-)

> If Marc has no objection to this fix, please add
>
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

Thanks for that, I've applied it to the patch and will push out
the update as soon as ra.kernel.org is reachable again.

         M.
-- 
Jazz is not dead. It just smells funny...
