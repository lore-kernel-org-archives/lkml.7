Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF37C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E280D24C2B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQHXiLPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfFDKL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:11:27 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38747 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfFDKL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:11:27 -0400
Received: by mail-ua1-f66.google.com with SMTP id j2so3708050uaq.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 03:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vIAhQXsHJOyXhrVT0CHYLbhy05/J5RqxTMr2w2w4Y2I=;
        b=hQHXiLPx88stEsF25lRD9d1mmW3eRvX2gS3t/o9d8ANOAc2IwjY09NFrzx6Hq1JR3C
         uLW6K/95h+EHigfTJw4GCy+EEffjN5dnO5niUMWSyEwanSjMbSjOBOB+F2FRK8Hij7jS
         1TeJTMtqy+T1Hj9hbSsjWYWejx+wo/a7+PXHa1iVbw2Pni4jBXVki5eKzgwPXhIQetC3
         nvDcY84Z8Uc7b2YNs2AnLpIbgsz9GeUU3LmUF11IscqtaNC/6062Jz8HmnEklR1lBWRR
         zzFq/Aiho5kgbxIUDQFj+lzAJWMeUQha1g0f8bu7mtZCmCVxp7CTTA280jI9aOBiMm1O
         IRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vIAhQXsHJOyXhrVT0CHYLbhy05/J5RqxTMr2w2w4Y2I=;
        b=ZrzgNlEIes7LpjVD+/KQVdxScxQPCc9JDQcftChJzPEpCqZrjL/axra6htNTmnsr8C
         M1zHdD9k2pMtEuw9p0RLarYIlTvx8Bsvc/Vzxc9VWoz3PSzDW244GJ4X5vWYuNrqLXwf
         PApAY/p4gKAuuB+JOqZE1PesJz++GlJ29Xk1rkNLDzGS9gtRD/fycp2wjwrM82BNwAM9
         U/jnXKciln69jOjV3xqKoERwVnGqX+C+BEbS5dt2yLzMUnNmElwPtid+zNXMkjCKDJUk
         HbQlT20c9bDUvFC8PvdgeIslDMPtUbNHKvnzGEGMLSFsYpq/x4c/19vjUqyqM6hlBNnQ
         WCBQ==
X-Gm-Message-State: APjAAAVHky5Cfa3cusP9+bxojIRjIMfq1ihRhQxq9qgQxVLRb9TXO0Lr
        2OH21jgTGu+aOE/PMmRMABTtOacnhS9CXqnVcLnKig==
X-Google-Smtp-Source: APXvYqx2OahnUZixNsj1G0zgpQmMhnztq1ywvKQDB+AKOAvTww/7rf5gLsRm9dBCyMhNeCDtQYchFVgLSfXBphrWUE4=
X-Received: by 2002:ab0:16da:: with SMTP id g26mr8574345uaf.15.1559643085791;
 Tue, 04 Jun 2019 03:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190520143647.2503-1-narmstrong@baylibre.com>
 <CAPDyKFoOHnYiYogjogRr=7PBjqHOseDDS6L0eirTo7Y+F449ow@mail.gmail.com>
 <CAMuHMdWHnyTWMToXU_DSezwYs_Lkxj+v0BC8PKXHZgX=e1N3ww@mail.gmail.com>
 <b6e67d32-6092-4bdf-312d-7241094a9248@baylibre.com> <20190604090041.GB2855@kroah.com>
In-Reply-To: <20190604090041.GB2855@kroah.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Jun 2019 12:10:49 +0200
Message-ID: <CAPDyKFoAzf-K+ZoK0Kn7W8dH+1RHmRNjd91qZiO2am0whqexow@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: meson: update with SPDX Licence identifier
To:     Greg KH <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2019 at 11:00, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 04, 2019 at 10:52:51AM +0200, Neil Armstrong wrote:
> > Hi,
> >
> >
> > On 04/06/2019 10:36, Geert Uytterhoeven wrote:
> > > Hi Ulf, Neil,
> > >
> > > On Tue, May 28, 2019 at 10:53 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >> On Mon, 20 May 2019 at 16:36, Neil Armstrong <narmstrong@baylibre.com> wrote:
> > >>> Update the SPDX Licence identifier for the Amlogic MMC drivers.
> > >>>
> > >>> Neil Armstrong (2):
> > >>>   mmc: meson-gx-mmc: update with SPDX Licence identifier
> > >>>   mmc: meson-mx-sdio: update with SPDX Licence identifier
> > >>>
> > >>>  drivers/mmc/host/meson-gx-mmc.c  | 15 +--------------
> > >>>  drivers/mmc/host/meson-mx-sdio.c |  6 +-----
> > >>>  2 files changed, 2 insertions(+), 19 deletions(-)
> > >>
> > >> Applied for next, thanks!
> > >
> > > Please note this conflicts with commit 2874c5fd28426836 ("treewide:
> > > Replace GPLv2 boilerplate/reference with SPDX - rule 152") upstream,
> > > which added (different) tags.
> >
> > This happens when we are not CCed with such changes.
>
> No one was cc:ed on such huge changes.  The merge conflicts are trivial
> to work out, this should not be an issue.

No worries, I deal with it as I am going to rebase my tree on rc4 on
Monday anyway.

Thanks for the heads up!

Kind regards
Uffe
