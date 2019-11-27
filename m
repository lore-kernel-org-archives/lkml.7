Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D73BC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306E02080F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="vThlKJNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbfK0V0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:26:21 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39051 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfK0V0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:26:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id a67so2655471oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 13:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvIzR24kHBea1uxOpKKhJOT4jJB8qq3HQYSkFgo3U3E=;
        b=vThlKJNpDRPL9EvkUMfozZ8dvzrN+pb71NRt9M+FbIHb/Xz+9FcrMIu4yHm1PEauZa
         I8eA2C10V6PS8qQEX8q22qTBiZ2eac763UwVTnYdKf3iE8vNrP914cHwDmWr0JuiusFq
         VI+Ps4ttc9N082Q70yjK9ZE2HHyAXYmKHiwGC2sU7GZXpTEAp/J6vH7eZJBJ7ppr+x3M
         ufcUicdg/5jdYNyBDasulrzj0g8Xf9nTla0fm1rVwJO0cRZ8Gq8O3MwocCqwAymu3E6V
         FTgEkxA9Uhq59tv2287Qz+s4W8TZdwaDOTg4LnJhfFfIPK+Puei6JaW0O2gb+x5eAI9V
         YAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvIzR24kHBea1uxOpKKhJOT4jJB8qq3HQYSkFgo3U3E=;
        b=pPirV9d6qzan26p7Vjw7HPLWmaoydG17YMvakNe/y159scVJzjQt3cSyM+C936Pijm
         elSXv2unssiC/9ZEH2NvyyzlCqOiiJqhA8kjdHi2bnv9B92egd/VJ1AAI0GKXP9QKY3c
         Zh/BUZB5FU2ZtQDPGEk52pxlQBl1CNLNabLU/jZJgTHvPT20pRMGu+Im7xfrbod/kB9W
         P+batyh2/xlsYFHwWx1TC5qZruwAI1XygA7FHWYEJSdB7Mb1AszbLZQWuz74KJtwtwsq
         WIqbVCEa1WGDgRiNm+4pZi4hil8RnrE7019foTX+xva5mZ3OblqWlJat/DTsWGLlA50o
         xIlg==
X-Gm-Message-State: APjAAAXJ09YISOsGhZJMKoMO9zjJAq+jS86IpJQfzU+3aMg+l37By71F
        KOHt4SsAcA2grTgop1ckUvInnWkEzFbIuIdW9iGSow==
X-Google-Smtp-Source: APXvYqzjfv3uRACCOCg93jfSkR/I+DVeAiPls/NFEqGCYZ38KdgrJFBtLtMlmlxnWDacs2YcTvlXPCF13m2/1pu3CJ0=
X-Received: by 2002:a05:6808:20c:: with SMTP id l12mr1738564oie.105.1574889978465;
 Wed, 27 Nov 2019 13:26:18 -0800 (PST)
MIME-Version: 1.0
References: <20191112202725.3009814-1-stefanb@linux.vnet.ibm.com>
 <20191114164151.GB9528@linux.intel.com> <20191114164426.GC9528@linux.intel.com>
 <185664a9-58f2-2a4b-4e6b-8d7750a35690@linux.ibm.com> <20191121184949.yvw2gwzlkhjzko64@cantor>
 <20191127211109.GF14290@linux.intel.com>
In-Reply-To: <20191127211109.GF14290@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 Nov 2019 13:26:07 -0800
Message-ID: <CAPcyv4gO2T4xcZjYSYJ8-0kDPRnVYWhX_df5E94Cjyksx6WFbg@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis: Move setting of TPM_CHIP_FLAG_IRQ into tpm_tis_probe_irq_single
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, jsnitsel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Jerry ]

On Wed, Nov 27, 2019 at 1:11 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Nov 21, 2019 at 11:49:49AM -0700, Jerry Snitselaar wrote:
> > On Sat Nov 16 19, Stefan Berger wrote:
> > > On 11/14/19 11:44 AM, Jarkko Sakkinen wrote:
> > > > On Thu, Nov 14, 2019 at 06:41:51PM +0200, Jarkko Sakkinen wrote:
> > > > > On Tue, Nov 12, 2019 at 03:27:25PM -0500, Stefan Berger wrote:
> > > > > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > > > >
> > > > > > Move the setting of the TPM_CHIP_FLAG_IRQ for irq probing into
> > > > > > tpm_tis_probe_irq_single before calling tpm_tis_gen_interrupt.
> > > > > > This move handles error conditions better that may arise if anything
> > > > > > before fails in tpm_tis_probe_irq_single.
> > > > > >
> > > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > > Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > > What about just changing the condition?
> > > > Also cannot take this since it is not a bug (no fixes tag).
> > >
> > > I'll repost but will wait until Jerry has tested it on that machine.
> > >
> > >    Stefan
> > >
> > >
> > > >
> > > > /Jarkko
> > >
> > >
> >
> > It appears they still have the problem. I'm still waiting on logistics
> > to send me a system to debug.
>
> Which hardware is guaranteed to ignite this? I can try to get test hw
> for this from somewhere. Kind of looking into this blinded ATM. Dan?

Jerry had mentioned that this was also occurring on T490s. Otherwise
I'll ping you offline about the system I saw this on internally.
