Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56614C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319872077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKNNvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:51:39 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:44525 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfKNNvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:51:38 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MWjQU-1iOabh1crI-00X86c for <linux-kernel@vger.kernel.org>; Thu, 14 Nov
 2019 14:51:37 +0100
Received: by mail-qk1-f176.google.com with SMTP id e2so5004593qkn.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 05:51:37 -0800 (PST)
X-Gm-Message-State: APjAAAUlUyTTSX7yFwcl/Kz5LJIrqxLM3xsSKs9U8s5hr/B2NKKKm9Rg
        Wx2JDLj1CRa44Y8f7/prQOPrEoibdOMg8ji6Jas=
X-Google-Smtp-Source: APXvYqxxVGk9D827yoegWYgUUayNyWuP7iTgVXSRBR9HP6ppKymhiwc52XEvlgI34kzct3ul42INS+FfI+MXScwfBz8=
X-Received: by 2002:a37:58d:: with SMTP id 135mr7491492qkf.394.1573739496258;
 Thu, 14 Nov 2019 05:51:36 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007ce85705974c50e5@google.com> <alpine.DEB.2.21.1911141210410.2507@nanos.tec.linutronix.de>
 <CACT4Y+aBLAWOQn4Mosd2Ymvmpbg9E2Lk7PhuziiL8fzM7LT-6g@mail.gmail.com>
 <CACT4Y+ap9wFaOq-3WhO3-QnW7dCFWArvozQHKxBcmzR3wppvFQ@mail.gmail.com>
 <CAK8P3a1ybsTEgBd_oOeReTppO=mDBu+6rGufA8Lf+UGK+SgA-A@mail.gmail.com>
 <CACT4Y+YnaFf+PmhDT5JRpCZ9pqjca6VeyN4PMTPbCt7F9-eFZw@mail.gmail.com>
 <CAK8P3a1viWDOHPxzvciDt8fPCm3XkbLJxAy1OjtJ_-vuP-86bw@mail.gmail.com> <CACT4Y+YsC7yX5d8Gw=C7pm_4xcZ1wjzb_=AoPOL1k5FEPERbzw@mail.gmail.com>
In-Reply-To: <CACT4Y+YsC7yX5d8Gw=C7pm_4xcZ1wjzb_=AoPOL1k5FEPERbzw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Nov 2019 14:51:20 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2BX==aF7LezgxxtPbRX=GY09Bug+jPH+qL5kam13mjmg@mail.gmail.com>
Message-ID: <CAK8P3a2BX==aF7LezgxxtPbRX=GY09Bug+jPH+qL5kam13mjmg@mail.gmail.com>
Subject: Re: linux-next boot error: general protection fault in __x64_sys_settimeofday
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+dccce9b26ba09ca49966@syzkaller.appspotmail.com>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7zQYjX3LuQYBw0hHkIFyAvR0IJhRq0UWEFwsrcXAdp8Uxv1avzK
 cQEzUedJoV2YqwTrM4SiTQOBir5Ddk+Z70cVhl+z5aA12D5BxYvl0PnEkEX6B0OvlRbQmBc
 fjmRGDTj5dsammj3XU7K1w9jaT8WA4wmt7ZdMEHqJf97y9HhICSwhin3L/pfP90zQgeykEn
 ZvRq06Y+hDnG4vyyAciYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c7DP1bcOy6c=:/UR/63emNwmpSNPdGXXSrY
 h4gBf8ytrwhFaaTak0gXXJ7CW7pramS0CqAu3uRZtbhaNQy/wJIsQvAu0jKxZpr2n9W8gKjzq
 VZtASKFxkSvNE9Q4cmb1i0bSkMMKxRxaSnqVtXESJa4vz9eTDFDxe4jZbYNm95BsvpMsfySF0
 NNNdrafSXMSULnQb0uHQM2ukw7+ltfdh1EJ81NVyn+KeAaXbRZZh3/DnnzSv9C7LYknnhCLdj
 7wXaoRlLEreATKBOCotmGb8autzCVRC9g8e90hHs2qOowWeA9iOUxhfksq7Jr9exVNW4UoTZt
 oghVWfFGxqwhAk/Nt8dwFTNtnhSWsZA7LDbQhiTcniHG3Bi3OvENZTVlYmheq66JF6b4/yz3e
 VYJVqOIIWR/s50sqHy+Mf55fea1vRejyqh8du32G2mbrSLUOEr03iM6Tnont/lBnRVpAxb321
 fcr4veStkfPXVHdKjQ5DNt6AjFC5Bz9GK+VTcAvVehUjRrE3f7YTknlJsQLSI29Y/pRMpYyQv
 IZKhzw+1yjVo2IIzc9LLXFeZWq2ayngBI5nIrzJqOK/oqZot9xA1uB11B+c987b0em8eFxVTb
 a5jofGSdHnpZwis3iNcYqSYzhyEmVjf/cijpgx/Roff8nFIodm/tGzEjciHBYiIvhfEmeLuqd
 8gr/wFhIPvCLBrMIVBrDbpGLEovJAiTDjwRUGd+MRJ8oERUNQuF/oY3CO4EFQA1cIWyp+t+38
 TbxxArPw/IsWmc+ZAYZ1PJvh9wL088kzWfjtx2ks/Ic4L1q5nf0zsyL5WFetUtJ+qCCXjI6eg
 iIjE5ERclPyj4Ykv7IX+HBLKufreG9P9C0fcziz0HLhkF2YHiTJr3UQ4oHKML3sPL5LNNc3TG
 sIYoRiCNHi/N2jSNJE/Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 2:39 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, Nov 14, 2019 at 2:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Nov 14, 2019 at 2:28 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > On Thu, Nov 14, 2019 at 2:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Thu, Nov 14, 2019 at 1:43 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > > On Thu, Nov 14, 2019 at 1:42 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > > > On Thu, Nov 14, 2019 at 1:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > > > >
> > > > > > > On Thu, 14 Nov 2019, syzbot wrote:
> > > > > > >
> > > > > > > From the full console output:
> > > >
> > > > > >
> > > > > > Urgently need +Jann's patch to better explain these things!
> > > > >
> > > > > +Arnd, this does not look right:
> > > > >
> > > > > commit adde74306a4b05c04dc51f31a08240faf6e97aa9
> > > > > Author: Arnd Bergmann <arnd@arndb.de>
> > > > > Date:   Wed Aug 15 20:04:11 2018 +0200
> > > > >
> > > > >     y2038: time: avoid timespec usage in settimeofday()
> > > > > ...
> > > > >
> > > > > -               if (!timeval_valid(&user_tv))
> > > > > +               if (tv->tv_usec > USEC_PER_SEC)
> > > > >                         return -EINVAL;
> > > >
> > > > Thanks for the report!
> > > >
> > > > I was checking the wrong variable, fixed now,
> > > > should push it out to my y2038 branch in a bit.
> > > >
> > > >       Arnd
> > >
> > >
> > > This part from the original reporter was lost along the way:
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+dccce9b26ba09ca49966@syzkaller.appspotmail.com
> > >
> > > https://github.com/google/syzkaller/blob/master/docs/syzbot.md#rebuilt-treesamended-patches
>
> /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
> this

Ok, got it. Now pushed out with a

Tested-by: syzbot+dccce9b26ba09ca49966@syzkaller.appspotmail.com

     Arnd
