Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0478CC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF3D20675
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GY2ZZVmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfFTKKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:10:44 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36180 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfFTKKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:10:44 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so583808ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 03:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jV1xtT6Suu2NuepDJacPY34RkA8y/nPmx6sAGtZRT34=;
        b=GY2ZZVmWjBrdNDwcAe2jMlFCfNtgQN0w5U1L+db+0QpM3lW9DPZ2NfMbwq3++n0jA6
         Le2FL8yvB6nCDV/2LW26NC1EESOrQOsfZCofRk4J9JQw5XGIDPwI3G41vBg+zpGbegwJ
         +L4DdDU8lW7reNaEGIPsO2SrWj12DKBKmKDKwOcaSpiwQ/rJCohB9+56IXfOMAVrPYpf
         mBo+hoH5uAvY9hKbIo/F0C8wiToqwKaaUOT5lK2U0UQSYilthGv2de/kGOZHt3KTNM0z
         qlYFbfpILWyUmCd831Tnyt/aLVlPY5gp6g/R86gnmcZjiJQO5Lig9MGF+0/LDk3j/zXf
         seSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jV1xtT6Suu2NuepDJacPY34RkA8y/nPmx6sAGtZRT34=;
        b=okLKfc2VCdHu0tuzyX6fSmo5KxgFmk7KZ+OCfwbvsUpxpVa9FGhyu6oBSF3BQ/475s
         qIHXEXPm79PxqSgdque8e9OCaJPfKqdGl6zoTaZpzG1mJ7x5bNn6o+Qdmgm7RL8HRpXV
         CF4A8It7Jf2CBf+/1NX+pL7vT77AnFPLLL07LVBo5L4LBUGYlRbRdvXCkbI+xWvTZVK4
         MxwITnTETn39hBGdMDye5hHhzgGoP2xzJ9k4C6b+hw7yaB71VfDTS8Akz9EHwRHU4Yot
         aIaCAD8/8Ypsn1fSuCs0cBqb5DFqHyIjzVg8H7EhvXD+0+JzemxyQzmcY1fKAM5Dymbi
         tPkQ==
X-Gm-Message-State: APjAAAWaK5x+dNK8cPgyZwOgk9Ll9Fmjzhod2wSCh+RgMI7fGOllTg9/
        86t9wpeYVnpxbqvICWoEegDIB6tR2/rG2HnfdcQY9rlJ4kI=
X-Google-Smtp-Source: APXvYqzVb7e1bAHRq03c2QbOYR4on4XnlUpI8KJ61K5/ydTtHdNzDhMN53l90YfyQ3Zd2Ywy4IzAVnZfPPSnsYqDCWE=
X-Received: by 2002:a5e:9e0a:: with SMTP id i10mr11582392ioq.44.1561025443346;
 Thu, 20 Jun 2019 03:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <1561010100-14080-1-git-send-email-laoar.shao@gmail.com> <e5c695c9-2006-f2cb-e3e2-7ea8ee465817@i-love.sakura.ne.jp>
In-Reply-To: <e5c695c9-2006-f2cb-e3e2-7ea8ee465817@i-love.sakura.ne.jp>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 20 Jun 2019 18:10:06 +0800
Message-ID: <CALOAHbCe9J0pOCW03dW+C4NK__amTKttAs=eNHXwvPPf5Lpwhw@mail.gmail.com>
Subject: Re: [PATCH] hung_task: recover hung task warnings in next check interval
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 6:03 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/06/20 14:55, Yafang Shao wrote:
> > When sys_hung_task_warnings reaches 0, the hang task messages will not
> > be reported any more.
>
> It is a common mistake that sys_hung_task_warnings is already 0 when
> a real problem which should be reported occurred.
>
> >
> > If the user want to get more hung task messages, he must reset
> > kernel.hung_task_warnings to a postive integer or -1 with sysctl.
>
> People are setting sys_hung_task_warnings to -1 in order to make sure
> that the messages are printed.
>
> > This is not a good way for the user.
>
> But I don't think we should reset automatically.
>
> > We'd better reset hung task warnings in the kernel, and then the user
> > don't need to pay attention to this value.
>
> I suggest changing the default value of sys_hung_task_warnings to -1.
>

Yes, that's what we have did now.

> >
> > With this patch, hung task warnings will be reset with
> > sys_hung_task_warnings setting in evenry check interval.
>
> Since it is uncommon that the messages are printed for more than 10
> times for one check_hung_uninterruptible_tasks() call, this patch is
> effectively changing to always print the messages (in other words,
> setting -1).

If sys_hung_task_warnings can't be recovered, does it make sense to exist?
In which case do we need this setting ?

Btw, why the default value of this setting is 10, instead of -1 ?

Thanks
Yafang
