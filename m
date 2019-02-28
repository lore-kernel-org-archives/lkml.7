Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9470C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA75C21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k/dlvZl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbfB1KXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:23:55 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36873 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732289AbfB1KXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:23:54 -0500
Received: by mail-it1-f196.google.com with SMTP id z124so14883715itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 02:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bcuts4AkJqYSdvRXdxZeMi1+ECwAYy2h1Q+wc2Bf0ls=;
        b=k/dlvZl7i9q0BdVNxxiLDQijx2RYemN0CkjktCRxIXSXzCpA3TzfP7eqNoBEJkqmdG
         imYy1bDkCs1YwAkh1A/7O/TVUIbcfLzp9bEvT6lB138zvQdXbdGcuchVy5uDIkKQY5S2
         JLJasNpXp3QVGiOf+C1mylp+dluxXYXS9NpuUed3Zf+8JoQA4MkVaQwuV690IStVxw+S
         6cicrW0k/cbb0KI0G1iO84IPsFTU1uCJE+lXUlr6bJyOtDcYnhLN/I0k/kIGDfEqi7eG
         giHHuKEmtSux29sfVYQglEdch4cmrz7Mh/r6XwPYy4teakuRZHoGVyEbfC7ZAfXx0Qit
         6veQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bcuts4AkJqYSdvRXdxZeMi1+ECwAYy2h1Q+wc2Bf0ls=;
        b=gcmkM1W4ZrGTZuoPFY6EsR4yBh9AmPS7LZUNj+UoC8BHy2wQjWNahI6JVCMTa1bijA
         HH0DX3592EDAqrzDskudI2p0diJ7woo0MhCh5x7+hv9nGgGAKN41yKPruhj7XeMLsas1
         e4oXvBEf9ggyNMwhEcdTGedz1IhU3U6/vJuogqEzixqTivbCGuZbqgar6mG/XlS3NY6W
         7TLUybEp18ytw9kOWGVWKxwMc6FX7ZaOMrM1c4rH8in90fj+eFrrPbcqw8AqCN3r3Ici
         r0tTbnPOzspKEcEPm7513LTVQH2vKIcNEaEhocmnCjRKve/SRDjOoV59vin8E6ZR/wPW
         8Gqw==
X-Gm-Message-State: AHQUAua7sh8+BVY5v2/zTbokz5fbYuzjSObZUg5iqPnkQ75Zqu40AkYG
        e1Plbrd2l9L/vYBDFDmkf2ittDGW/3ZIsmbUoFw7GA==
X-Google-Smtp-Source: APXvYqw3u13iOiwETRy3MtMJhTJYr6q4C5ylkodLhBWL7iyrQtpvhPqLAN2E2/LD2nM65AcTgv6V1rf5jnPR9T5rkkQ=
X-Received: by 2002:a24:c8:: with SMTP id 191mr2245990ita.166.1551349433764;
 Thu, 28 Feb 2019 02:23:53 -0800 (PST)
MIME-Version: 1.0
References: <0000000000001c63c80582e32294@google.com> <8d94063c-e10c-c470-8ce0-1f86c517b1b4@i-love.sakura.ne.jp>
 <CACT4Y+ZqjoXftDAby9s-YUrOv8txBFqKukRcxP6ty3LLKz_+Hw@mail.gmail.com> <722a3390-3112-0067-282c-b94a8be53aa0@i-love.sakura.ne.jp>
In-Reply-To: <722a3390-3112-0067-282c-b94a8be53aa0@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Feb 2019 11:23:42 +0100
Message-ID: <CACT4Y+aXA4fh9Z=vKKVi-vids4O_npkUDqccD1eUS+gNV7WyGA@mail.gmail.com>
Subject: Re: kernel panic: MAC Initialization failed.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:20 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/02/28 15:51, Dmitry Vyukov wrote:
> > On Wed, Feb 27, 2019 at 11:37 PM Tetsuo Handa
> >>
> >> Thank you. The LSM stacking seems to be working as expected.
> >> But this one should not be considered as a bug.
> >>
> >> If something went wrong before loading access control rules,
> >> it is pointless to continue. Thus, stopping with kernel panic.
> >
> > Hi Tetsuo,
> >
> > What misconfiguration you mean?
>
> To use security modules, access control rules need to be loaded. Regarding
> TOMOYO, access control rules can be loaded from the kernel itself (built-in)
> and/or from /etc/tomoyo/ directory via /sbin/tomoyo-init (run-time).
>
> Since the kernel is built without built-in policy and /sbin/tomoyo-init does
> not exist, memory allocation failure is handled as a fatal problem.
>
> But if syzbot cannot test other paths due to hitting this path, we need to somehow
> avoid panic(). Can you add tomoyo-tools package into your rootfs images? It is
> explained at https://tomoyo.osdn.jp/2.6/chapter-3.html .


Is installing the package everything that needs to be done? It's not a
standard package, right?
What does it do? Frequently there is like 3 DVD's of some software,
but everything that needs to be done is a single system call? What
exactly from kernel perspective we need to do?
