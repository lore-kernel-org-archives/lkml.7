Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E209DC00306
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BDB20828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567719635;
	bh=rE87t2IaGvkbqZwJKihoeOJJ/pPsL/ji2UDYBcMkVps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wW7AA+G7S0WM7TlrdBqxb3vOQUgGdNFuxXrVSyTkRQxnYuB6HoZ2jqlVHfsWBi9Qz
	 B7lHmxACQYo/jnBjy8Y7YP4ck1DMJvUsVuEKmUKf/aOOUyTZY3maYReJPgwwNgp4zu
	 +uAXIUnoGE8jXlTYiSsRFh+jkIAK+DlIG/tnym8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388021AbfIEVke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 17:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730704AbfIEVkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:40:33 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB8D2206BB;
        Thu,  5 Sep 2019 21:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567719633;
        bh=rE87t2IaGvkbqZwJKihoeOJJ/pPsL/ji2UDYBcMkVps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTBbGB50XJbmZ+ljQpoFIahI/vRJAJkhBdJgV5xPESKP5ztQb1cKc2sTmgYRu68gk
         ZrY419ov9p+dgcvUVSsBQ9Qqf5sHUX8PGSxsFUC4FlDBvxz8QRne6ojHE9kkl9u9qr
         K64iwBAjdrH6gxGidsFt19cVm3/KJ6EcJdFATW50=
Date:   Thu, 5 Sep 2019 17:40:30 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mike Travis <mike.travis@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6/8] x86/platform/uv: Decode UVsystab Info
Message-ID: <20190905214030.GE1616@sasha-vm>
References: <20190905130252.590161292@stormcage.eag.rdlabs.hpecorp.net>
 <20190905130253.325911213@stormcage.eag.rdlabs.hpecorp.net>
 <20190905141634.GA25790@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190905141634.GA25790@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 04:16:34PM +0200, Greg KH wrote:
>On Thu, Sep 05, 2019 at 08:02:58AM -0500, Mike Travis wrote:
>> --- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
>> +++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
>> @@ -1303,7 +1303,8 @@ static int __init decode_uv_systab(void)
>>  	struct uv_systab *st;
>>  	int i;
>>
>> -	if (uv_hub_info->hub_revision < UV4_HUB_REVISION_BASE)
>> +	/* Select only UV4 (hubbed or hubless) and higher */
>> +	if (is_uv_hubbed(-2) < uv(4) && is_uv_hubless(-2) < uv(4))

For someone not too familiar with the code, this is completely
unreadable. There must be a nicer way to do this.

--
Thanks,
Sasha
