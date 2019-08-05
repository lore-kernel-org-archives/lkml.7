Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED73BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81B42147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Amh9ZXwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfHEU2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:28:07 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9829 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfHEU2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 16:28:07 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4891580002>; Mon, 05 Aug 2019 13:28:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 05 Aug 2019 13:28:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 05 Aug 2019 13:28:06 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Aug
 2019 20:28:06 +0000
Subject: Re: [PATCH v2 0/1] x86/boot: save fields explicitly, zero out
 everything else
To:     "H . Peter Anvin" <hpa@zytor.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20190731054627.5627-1-jhubbard@nvidia.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <98d7c31b-c805-ce50-bd67-5bc448b524b3@nvidia.com>
Date:   Mon, 5 Aug 2019 13:28:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731054627.5627-1-jhubbard@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565036888; bh=WfKagHt7RPgl+4Jvdfwos3Ydu88tlg3u8jAWdp5g2OQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Amh9ZXwjBV4UEvgUfQ2ED52ctjKMN0tq+sG3zTtDntTsBMNneHFF0A0nsi4b6/0xE
         KzlZAC0RW5IribsWgjA0wS3/auY2VFwfoJihhX2RdyzArfxllIxV62Ku5zUxJh11fU
         3I3bRMKNnTvJEGpy7Ji/qRtwTm5xYDnmYcfb/0xJl2Docqj7Ns+aE3OrnKRrdMRsCJ
         fxFhAtUpJwIKp+r0+qFKZWkqXEJjLpXRDV8Zx3yLxX//EXTx0eeCpaT5CejqP12XB2
         gUjPkhSflmuOjbY7c12INCqa/U+pF0GxNvVCg85l4o7h3fmKfuvirCZN72t/0o77kq
         1+Pw7lSL7s2VA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/19 10:46 PM, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> Hi,
> 
> This uses the "save each field explicitly" approach that we discussed
> during the first review [1]. As in [1], this is motivated by a desire
> to clear the compiler warnings when building with gcc 9.
> 
> This is difficult to properly test. I've done a basic boot test, but
> if there are actually errors in which items get zeroed or not, I don't
> have a good test to uncover that.


Also, if anyone has advice about any extra testing I could run on this,
please send it my way.

thanks,
-- 
John Hubbard
NVIDIA

> 
> [1] https://lore.kernel.org/r/alpine.DEB.2.21.1907260036500.1791@nanos.tec.linutronix.de
> 
> John Hubbard (1):
>   x86/boot: save fields explicitly, zero out everything else
> 
>  arch/x86/include/asm/bootparam_utils.h | 62 +++++++++++++++++++-------
>  1 file changed, 47 insertions(+), 15 deletions(-)
> 
