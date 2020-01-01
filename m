Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8432C2D0DE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 22:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8060E2072C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 22:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUagTsNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgAAWux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 17:50:53 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45186 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbgAAWux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 17:50:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so30250741qkl.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 14:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ypv53uIb6kuw7M/5S57dRaQlQX5A0Akbwb84pMvM1bE=;
        b=JUagTsNiPiJoebWjJs2NII/lUJJ4GiuDl5aSoJ2O9XsTW8JDLYUOW/du6wyp6FFrtz
         1zwMOhEiMJs9JHSrb60fPOeuem98OCRtrASVUSVJU1YzCDtCpPkZqOD5Yrr3rvdzKsy3
         G9dqXUOKM8pGp4Xd8PHdJTSv49u0wEwbCUUhjEGuI1esZvZtscQKzTzxy4qKmSksvaMO
         nF5rKxyMzN6mCkyujnoo95JVkV5Z+acJ4EKkSwN1aFxELSZHfXu6YfqVOofDsgEDQyMP
         owcVdHnUqVuzywY7eDpH6t04/G7f0Wxe57B/fBtknQMcXl87zlXMZGq7UezvY6pWzBWR
         xSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ypv53uIb6kuw7M/5S57dRaQlQX5A0Akbwb84pMvM1bE=;
        b=JvSMPgghVzKjgbtMik6EaHZUxJ6WYpZFm3wYVAwjNwR46NNmqViK13VZWwmzXMTOIi
         GZXav6jbeHD2ebegxU2xEGnwBkDpwTDOO9X0Jcqvr0Te1hOQI00zJ8IR6C5Dv+e4ZzB9
         pdciOzGticLT+9Hm0labENI0WLVjP4iHaKIkvwUEiR13uEsJCIfPQqszJWXOFECMRSNc
         A6N0BYdhqt1J3goWWXUxOSQnYjCw4uSvbfvO/K3uMGKbJNOmNHAHgMxdL/FDaG0Z+2Gl
         3K6DrCjFzN5+ytOqTCq5zBls7Ca1habS+i8hUZ1geXZPmfx4NaQT6pcKq8gmxy8QPLPg
         9XqA==
X-Gm-Message-State: APjAAAXDLnVTtp/sJkC0ROTR1qal4dW1Nz78Pz+3kVbIxmFbBGR32u33
        d6a0pXTGGdvAMZ5ymCYAFBc=
X-Google-Smtp-Source: APXvYqzCjOnpQD5aj7zJNzkPqlMVxzj6dkZ2A/CeHKO/ghcWL/EF7U5791gdtgFoGgM2+QNR3hUGDw==
X-Received: by 2002:a37:e317:: with SMTP id y23mr64466613qki.431.1577919052325;
        Wed, 01 Jan 2020 14:50:52 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z4sm16520428qta.73.2020.01.01.14.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 14:50:51 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 1 Jan 2020 17:50:50 -0500
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        youling 257 <youling257@gmail.com>
Subject: Re: [PATCH] early init: open /dev/console with O_LARGEFILE
Message-ID: <20200101225049.GB438328@rani.riverdale.lan>
References: <20191231150226.GA523748@light.dominikbrodowski.net>
 <20200101003017.GA116793@rani.riverdale.lan>
 <20200101183243.GB183871@rani.riverdale.lan>
 <CAHk-=whzgLPi4szh8xOKysuS9CKaQESngc=n0omBVpwdQ822aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whzgLPi4szh8xOKysuS9CKaQESngc=n0omBVpwdQ822aw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2020 at 01:39:00PM -0800, Linus Torvalds wrote:
> On Wed, Jan 1, 2020 at 10:32 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Also, this shouldn't impact the current issue I think, but won't doing
> > filp_open followed by 3 f_dupfd's cause the file->f_count to become 4
> > but with only 3 open fd's? Don't we have to do an fd_install for the
> > first one and only 2 f_dupfd's?
> 
> I think *this* is the real reason for the odd regression.
> 
> Because we're leaking a file count, the original /dev/console stays
> open, and we end up never calling file->f_op->release().
> 
> So we don't call tty_release() on that original /dev/console open, and
> one effect of that is that we never then call session_clear_tty(),
> which should make sure that all the processes in that session ID have
> their controlling tty (signal->tty pointer) cleared.
> 
> And if that original controlling tty wasn't cleared, then subsequent
> calls to set the controlling tty won't do anything, and who knows what
> odd session leader confusion we might have.
> 
> youling, can you check if - instead of the revert - this simple 'add
> an fput' fixes your warning.
> 
> I'm not saying that the revert is wrong at this point, but honestly,
> I'd like to avoid the "we revert because we didn't understand what
> went wrong". It would be good to go "Aaaahhhh, _that_ was the
> problem".
> 
>                  Linus

Shouldn't that only affect init though? The getty's it spawns should be
in their own sessions.
