Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C176C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FE02084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaUgNytS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfFQMUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:20:47 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34929 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfFQMUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:20:45 -0400
Received: by mail-vs1-f66.google.com with SMTP id u124so5965261vsu.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 05:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h6E2Ip34X/NLucxUj+SAkivtur6dQeITpi+3ydY7xI0=;
        b=VaUgNytSxrZHTdPy4AHf679viycuTT6TSbjD97ksFXQstGJ82OF4pQ79sVLFQZQhN+
         TAuv5O2zEPG++5ULYyed+wDJ5gD2Dqj0QNEzc6xYj4nzpZTwncw9qHWxhO6uVJGU+EYS
         2EbluPNmffJYa8MDJ+KpRZqomOybDNanPvTv+/o3haL3l7jK1LYduPX7LAks6bEOSRAB
         Ten84501wJz8bGfC9E0wLG4zBNZLaFYPikgrBwnDcGtcQe9IxcbgCH3GWG/SspfXvqP9
         zgqRTcV4gdtH0YJ7d3VGLRfctNOdxQZCumldkSAga6QkZJaEAFxC0NobHLu/1cHYL9Qj
         jdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h6E2Ip34X/NLucxUj+SAkivtur6dQeITpi+3ydY7xI0=;
        b=MYykcE7iVsYCDJT/vnNjb+D+yBxIck7UA93FNLBUWPNmny8fIVh+0WrBuUA4LbzwoP
         b5cuz4tfoLGBsit8i91Le7tiI644NRWWcKavZ4oJmLBUqKYlGLxWx4jmkRo/y53DmbpL
         PUB0AZo6WBGNHP/nr4JFQKQ74dfHeA3paPTQF8+sXmmjCiZN8x494h4jAuLbvjW/cwOq
         FZ58RvLhx855w1/tVp+uXoLfbJSvRbcpHVEAD6HmhsbKFI4VdJeQNmxju0ajL8v/L6JQ
         znBQ+JVjf6QQ7OHS+DiLjFBeNf5uZNTyY35Y3j4o9emz846/0eg665rKBC9fUOhmIE03
         pbLg==
X-Gm-Message-State: APjAAAU9PnZNedsmr2Zky55nZ6DvGwDYcNRW41y2xAsZB2N4hjtvMT8x
        +UKU+tRqtS9623lFmQr0jaI8n9dGC26IV8k2Z81f7QLh
X-Google-Smtp-Source: APXvYqxMJLMuFqwF6SNEbeLs9khmkOhZ5vp7TF3Ik3nkRvURQ4fTn76Oh+GhbDbYR/M64gcI1PcWhg4Eko/OqHDU99I=
X-Received: by 2002:a67:6d44:: with SMTP id i65mr59348095vsc.106.1560774044360;
 Mon, 17 Jun 2019 05:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLifSHQmi+jCMzRGYz3kzct+NB_vyv-yiwL91adRZPkTrQ@mail.gmail.com>
 <CAOfkYf7BZ1Ttrm7iVioq4mxZcJy7V44gNmusavPzgi=59=TY6g@mail.gmail.com> <13999.1560455005@turing-police>
In-Reply-To: <13999.1560455005@turing-police>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 17 Jun 2019 17:50:32 +0530
Message-ID: <CAOuPNLj4useN+BiPJvd2MRMntELt=_Kc_8x=mbxfrkgWh5v7Mw@mail.gmail.com>
Subject: Re: Pause a process execution from external program
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Shyam Saini <mayhs11saini@gmail.com>,
        open list <linux-kernel@vger.kernel.org>, pedro@palves.net,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 1:13 AM Valdis Kl=C4=93tnieks
<valdis.kletnieks@vt.edu> wrote:
>
> On Thu, 13 Jun 2019 13:22:12 +0530, Shyam Saini said:
>
> > from command line we use ctrl-z to stop execution of a foreground
> > process but you can program
> > SIGTSTP signal handler in your application code to do the same.
>
> Note that if you simply fail to include a signal handler for SIGSTOP and
> SIGCONT, it will Do The Right Thing.  The only programs that need worry a=
bout
> SIGTSTP are ones like 'vi' that may want to do something (like restore th=
e
> terminal state from raw to cooked mode, etc) before they stop.  That's wh=
y you
> can control-z /bin/cat without it having to include a signal handler for =
it.
>
> % kill -STOP `pidof process-to-stop`   # stop it
> % kill -CONT `pidof process-to-stop`  # and make it run again.
>
> No source code modifications needed.  No source needed.
>
> Now, if you want to make it stop at a *specific point*, then you're into
> ptrace territory, and source will be helpful.
>
Yes, I think ptrace can serve our purpose.
Thank you so much.
