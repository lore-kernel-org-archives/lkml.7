Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8A3C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 14:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CC520869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 14:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555166291;
	bh=eDdpk7OVEkgezpqaRXRb+Tovg4FCFdCUBaBUtTanoBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JCwQRs3GzvB/FpC2YyKwhEMiG7gjMy1sN0m42/9ERi2Mkeknh8viQCkKABVA/1J83
	 j4G5KrGlefKOg5gnTZjeYuLDcwnufM5DRDmetCpABb2fAFOBaHbxAO5hqydBUIxcIy
	 3qhnNuyLNl2RHqxm3qAm+F+3Mxi2bzGsrgIypk3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDMOiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 10:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfDMOiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 10:38:09 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDF922077C;
        Sat, 13 Apr 2019 14:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555166289;
        bh=eDdpk7OVEkgezpqaRXRb+Tovg4FCFdCUBaBUtTanoBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/wI8KHF11+XCX8ZvRKt5IAWIIsYojvrDIS0j3Ar/gnfV1xfKpPIl4BmOrAAOOSXi
         6eSikcNQYHV1UAgozcaVw4u0yriv3Pp00lWFrg2HRIpoNUZbKbMZLcmcq3pbg711+d
         X8njMc3oF6GTNotKmtYwreGUhYlVyuKGgXmV6wuM=
Date:   Sat, 13 Apr 2019 10:38:07 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yueyi Li <liyueyi@live.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
Message-ID: <20190413143807.GV11568@sasha-vm>
References: <BLUPR13MB0289A32373545C7FBE3400CBDFBB0@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu_m353cv=Pf2cEUDLn8=5YTLjLDDO23n=P14nWXydQWDQ@mail.gmail.com>
 <BLUPR13MB02892B82F5EB663B2FECF20EDFB40@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu-YTdQmhU_br4amNZYn12=6Amr7w=wP57DyNn7_axptCg@mail.gmail.com>
 <BLUPR13MB028993B73A531E5C7EA62DCEDF820@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu-0JUqihHGQt+YyvUHRTizTOWywXqMaE4RiXOjQ7xi7zA@mail.gmail.com>
 <BLUPR13MB0289B8C3D58E9A3FAD2CF3DEDF820@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CANMq1KCdagM3L23Fgz2znhFCB_2JvtBWNvVCXZp4iGc8T46GwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CANMq1KCdagM3L23Fgz2znhFCB_2JvtBWNvVCXZp4iGc8T46GwQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 08:41:33PM +0800, Nicolas Boichat wrote:
>Dear stable maintainers,
>
>I encountered a similar issue on a 4.19.33 kernel (Chromium OS). On my
>board, the system would not even be able to boot if KASLR decides to
>map the linear region to the top of the virtual address space. This
>happens every 253 boots on average (there are 0xfd possible random
>offsets, and only the top one fails).
>
>I tried to debug the issue, and it appears physical memory allocated
>for vmemmap and mem_section array would end up at the same location,
>corrupting each other early on boot. I could not figure out exactly
>why this is happening, but in any case, this patch fixes my issue (no
>failure in 744 reboots with 240 unique offsets, and counting...), and
>IMHO the ERR_PTR justification in the commit message is enough to
>warrant inclusion in -stable branches.
>
>The patch below was committed to mainline as:
>commit c8a43c18a97845e7f94ed7d181c11f41964976a2
>    arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in linear region
>
>and should be included in stable branches after this commit:
>Fixes: c031a4213c11a5db ("arm64: kaslr: randomize the linear region")
>i.e. anything after kernel 4.5 (git describe says v4.5-rc4-62-gc031a4213c11a5d).

I've queued it for 4.9-4.19, thanks for the report.

--
Thanks,
Sasha
