Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F259C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B522146E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKfeUFTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfDZROW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:14:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36740 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfDZROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:14:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id w20so1253385plq.3;
        Fri, 26 Apr 2019 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LHCpKaf1HvEGUJaGSpEOfNmTdAWfOcSX4L5+FbvjD6E=;
        b=NKfeUFTz2R9OzWUt0WTxUof164iZWtirIRGaO3BReaDqC80KZNdnOWD0xjceDYytZW
         qjljCmBUEKCqegdrALANno9IrJ7tW+f89DK8kodLgEOkAERLxBHZOFoqueFNqO48yWE6
         npT6MyMX/5tkH6ma/pBRD0m4LYprvw/kR70ih5tIR92yidh1t4gPm5JFk5RSWSMcSY3Y
         W9jYj62H79O5o3P+cDorYAt7tsbfDThae+MAX4OFZ3qaCrNSyPM8NozEdDILy2HfRFWg
         rRXGzmN2IEmg71YkB3uTmRKmbcl9JZW0hTlFm1meYzjFxBXz15AoowBbhezIUeskapTu
         V1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LHCpKaf1HvEGUJaGSpEOfNmTdAWfOcSX4L5+FbvjD6E=;
        b=gVWHuHt2gTmN6cGgE2BWoPtmoNNjpdtgIiQOIGODvGIyc02DUS/E2kJJTfMbd2vwc9
         LH4teUdDBUg5BVh+1Mya24nWZ/560bk1Fo9h5AwAk8N7oHiIJFM7EdxVKgqV2Ts0DQtb
         01E0WAiqj5Uo9opjD9NGXK3CFLKj/DJP8MsepIh55jYbbwSYAcF5fmOnceUVqdd+H1Hr
         3nJqrKHH/7vb4eQ3ed2sKw/hf4gq3buGKVylDLk+up8sNrq8Gv63dfBAKOOCyZDrax+7
         1gFaaBrQC8geImRc08b87fTu9sym/hDO4b2ZcE7CKnmx4yNxqmENMMUJxCgwfl/rws37
         XeHg==
X-Gm-Message-State: APjAAAXxEze6uBEEEgr3gyie0i9bZOGCQrA9z3DHSIth2+xtf2769MQr
        s4SjydOoXuYyQM7rN1qob+DmB/B6/ErPbWgDGE0=
X-Google-Smtp-Source: APXvYqzIkq2jSG6TFvKJAwcS+e1ccNQJbud9ioIQcPdt33YTTp1tQeE/EJq8l8lm7tI7OZ7MSy1sd+PxMiRaSbqIgZc=
X-Received: by 2002:a17:902:7885:: with SMTP id q5mr47383590pll.12.1556298860193;
 Fri, 26 Apr 2019 10:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <5a547510-2605-bae5-bd58-ab4aff28840d@siemens.com>
 <CAHp75VddTO890=DMa8pQANBGMMaDtCGgVb_cxCHc_Y1hxNTHwg@mail.gmail.com>
 <28d2856b-7fe5-1b42-e1bc-1c3601265dd2@siemens.com> <CAHp75VcENChz5BvZn9YdT3-rBZq4U9dkF-OtVm2rYprvpqXG6A@mail.gmail.com>
In-Reply-To: <CAHp75VcENChz5BvZn9YdT3-rBZq4U9dkF-OtVm2rYprvpqXG6A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Apr 2019 20:14:09 +0300
Message-ID: <CAHp75VdX2vS6GnepDqNw0qc-6FWdKF63aLK-2Hm3rKX0CP_ADw@mail.gmail.com>
Subject: Re: [PATCH] stmmac: pci: Adjust IOT2000 matching
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        David Miller <davem@davemloft.net>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Su Bao Cheng <baocheng.su@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 8:13 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Apr 26, 2019 at 6:36 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > On 26.04.19 16:34, Andy Shevchenko wrote:
> > > On Thu, Apr 18, 2019 at 12:15 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> > >> +       /*
> > >
> > >> +        * There are 2 types of SIMATIC IOT2000: IOT20202 and IOT2040.
> > >
> > > 20202 ?
> >
> > 2020...
> >
> > I can send a fix-up or v2, whatever is preferred.
>
> My understanding that if Dave applied, you need to send a fixup.

s/Dave/David/
Sorry.

-- 
With Best Regards,
Andy Shevchenko
