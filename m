Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D742C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBF12075D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553539772;
	bh=g0w3mA1lmQUz6jMdNxASe9eG/8dSKleEMARwjag5xvo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xBvH12FveWPtvq8oG9ArZykZimdsn85NXZTTJqC23dRtiJe6Lp6U4LsrK7Xr7Qf+1
	 aJWEfa77+sctgxSaitK04qj4zGL69JICip9XJFsvQFLIDTNAbmy6YIu2Rto64rgkB8
	 p+60DniukFVrzC/csmdbwm3HBoEKYRlfv2raCKLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfCYStb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbfCYStb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:49:31 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E48A42075D;
        Mon, 25 Mar 2019 18:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553539770;
        bh=g0w3mA1lmQUz6jMdNxASe9eG/8dSKleEMARwjag5xvo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L2Ghg82bgwQYfYVG/miLGmzVpSH30VtMnzS6wd8BwOZng85fMylAY9xRz6+lIBJJ9
         1b6yS2kPZomJnsMNe5WZ47zDKh77UBecdYOYjyr+xDOqi8bo4E+Ot4DeO1vHZc+R8w
         DCabNt/HpYRVno2Z3wWZ1v8ALr698hX64aC7/hxU=
Received: by mail-ed1-f45.google.com with SMTP id v21so8503372edq.4;
        Mon, 25 Mar 2019 11:49:29 -0700 (PDT)
X-Gm-Message-State: APjAAAVGhfCYPIOJI82tNqZmDFgWRkclaXJb2zAneM91UyaxuSWL5yxV
        U1PGI6C6elTr4yh0weofJdkjIvclQ1eMvmELwTI=
X-Google-Smtp-Source: APXvYqwuUeOjq/5HjqHOU4aAiolpMWPbPzjpb/OsZNI75PR9jP8zOHO4krKy5tl/VZSxbsD/QmoT/8mflnlNqm4YRh0=
X-Received: by 2002:a17:906:3db1:: with SMTP id y17mr14773290ejh.90.1553539768531;
 Mon, 25 Mar 2019 11:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com> <1553483264-5379-4-git-send-email-hao.wu@intel.com>
In-Reply-To: <1553483264-5379-4-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 25 Mar 2019 13:48:52 -0500
X-Gmail-Original-Message-ID: <CANk1AXTCbR3E=WFUvyHx3BDFwV19djuhC=qBpxQHT46qGgwWJA@mail.gmail.com>
Message-ID: <CANk1AXTCbR3E=WFUvyHx3BDFwV19djuhC=qBpxQHT46qGgwWJA@mail.gmail.com>
Subject: Re: [PATCH 03/17] fpga: dfl: fme: support 512bit data width PR
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 10:23 PM Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

This looks fine.

>
> In early partial reconfiguration private feature, it only
> supports 32bit data width when writing data to hardware for
> PR. 512bit data width PR support is an important optimization
> for some specific solutions (e.g. XEON with FPGA integrated),
> it allows driver to use AVX512 instruction to improve the
> performance of partial reconfiguration. e.g. programming one
> 100MB bitstream image via this 512bit data width PR hardware
> only takes ~300ms, but 32bit revision requires ~3s per test
> result.
>
> Please note now this optimization is only done on revision 2
> of this PR private feature which is only used in integrated
> solution that AVX512 is always supported.
>
> Signed-off-by: Ananda Ravuri <ananda.ravuri@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Alan Tull <atull@kernel.org>
