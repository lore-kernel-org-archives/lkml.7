Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69096C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3702D22CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TwmH/qbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfHUS4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:56:38 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14194 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfHUS4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:56:38 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5d93e60000>; Wed, 21 Aug 2019 11:56:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 21 Aug 2019 11:56:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 21 Aug 2019 11:56:37 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 18:56:37 +0000
Received: from [10.2.161.131] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 18:56:37 +0000
Subject: Re: Boot failure due to: x86/boot: Save fields explicitly, zero out
 everything else
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Neil MacLeod <neil@nmacleod.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>
References: <CAFbqK8m=F_90531wTiwKT4J0R+EC-3ZmqHtKCwA_2th_nVYrpg@mail.gmail.com>
 <900a48bf-c9fc-09bd-52a3-9e16ff8baa19@nvidia.com>
 <alpine.DEB.2.21.1908212047140.1983@nanos.tec.linutronix.de>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <5b9b4c36-c28b-1644-61fe-dbdfe3c4a1d2@nvidia.com>
Date:   Wed, 21 Aug 2019 11:54:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908212047140.1983@nanos.tec.linutronix.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566413798; bh=59TbhX++fURQ6IB6sU9SaGJ90qlX21B5kkUFNbRHcNY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TwmH/qbb31K20tbA0upbxLrQ+eDSkIqweaP8EXTvOiePYRHEbHaeWeEkAFjMCFni+
         HjZugrSxPNA8TSqVK+iIFLPpv6Zlo3HJx6+ENVknN4bzAi4WeTyhAvDy2hj1nkFGgc
         z9mEkyTGjssl1Oohe+4qrvtCCDkNdfArS4Y2jag6i8edskt0nhJ1+razhjQbpTDZ8H
         vPVsnWVuH+hyXhGcIxvRNv4YZNWlmBNj+z5r/D09eq9ZKx5UdYhUenQm9u77/5gYNx
         CyuActTxqx0eqzH3w7HtyKrlYrO88SVnLcMOZB9TjC/fVDsGNiKn90wW0s8FZDMUHW
         Y8vdqv4+FohMQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/19 11:51 AM, Thomas Gleixner wrote:
> On Wed, 21 Aug 2019, John Hubbard wrote:
>> On 8/21/19 10:05 AM, Neil MacLeod wrote:
>> static void sanitize_boot_params(struct boot_params *boot_params)
>> {
>> ...
>> 		const struct boot_params_to_save to_save[] = {
>> 			BOOT_PARAM_PRESERVE(screen_info),
>> 			BOOT_PARAM_PRESERVE(apm_bios_info),
>> 			BOOT_PARAM_PRESERVE(tboot_addr),
>> 			BOOT_PARAM_PRESERVE(ist_info),
>> 			BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
>> 			BOOT_PARAM_PRESERVE(hd0_info),
>> 			BOOT_PARAM_PRESERVE(hd1_info),
>> 			BOOT_PARAM_PRESERVE(sys_desc_table),
>> 			BOOT_PARAM_PRESERVE(olpc_ofw_header),
>> 			BOOT_PARAM_PRESERVE(efi_info),
>> 			BOOT_PARAM_PRESERVE(alt_mem_k),
>> 			BOOT_PARAM_PRESERVE(scratch),
>> 			BOOT_PARAM_PRESERVE(e820_entries),
>> 			BOOT_PARAM_PRESERVE(eddbuf_entries),
>> 			BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
>> 			BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
>> 			BOOT_PARAM_PRESERVE(e820_table),
>> 			BOOT_PARAM_PRESERVE(eddbuf),
>> 		};
> 
> I think I spotted it:
> 
> -               boot_params->acpi_rsdp_addr = 0;
> 
> + 			BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
> 
> And it does not preserve 'hdr'
> 
> Grr. I surely was too tired when staring at this last time.
> 

ohhh man, that's embarrassing. Especially hdr, which was the center of
the whole thing...sigh. Patch coming shortly.


thanks,
-- 
John Hubbard
NVIDIA
