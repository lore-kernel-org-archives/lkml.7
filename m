Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CAEC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2043F21985
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfGVPVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:21:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41495 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbfGVPVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:21:47 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so38826046qtj.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pbrm6P8ozZzKpm0OxCMGSgZScoFWEg9X0MRg7kLdedQ=;
        b=o1dUUvvH1Tvjkbwnw+c7069ZRaTeqX4mD5A4lwSmtE5NkBjHrng05g+6PD0/PpnVlp
         rUfEN5pyT3+GPN6yc4HN4gZ1yDPJWAixwJt+aViTvyzRtApDMLQCxmBEQ38VAZjGxqhl
         U0yxpj/Hr8uyQuSkOeT30vOcubIA2Mihvfhq3fx7hZOKlVoRu5O9Y8FKAFOLrI7MiOj3
         vvcjLsAXcPPreA90XzcpUhctiwGKQEUmw9ULtPgIbGwHRP3M/0/wQofo5hd0MuBRaSfl
         MPdmVNaJKNTeBZCpHKDHxskBzZPIfQBJDv4X0EN5mNR6fbkSR7BfjxTNRSGWB3faq5WK
         CNSg==
X-Gm-Message-State: APjAAAXcYk6kTX8IXK4u4JMggkbZ2KTg0ypFkJp65SbwieyXNRXl9F57
        0gXLjNPL94D1ugUr2BI9Qm6s5ZYsrHy5BgLloKk=
X-Google-Smtp-Source: APXvYqxnPuowWMhrH6V+M7Ik6Aa9HM1kt0ksL4QItNC2I5iXYgej2trlQTdipljpGNH2ToxnNvKCkOD0h/aIs9Ld1Ac=
X-Received: by 2002:ac8:f99:: with SMTP id b25mr43173538qtk.142.1563808906647;
 Mon, 22 Jul 2019 08:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190721142308.30306-1-yamada.masahiro@socionext.com>
 <de9e94ee-9c01-1c0c-4359-b637319a298f@linux.intel.com> <s5hftmy8byl.wl-tiwai@suse.de>
 <ec306745-052d-f52c-2cce-d8915822d4ff@linux.intel.com> <CAK8P3a2tLuqu+upt0nW8dUzXc+t_kEJwVhLcqY8TXydHLb_nCw@mail.gmail.com>
 <9a56ccdb-397b-3046-4043-49bc20aaa804@linux.intel.com>
In-Reply-To: <9a56ccdb-397b-3046-4043-49bc20aaa804@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Jul 2019 17:21:30 +0200
Message-ID: <CAK8P3a29JcyMOfGGSpRCyeS913BSGn5bJT_pZ9e-K3Ds1E0UHw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: use __u32 instead of uint32_t in
 uapi headers
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 5:18 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 7/22/19 8:34 AM, Arnd Bergmann wrote:
> > On Mon, Jul 22, 2019 at 3:16 PM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> >> On 7/22/19 7:56 AM, Takashi Iwai wrote:
> >>> On Mon, 22 Jul 2019 14:49:34 +0200,
> >> Our goal is to minimize the differences and allow deltas e.g. for
> >> license or comments. We could add a definition for __u32 when linux is
> >> not used, I am just not sure if these two files really fall in the UAPI
> >> category and if the checks make sense.
> >
> > If you can build all the SOF user space without these headers being
> > installed to /usr/include/sound/sof/, you can move them from
> > include/uapi/sound/sof to include/sounds/sof and leave the types
> > unchanged.
>
> yes we don't need those files to build userspace stuff. The idea was
> that these format definitions establish a contract between userspace
> (more specifically the files stored in /lib/firmware) and the kernel.
> IIRC we wanted to make sure that any changes would be tracked as
> breaking userspace. If the consensus is that the uapi directory is
> strictly used for builds then we should indeed move those files

I don't see a problem with keeping the files in uapi for practical
purposes, but then I think it makes sense to apply the same rules as
for other uapi headers and use user-space clean type names.

       Arnd
