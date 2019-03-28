Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DCA21773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfC1OA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:00:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfC1OA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:00:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63CD480E44;
        Thu, 28 Mar 2019 14:00:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA8BA1001E6B;
        Thu, 28 Mar 2019 14:00:06 +0000 (UTC)
Subject: Re: [PATCH 2/3 v9] resource: add the new I/O resource descriptor
 'IORES_DESC_RESERVED'
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
References: <20190321103309.27883-1-lijiang@redhat.com>
 <20190321103309.27883-3-lijiang@redhat.com> <20190322192800.GM12472@zn.tnic>
 <47bfcbe2-1631-9733-74c2-fb3e56540052@redhat.com>
 <20190325122426.GK12016@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <86919dfe-ab72-efef-8304-b2608078d320@redhat.com>
Date:   Thu, 28 Mar 2019 22:00:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190325122426.GK12016@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 28 Mar 2019 14:00:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年03月25日 20:24, Borislav Petkov 写道:
> On Mon, Mar 25, 2019 at 02:53:02PM +0800, lijiang wrote:
>> In this function, i printed its values, and only got the value of reserved
>> type, so i changed the IORES_DESC_NONE to the IORES_DESC_RESERVED.
>>
>> In addition, after the new descriptor 'IORES_DESC_RESERVED' is introduced,
>> the IORES_DESC_NONE does not include the IORES_DESC_RESERVED any more, it
>> could miss to handle the value of the reserved type.
> 
> Yes, IORES_DESC_RESERVED is supposed to denote the e820 reserved type.
> Why should IORES_DESC_NONE include it ?!?!
> 
> IORES_DESC_NONE is, well, an invalid, i.e., "none" type:

Yes, i see. That indicates an empty area, or "void" type.

> 
> /*
>  * I/O Resource Descriptors
>  *
>  * Descriptors are used by walk_iomem_res_desc() and region_intersects()
>  * for searching a specific resource range in the iomem table.  Assign
>  * a new descriptor when a resource range supports the search interfaces.
>  * Otherwise, resource.desc must be set to IORES_DESC_NONE (0).
>  */
> 
>> Do you mean i should never touch the three chunks? If i made a mistake, i
>> will remove this changes next post.
> 
> I'm looking at the hunks below and you're changing ->desc assignments in
> some random function which doesn't look like you know what you're doing.
> Maybe it gets you what you want but it sure as hell doesn't look right
> to me.
> 
I have realized that there could be a problem with this changes. Indeed, here
it denotes an empty area instead of a reserved area.

BTW: Looks like the name of this function(__reserve_region_with_split) is a bit
misleading.

Thank you for pointing out this problem, i will correct them next post.

Lianbo
