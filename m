Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF40C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CE1206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfLQVPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:15:51 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:41053 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfLQVPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:15:51 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mzhzd-1hlwDk3dDd-00viNH for <linux-kernel@vger.kernel.org>; Tue, 17 Dec
 2019 22:15:50 +0100
Received: by mail-qt1-f172.google.com with SMTP id w47so69612qtk.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 13:15:49 -0800 (PST)
X-Gm-Message-State: APjAAAVbFAFeiDumZi4zLZJCkxgGzmY21ae9VGEmnPFqmBJZZviLVkmm
        g0cp323Z9uFYV/EVsxMIC5wchfmX0DlEpB/H9z4=
X-Google-Smtp-Source: APXvYqy7B0yAuutBabtpxZAD4q9oCuIdKTJ/s6uAQ2ZKYGBWmxxVMFU8CMT20J9fghezOmHOWFZajbDQKTvpdR049S8=
X-Received: by 2002:ac8:709a:: with SMTP id y26mr6536373qto.304.1576617348814;
 Tue, 17 Dec 2019 13:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20191211212025.1981822-1-arnd@arndb.de> <s5htv5z1bes.wl-tiwai@suse.de>
In-Reply-To: <s5htv5z1bes.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 17 Dec 2019 22:15:32 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3um5paR7DoNE3Qa9pjJx4jDfzsCbh+ihSPf1aGA10Niw@mail.gmail.com>
Message-ID: <CAK8P3a3um5paR7DoNE3Qa9pjJx4jDfzsCbh+ihSPf1aGA10Niw@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Fix year 2038 issue for sound subsystem
To:     Takashi Iwai <tiwai@suse.de>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:87UMdFheKhogWXEkF3ASS9acZ1k9UtMEwa1o/fM1wBeJxWmCjX9
 /g2IOISdHGHXLDwIgy5HDmfTdz+tOG1lhOWp7YjRq9RVZBdLkhEE+JAJYk1JJbFL6Vmeshd
 uibGiJ/40vU3L1TbOk89xcfnthc8GigQ1EtF/DTFRNPSvZLhs2YnH99U06Uo5v3x5dNMI/N
 M3BFunN87eoIqRv0fiV+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5ofDH6pv/AE=:p9QYb9/8Og18WpCl0WGUXZ
 uota5wnCAASRN4kVSK3VxY85d3lkBaswNjDYmeo2T5C6/CFdQ+7WCd4L1/x9nN0WIFSoz5nL2
 YFahuNNWeZE0n/lNPIqQA5QWUs5rNfVsy9ocirou9LmBI7hC/PdlOy2bZgO0ehBx6Zgph2HGS
 //v5GYgzuSDx+4aYzghded2M0bPnKIoxZvo7nNDaFm80/P5f+FVsl0/MKrmBFg9/Jdi2QdObK
 vO3I3r8Z8qYA3BTiXRG//dufXtd1R0lZHQ440/QbovGBrJ9aEbxzqSUOkVL+/NaeRFTHTYGjI
 s7uJkMQIIfetMx2yQ9FguU882lzTUa+TFyfO1CikLS6j0klirSQlhjhWW8eGOP8pwDIc0h+ln
 jpubbca//OKMXTKY3vr8dSYnvQ8Lz4RvZxrptlHLJQqVOCdV3vzxch3EXVlnbLpofCU7jv35b
 U4c2kexG6KU0HdjczbJ8ZbIk1Q017O+7eOfrcsSs1+GOBj6pcP9M+N6waeyT8hdfkc93z2lKG
 T3znj4NJoqvIFoScN4Cz2v1jj4UqOZBrQlzdSVs/BUX0msH9X00Gi5034kUCPbnEXU0X2/Po8
 yyCRnxFug6iM5zkqKB4fVt3AK+id7KK5GTpmMNgzTTsrbd8Xxy79FVNKni9MjRvXYpq6QXIr+
 VhOGz5x7JWNecteoJfgPqPKxqhDkGFOKS9tjWyAt7KJowbhcLuGw0QkxAMyDRxwi/g5YL0D5g
 BCZ+kMVEZjnhtIiygnv1M4mZ8jVlx0HxFBkjZnlsLJw3q8/w4LEnJ/C5dz1gk8UFg0QXpWF4D
 cF5rW2TgvZXxJDML0EfOIKEnQoAv1A6gGLPWlnAb2b5GelL3BvX8uJMS449V2b8y0ezFb5N8I
 6AWcLu9jPVtQoqLoqUXg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:42 AM Takashi Iwai <tiwai@suse.de> wrote:
> On Wed, 11 Dec 2019 22:20:16 +0100,
> Arnd Bergmann wrote:

> >
> > I hope I addressed all review comments by now, so please pull this
> > for linux-5.6.
> >
> > A git branch with the same contents is available for testing at [1].
> >
> >      Arnd
>
> I see no issue other than the timer API patch Ben pointed.
>
> Could you resubmit that patch?  Or just submit the whole as v8, I
> don't mind either way.  Then we'll get this done for 5.6.

Can you take this as a pull request? That would be ideal for me,
as I can then use it as a parent for a shared branch with additional
cleanups on top (removing time_t etc) in linux-next. It also provides
a nice place to preserve the series cover letter.

I'm sending you the pull request now, and the last modified patch,
in case you prefer the patch over a git tag.

Thanks,

        Arnd
