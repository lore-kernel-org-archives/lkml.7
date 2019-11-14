Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90817C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E4E206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKNKw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:52:57 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:41397 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfKNKw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:52:57 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MS43X-1iKWSa34d1-00TRPy for <linux-kernel@vger.kernel.org>; Thu, 14 Nov
 2019 11:52:55 +0100
Received: by mail-qk1-f174.google.com with SMTP id z16so4549384qkg.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 02:52:55 -0800 (PST)
X-Gm-Message-State: APjAAAUOq4GtU9nYL3k8jTMv2LkTU+aT0aDRtFhTUtnbtNdvlOt+juCJ
        AEXUsiQzZpqlaR2PqYuOpYTutkfCtZOWcrYZBlY=
X-Google-Smtp-Source: APXvYqxNdNMzQJrDlcwagBxK0gtxmBL9pg3cdNf4WYHS6D7X7GoHKDQSMAzZ6n/N4QRYjs0hNMFDHegk/kTe1Yd2y5M=
X-Received: by 2002:a37:44d:: with SMTP id 74mr6585761qke.3.1573728774640;
 Thu, 14 Nov 2019 02:52:54 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-12-arnd@arndb.de>
 <alpine.DEB.2.21.1911132306070.2507@nanos.tec.linutronix.de> <20191113210611.515868a4@oasis.local.home>
In-Reply-To: <20191113210611.515868a4@oasis.local.home>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Nov 2019 11:52:38 +0100
X-Gmail-Original-Message-ID: <CAK8P3a17qGymdM6JZYYB_o7hazVDNAB129duSoYtyNoBz1rnSg@mail.gmail.com>
Message-ID: <CAK8P3a17qGymdM6JZYYB_o7hazVDNAB129duSoYtyNoBz1rnSg@mail.gmail.com>
Subject: Re: [PATCH 21/23] y2038: itimer: change implementation to timespec64
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:FCW85QZEQ8qYh4NC8xy+rjxp97R2i/4vMl3A1ISOMmX8jorH+NJ
 P9+06IoK0kC6UjbtonNG4hyN27HpMiDsD8BhbwEHr6levLnzQAuczCa634TEbWyPIsfjqu1
 WyeFBTOFFvy7PoM4FF6RfFFnt0SpWcnkFi8zFIxpEk6PkG38lEKFilGdjCr2MseBGxcu8qk
 BFd0zAhYswGFuEPQWe9dA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YrMssL/nbYE=:TULfcBGK5jooZZDkDO2iHg
 iRo+knxQSOKcpFSpDvvD70W1i3VEZvFryCaUoCMvqlyN1T1b7mpHw7TyWavo1IyN2hOjzFaj6
 vvbN+PDfJ6jBubD6OY60F1Ir40aL+pv9fZ6fbcWm6NUhye0eBGLZ/Sfd2FkfHHxlzWSIp6r0x
 JuejeNcjeJ+mYyj4C9YigXC1zYZQbKhJAZ4DE6rPOWf9zKNomzc388DYi4kVWqWiv9QOzaX0s
 QE3Kp4BgVqkn/DuJ69POuKX1jAaweIeZmuyGYxMnhI3z6vWq9v0FBB6qAqdldkMELYHC47x/R
 Lsb+rM/yMwybCdwHWS4DqLAoawagTSuibdsQe5jPfjGOeM3rYzh2vuZueFJ00hlF71QrbK0iX
 iB5ELl2YKc1d5WOHlyMaGj/weyDq5aK6GBpR9eMxIup39ABMOXWYf/YLspOEIuZw9n5C5xCQR
 1jo/Lws/AKkIgOl2XAnFwe5PeWNO8bXEKqdz2Jy/a+gTdCmt8TVxCv08j5noOFEmV+Vb/pv6I
 uNWAbQYMQP38d7P7k6UGDLWmh5YOtIM4vcGbaIN/GP6pOefx2L7aLfCdJkPQaqmTO3JQh5Wj9
 oaJp553GbdaWXRd+ZmsGKbg2GKTQYbu82+SInbHzGpNGUC5zVN7IHy2KevrhCAGWxAqHAhjpY
 kIPhDN+H3er/lzWRchnIhPyI4C4DQo6rl/oOpPoXQCK+K/ukSevzdChOp4munTkp4X/Gc/VMx
 d2Sh7OXtUvj9cneos0TDGH0NF60TBJH/sS3vVLCRBABGoBFYS1898EnFlOdyCcZ3qyFRG14kb
 H/I3CnZg5Qnl9uPsbBxrjsa02sIy8Cvu9FmVsW4msFsKnv/OpHbUFzp6Pw/i5kyVRXe4aMA39
 VVV5p82XROjz6gXFVS5A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 3:06 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 13 Nov 2019 23:28:47 +0100 (CET) Thomas Gleixner <tglx@linutronix.de> wrote:
> > > -           __entry->value_usec     = value->it_value.tv_usec;
> > > +           __entry->value_usec     = value->it_value.tv_nsec / NSEC_PER_USEC;
> > >             __entry->interval_sec   = value->it_interval.tv_sec;
> > > -           __entry->interval_usec  = value->it_interval.tv_usec;
> > > +           __entry->interval_usec  = value->it_interval.tv_nsec / NSEC_PER_USEC;
> >
> > Hmm, having a division in a tracepoint is clearly suboptimal.
>
> Right, we should move the division into the TP_printk()
>
>                 __entry->interval_nsec = alue->it_interval.tv_nsec;
>

Ok, fixed now, thanks for the suggestion!

     Arnd
