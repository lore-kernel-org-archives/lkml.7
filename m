Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDD5C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8C423403
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BAAvOyHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfHUUCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 16:02:42 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16444 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfHUUCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:02:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5da3610000>; Wed, 21 Aug 2019 13:02:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 21 Aug 2019 13:02:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 21 Aug 2019 13:02:41 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 20:02:40 +0000
Received: from [10.2.161.131] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 20:02:40 +0000
Subject: Re: Boot failure due to: x86/boot: Save fields explicitly, zero out
 everything else
To:     Neil MacLeod <neil@nmacleod.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>
References: <CAFbqK8m=F_90531wTiwKT4J0R+EC-3ZmqHtKCwA_2th_nVYrpg@mail.gmail.com>
 <900a48bf-c9fc-09bd-52a3-9e16ff8baa19@nvidia.com>
 <alpine.DEB.2.21.1908212047140.1983@nanos.tec.linutronix.de>
 <5b9b4c36-c28b-1644-61fe-dbdfe3c4a1d2@nvidia.com>
 <CAFbqK8mG0-f9BpwTykXq+P_pAzMrn_4-5QJ_jawJ1aYSTMGR7w@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <a6630fa1-cbf9-4bee-3793-caad57a2a2c0@nvidia.com>
Date:   Wed, 21 Aug 2019 13:00:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFbqK8mG0-f9BpwTykXq+P_pAzMrn_4-5QJ_jawJ1aYSTMGR7w@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566417761; bh=nIvZiZMif2B4EoipCeGZQIqrYDZby4SIWMrDUGBINLk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BAAvOyHfVUrYnJGbAO+0XbAwRUJfvZBEHpbKHGUaJayMjtOlxxuKEwot2RCv1WEH8
         pC1FOvDIhJHmUF7zQNwHu7RMT/uDu/RVBsqUnz7tp+3aZ62DFiUoHrPJVNXtk36R14
         By6kXvDGzk22/aArVEoRmuNlIp4nowxTASDH2Ru1D5GrrlRHHYEXuGOiw/Sah+F5Mn
         afnNU0AcFNBvlqnZfa09pcZfdgAYXMzcB1QysSNexAmBF3L0+tNtKAHFzmNd+Myf5U
         CVfPsGtuWjDena8xI40EwSHr+8BMxWS+C8kB0xGc1I33BZpUsmaDsE2bOX/WszK7M8
         jAL98k58/mwLw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/19 12:49 PM, Neil MacLeod wrote:
> The fix looks good - many thanks for the quick turnaround!
> 

Great news, and thanks for the bug report!

thanks,
-- 
John Hubbard
NVIDIA

> 
> On Wed, 21 Aug 2019 at 19:56, John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 8/21/19 11:51 AM, Thomas Gleixner wrote:
>>> On Wed, 21 Aug 2019, John Hubbard wrote:
>>>> On 8/21/19 10:05 AM, Neil MacLeod wrote:
>>>> static void sanitize_boot_params(struct boot_params *boot_params)
>>>> {
>>>> ...
>>>>               const struct boot_params_to_save to_save[] = {
>>>>                       BOOT_PARAM_PRESERVE(screen_info),
>>>>                       BOOT_PARAM_PRESERVE(apm_bios_info),
>>>>                       BOOT_PARAM_PRESERVE(tboot_addr),
>>>>                       BOOT_PARAM_PRESERVE(ist_info),
>>>>                       BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
>>>>                       BOOT_PARAM_PRESERVE(hd0_info),
>>>>                       BOOT_PARAM_PRESERVE(hd1_info),
>>>>                       BOOT_PARAM_PRESERVE(sys_desc_table),
>>>>                       BOOT_PARAM_PRESERVE(olpc_ofw_header),
>>>>                       BOOT_PARAM_PRESERVE(efi_info),
>>>>                       BOOT_PARAM_PRESERVE(alt_mem_k),
>>>>                       BOOT_PARAM_PRESERVE(scratch),
>>>>                       BOOT_PARAM_PRESERVE(e820_entries),
>>>>                       BOOT_PARAM_PRESERVE(eddbuf_entries),
>>>>                       BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
>>>>                       BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
>>>>                       BOOT_PARAM_PRESERVE(e820_table),
>>>>                       BOOT_PARAM_PRESERVE(eddbuf),
>>>>               };
>>>
>>> I think I spotted it:
>>>
>>> -               boot_params->acpi_rsdp_addr = 0;
>>>
>>> +                     BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
>>>
>>> And it does not preserve 'hdr'
>>>
>>> Grr. I surely was too tired when staring at this last time.
>>>
>>
>> ohhh man, that's embarrassing. Especially hdr, which was the center of
>> the whole thing...sigh. Patch coming shortly.
>>
>>
>> thanks,
>> --
>> John Hubbard
>> NVIDIA
