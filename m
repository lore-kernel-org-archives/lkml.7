Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E38C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 20:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF4920815
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 20:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im6c8IsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfEZUMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 16:12:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45577 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfEZUMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 16:12:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id w34so3179274pga.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGyAuCu5e13bXGrj6S6Qg91jJyzgztWuEgcVp4sGd/M=;
        b=im6c8IsA9o+UFLaEeioTVf/5NiFtZVYhv2pWbrKbcRJhP/k+lwoJYkOfwMw3LNFUbL
         VKvBjQcfwAL08o9/72XLJzQ8WiMlBuiWliSmJdKEPhg2dkbmiDM8bPtQ5/fOXiIOp6Lz
         yyD9HOOE6BVqQ3Mx8UP4kk5cEKw7DNw+zzR8IZSK4Uxa+SeK5QS/H7/UiUs520ZpESM0
         5l4kYRrlR2o6scUdckWw5l+sGBALf+9iPzr2tQyhNRjgxUlW9+uSqfA3EleF4RlDlfz6
         tDWqkKVn4LvtEKXV4gPQH9nEKNRU1spAf3ABmOKhUkCfNmF5jOxW4OoVw6hOLs07VOup
         utbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGyAuCu5e13bXGrj6S6Qg91jJyzgztWuEgcVp4sGd/M=;
        b=Ruf+iIV6p50oX6qNRYaCW/wBmsnlDP2q4sQbBaph8MNNxNNh21M58p+uKHznQNFY9F
         XbTO9a0r7/hzDHiOREUDBdHul0B23xHB3BVTP73DqJfvp3/PfoLUPiSh1bPFVvtksS+V
         nGaAx2O0E2pPqG/DsQSBz0RsvuqDjVfwKhE1L1uENDM4cDwXxMF/MmP4ZYG4V2+CzriH
         F/6ycfgRPu943oBNLR1w+ObZ17bfR59fd7/A9H7fpZeOccpiKd8Zt1yGvynO69OCSso2
         um7tt2MMC/Xgj24SzG36CI/NUJuLl22AAayX63r2G9LUttWYW2POQVOdisLHUlpBmjOV
         Djjg==
X-Gm-Message-State: APjAAAXZf9tO6mFx5bCJhRAZ2PVu+P5cqcNmiF2tGaTuxAlQDOvKggrF
        2Hh7r2j4dtKCjbxUmNs7g2zUAU44uNUAmld1TEJlDQ==
X-Google-Smtp-Source: APXvYqzsJ9vWRerYW+gXOLUiWw1Ri89TtGLYdgpAWH/Kg1aTAq6XQxAqGTuG3lE7Hb32BnpdDeS6cuIPXW+unIsIqWU=
X-Received: by 2002:a63:1d05:: with SMTP id d5mr11880687pgd.157.1558901533350;
 Sun, 26 May 2019 13:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190525165802.25944-1-xiyou.wangcong@gmail.com> <20190525183715.0778f5e5@gandalf.local.home>
In-Reply-To: <20190525183715.0778f5e5@gandalf.local.home>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sun, 26 May 2019 13:12:02 -0700
Message-ID: <CAM_iQpVOdp92gscmHH4zSzLWsMh5sbTSOd9WZWyqZjE+k2AJZQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] trace: introduce trace event injection
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 3:37 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat, 25 May 2019 09:57:58 -0700
> Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> > This patchset introduces trace event injection, the first 3 patches
> > are some trivial prerequisites, the last one implements the trace
> > event injection. Please check each patch for details.
> >
> > I have tested them with both valid and invalid input on different
> > tracepoints, it works as expected.
>
> Hi Cong,
>
> Thanks for sending these patches, but I just want to let you know that
> it's currently a US holiday, and then afterward I'll be doing quite a
> bit of traveling for the next two weeks. If you don't hear from me in
> after two weeks, please send me a reminder.

I will do it. Thanks for letting me know!
