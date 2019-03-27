Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE04C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F85206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k11EeTyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389005AbfC0TQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:16:30 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43290 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388568AbfC0TQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:16:28 -0400
Received: by mail-vs1-f66.google.com with SMTP id i207so10618422vsd.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BAs42VnbyZGCqFFb0/7TjYtBvamfLnChRfKlWZNyr0A=;
        b=k11EeTyw/SvGiiVWALDSTI176eb/8Q+iZIQ8tPs3y3X3d11r6WdB8GeHjfOX5hb1fs
         bMMkG4BtpHNEAPvkwPRHxG5/UlkSIGN7hdJwVuGEosj2UJeyNFbvk446UumUmRBTRLlZ
         oeo1p4mbbNp8bsaTHgloQJ535nDo75eyVdUkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BAs42VnbyZGCqFFb0/7TjYtBvamfLnChRfKlWZNyr0A=;
        b=IdqjZCC+wBwCMzmUEBuN085im6NN8B3gasejZv5WCBjiQ1sTZm2NfIrNkpEGoNsdPt
         g7miBxJo861hmk+X1de3ao3DEFY78EILVLy5EP4SUZMDZjTlPAPE6MKmcfvBHhh9bCYM
         z77TDTBCjhs9Su70JnlKTt4U3qzRMswc2eCy4iQvGQ7WEW22jP0fsm4QUfLhqOm24RqJ
         sM7W0ZZOUrhhytYPv9jlXuxBCqGrDErgoMOh9+VINoGm50DePuP5beMxlMwJ0HmK+VEO
         doZhbkyD8TpfOo2H4LSldL6BpZvUMVEJcPfDPrheHisbN85+AIjXx8PGWr19DtCiGYGR
         I5hg==
X-Gm-Message-State: APjAAAWeZ4y4+wyqsqnEhfm6udXRueFEVDhuAWn44wUrT5YGUMTSUaJU
        MUKr5fDJLyQCUjeSge1ZD8G7ZlvJ4IE=
X-Google-Smtp-Source: APXvYqwGb+eQX4QlAUTSd9Kg/Jcf7OhLksv33nelishhsGiFdTMVCltYnxHqTbz55xEwxX1d7R561w==
X-Received: by 2002:a67:de0c:: with SMTP id q12mr23676784vsk.156.1553714186600;
        Wed, 27 Mar 2019 12:16:26 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id s189sm5145214vks.25.2019.03.27.12.16.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 12:16:25 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id e131so3925161vkf.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 12:16:25 -0700 (PDT)
X-Received: by 2002:a1f:2acb:: with SMTP id q194mr22206830vkq.92.1553714184850;
 Wed, 27 Mar 2019 12:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgg_PRWs3a6u2gnFLQjhxOJcrFkqqWVnLw60eQAwD-DNw@mail.gmail.com>
 <2d4f3bfa-22c7-a18c-3902-fe1b6ac401f7@infradead.org> <alpine.LRH.2.21.1903260607500.13529@namei.org>
 <8811b2e4-28e1-2f01-024b-fb7d0196483f@i-love.sakura.ne.jp>
In-Reply-To: <8811b2e4-28e1-2f01-024b-fb7d0196483f@i-love.sakura.ne.jp>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 27 Mar 2019 12:16:12 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJZ1H1RFMFBxPsoBW+T17ya+50-d7-31Gr9ciRgpCOaDA@mail.gmail.com>
Message-ID: <CAGXu5jJZ1H1RFMFBxPsoBW+T17ya+50-d7-31Gr9ciRgpCOaDA@mail.gmail.com>
Subject: Re: Linux 5.1-rc2
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     James Morris <jmorris@namei.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 2:06 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/03/26 4:08, James Morris wrote:
> > On Sun, 24 Mar 2019, Randy Dunlap wrote:
> >
> >> On 3/24/19 2:26 PM, Linus Torvalds wrote:
> >>> Well, we're a week away from the merge window close, and here's rc2.
> >>> Things look fairly normal, but honestly, rc2 is usually too early to
> >>> tell.  People haven't necessarily had time to notice problems yet.
> >>> Which is just another way of saying "please test harder".
> >>>
> >>> Nothing particularly stands out. Yes, we had some fixes for the new
> >>> io_ring code for issues that were discussed when merging it. Other
> >>> than that, worth noting is that the bulk of the patches are for
> >>> tooling, not the core kernel. In fact, about two thirds of the patch
> >>> is just for the tools/ subdirectory, most of it due to some late perf
> >>> tool updates. The people involved promise they're done.
> >>
> >> Hmph.  I'm still looking for the patch that restores the various
> >> CONFIG_DEFAULT_<security> kconfig options to be merged.
> >>
> >> https://lore.kernel.org/linux-security-module/2bf23acd-22c4-a260-7648-845887a409d5@i-love.sakura.ne.jp/
> >>
> >> since commit 70b62c25665f636c9f6c700b26af7df296b0887e dropped them somehow.
> >
> > AFAICT we don't have a finalized version of the patch yet.
> >
> > Kees?

Sorry for the delay -- back from travel now.

> As far as I can tell, Kees's comment
>
>   It breaks the backward-compat for the "security=" line. If a system is
>   booted with CONFIG_LSM="minors...,apparmor" and "security=selinux",
>   neither apparmor nor selinux will be initialized. The logic on
>   "security=..." depends on the other LSMs being present in the list.
>
> was just a confusion

Yes, you are correct here. This is what I get for drive-by comments
while travelling. :) However, I don't like that it creates an
incomplete LSM list for no reason. I'd like CONFIG_LSM to be built in
a way that future stack-enabling will Just Work. Leaving off LSMs
means it won't. My original patch doesn't change the behavior relative
to the old configs (i.e. the CONFIG_DEFAULT_SECURITY_* will still be
selected and turn off the others) but does allow the other LSMs to be
initialized in the future once earlier ones in the list become
stackable.

The part I don't understand is what you've said about TOMOYO being
primary and not wanting the others stackable? That kind of goes
against the point, but I'm happy to do that if you want it that way.
If so, my current proposal would be:

 config LSM
        string "Ordered list of enabled LSMs"
+       default
"yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor" if
DEFAULT_SECURITY_SMACK
+       default
"yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo" if
DEFAULT_SECURITY_APPARMOR
+       default "yama,loadpin,safesetid,integrity,tomoyo" if
DEFAULT_SECURITY_TOMOYO
+       default "yama,loadpin,safesetid,integrity" if DEFAULT_SECURITY_DAC
        default "yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

Note that the last default line holds for both "new build" and
"selinux chosen". The other change from my earlier patch is that _DAC
must turn off all the legacy major LSMs to get the behavior Randy was
expecting. Shall I send a patch that does the above, or is there
another wrinkle?

Thanks!

-Kees

> the finalized version.
>
> From 72f5f21b800c87f9ec3600f6e3acfb654690d8f0 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Tue, 26 Mar 2019 05:56:30 +0900
> Subject: [PATCH] LSM: Revive CONFIG_DEFAULT_SECURITY_* for "make oldconfig"
>
> Commit 70b62c25665f636c ("LoadPin: Initialize as ordered LSM") removed
> CONFIG_DEFAULT_SECURITY_{SELINUX,SMACK,TOMOYO,APPARMOR,DAC} from
> security/Kconfig and changed CONFIG_LSM to provide a fixed ordering as a
> default value. That commit expected that existing users (upgrading from
> Linux 5.0 and earlier) will edit CONFIG_LSM value in accordance with
> their CONFIG_DEFAULT_SECURITY_* choice in their old kernel configs. But
> since users might forget to edit CONFIG_LSM value, this patch revives
> the choice (only for providing the default value for CONFIG_LSM) in order
> to make sure that CONFIG_LSM reflects CONFIG_DEFAULT_SECURITY_* from their
> old kernel configs.
>
> Reported-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/Kconfig | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/security/Kconfig b/security/Kconfig
> index 1d6463f..2f29805 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -239,9 +239,44 @@ source "security/safesetid/Kconfig"
>
>  source "security/integrity/Kconfig"
>
> +choice
> +       prompt "Default security module [superseded by 'Ordered list of enabled LSMs' below]"
> +       default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
> +       default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
> +       default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
> +       default DEFAULT_SECURITY_APPARMOR if SECURITY_APPARMOR
> +       default DEFAULT_SECURITY_DAC
> +
> +       help
> +         This choice is there only for converting CONFIG_DEFAULT_SECURITY in old
> +         kernel config to CONFIG_LSM in new kernel config. Don't change this choice
> +         unless you are creating a fresh kernel config, for this choice will be
> +         ignored after CONFIG_LSM is once defined.
> +
> +       config DEFAULT_SECURITY_SELINUX
> +               bool "SELinux" if SECURITY_SELINUX=y
> +
> +       config DEFAULT_SECURITY_SMACK
> +               bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
> +
> +       config DEFAULT_SECURITY_TOMOYO
> +               bool "TOMOYO" if SECURITY_TOMOYO=y
> +
> +       config DEFAULT_SECURITY_APPARMOR
> +               bool "AppArmor" if SECURITY_APPARMOR=y
> +
> +       config DEFAULT_SECURITY_DAC
> +               bool "Unix Discretionary Access Controls"
> +
> +endchoice
> +
>  config LSM
>         string "Ordered list of enabled LSMs"
> -       default "yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
> +       default "yama,loadpin,safesetid,integrity,selinux" if DEFAULT_SECURITY_SELINUX
> +       default "yama,loadpin,safesetid,integrity,smack" if DEFAULT_SECURITY_SMACK
> +       default "yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT_SECURITY_TOMOYO
> +       default "yama,loadpin,safesetid,integrity,apparmor" if DEFAULT_SECURITY_APPARMOR
> +       default "yama,loadpin,safesetid,integrity"
>         help
>           A comma-separated list of LSMs, in initialization order.
>           Any LSMs left off this list will be ignored. This can be
> --
> 1.8.3.1



-- 
Kees Cook
