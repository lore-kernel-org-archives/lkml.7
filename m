Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AEEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 06:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34E22072A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 06:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTz+65Bz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfLYG7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 01:59:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35679 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbfLYG7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 01:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577257163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u//ESy15IGc/BP211+J4VWx/wIc7dqxkikgAFDRdb4w=;
        b=fTz+65BzIQp8ftR4JtABkrrnHZOo/jKM+//cmhSAAtfGctWquXtOm+30vLz4erif+Wc7ah
        dCnACrt9vE4fgna6f0EU74/eStu8R0smYfTnZfl94gd7llZ166WRF92YTS/fbuGuQWAPmo
        09bw6AkmgOb5ugEXln21x7LVxMyeWXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-LgD31ExNMAezazMTwDceuw-1; Wed, 25 Dec 2019 01:59:22 -0500
X-MC-Unique: LgD31ExNMAezazMTwDceuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6604800EBF;
        Wed, 25 Dec 2019 06:59:20 +0000 (UTC)
Received: from localhost (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F54B691EA;
        Wed, 25 Dec 2019 06:59:17 +0000 (UTC)
Date:   Wed, 25 Dec 2019 14:59:14 +0800
From:   "'bhe@redhat.com'" <bhe@redhat.com>
To:     "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
Cc:     "'dyoung@redhat.com'" <dyoung@redhat.com>,
        "'vgoyal@redhat.com'" <vgoyal@redhat.com>,
        "'ebiederm@xmission.com'" <ebiederm@xmission.com>,
        "'mingo@kernel.org'" <mingo@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>
Subject: Re: [RFD] kdump, kaslr: how to fix the failure of reservation of
 crashkernel low memory due to physical kaslr
Message-ID: <20191225065914.GC3355@MiWiFi-R3L-srv>
References: <OSBPR01MB4006AF8B4D355200E385850E95280@OSBPR01MB4006.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB4006AF8B4D355200E385850E95280@OSBPR01MB4006.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi HATAYAMA,

On 12/25/19 at 04:26am, d.hatayama@fujitsu.com wrote:
> Currently, reservation of crashkernel low memory sometimes fails due
> to a sparse memory caused by physical kaslr with the following
> message:
> 
>     Cannot reserve 256MB crashkernel low memory, please try smaller size.

I don't understand, may not get your point. KASLR will randomize the
position of kernel image. However, kernel image usually takes up 50M
memory. Under low 4G memory, how come it can't reserve 256M crashkernel
low memory. Do you have the boot log of the failed case?

> 
> Kdump needs low memory, memory area less than 4GB, e.g. for swiotlb.
> Its size is 256MB for low memory by default. OTOH, physical kaslr
> loads kernel images in a random physical address for
> security. Physical kaslr sometimes choose low memory and sparse
> there and as a result, reservation of crash kernel low memory could fail.
> 
> This failure seldom occurs on systems with large memory. For example,
> on our system with 128GB, the issue occurs once in hundreds of
> reboots. Although it doesn't occur frequently and can be avoided in
> practice simply by rebooting the system, it definitely occurs once in
> hundreds of reboots. Once the issue occurs, it's difficult for ordinary
> users to understand why it failed. I'd like to fix this current behavior.
> 
> I'm now coming up two ideas but don't know what is best. Please
> discuss how to fix the issue in better way.
> 
> 1) Add a kernel parameter to make physical kaslr to avoid specified
>    memory area
> 
>   This is the simplest idea I came up with first just like
>    kaslr_mem_avoid=4GB-0, which is similar syntax to memap=, meaning
>    that kaslr, please avoid to load kernel image into the region [0,
>    4GB).
> 
>   It looks to me that this can be implemented easily by taking
>    advantage of the existing code about mem_avoid mechanism in
>    arch/x86/boot/compressed/kaslr.c.
> 
>   This mechanism doesn't lose security provided by physical kaslr if
>    system memory is large enough.
> 
>   Demerit of this is that users need configuration. Automatic way is
>    better if possible.
> 
> 2) Add special handling for crashkernel= low in physical kaslr
> 
>   The second idea I came up with is to add special handling for
>    crashkernel= low in physical kaslr, i.e. physical kaslr recognizes
>    crashkernel= in kernel parameters and keep enough memory for
>    crashkenrel.
> 
>   To guarantee that the memory area kept by the special handling in
>    physical kaslr is used for crashkernel, it is necessary to mark the
>    area to indicate to the crashkernel code executed after kernel
>    runs. To implement this, I imagine introducing a new type of memory
>    a kind of E820_CRASHKERNEL_LOW.
> 
>   My concern on this idea is whether its worth implementing such
>    special handling in physical kaslr simply because I don't find such
>    code in physical kaslr now.
> 
> 3) Any other better ideas?

Someone ever told that some systems may not have low 4G memory since
they own hardware iommu. In real life, I never see such kind of system,
and most of them can give 256M crashkernel memory a satisfactory result.
Unless you reserve more than 1G under low 4G, it could fail because of
kinds of complicated memory reservations there.

Thanks
Baoquan

> 
> Thanks.
> HATAYAMA, Daisuke
> 

