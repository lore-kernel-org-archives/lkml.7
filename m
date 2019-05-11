Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13048C04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 08:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF3B2183F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 08:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMl649QE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfEKIEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 04:04:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52676 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfEKIEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 04:04:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3so106595wmm.2;
        Sat, 11 May 2019 01:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=RiApvCW/EDWmoLHPwwokM8Z2q4egWD6HO/9afTP1gpo=;
        b=OMl649QECwuEVR6KOuWhcB+bqTaYpp0THi+xtT3rNj2o6SuKbsv6wjiZpfbdiGjNwQ
         VZ8gdM720yeRIo4B0h7FU9twNN79L9rN46cY5Lq4n4LO/lHPk+dJKy31U6djRMdLKqGQ
         HZgjadz158AmhftMIVoI2/YiyiTDDXFU8XhOKztw7o3GesYX8JPqjTxcRbSbdD+XBHux
         ILCeF0zNCcJhz2T7vYkZvP4My7kMFjNuZJxyH6A9k7ysosDBhR06V5TtAzfDrgyXBPqc
         iH2HkvH7i30E2Q/0vW93cEionSnaNSdcZ/ukaa4g75nc/lU69KYDUrMqq9EongLPasTe
         0K/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=RiApvCW/EDWmoLHPwwokM8Z2q4egWD6HO/9afTP1gpo=;
        b=lSqW04UfxTh+Yka7EYQlwNxVBqdj7pDYWbhJgFxBGoFuVj6Inb1GEa1a+J8SR8+bkd
         UTh3ru3LkarESlDls6OXybxBL4SykttUZNnt7jZ4tFvGoRYsMRkxiC8pPLH3eQ/IUd6+
         VaNXnCKuqQefPUb7H7haafUozbDwdKJyoHU3yK869LxVwTXD+hi4cD/AEkWDOhiYhe5R
         msIZyzh6UvGl0tdCRnIXh8LIxQhATzkTndeu5mFCwzyxXkAEFiN2cBqE/PtGEeN2ZOWr
         KxaCiT3ydHFKEpt/8GSL5vGJDEodmbD78snHh+6ugpH7ITCYEghzIEsISXmvz/kvrDOR
         EcIw==
X-Gm-Message-State: APjAAAXKnlThLbFx+hSZ2KB1wxEPXoXmMb+n0Ri8Y6CRmyYyFCuM5CFo
        R/NjQuvukc0jE/yO8yxvQCSCzEnT7xAwSgpNPq8=
X-Google-Smtp-Source: APXvYqxyzYRMtFJZHVTDGyMNXJQS3iuhm7btNZcTohlbrm0YWyyKyGYTxh2ZoVaiXtn12YlcWA5rmMCznaZ8IHrV5/U=
X-Received: by 2002:a1c:a008:: with SMTP id j8mr9768369wme.73.1557561846582;
 Sat, 11 May 2019 01:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWSJSnKcoYeh__v_BLnXP5O0XGewLdGenz13extauRr_w@mail.gmail.com>
 <20190511055210.GF14153@kroah.com>
In-Reply-To: <20190511055210.GF14153@kroah.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 11 May 2019 10:03:54 +0200
Message-ID: <CA+icZUVSL_fPBQaJaq_MZ9vhjZS509WzpkZH_7J55EKppqRo4g@mail.gmail.com>
Subject: Re: Linux v5.1.1
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 7:52 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 10, 2019 at 09:47:14PM +0200, Sedat Dilek wrote:
> > Hi Greg,
> >
> > I have seen that all other Linux-stable Git branches got a new release.
> >
> > What happened to Linux-stable-5.1.y and v5.1.1 release?
>
> Dinner happened before I could get to them all :)
>
> > Is there a show-stopper?
>
> Nope, nothing was "supposed" to be released until today, according to
> the -rc announcement, so there's no real issue.
>
> Dealing with 5 stable trees at once is not trivial, please give us a
> chance...
>

Hehe.

I hope you had a wonderful dinner and I was not complaining...

Thanks.

- Sedat -
