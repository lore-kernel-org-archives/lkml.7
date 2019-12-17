Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B67C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE99D21582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576615227;
	bh=vRwe/+KVwzNfxyOTGHd2lJI5Qvmm6ArlVTdFlgVjSuc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kA3i76BCQIN1joxjV724X5kPQZcLXsGQCcllO3v8L1xZEhh4MLKaD7VqBC6heHITi
	 BEZAfFz8j/+r52DqtGZPG31TqKFEnYrD3sFCcPfXzfADPwsO3fgZihEVRTqoDVcV2I
	 PIVH/rTcP0IasVEc4eKtiX7lzyqt0oz6KSiDLgsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfLQUk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:40:26 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37952 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfLQUk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:40:26 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so7954102lfm.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 12:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1UVWu00nZlnL+gSKSf+cYvswvY2Irci1SeQ3MCQ5Q0=;
        b=abj0IKuOCgcU6SWlN3sX6zMFg345ZVN2DnXZ9SRr4NYFVRrccR9oTW9nm41eaSIqTB
         bK0MSdhqYdHm25aPG53SYvLba08MJIScLkS9CwO2/Z6VvfU4vlxKSL783ucCUEwm9LEw
         mc7PshrW4thetnIpE/uEjUH08H5ySbZdktI4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1UVWu00nZlnL+gSKSf+cYvswvY2Irci1SeQ3MCQ5Q0=;
        b=czEXFBw8SGOEun/UCRQGFB+NxNjbTRrXBZcqBVotV1KHJvFMPX3D4DlfobH2nVIEKR
         3IgQ1fRaaSEogO2RIugFJUOntXXZ2KC4S4NH+xEARzZm4zk776Gkv25sHqSUmnAcvz00
         H7F960ISzOoNDgjBil5Cu814KPc/nKRPbkivynwlBd9ydpBNDM+7E61NxP0Vr28Sd3Pu
         o6GPaXX2MdqkBMIWI3ON4oN7YtxfGWx1sKkd7zEP4R0Rx9cktur5qVwEjcl0SBiiqGx7
         5huXs3Vh+91NiEnOo5zpbO0vKv3cZMRD3u727m3wEiym0/Ejn+IW+GOfRM5uGuZ05y5S
         xIhA==
X-Gm-Message-State: APjAAAUtV6rAaY/aTt+pw9ZPZV6LPk0RVHaMSJ0f54TgIowIxWYBBMge
        Mm3Zkp0E//12PODzSTOEdNnmxTHvOC8=
X-Google-Smtp-Source: APXvYqwxYOc+8FsrVMk7fECuzjA+akqaoP7hmfG8dGB+hK/cCtc8ApNCQw5ZB827PRVzn/lfxFvhuw==
X-Received: by 2002:a05:6512:c7:: with SMTP id c7mr4160210lfp.120.1576615224129;
        Tue, 17 Dec 2019 12:40:24 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id h24sm13077194ljl.80.2019.12.17.12.40.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 12:40:23 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id j6so12491383lja.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 12:40:23 -0800 (PST)
X-Received: by 2002:a2e:99d0:: with SMTP id l16mr4701887ljj.1.1576615222887;
 Tue, 17 Dec 2019 12:40:22 -0800 (PST)
MIME-Version: 1.0
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <157644301187.32474.6697415383792507785.pr-tracker-bot@kernel.org> <CAJmaN=ksaH5AgRUdVPGWKZzjEinU+goaCqedH1PW6OmKYc_TuA@mail.gmail.com>
In-Reply-To: <CAJmaN=ksaH5AgRUdVPGWKZzjEinU+goaCqedH1PW6OmKYc_TuA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Dec 2019 12:40:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgjNqEfaVssn1Bd897dGFMVAjeg3tiDWZ7-z886fBCTLA@mail.gmail.com>
Message-ID: <CAHk-=wgjNqEfaVssn1Bd897dGFMVAjeg3tiDWZ7-z886fBCTLA@mail.gmail.com>
Subject: Re: [GIT PULL] remove ksys_mount() and ksys_dup()
To:     Jesse Barnes <jsbarnes@google.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:33 AM Jesse Barnes <jsbarnes@google.com> wrote:
>
> Still debugging, but this causes a panic in console_on_rootfs() when we try to dup the fds for stderr and stdout.

Duh.

That series was incredibly buggy, and there's another bug in there.

I think this should fix it:

  diff --git a/init/main.c b/init/main.c
  index ec3a1463ac69..1ecfd43ed464 100644
  --- a/init/main.c
  +++ b/init/main.c
  @@ -1163,7 +1163,7 @@ void console_on_rootfs(void)

          /* Open /dev/console in kernelspace, this should never fail */
          file = filp_open("/dev/console", O_RDWR, 0);
  -       if (!file)
  +       if (IS_ERR(file))
                  goto err_out;

          /* create stdin/stdout/stderr, this should never fail */

and yes,that particular problem only triggers when you have some odd
root filesystem without a /dev/console. Or a kernel config that
doesn't have those devices enabled at all.

I delayed pulling it for a couple of days, but the branch was not in
linux-next, so my delay didn't make any difference, and all these
things only became obvious after I pulled. And while it was all
horribly buggy, it was only buggy for the "these cases don't happen in
a normal distro" case, so the regular use didn't show them.

My bad. I shouldn't have pulled this, but it all looked very obvious
and trivial.

              Linus
