Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C565DC282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4563920880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4waNxVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfDHHAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:00:04 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33904 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfDHHAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:00:03 -0400
Received: by mail-it1-f194.google.com with SMTP id z17so16380294itc.1;
        Mon, 08 Apr 2019 00:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qT5pxTyuNs8w0lZPrSv8Oq5hASC4Y1C3aUkHEx/B2k=;
        b=U4waNxVuW9vZ4uCBf8Yv7wz5us/Cpk7bBg2XXY+bJEAxKSKqmcT2kT2U7obksWvWTL
         faByY8lVSWdDCgh1hTrwF15SJL2YRjAy0ZhDq5LYY3IVvBk4r3zpH+lArLNtk1ePLZMp
         7xpnoceVxNIf585i0H2xVGYAMGK5lzgozO/ygMeUx0b4Fv7LVD5WaFpiLjaUppTTvpd7
         WVTiRLIPmJ/Ym3S1kQg6loMsBcNwNxvsHcF263WA4WgNa96lHRDOmTPTdeVwBx6/TAzz
         mTxKP1fw6pMqDQXnKLXbPWIRdHaofFXBbnUlfch0u4sM4SVUjlAnd/w8R5n/7g3QpPF4
         tY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qT5pxTyuNs8w0lZPrSv8Oq5hASC4Y1C3aUkHEx/B2k=;
        b=BIeYNPjnzQWcZcEosEwSGTecNuiheK+kobu3yg7TICYPWDNJDasI1Vky2+/3UvynW4
         DHNgxg+2XVpqZPQzzwT7FWfy0M4Y98K2ijt1AMDCRMIcm7K5mRYaEGsZeRe0A5SlRmwp
         4eph8eF7FkXfz/BE1S4+rAH0g5MUa6gyLNVrSxotMMLy/ipzQmU8muB4QcpUgAaI/vMr
         qxymkzF5ec8Dya4z09V5ZwRX5jRgJpeg0QHczW0zb+soTVEEzJv9531xRr91+1/RVs/Y
         g75I5ecO19YvS+f3hMoO0j+SPdHQek/TJKyytxIiKqgvj7oSIjSvg7KKY8GvF4XDQGRu
         3Vlw==
X-Gm-Message-State: APjAAAXyBpWkC7yswRGPQORcX7ldgF8ayXv+xxus6GEDBdX03h0llNpS
        A9AvuG/sfuD80vvyvQrakPlGm2d+u2YSDbIRrUYNGfVH
X-Google-Smtp-Source: APXvYqw5P3pf7ut3sGPHKFs34jg+Lu8rl4RCdnmtCJZjdDntOYEa/H86SWw1sCBLlz/3v8/DR4XCvTZjsTUkYDYc5+E=
X-Received: by 2002:a02:4345:: with SMTP id s66mr8152130jab.46.1554706802731;
 Mon, 08 Apr 2019 00:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <CADBGO7_WUoA53gM8EDFy6Q36SDEZPU9V=OUBA0QM20FOko51Rg@mail.gmail.com>
 <CADBGO7-UkQMxSPdSX9bGVPxSRROj75FA16FuXeFrVmcKVQ_Qdg@mail.gmail.com>
 <CADBGO7_XnbXiWHB=O1B_+b+CUA9g-bYJHN37VJ2SsxXMNHcPOQ@mail.gmail.com>
 <20190321134140.GA4603@linux.intel.com> <31f75727-d2c3-1afa-ab14-1dbc62a6315b@ginzinger.com>
In-Reply-To: <31f75727-d2c3-1afa-ab14-1dbc62a6315b@ginzinger.com>
From:   Paul Zimmerman <pauldzim@gmail.com>
Date:   Sun, 7 Apr 2019 23:59:36 -0700
Message-ID: <CADBGO789BkFxwsuybwOvL3ydYP075U6KDccGnC7pfSJ_grfcng@mail.gmail.com>
Subject: Re: Regression in suspend-to-ram (TPM related) with 5.1-rc1 (BISECTED)
To:     Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 10:53 PM Martin Kepplinger
<martin.kepplinger@ginzinger.com> wrote:
>
> On 21.03.19 14:41, Jarkko Sakkinen wrote:
> > On Tue, Mar 19, 2019 at 04:03:37PM -0700, Paul Zimmerman wrote:
> >> So I bisected this down to:
> >>
> >> # first bad commit: [a3fbfae82b4cb3ff9928e29f34c64d0507cad874] tpm:
> >> take TPM chip power gating out of tpm_transmit()
> >>
> >> but this doesn't revert cleanly on Linus' HEAD. Anyone have an idea what
> >> could be wrong here?
> >
> > Sorry I've been in flu for the early week. I spotted the bug
> > immediately.  When I did these patches I did not have TPM 1.x at my
> > hand. I used fTPM 2.0 and dTPM 2.0. Stefan did TPM 1.x testing but I
> > probably forgot to ask him to try out suspend.
> >
> > Anyway, the bug is obvious and I'll send you a patch to try out.
> > Thanks a lot for bisecting this!
> >
> > /Jarkko
>
> Hi,
>
> Any news on this? It seems not to be fixed in -rc4. I'd happily test a
> patch too.
>
Hi Martin,
Patch is here: https://patchwork.kernel.org/patch/10865495/
Don't know what the status of it is though.

-- Paul
