Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65149C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 04:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B543213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 04:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PzUxnAzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfCTES3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 00:18:29 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19849 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfCTES2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 00:18:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c91bf160000>; Tue, 19 Mar 2019 21:18:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 Mar 2019 21:18:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 Mar 2019 21:18:27 -0700
Received: from [10.25.74.141] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Mar
 2019 04:18:24 +0000
Subject: Re: [PATCH v3] ARM: tegra: enforce PM requirement
To:     Dmitry Osipenko <digetx@gmail.com>, <linux@armlinux.org.uk>,
        <jhogan@kernel.org>, <jonathanh@nvidia.com>, <treding@nvidia.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1551255628-4794-1-git-send-email-spujar@nvidia.com>
 <6e5bf310-12b5-26a3-f466-95cc56c6932a@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <226b42a9-766f-2124-6af9-891694ad1195@nvidia.com>
Date:   Wed, 20 Mar 2019 09:48:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <6e5bf310-12b5-26a3-f466-95cc56c6932a@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553055510; bh=J31mxn0xE6EJ1K4K+0budBSjg7LEa82DFKPhOdancq0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=PzUxnAzhi2Fdz/2Kfc7Cj4SU3ca1SiCBANc+btNXgB5viRLS8cOI5pjwlfBRWJefT
         mNe6Aoc4EXLIx4fSnkQmIs7ZCf1B+3URDKaomRjMcEX3mAN0VPQ3kSm/zNPwIGb+VC
         H/zfVlQumRbg9F2nMmpm3UBULpGVfCM9pXlvD3ir/yZNLamA0FJ/mbM8oeXxxZkJlu
         LrPFSGnP98hsuUgnUL493088zK+9XcxmLfXsYxXkDnGuwF+bSGT2349p9g8UHfvDNT
         Quirhh+ByvWBtIsS3JnBl+bqeyTCqyfzLg8n3avKNXWbPirVnc1unPIts+JYXNhM7q
         ZTEeQDZTUQ1iw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/27/2019 7:01 PM, Dmitry Osipenko wrote:
> 27.02.2019 11:20, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Currently runtime PM is enabled for Tegra HDA driver. One of the concern
>> raised was about handling !PM case in HDA driver. In this case, there is
>> a need to manage clocks and power explicitly in the driver and reviewers
>> were not really convinced about this. The consensus at the end was to
>> enforce PM requirement to keep things simple, rather driver mentioning a
>> dependency on PM. This is how it is done for ARM 64-bit Tegra platforms
>> and the same can be done for 32-bit Tegra platforms too.
>>
>> Finally the objective is to remove dependency on PM availability for all
>> Tegra drivers. The detailed discussion can be found in following patch,
>> https://patchwork.ozlabs.org/patch/1031007/
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> Reviewed-by: Thierry Reding <treding@nvidia.com>
>> Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
>> ---
> The commit message is okay to me this time, thanks! I'm still not super-h=
appy to lose the !PM option because of its value in regards to the PM debug=
ging, but again we can just do something better in that regards later on if=
 will be really needed.
>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Do we have any further concerns over the patch? Request maintainers for=20
merge otherwise.
