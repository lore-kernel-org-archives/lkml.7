Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4566C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C3D2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m3iqPO7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbfCZDqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 23:46:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35454 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfCZDqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 23:46:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id h39so13044699qte.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 20:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2A9sFz1A4gm0UZ7I8tzNTiFD4c5dfHSGYHbj3F4ufNE=;
        b=m3iqPO7RkWlwhigXMtxw24YoazuWrbMM4hUuwqkPHojXg5OMnbWrQioSHWjltSWDaY
         8aSt2BRFGnbAsbBzIe8pQsuBs/h0F7FC10msCzzM1asPJlMudnyLyydnQxmTgY95+TEO
         hJoSnPjHCTIpdBDIY0C1XLwtMguXbQ9CM2hYzUa5gdwkYbR4/RPxJZ3nkuefAAyMAHry
         BxjH0Uw+2My9WX6U6PQ3lk4J5DRLWgXGPGvks+WFoZhWi3haIyS8sAxxmrNNPkmJeBTS
         mygT0ug/IR9+chgw9wchwcmuq10zcQxLqzEU+O5IF0iVFPwErbEu2L/JiqvS0KhwnHfs
         6E8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2A9sFz1A4gm0UZ7I8tzNTiFD4c5dfHSGYHbj3F4ufNE=;
        b=Hps4yfkzqX78QSgf8xtpCcL5bcb8ZwDf5IwCUvtSZ+YfyCvNMOF2b3itp+2XXUN3oC
         Sbf9TlPJekdL20pNVD/Lrcnrmi8H1GAte5PQhKmKtb9SeCa+4oca7gYfcCmb1BtTGKu/
         yvCIKxYKeyrpk7dUAVvE8RTZpT8lPGtibyVy4+4pexSb7UUnRcRP8slNkif1yT3XfORq
         MCiEeKjJEz1e9QWWam5Vwm+vVow/NneD97LqpbdhggyGuTfjZDkeZsz4DdF7/JF5NjuN
         JTb3r7eHIkLAQQIGqLJNTkNlFBeGmIDErKEXg5aaSWyrjXN3aozJDdap4WWRoSIbZ4Yk
         RnHA==
X-Gm-Message-State: APjAAAUpQV1YHmGE3NkMOm/+4HavXURi8BWakyWPkTGSNbzo7nLwKssS
        gRKc7d/N/DwnBxKZ3e51ZaqmkV7eGVq+GI6Hw+CA3uoC/Qw=
X-Google-Smtp-Source: APXvYqytkxNjKoUdQ4XVPAiVvpDF0ZCz/4Jh++u0zz9CqttWZtPROMzf0kZQRTlcFpsdQgBIA0BoTSw1X5THxZyBhwI=
X-Received: by 2002:ac8:2207:: with SMTP id o7mr23650141qto.376.1553571997519;
 Mon, 25 Mar 2019 20:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <362a9b5f-8908-17f5-3594-6c3c68789dea@molgen.mpg.de>
 <CAEJqkggKGTn0ojWzuYGfoYehDnOf=je5L-7-M1kWogutPGMg3g@mail.gmail.com>
 <874l8ic0l4.fsf@codeaurora.org> <CAEJqkgjYRu1Az6ec1ksQfLZ71fa062Us7XkOzw8BZ2bEoUe8BQ@mail.gmail.com>
 <87wol97hvp.fsf@kamboji.qca.qualcomm.com> <CA+ASDXOcbSGJs3Xk_SjjsAA87fcwrx_JB_mB9cyV=9u6V+FZ_A@mail.gmail.com>
In-Reply-To: <CA+ASDXOcbSGJs3Xk_SjjsAA87fcwrx_JB_mB9cyV=9u6V+FZ_A@mail.gmail.com>
From:   Claire Chang <tientzu@google.com>
Date:   Tue, 26 Mar 2019 11:46:26 +0800
Message-ID: <CALiNf2-Wdo4YnKLprUUyPF9QJBL10Mz3wvVG6fWtd_Xi-Yn=6w@mail.gmail.com>
Subject: Re: Warning at drivers/net/wireless/ath/ath10k/mac.c:5625 ath10k_bss_info_changed
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Gabriel C <nix.or.die@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Mar 26, 2019 at 12:49 AM Brian Norris <briannorris@chromium.org> wr=
ote:
>
> Hi Kalle,
>
> On Fri, Mar 8, 2019 at 2:58 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> > Gabriel C <nix.or.die@gmail.com> writes:
> > > Am Mo., 4. M=C3=A4rz 2019 um 12:59 Uhr schrieb Kalle Valo <kvalo@code=
aurora.org>:
> > >> Gabriel C <nix.or.die@gmail.com> writes:
> > >> > I reported that twice and no one seems to care about.
> > >> >
> > >> > http://lists.infradead.org/pipermail/ath10k/2018-November/012398.h=
tml
> > >> > http://lists.infradead.org/pipermail/ath10k/2018-December/012658.h=
tml
> > >>
> > >> Does this patch help:
> > >>
> > >> ath10k: Drop WARN_ON()s that always trigger during system resume
> > >>
> > >> https://patchwork.kernel.org/patch/10837139/
> > >>
> > >
> > > Without to test this patch I can confirm it will help , I dropped the
> > > WARN_ON()'s in 4.19 already.
> > > If I remember right 4.19 has one WARN_ON() triggers while 4.20 got tw=
o.
> >
> > Ok, thanks. I'll try to get this patch to 5.1.
>
> Ping? Is there any solution queued anywhere? It's kinda sad how long
> this has sat here.
>
> Brian

Do we need to set mcast rate and basic rates during/after system resume?
Dropping the WARN_ON() will solve the warning issue, but won't make
those rates set properly.
