Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625B4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253CA2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M4Z7sw56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfDBXCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:02:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42326 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDBXCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:02:05 -0400
Received: by mail-lf1-f67.google.com with SMTP id b7so10222307lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 16:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SO58Wsvlssf+4GkdAXJfc0AlvDidEvl/QldqzBDTW8w=;
        b=M4Z7sw563MLFqjrmpOtd29LUggA2wt0b5ZNzN9kASRueYLiWhSKpcb1uGOmLWX8Ust
         KceJlBjUqPCiCHSQhS3BvlrPerng8I4zwix/Lhb4sBrDPqwWipH5SdHBa/OeqeIDMbjZ
         eUkxyWUtdpGn/UVvtsWYn+PDuWEm5Zv4UXik4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SO58Wsvlssf+4GkdAXJfc0AlvDidEvl/QldqzBDTW8w=;
        b=fqOHFq6XPb6LQ7syCPYsBcFGkePVlKnO5NmW88YMLq6d1X+grEnSbPGg7YV2mFYPbM
         /7ctZ7fkG9nXugo4vI4TIdJb3FdnDjmtm5shOEbJnPSycuG/Ov2TLKWxQdwVIJ0GWRIR
         n1QZa1ddMNHNIWCuePePICOIgrqqDK25U3PVL3jWJ/8mlfxygkvFsAGaL7dsFcaTtMaD
         xGA3wsqKjMfhm/UTWCb6I4P//3nDf3M3+ufbUjT5nbdoA+oevBrgGIK6Ui8va/iFoS5G
         WQEjBdPI4VICv/+fe7/Bt69VxEM2wM/oYD6IqW/f9FB/Kh4wka74wl7puIOnmnj7qxVB
         rlbw==
X-Gm-Message-State: APjAAAUJDoFIGr3f02N0BHThxzmx1k8iIq11iBiVIDsAzDunUEWibplZ
        /apCxBquA/3B73SrURfMHXhRge40txM=
X-Google-Smtp-Source: APXvYqyRG1afppULh7+GzHj0iiPnrqChyV/70+0eLhtxOfpwTz8ADDUw0rtL0iaVxe9/ASYQ2t7NZg==
X-Received: by 2002:a19:7503:: with SMTP id y3mr36745089lfe.83.1554246122707;
        Tue, 02 Apr 2019 16:02:02 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id s24sm2998778ljs.30.2019.04.02.16.01.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 16:02:00 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id t4so13128438ljc.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 16:01:59 -0700 (PDT)
X-Received: by 2002:a2e:9213:: with SMTP id k19mr18362707ljg.118.1554246118947;
 Tue, 02 Apr 2019 16:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <362a9b5f-8908-17f5-3594-6c3c68789dea@molgen.mpg.de>
 <CAEJqkggKGTn0ojWzuYGfoYehDnOf=je5L-7-M1kWogutPGMg3g@mail.gmail.com>
 <874l8ic0l4.fsf@codeaurora.org> <CAEJqkgjYRu1Az6ec1ksQfLZ71fa062Us7XkOzw8BZ2bEoUe8BQ@mail.gmail.com>
 <87wol97hvp.fsf@kamboji.qca.qualcomm.com> <CA+ASDXOcbSGJs3Xk_SjjsAA87fcwrx_JB_mB9cyV=9u6V+FZ_A@mail.gmail.com>
 <CALiNf2-Wdo4YnKLprUUyPF9QJBL10Mz3wvVG6fWtd_Xi-Yn=6w@mail.gmail.com>
In-Reply-To: <CALiNf2-Wdo4YnKLprUUyPF9QJBL10Mz3wvVG6fWtd_Xi-Yn=6w@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 2 Apr 2019 16:01:46 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNnRv3AbPqjcsUpfLM+CMSv1CKduRfCUKtZgQ5s8xOPdw@mail.gmail.com>
Message-ID: <CA+ASDXNnRv3AbPqjcsUpfLM+CMSv1CKduRfCUKtZgQ5s8xOPdw@mail.gmail.com>
Subject: Re: Warning at drivers/net/wireless/ath/ath10k/mac.c:5625 ath10k_bss_info_changed
To:     Claire Chang <tientzu@google.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Gabriel C <nix.or.die@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ath10k@lists.infradead.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sriram R <srirrama@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Rafael
+ authors of these bad commits:
cd93b83ad927 ath10k: support for multicast rate control
f279294e9ee2 ath10k: add support for configuring management packet rate

Hi,

On Mon, Mar 25, 2019 at 8:46 PM Claire Chang <tientzu@google.com> wrote:
> On Tue, Mar 26, 2019 at 12:49 AM Brian Norris <briannorris@chromium.org> =
wrote:
> > On Fri, Mar 8, 2019 at 2:58 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> > > Gabriel C <nix.or.die@gmail.com> writes:
> > > > Am Mo., 4. M=C3=A4rz 2019 um 12:59 Uhr schrieb Kalle Valo <kvalo@co=
deaurora.org>:
> > > >> Gabriel C <nix.or.die@gmail.com> writes:
> > > >> > I reported that twice and no one seems to care about.
> > > >> >
> > > >> > http://lists.infradead.org/pipermail/ath10k/2018-November/012398=
.html
> > > >> > http://lists.infradead.org/pipermail/ath10k/2018-December/012658=
.html
> > > >>
> > > >> Does this patch help:
> > > >>
> > > >> ath10k: Drop WARN_ON()s that always trigger during system resume
> > > >>
> > > >> https://patchwork.kernel.org/patch/10837139/
> > > >>
> > > >
> > > > Without to test this patch I can confirm it will help , I dropped t=
he
> > > > WARN_ON()'s in 4.19 already.
> > > > If I remember right 4.19 has one WARN_ON() triggers while 4.20 got =
two.
> > >
> > > Ok, thanks. I'll try to get this patch to 5.1.
> >
> > Ping? Is there any solution queued anywhere? It's kinda sad how long
> > this has sat here.
> >
> > Brian
>
> Do we need to set mcast rate and basic rates during/after system resume?
> Dropping the WARN_ON() will solve the warning issue, but won't make
> those rates set properly.

I don't think there's anything to fix here about the rate info; the
original patches just made mistakes with how this callback is used. In
this case, we're not associated (we're not using WoWLAN), so it's
ieee80211_reconfig() -> ieee80211_bss_info_change_notify(), which
notifies the current association status (not associated), as well as a
few other parameters. There is no rate info to be had, so we should
just exit silently.

I don't see any reason not to take Rafael's patch. I'll respond with
my Reviewed/Tested there.

Brian
