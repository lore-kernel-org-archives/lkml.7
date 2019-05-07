Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957D3C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710F520989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfEGHus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 03:50:48 -0400
Received: from shell.v3.sk ([90.176.6.54]:34514 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbfEGHus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:50:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 351B5103E1A;
        Tue,  7 May 2019 09:50:44 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nohfolaQftHQ; Tue,  7 May 2019 09:50:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9D22B103E16;
        Tue,  7 May 2019 09:50:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ytnwLJcCxEiL; Tue,  7 May 2019 09:50:37 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 73CFA103D8C;
        Tue,  7 May 2019 09:50:37 +0200 (CEST)
Message-ID: <a99e0316d831dcf0c81060fb977f7147704b6742.camel@v3.sk>
Subject: Re: [PATCH -next] x86: olpc: fix section mismatch warning
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Date:   Tue, 07 May 2019 09:50:35 +0200
In-Reply-To: <CAL_JsqLawPdSa-c_a7EE_uyu2Oc=xvJKf3NgcTywcm6AY0CQ9w@mail.gmail.com>
References: <76cbb7d3-bb91-4900-0275-a9b09fd7c77b@infradead.org>
         <CAL_JsqLawPdSa-c_a7EE_uyu2Oc=xvJKf3NgcTywcm6AY0CQ9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-06 at 16:06 -0500, Rob Herring wrote:
> +Lubomir
> 
> On Mon, May 6, 2019 at 2:31 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Fix section mismatch warning:
> > 
> > WARNING: vmlinux.o(.text+0x36e00): Section mismatch in reference from the function olpc_dt_compatible_match() to the function .init.text:olpc_dt_getproperty()
> > The function olpc_dt_compatible_match() references
> > the function __init olpc_dt_getproperty().
> > This is often because olpc_dt_compatible_match lacks a __init
> > annotation or the annotation of olpc_dt_getproperty is wrong.
> > 
> > All calls to olpc_dt_compatible_match() are from __init functions,
> > so it can be marked __init also.
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: x86@kernel.org
> > Cc: Rob Herring <robh+dt@kernel.org>
> 
> Fixes: a7a9bacb9a32 ("x86/platform/olpc: Use a correct version when
> making up a battery node")
> Acked-by: Rob Herring <robh@kernel.org>

Thanks for this. Which tree does this apply to? I can't see the patch
that introduce the problem in x86's for-next? I've a mostly equivalent
patch lined up with an intent to send it over to x86 once the faulty
commit reaches it:

https://lists.01.org/pipermail/kbuild-all/2019-April/060269.html

In any case;

Reviewed-by: Lubomir Rintel <lkundrak@v3.sk>

> -int olpc_dt_compatible_match(phandle node, const char *compat)
> +int __init olpc_dt_compatible_match(phandle node, const char *compat)

My patch also marks olpc_dt_compatible_match() static. It should still
be done if this one ends up being applied.

Lubo

