Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC286C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70BC20645
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EaU2K1YQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfCDMHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:07:23 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34626 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCDMHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:07:22 -0500
Received: by mail-lj1-f194.google.com with SMTP id l5so4112499lje.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 04:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=at4ZF0j+vQkCFni4N26l3CmGY+lWq9dF5tMlQCCPPh8=;
        b=EaU2K1YQLAerwE2uX+DWTZLZS3087UpEMGoOh3Q6wCUE+EodlT5Aut8ajO4Nj9OobG
         eMcmw9hylpM8pwB0q235SSLfvOBJfU/CZxAtTI9sN+SuSUzRL9u86S8zpsiIWggBk6Aa
         PfZB+ZFzatO37ysOJj7k98NPXsdma6YwGonvx4Pi4PaHaD+Ls2uUqGFz3Jg2yl3lNNKR
         vS1M81nCnbtdP7dDkOcjbVvLJAFhycU8Rnb8tgBExNrDS+aO/c8e36XP8qt1vO+V8vJ+
         6F9Gncnwiett5THlp/AbGlOHmDsUhYY32H4nnezXX2+NFLY0s9bMonMWY2Y+VBh6xiqw
         kNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=at4ZF0j+vQkCFni4N26l3CmGY+lWq9dF5tMlQCCPPh8=;
        b=Ezq1+OrYe8j5S5xNAQnKN88nMWpCA1O2qAQCPUu0JViT5GR1+mxgKGebeTYpaImHi3
         d18vdlIKuEtKgkiuN/Xhq/S7DgjsLVSBwBxRYQ1IbBSSKMhPFgO/0PuCDJiapUseKTn1
         +/Jj1oydwp1F4Y46Equ+Xvfdk5T7sX6dbls7B/kYHoVTeXuvxD8tbI2gjbUHf9wuthH0
         TyyDdk5KGsDQv+vWekcEXFdhrZ7Rs4IDFSvXvNRnA46QMBEEXaVUGGUtp1d02TNlpvBw
         dIn8HShhIK20boEtSm2iBrPOBtDQS9CPjepTYRDyJoL0gIElQMuUuWxMJziArSKYZgoz
         7gGQ==
X-Gm-Message-State: APjAAAVz3nMTWUeLW3PAw1+L/rOWOD7bBHRCeovxr27H0/Pwn2LfISub
        7i9G8LN3wcvb8HIoDsMbOTR2nm3H+0u26WiwaW+l/EI2
X-Google-Smtp-Source: APXvYqy6gjedxOnXAsinq7Ytrx4l/odOLshf9UZnnLXJyb3HV+Bl8BcVeDbhRlbz8krHT3XdnT2XNrWo85hSd6RD9/4=
X-Received: by 2002:a2e:2ce:: with SMTP id y75mr10106341lje.126.1551701240486;
 Mon, 04 Mar 2019 04:07:20 -0800 (PST)
MIME-Version: 1.0
References: <20190301035852.26780-1-marek.behun@nic.cz> <20190301035852.26780-4-marek.behun@nic.cz>
 <CACRpkdam_CYGtph16McpQQ_WwohpZr+Rzi1B=re4UrGxXmSEqg@mail.gmail.com> <20190301161510.20b15183@nic.cz>
In-Reply-To: <20190301161510.20b15183@nic.cz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Mar 2019 13:07:09 +0100
Message-ID: <CACRpkdb0Bv1iwtd61GUQLU25nAKrfk-VS0PGKTYh_LoyjYWHFg@mail.gmail.com>
Subject: Re: [PATCH v3 bus+gpio 3/5] bus: moxtet: Add sysfs documentation
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 4:15 PM Marek Behun <marek.behun@nic.cz> wrote:

> On Fri, 1 Mar 2019 15:34:26 +0100
> Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > > +What:          /sys/bus/moxtet/devices/moxtet-<name>.<addr>/output_v=
alue
> > > +Date:          March 2019
> > > +KernelVersion: 5.2
> > > +Contact:       Marek Beh=C3=BAn <marek.behun@nic.cz>
> > > +Description:   (RW) Read last written value or write value to the
> > > module on
> > > +               this Moxtet address. Format: %x
> >
> > What is the usecase for these?
> >
> > If this is for debugging it should be in debugfs rather than in sysfs.
> >
> > If it is here for random userspace drivers, we need some good
> > explanation as to why they can't just be kernel drivers.
>
> Hmm, it was for debugging purposes but the ability to write there is
> not needed anymore... Shall I make it read/only? Or completely remove
> it?

I would either remove it or move it to debugfs.

Yours,
Linus Walleij
