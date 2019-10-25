Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12A3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F6921D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dDbon0qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502026AbfJYLz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:55:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:44325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfJYLz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572004515;
        bh=mLDxk03QgZ49jLBWzJk07zrzftgPYbqYvmcg2mY5ycA=;
        h=X-UI-Sender-Class:Subject:From:Reply-To:To:Cc:Date:In-Reply-To:
         References;
        b=dDbon0qmEYRdDCA8JWudMc2B08QtrpSI70J48PhNyA4bQePEKdauZ5emLd3cx4z02
         SoUN4d4JEimPvJpjFjsRlqwRwIcxMeFhjFPMEdkhxfR2/gEbgmRFIAFkhf0NDT/3Ul
         DThNKvNv8+0RLXToE4l5cM3qAPnVrzREwjvEw3qI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from bear.fritz.box ([80.128.101.49]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnps0-1hd4e11Vso-00pNxA; Fri, 25
 Oct 2019 13:55:15 +0200
Message-ID: <d740f26ea94f9f1c2fc0530c1ea944f8e59aad85.camel@gmx.de>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
From:   Robert Stupp <snazy@gmx.de>
Reply-To: snazy@snazy.de
To:     Michal Hocko <mhocko@kernel.org>, snazy@snazy.de
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Date:   Fri, 25 Oct 2019 13:55:13 +0200
In-Reply-To: <20191025114633.GE17610@dhcp22.suse.cz>
References: <4576b336-66e6-e2bb-cd6a-51300ed74ab8@snazy.de>
         <b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org>
         <20191025092143.GE658@dhcp22.suse.cz>
         <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
         <20191025114633.GE17610@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cNUvOUD9nrltn6/gYgTexXM/uEZqc30ijw4NkgQvGpOvolVX00J
 b408xrKUAZ9HQfCGo7fRA03Lro5arpDxTSfurS8/NfK0ks/UWThAd+0MUH1RL22JDs/57yZ
 AH17KRh7KXV0EdQyVIzrQ2IuE3YCK1gEriC1hMzgV8oTBzZ3QCCaX41uC+AGg82QxG/G4Fm
 V3oMf2P3DcI26OMPdtXIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:38xgz3rSgBw=:G7lsGuMYS1aNz2KyfxDTPn
 rMVxSgm6FkKrsQ7VGpMo2/qaHdxIZmM407ia+jo5TnYHVaX/n7q5gsQcK0dSZMcOUt5EbyG/Z
 HSP9A2fidEqPUQAnQQnfxREzoS0ngwYuIKHowSj0/4k01nCP8RZwq8STcKN59oLoHtZOJz/S4
 kUdFVLRTGt5bXunbg+NrUv4cuD+uTPSaKN/W8QfNhItFqK1mO1MDep9aFazkfqi/oRVGktSAs
 jkc4PgVa47LvOSNZF8KdI8SLXuu/zNbk3DFEWKEhKEauI2IIqcqYUxO5u7UyR8z29uIzgKJW+
 bNTcfzwfYHFnYe5EpUOJWfAldgir52ALMIiAKij+OPw4tLPJ7biOjymlvIMc4Tm9roCYyoH2c
 WdEt/q7/bdpE//sA0Y/442JyJ3iIhTx0Oqg3BXhq7v1RRqQzVfLsxeyUGqTQBKCsxNgUW2Gjn
 lutHjFbtxfqCR3XPh4rtjL5MMbfzBrHSsVNx8CV02Jn9ezskQsVqeB1oGQ1lNCYu3hIqxOcuT
 Yt31sgwyVraTrxWq+CUdEd7a7DQ4zaNq12BQF/wA7oHA1SXVY4K0u334nf7wqc8m5PEzavCkY
 ZQP364yqDEGN+4+l4HxhwLiI5U08u4sn9M6FdH1z2fCKB57eDZ+77cyHWC+KXv8dsA9lpRtUc
 HfWw8xEnR016PRTExq8LysJfyEq8VQDBouXbb798C5CZtX28cZjqsqazp1Q6b9ZI6zZ86S0lt
 e6dLPmgMVouG6oojsdmmdTm5Qicxbh7N0E4F1ydPEGYk4KSH3VvIvTdCWOWPiVVD2B5e8bmkb
 dOFvsf967Sd0w9wCNlB1Jk/E83RnbxmHQuf3nU3WTEsbKcOCUlcTOx0BA0jg5XNNMnAoaQPJn
 v2KxB+LA8TCJKASPpMUc0JoRZauj5QCfOkh+yRuf2jJzYjFg+7lPERNEbe0N8+ReSmAINUCVv
 b4bEXbwnfIQXbeRdgsdlbVYAHcCieWZmq7vbiAO/zDJLT/kRg9XwzKDbE7AqHFZu5WsGIUL+/
 Wp42m8XcqJc/X1Ge5HmhN/BIOAE7XR0uoFM/DnNIIXHS0Jct/WlNjR1EvNLn7Z3oGQ7FBRSz0
 DGaS73qqJil49j2rnQSByrjdhGoGtH7GsLi4ZlD9Tu2sDroW4Rajq5/PspBFzhxu6tB+eEnjS
 SYYiXREdn/Z+jJu1yy0uPqpj8A8k/PsmngtqiZC92BAWlzmeMumcGjB9+HGxoxiYda5fGQKHL
 dgAqEUWlcteriUf1aHyeIlO1zmMFkzdmKOdNaVA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-25 at 13:46 +0200, Michal Hocko wrote:
> On Fri 25-10-19 13:02:23, Robert Stupp wrote:
> > On Fri, 2019-10-25 at 11:21 +0200, Michal Hocko wrote:
> > > On Thu 24-10-19 16:34:46, Randy Dunlap wrote:
> > > > [adding linux-mm + people]
> > > >
> > > > On 10/24/19 12:36 AM, Robert Stupp wrote:
> > > > > Hi guys,
> > > > >
> > > > > I've got an issue with `mlockall(MCL_CURRENT)` after
> > > > > upgrading
> > > > > Ubuntu 19.04 to 19.10 - i.e. kernel version change from 5.0.x
> > > > > to
> > > > > 5.3.x.
> > > > >
> > > > > The following simple program hangs forever with one CPU
> > > > > running
> > > > > at 100% (kernel):
> > >
> > > Can you capture everal snapshots of proc/$(pidof $YOURTASK)/stack
> > > while
> > > this is happening?
> >
> > Sure,
> >
> > Approach:
> > - one shell running
> >   while true; do cat /proc/$(pidof test)/stack; done
> > - starting ./test in another shell + ctrl-c quite some times
> >
> > Vast majority of all ./test invocations return an empty 'stack'
> > file.
> > Some tries, maybe 1 out of 20, returned these snapshots.
> > Was running 5.3.7 for this test.
> >
> >
> > [<0>] __handle_mm_fault+0x4c5/0x7a0
> > [<0>] handle_mm_fault+0xca/0x1f0
> > [<0>] __get_user_pages+0x230/0x770
> > [<0>] populate_vma_page_range+0x74/0x80
> > [<0>] __mm_populate+0xb1/0x150
> > [<0>] __x64_sys_mlockall+0x11c/0x190
> > [<0>] do_syscall_64+0x5a/0x130
> > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [<0>] __handle_mm_fault+0x4c5/0x7a0
> > [<0>] handle_mm_fault+0xca/0x1f0
> > [<0>] __get_user_pages+0x230/0x770
> > [<0>] populate_vma_page_range+0x74/0x80
> > [<0>] __mm_populate+0xb1/0x150
> > [<0>] __x64_sys_mlockall+0x11c/0x190
> > [<0>] do_syscall_64+0x5a/0x130
> > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> >
> > [<0>] __handle_mm_fault+0x4c5/0x7a0
> > [<0>] handle_mm_fault+0xca/0x1f0
> > [<0>] __get_user_pages+0x230/0x770
> > [<0>] populate_vma_page_range+0x74/0x80
> > [<0>] __mm_populate+0xb1/0x150
> > [<0>] __x64_sys_mlockall+0x11c/0x190
> > [<0>] do_syscall_64+0x5a/0x130
> > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> >
> > [<0>] __do_fault+0x3c/0x130
> > [<0>] do_fault+0x248/0x640
> > [<0>] __handle_mm_fault+0x4c5/0x7a0
> > [<0>] handle_mm_fault+0xca/0x1f0
> > [<0>] __get_user_pages+0x230/0x770
> > [<0>] populate_vma_page_range+0x74/0x80
> > [<0>] __mm_populate+0xb1/0x150
> > [<0>] __x64_sys_mlockall+0x11c/0x190
> > [<0>] do_syscall_64+0x5a/0x130
> > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
>
> This is expected.
>
> > // doubt this one is relevant
> > [<0>] __wake_up_common_lock+0x7c/0xc0
> > [<0>] __wake_up_sync_key+0x1e/0x30
> > [<0>] __wake_up_parent+0x26/0x30
> > [<0>] do_notify_parent+0x1cc/0x280
> > [<0>] do_exit+0x703/0xaf0
> > [<0>] do_group_exit+0x47/0xb0
> > [<0>] get_signal+0x165/0x880
> > [<0>] do_signal+0x34/0x280
> > [<0>] exit_to_usermode_loop+0xbf/0x160
> > [<0>] do_syscall_64+0x10f/0x130
> > [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Hmm, this means that the task has exited so how come there are
> other syscalls happening. Are you sure you are collecting stacks for
> the
> correct task?

I guess that the `cat /proc/$(pidof test)/stack` captured the stack
after I hit ctrl-c. Does that make sense?

Also tried `syscall(SYS_mlockall, MCL_CURRENT);` instead of
`mlockall(MCL_CURRENT)` - same behavior.

