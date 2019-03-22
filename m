Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A69C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D1B20811
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfCVT4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:56:46 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45908 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfCVT4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:56:45 -0400
Received: by mail-qk1-f195.google.com with SMTP id z76so1938370qkb.12;
        Fri, 22 Mar 2019 12:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SgPDu1W3M8SKQ3QP43fukwgAnX3JsjWjoGGwg1Zmx9Y=;
        b=ALJyiB++amhZQl87Zb8hXu+v83bP6Qzo22KCctA7odljhUqLJN8rjas6m4nIkoKfT3
         VprFXp0BcJ9/Lb4bpXF7hAEbtf5DoseflH2zdHxaXKGMzVZSXE7ARYOU60bOrUTXNSDx
         dL4mtCg0zbNu5vGPgzn2OzLKYVPU3JSkJgy4DGivtH5d8jr6RGjLKE6Bf9S+przlSUmi
         AgM2CO5AjgadatN41NN5+Rl61D14akYe35e/MW7EOGePfopTS0TXic/leX/c8oG4odYC
         9eGzOdO5iCdPTirOG1NM8aA7YmBDaH2kEtVBtXEG/Gt6fj9ELUU7t7e7qVJ9H4Xwqwjs
         iBqg==
X-Gm-Message-State: APjAAAUoQ+Hb5TptuVZrtMN1Phce0PVoPL0WQD8gp15sfOxysIM+IMkQ
        0qR7CU26IdklSEOM7mu5gSq/CSwYO8ZKHDyQ/dKxwQ==
X-Google-Smtp-Source: APXvYqz4E94WAS88CIDx8yvyXdRmjkQmaT8bPk6eaFLcNb2/4m03HiPpMk9tzptv5TIkCF94les2av8IzmyS817jpPs=
X-Received: by 2002:a37:aa58:: with SMTP id t85mr9238770qke.291.1553284604723;
 Fri, 22 Mar 2019 12:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190314215952.GA303@agluck-desk> <20190315094341.GA12523@zn.tnic>
 <20190315155718.GA17775@agluck-desk> <20190315173720.GC12523@zn.tnic>
 <20190315174956.GA20831@agluck-desk> <20190315180206.GD12523@zn.tnic>
 <20190315181108.GA21111@agluck-desk> <CAK8P3a2CFyF5wExbZPb20E56sJ=3DpsP+0m2Px6D5Sw_L3pKXA@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7D53BD42@ORSMSX110.amr.corp.intel.com>
 <CAK8P3a0WjUi+mBZ0nO2FFFCRvy5mA10frZMAaXisGWOs4pnPCA@mail.gmail.com> <20190322175504.GA11213@agluck-desk>
In-Reply-To: <20190322175504.GA11213@agluck-desk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Mar 2019 20:56:27 +0100
Message-ID: <CAK8P3a1gOzvWmkupO_5Lhfm17OPkV9FVoSO0qDboms=QRB+4ag@mail.gmail.com>
Subject: Re: [PATCH] EDAC, {skx|i10nm}_edac: Fix randconfig build error
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 6:55 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Fri, Mar 22, 2019 at 03:00:25PM +0100, Arnd Bergmann wrote:
> > Sorry, this was my mistake, my email was garbled. The patch was
> > correct though: the idea here is not to change the Kconfig symbols
> > but to change the Makefile to do the right thing even when Kconfig
> > is set wrong.
>
> Well this does seem like a "clever" way out of the randconfig
> problem.  New patch applies and when I set .config to have:
>
> CONFIG_EDAC_DEBUG=y
> CONFIG_EDAC_SKX=y
> CONFIG_EDAC_I10NM=m
> CONFIG_EDAC_SKX_COMMON=y
>
> I don't see any build errors.
>
> There are lots of "skx_" symbols in System.map
>
> But I'm not at all sure what happened to the I10NM driver.
>
> I don't see it mentioned in the output from "make".
>
> It didn't get built as a module (no ".ko" file for it).
>
> It doesn't seem to be built in (no ".o" in drivers/edac/built-in.a)
>
> So I added a #error line to the start of i10nm_edac.c and
> ran "make" again.  Nothing.

Oops, I guess my testing method was also insufficient,
I only checked that the bug was gone, not that it actually
worked.

> So, I don't think this is doing what you think it should
> do.  Even if it did, it would seem very confusing to a user
> that asked for "one module, one built-in" in Kconfig, but
> found both built-in.
>
> Boris: I'm voting for Qiuxu's most recent solution (moving
> all the EDAC_DEBUG bits out of skx_common.c).

Yes, that's probably best then. My patch was likely close to
another correct solution, but I've screwed it up twice now ;-)

     Arnd
