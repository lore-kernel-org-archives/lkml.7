Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A4FC10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BC220855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMpCTZim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfCHU4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:56:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33358 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfCHU4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:56:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id h11so15066024pgl.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 12:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nV+rJZoZdmpxnwi+SrbTvBC3ObGTQ9IWO3/GGvlcy1Y=;
        b=UMpCTZimjLlUnjBSPVnMdWjSfenYSzkF9zobLaaIhl6zXR/C8TSibYnoE6Kjcxrf5h
         0DUWhqKjuugmxuNaDRkYQbKE+wwAed7G67axF3XTXteVVPNcOA9g4yO8n70/JXtVmk6N
         FnRexuuiy63KfexVTZ3Rlp3DzTl6aPzmC6A8SNsFHdzM3g5n65HJMUwnRgjWSX6T+yeX
         83bUL8UExrz+gs3R5olqp5SUCCyo0qoHJNebnv5BBnK+D8gyBtK1wOp+Zd7PUlCdP579
         nTiL9MVM8gJW464bZDz5E9yEx7Yy8XTsKLuRJpS0cm8yVBhfa+2auUOVh+6E5SJTarBT
         BH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nV+rJZoZdmpxnwi+SrbTvBC3ObGTQ9IWO3/GGvlcy1Y=;
        b=F/jVIPEEqWkQO2EoIxCJy2FTyxAVL6VwWwHAp8w/rQvOdrburilDe8AZjZAtsAUGg7
         Rfa2kGliG6P2YImyOegYwDzqQ2VPbYtpBW4cBI7nolDExz+qEhvg4HVNAcwVIX0OToHg
         ZhlYUVczvhuWZfzW3idHRvifi2XdC3PplsQDzlP1xlH/Ib3qBdcjt3MZ2F8iEyejt3Zz
         mGfZcODeQW0R6LZJF4dyDhqDUxQSZ3W53Z0Wkh4dGvhm2vz/71mRXr9da+yB+PzysNP+
         FuLy2s75qFMXDvm1pRh5HfjGK7AE43AVL728LXQ/a0RkFbzi8OqrtivHcdzSCFM8Vimy
         vDlA==
X-Gm-Message-State: APjAAAWT+nok2gKkkwshFJbUyt9gkY2bIgBXZ9EKTrjrWvw6T3Upr2gl
        yHgrkIztDvHMEMmnKsQBGrN6PZJQ0/Mau1V2N23ppw==
X-Google-Smtp-Source: APXvYqzfrenlYnSiYKUTTXZtE/jr+d0oqfLL+VS/KE2z+bfEsXgL+SXCjaYV5HWBeY38Ct+HeAkFf3mfEqElmqlODSA=
X-Received: by 2002:a63:f544:: with SMTP id e4mr1426709pgk.145.1552078599798;
 Fri, 08 Mar 2019 12:56:39 -0800 (PST)
MIME-Version: 1.0
References: <20190305103014.25847-1-kieran.bingham@ideasonboard.com>
 <CAKwvOdnOuXhkwizSnp6qOwJkisHKEBs=2xSvHaus3Yhdx2xE-w@mail.gmail.com> <20190308123655.GA13818@kroah.com>
In-Reply-To: <20190308123655.GA13818@kroah.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Mar 2019 12:56:28 -0800
Message-ID: <CAKwvOdm8nbXvjgOk4eqYQYG3uXLGJhgHe7DspB0nF18+POx8Eg@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/gdb: replace flags (MS_xyz -> SB_xyz)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Kieran Bingham <kbingham@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Dan Robertson <danlrobertson89@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 4:37 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 05, 2019 at 01:47:58PM -0800, Nick Desaulniers wrote:
> > On Tue, Mar 5, 2019 at 2:30 AM Kieran Bingham
> > <kieran.bingham@ideasonboard.com> wrote:
> > >
> > > From: Jackie Liu <liuyun01@kylinos.cn>
> > >
> > > Since commit 1751e8a6cb93 ("Rename superblock flags (MS_xyz -> SB_xyz)"),
> > > scripts/gdb should be updated to replace MS_xyz with SB_xyz.
> > >
> > > This change didn't directly affect the running operation of scripts/gdb until
> > > commit e262e32d6bde "vfs: Suppress MS_* flag defs within the kernel unless
> >
> > Note to stable, e262e32d6bde landed in v5.0-rc1 (which was just
> > released), so we'll want this picked back to 5.0 stable once this
> > patch hits mainline (akpm just picked it up).
> >
> > Just following up to say that without this, debugging a kernel a
> > kernel via GDB+QEMU is broken in the 5.0 release.
>
> I do not understand, sorry.  Specifically, what git commits do you want
> applied to which stable releases for what reason?

commits: 663cb6340c6e
release: 5.0
reason: kernel debugging scripts in gdb are broken since v5.0-rc1 via
e262e32d6bde
-- 
Thanks,
~Nick Desaulniers
