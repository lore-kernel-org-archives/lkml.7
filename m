Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9447C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74ECF206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557176832;
	bh=kngKcG0bUGaMf92NeAkwqPXzJ5UrtJiCjolUeEgxLQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ggOGpzL4BQGVw7FUr/pYxenmP245EMDmp95mAIgIrH034B8DhWPELSGlbQ0Zl9CYh
	 ahBrEFIOUy6zc8gxDXSEnYiYr2xD+ztsWpYvWH2BTCQRvNqvS8+tEBmzHMi666P/rG
	 qkQ9j3AEmlFzpdPCaYzuLOWulpHtS+xdCauTR3QE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEFVHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfEFVHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:07:10 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B16BD20B7C
        for <linux-kernel@vger.kernel.org>; Mon,  6 May 2019 21:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557176829;
        bh=kngKcG0bUGaMf92NeAkwqPXzJ5UrtJiCjolUeEgxLQc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o0y5ir8H1CY7Ipt7sp7gymTPQAou0GiDAzNxsRijBixYy+0NkVF3ezVQBgKmBMl2U
         XRvv9nVEap/fGRISzJmGOjyPusQix60Yb3B0/QwtrsoIlYRxuhpKKQn/6FS0Kx37qZ
         g0YclD4nk2cKKqdRCc7Mwuj8STp4lRTJKQ/YIHo8=
Received: by mail-qt1-f178.google.com with SMTP id j6so16606239qtq.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:07:09 -0700 (PDT)
X-Gm-Message-State: APjAAAXj+3aRY7JkrY88SS42TLTI8FN9+D+iXYVOQs6DJ8xTusqVAmWP
        WlFWLAEG8FrUEYHARd/cpdsLeUMQFxYgSD1xpw==
X-Google-Smtp-Source: APXvYqwNVz7mnUf51sEJ7wG3mUwwc7LGqm7K3FI2/CEid07XSkDYGNvLZ8cIBgGTbxRZSZcZqzHueB4rC41DEbEpDiU=
X-Received: by 2002:aed:2471:: with SMTP id s46mr2725060qtc.144.1557176828957;
 Mon, 06 May 2019 14:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <76cbb7d3-bb91-4900-0275-a9b09fd7c77b@infradead.org>
In-Reply-To: <76cbb7d3-bb91-4900-0275-a9b09fd7c77b@infradead.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 May 2019 16:06:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLawPdSa-c_a7EE_uyu2Oc=xvJKf3NgcTywcm6AY0CQ9w@mail.gmail.com>
Message-ID: <CAL_JsqLawPdSa-c_a7EE_uyu2Oc=xvJKf3NgcTywcm6AY0CQ9w@mail.gmail.com>
Subject: Re: [PATCH -next] x86: olpc: fix section mismatch warning
To:     Randy Dunlap <rdunlap@infradead.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Lubomir

On Mon, May 6, 2019 at 2:31 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix section mismatch warning:
>
> WARNING: vmlinux.o(.text+0x36e00): Section mismatch in reference from the function olpc_dt_compatible_match() to the function .init.text:olpc_dt_getproperty()
> The function olpc_dt_compatible_match() references
> the function __init olpc_dt_getproperty().
> This is often because olpc_dt_compatible_match lacks a __init
> annotation or the annotation of olpc_dt_getproperty is wrong.
>
> All calls to olpc_dt_compatible_match() are from __init functions,
> so it can be marked __init also.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: x86@kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>

Fixes: a7a9bacb9a32 ("x86/platform/olpc: Use a correct version when
making up a battery node")
Acked-by: Rob Herring <robh@kernel.org>
