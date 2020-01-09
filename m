Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6022AC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142102072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="C2t3NIZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgAIHYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 02:24:38 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3825 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgAIHYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:24:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e16d5230000>; Wed, 08 Jan 2020 23:24:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 08 Jan 2020 23:24:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 08 Jan 2020 23:24:37 -0800
Received: from [10.24.44.157] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jan
 2020 07:24:35 +0000
Subject: Re: [PATCH v3] regmap: add iopoll-like atomic polling macro
To:     Dmitry Osipenko <digetx@gmail.com>, <broonie@kernel.org>
CC:     <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <1578546590-24737-1-git-send-email-spujar@nvidia.com>
 <fa5198bf-0001-3a57-017f-1b40e0188606@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <b9f5459f-007e-3139-a3cf-c7dfd3fc335a@nvidia.com>
Date:   Thu, 9 Jan 2020 12:54:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <fa5198bf-0001-3a57-017f-1b40e0188606@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578554659; bh=IL/YAb4LXWZegxtbauJrOQG4Bg2KlREeVlVy1iUL9lA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=C2t3NIZCN7gMezuCEAHzg02MvfSXrWWVossQZwndyLA0b8xRc2uaC0iGB6M6o/f6+
         3dgjv70oZQaJV6I3xOHBJyk9Ng8JybIMqMunPPyW1V1k/jB9yCB0yhYRdeK8W12R8R
         K0G9pUL1XtHgCxJjQ6jjLHBc8ulUOb5cWjvMfQrPL75efKOwto+D5PM2PiToECVHMD
         TRehGoX2cstgvWrJM7z1uzmjAj/7H59D7H3A7slDEitPhsQL9saUUrohDcRNeCNRDO
         vC77UpJ4YRyEcHwUjdqt1n2NK7j13+GTv0xTfJ6oFKXtjMcZSvFaN8w1POdARQe2SZ
         mT70MdInv/klw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/9/2020 11:30 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 09.01.2020 08:09, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> This patch adds a macro 'regmap_read_poll_timeout_atomic' that works
>> similar to 'readx_poll_timeout_atomic' defined in linux/iopoll.h; This
>> is atomic version of already available 'regmap_read_poll_timeout' macro.
>>
>> It should be noted that above atomic macro cannot be used by all regmaps=
.
>> If the regmap is set up for atomic use (flat or no cache and MMIO) then
>> only it can use.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
> Could you please explain what is the targeted use-case here?

I was trying to use regmap_read_poll_timeout() to poll for status change=20
of a register. This resulted in "BUG: scheduling while atomic". The=20
callback function, in which I was trying to use the macro, runs in=20
atomic context. Hence new atomic macro is added. I was checking ALSA=20
playback/capture and trigger() callback had to monitor some register status=
.

In general, the new macro can be used in atomic callbacks where regmap=20
interface is used and polling is required.

