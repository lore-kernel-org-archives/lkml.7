Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7653C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37A823F94
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cewzcBd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfFCQYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:24:55 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:46788 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727162AbfFCQYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:24:54 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CF72AC2124;
        Mon,  3 Jun 2019 16:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559579074; bh=JX+elEHAI7MoI1Kj6PhDcFRioomBwhgwjAEA09vtnIg=;
        h=From:To:CC:Subject:Date:References:From;
        b=cewzcBd3vYNCfDC3IhKlsGl2ELoWAKv8GHqe4/WXW/yiEuN8pwH2OZUTGi2TMEHwf
         9KMaMKjgt3MCVQ4zpaFkYE3YBK6o0WXALP+vdfaaPBdmdcyuHwNFCYbVKsbEba/8Zt
         kT93PPT9bOHPGzER8qLfuE4N41BpuMs0yXUp/g4Lknp5hRtwreAOyfp0fgXIQNshiw
         cfZi98+4IDMJwGEuQUwnPjmXUS8lW6Hfu4mls7Y+Vtmqs3TOrliVS7bGfgGCvN0IIA
         rKwf9ai8hA4F64MmFEo8UJCF2v2lBL5+7AIesFyqcDdo9tlxfKFDQ/ZjIxDnqxKBP+
         BcGxQw2xGBo/w==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 36BD3A0079;
        Mon,  3 Jun 2019 16:24:51 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.22]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon, 3
 Jun 2019 09:24:50 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Masahiro Yamada" <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] ARC: build: Try to guess CROSS_COMPILE with
 cc-cross-prefix
Thread-Topic: [PATCH] ARC: build: Try to guess CROSS_COMPILE with
 cc-cross-prefix
Thread-Index: AQHVGdX4wIpfF+K0XEmKZYQZNUp5WA==
Date:   Mon, 3 Jun 2019 16:24:49 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A2522AB4@us01wembx1.internal.synopsys.com>
References: <20190603063119.36544-1-abrodkin@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/19 11:31 PM, Alexey Brodkin wrote:=0A=
> For a long time we used to hard-code CROSS_COMPILE prefix=0A=
> for ARC until it started to cause problems, so we decided to=0A=
> solely rely on CROSS_COMPILE externally set by a user:=0A=
> commit 40660f1fcee8 ("ARC: build: Don't set CROSS_COMPILE in arch's Makef=
ile").=0A=
>=0A=
> While it works perfectly fine for build-systems where the prefix=0A=
> gets defined anyways for us human beings it's quite an annoying=0A=
> requirement especially given most of time the same one prefix=0A=
> "arc-linux-" is all what we need.=0A=
>=0A=
> It looks like finally we're getting the best of both worlds:=0A=
>  1. W/o cross-toolchain we still may install headers, build .dtb etc=0A=
>  2. W/ cross-toolchain get the kerne built with only ARCH=3Darc=0A=
>=0A=
> Inspired by [1] & [2].=0A=
>=0A=
> [1] http://lists.infradead.org/pipermail/linux-snps-arc/2019-May/005788.h=
tml=0A=
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dfc2b47b55f17=0A=
>=0A=
> A side note: even though "cc-cross-prefix" does its job it pollutes=0A=
> console with output of "which" for all the prefixes it didn't manage to f=
ind=0A=
> a matching cross-compiler for like that:=0A=
> | # ARCH=3Darc make defconfig=0A=
> | which: no arceb-linux-gcc in (~/.local/bin:~/bin:/usr/bin:/usr/sbin)=0A=
> | *** Default configuration is based on 'nsim_hs_defconfig'=0A=
>=0A=
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>=0A=
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>=0A=
> Cc: Vineet Gupta <vgupta@synopsys.com>=0A=
=0A=
Not a big deal but I'd propose we add "Suggested-by: vgupta" since that is =
where=0A=
it came from.=0A=
=0A=
@Masahiro san I suppose you are OK with this, so perhaps an Ack etc would b=
e nice=0A=
to have.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
=0A=
> ---=0A=
>  arch/arc/Makefile | 4 ++++=0A=
>  1 file changed, 4 insertions(+)=0A=
>=0A=
> diff --git a/arch/arc/Makefile b/arch/arc/Makefile=0A=
> index e2b991f75bc5..9cfd2ba7a12d 100644=0A=
> --- a/arch/arc/Makefile=0A=
> +++ b/arch/arc/Makefile=0A=
> @@ -8,6 +8,10 @@=0A=
>  =0A=
>  KBUILD_DEFCONFIG :=3D nsim_hs_defconfig=0A=
>  =0A=
> +ifeq ($(CROSS_COMPILE),)=0A=
> +CROSS_COMPILE :=3D $(call cc-cross-prefix, arc-linux- arceb-linux-)=0A=
> +endif=0A=
> +=0A=
>  cflags-y	+=3D -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__=
=0A=
>  cflags-$(CONFIG_ISA_ARCOMPACT)	+=3D -mA7=0A=
>  cflags-$(CONFIG_ISA_ARCV2)	+=3D -mcpu=3Dhs38=0A=
=0A=
