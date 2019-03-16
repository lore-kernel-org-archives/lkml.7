Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2EEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C9D218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vd2UZ7IC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCPPK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:10:28 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39579 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfCPPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 11:10:28 -0400
Received: by mail-it1-f193.google.com with SMTP id l15so15403709iti.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkTDSbQzw2+olZOctVQP5qL+c8FHI1uVKJOTh59K2fg=;
        b=Vd2UZ7ICAZJeelXJO0a24gBxjI/N1dvEETUO2K2AAsvinVoE5NgPhmN/gUtlG8sY/S
         ZByZLfm6/3s8VUgHAGJxzphro7G2uh1zR+B4O/cPGNAq4WiGf7V+kGERxcSQF0Eci16q
         PAfoVIB4dT/cZt9+nxu8JK3rjC5OjFCqbqOtV+gtUWH6T1+Ei7reOexdmdTSf7mGU0XG
         EzzWJi4KTuZiGfcmX3pO7OwuGxcHwSpotbroczSFNVrFI60vjl+91EXM0vep//ZQp9lA
         xL6Z5Yyt0O5VTge0x4f4TtWFFGFGW6+ubiZX4aTNx+W6PVgh4O1xEuCMYqSD5R7OE7Qf
         WbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkTDSbQzw2+olZOctVQP5qL+c8FHI1uVKJOTh59K2fg=;
        b=NajhiNDeCqsiOdWwmF7oGvoYTL0ZGRgfka5Pg2sKsMm2NMGspyWrFWdg5cpcBGfp43
         MsR097PyXKunEPneYcPjD/1TfZpK4+c6Ah5LGw2+fB0KrbFwOBzlIWX56Sdo+pqjkdIa
         OnLzHW7LWXJndGAT1wHIXT4vdaGcqFmpyxNHKpLQ/dLjCn2Z4Bv4/4YDNBkuHtgheW7s
         2bU1mDx8m3xEvEQoqXLKdz2Rp3RPFuyim2iedHlTI5GZlX8drDDmRAY85JAIUsYihTef
         85wRL1n3tzcFHNgfNItK46w5Vbi2g1pNVYLvj5eKq7aNGDihoR8GJGh32auFW4fHTFxH
         XFTA==
X-Gm-Message-State: APjAAAU+iWveMg3eyI36FdGBTiOeDL9TR7kpQ9u0Yl/AoZ5sWf78djpu
        5gUkvoh4S3vDqlxPe3DbiorG/A5T+FQ0JeE3Y3sMfw==
X-Google-Smtp-Source: APXvYqzMYzWAgmneuO87STKTvpCpiLzed682ROwOpKqYJ2NtjQpKxTvQ5sHk2uCSAof8lSey8xGHQGbOSqP+f8Pvcqw=
X-Received: by 2002:a24:674a:: with SMTP id u71mr5552481itc.12.1552749027098;
 Sat, 16 Mar 2019 08:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <0a0d282b-6757-5f42-b888-ef52b040aaa1@i-love.sakura.ne.jp>
 <CACT4Y+ZBpfLpk0FRp7O8Ut=mmf-uddK_fLMDHtPkf6FnMGMqPA@mail.gmail.com>
 <f015f007-2402-27a0-1694-93b1bcffe84b@i-love.sakura.ne.jp>
 <20190316141410.GA18654@tigerII.localdomain> <CACT4Y+YEx5PF7QqaLdYpkyBCr_eBgp1n2yuY2LyrN9iZANXgzQ@mail.gmail.com>
 <647012f4-c221-addf-51ab-586014e8f435@i-love.sakura.ne.jp>
 <CACT4Y+Zg4RVbV=ePRYff9BbpqAg0bOUS79Os5kzQXF39z_KSLw@mail.gmail.com> <2a48dee7-b649-65a4-be5d-8b3374013cee@i-love.sakura.ne.jp>
In-Reply-To: <2a48dee7-b649-65a4-be5d-8b3374013cee@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 16 Mar 2019 16:10:15 +0100
Message-ID: <CACT4Y+ay7nuT-7y2JARozV1s0VisuLdN6VT+w9OsEDs1PeBRoA@mail.gmail.com>
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 4:02 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/03/16 23:57, Dmitry Vyukov wrote:
> > On Sat, Mar 16, 2019 at 3:53 PM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> On 2019/03/16 23:16, Dmitry Vyukov wrote:
> >>>>> Maybe try running with "ignore_loglevel" kernel command line option added?
> >>>>
> >>>> Right, that's something I would expect 0-day and syzkaller to do.
> >>>
> >>> to double-check: enabling this won't lead to verbose/debug level of logging?
> >>>
> >>
> >> I don't know what "verbose/debug level" means. But enabling this option causes
> >> KERN_{EMERG,ALERT,CRIT,ERR,WARNING,NOTICE,INFO,DEBUG} be printed equally.
> >>
> >>   "ignore loglevel setting (prints all kernel messages to the console)"
> >>
> >> static bool suppress_message_printing(int level)
> >> {
> >>         return (level >= console_loglevel && !ignore_loglevel);
> >> }
> >
> > Then I don't think it's suitable: there will be too much output.
> >
>
> Then, we need to find what test is changing console_loglevel.
> Maybe add debug BUG_ON() in linux-next.git using CONFIG_DEBUG_AID_FOR_SYZBOT ?


Is there a single place to catch this? I could run syzkaller locally
first with the check.
