Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DCBC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FB12245B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfKMPJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:09:37 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:44459 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKMPJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:09:37 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N5n3t-1hq9Tw3ncR-017HxJ for <linux-kernel@vger.kernel.org>; Wed, 13 Nov
 2019 16:09:36 +0100
Received: by mail-qk1-f182.google.com with SMTP id d13so2015720qko.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 07:09:35 -0800 (PST)
X-Gm-Message-State: APjAAAUt1kITgAgZLHtsHa44P6KkJp7ihfZyzWmwhfDxPa0kzfTSDIW1
        ztoNQcsdHZg3RfKDvFWrwL9FgMngg0WrrLFCP2E=
X-Google-Smtp-Source: APXvYqzQ08oWGBtIBKfGwjyYF/iVEHvO+TappMGnZDNXcHZ/2ulhuHUZC/UgZA1ht67tDy6BsfjyTBfPL3Z6pLWgoTA=
X-Received: by 2002:a37:4f13:: with SMTP id d19mr2794772qkb.138.1573657774816;
 Wed, 13 Nov 2019 07:09:34 -0800 (PST)
MIME-Version: 1.0
References: <20191112151642.680072-1-arnd@arndb.de> <20191112151642.680072-3-arnd@arndb.de>
 <s5hblthp0di.wl-tiwai@suse.de> <CAK8P3a1fsC+05i-i77g2aR3bkzprnhbhROLkMPcy=UFfsV3GMw@mail.gmail.com>
 <s5hlfsk7sbt.wl-tiwai@suse.de>
In-Reply-To: <s5hlfsk7sbt.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Nov 2019 16:09:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3EKr4-ygUJ453Fv9DdW0YTHMcTuMu5TmbZ=aLxsWzU0g@mail.gmail.com>
Message-ID: <CAK8P3a3EKr4-ygUJ453Fv9DdW0YTHMcTuMu5TmbZ=aLxsWzU0g@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] ALSA: Avoid using timespec for struct snd_timer_status
To:     Takashi Iwai <tiwai@suse.de>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:DQPeP9fCKR+dtP2gtqXF47VzYNfi5VB6xJ3uB5M5Euvj/0Pbrtg
 pwZQ54IfrHkDlXFo9Xs8COJVHkk5CtRWWt4tRnQ4+DF/I34gbZpqJvHhcnWiO0Twa1M1nOE
 puEZUDN1meijTxvF6ytpnJzxaVSK6kWLqZghGqxS4PIhQli280mrJ9+Q7rJpX2Mey35vHXj
 lL+eqh5aHju3hCQoUrF9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MuhNGDZnFB0=:W3BTz9XcTpqAb5R3g186l9
 pBQmkPS43ZgMQLVM0Eu/Z/PvGoJ5EGtyGu3MmnJ6a+89S3tqYaHPqNev9k69Gi2OKeeB58JID
 Vo49k40QkxlTUeY/6keF7tJjCsSXSuo0SU/o2SuLu2p2qYKdmmIDhe0aM3necRBDxG9d2npmx
 mss9t+3UqBWpPuoZeG/5QtHMvPrtEm0A0ZjP0yyJDcyxOuTJZgJeOfXy839uShxpGrqC4UW5/
 cv8qOTlgzegtWZ8Tq/DzeAn0eWtx1+B1tixeMytV1HFRnAOMFAxuGynj/2HJfM4cgFSi36Rpi
 xdFB5D0V1fCJIPZWmGrzLxwb2pcsmp/t+9AuGrWoAY3gv5jyxQciZIE7LASqejCiiWqHYwxWD
 CflLwP0BE9GrrJkyWrbnjhgEbHEiKtHHR7ljwb3KIEGiFaJ0UkURbst3kCzDdqnGCxoQVn3Qd
 M21EMAbW+obHODmrNrhs2Jaw2vNXkEAofi438/wtSjSiImoy1rHKDpiSTuy6NqOZWj2vgPidM
 +OWJnNlHcyOvaiaScKb9VR6kZWX8DgpsLNyPhUhUtUCwq3NyZFo7US/pgkR6p3D4tpveUsaup
 GLs6iGZ++2nwwJuUnXouDwRLTYSHH+bAx37Fm96om26gCYdkP25kkyY5wphFr7Az6sCxw9aPo
 /eHx3e0Jm+FqNEybESF7xTK1Loq8A7uOzA6UQ9su1cK68Q+8LwxMXmb5tx7TDFXa4Zh4Ha9fm
 QWixxYuTLPuxpEpa2gVQlexde5VTw8qNXfCaQb8GALJHbwEP6vE4ha4qPTWIaHNOqM5NgUTg7
 zcCsMh0cgGANLikzVZ4eefYcb6bhHVQCWao815bWDt9qPVGz+Lf2DoZ3qKc03WWoYorst2mDZ
 x/56NSbjaCOhGMA603sA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 9:28 PM Takashi Iwai <tiwai@suse.de> wrote:

> > Well spotted, this is indeed a very recent change I did to the patch.
> > The idea here is to hide any use of 'time_t', 'timespec' and 'timeval'
> > from kernel compilation. These types are now defined in an incompatible
> > way by libc, so we have to remove them from the kernel's uapi headers.
> > I would prefer to remove them completely from the kernel (rather than
> > moving them from uapi to internal headers) to make it harder to write
> > y2038-incompatible code, and with the 90 patches I sent this week,
> > all users are gone from the kernel (this series was the last part).
>
> Could you put this trick in the changelog, too?

Done.

      Arnd
