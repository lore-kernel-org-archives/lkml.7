Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98384C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4B8206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nErOwMR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfKLMCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 07:02:06 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18632 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfKLMCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:02:05 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dca9f3d0000>; Tue, 12 Nov 2019 04:02:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 12 Nov 2019 04:02:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 12 Nov 2019 04:02:05 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 12:02:03 +0000
Subject: Re: [PATCH] mailbox: tegra: Fix superfluous IRQ error message
To:     Thierry Reding <thierry.reding@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20191011083459.11551-1-jonathanh@nvidia.com>
 <20191014132458.GG422231@ulmo>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f5cd4647-4349-f20c-bc16-da9291fc9329@nvidia.com>
Date:   Tue, 12 Nov 2019 12:02:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014132458.GG422231@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573560125; bh=MXqTssWPWKdVEX2bZ8+ChpONM31fFZUEKiWQR+GY8GA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=nErOwMR9+n7s4nN5ASX7kZEmlxiXBdpT4WEr4AjSUZEr8uKD/jPCSe8O/j6yjU5Xa
         hfYHc/WVti7CLYxZ2caWfwkp7YnGDHZtoSOLfn4l/7JHq8BSUxUkBa+LHLr3ID735e
         XWmEFw8oR8Fow96AguuKNC4ernuLrIAZWJvFjUXGmtD1GThFWA6Ip7UDJAKz8DnhJH
         os/Xh0kD3f4jfpjfBucgxC82LyUVFV6bwECqWF63JwJYoa7KZSgG0qfJLSewt3hXeM
         o5VfDViSXsj6x/VNNPm93PK9Pd3L+OBP68P6OPGkbqqY529IeImh0U2VcGP25dUiXq
         GJ3uRAcSZkAwA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 14/10/2019 14:24, Thierry Reding wrote:
> On Fri, Oct 11, 2019 at 09:34:59AM +0100, Jon Hunter wrote:
>> Commit 7723f4c5ecdb ("driver core: platform: Add an error message to
>> platform_get_irq*()") added an error message to avoid drivers having
>> to print an error message when IRQ lookup fails. However, there are
>> some cases where IRQs are optional and so new optional versions of
>> the platform_get_irq*() APIs have been added for these cases.
>>
>> The IRQs for Tegra HSP module are optional because not all instances
>> of the module have the doorbell and all of the shared interrupts.
>> Hence, since the above commit was applied the following error messages
>> are now seen on Tegra194 ...
>>
>>  ERR KERN tegra-hsp c150000.hsp: IRQ doorbell not found
>>  ERR KERN tegra-hsp c150000.hsp: IRQ shared0 not found
>>
>> The Tegra HSP driver deliberately does not fail if these are not found
>> and so fix the above errors by updating the Tegra HSP driver to use
>> the platform_get_irq_byname_optional() API.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/mailbox/tegra-hsp.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Perhaps Greg should pick up this patch because he's carrying the patch
> that adds the platform_get_irq_byname_optional() patch for v5.5.
> 
> Greg, would you prefer a copy of this in your mailbox, or does the
> following patchwork link suffice:
> 
> 	http://patchwork.ozlabs.org/patch/1175012/
> 
> Either way, this patch:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 
> Thierry

Are you OK to pick this up? Do you need Jassi's ACK as well?

Thanks!
Jon

-- 
nvpublic
