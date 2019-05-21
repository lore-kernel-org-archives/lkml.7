Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B901C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3096B20856
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqDX15zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfEUFxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 01:53:14 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33100 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfEUFxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 01:53:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id m32so19179087qtf.0;
        Mon, 20 May 2019 22:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OjojgwXHUu9zF/M3I/YD6BlqRchfsfu1PM8JDHkSMGU=;
        b=EqDX15zqI0t4trSp932Ie2IL04ablXakn6fezuGNcVUfED9gQTQVBdyqflNoXl+XBW
         qHG0+Sl+gRVbWuiYCtFWapb5KWgzyZIpf1r8Xr7U8YrhdBlkKK062jo8iLNBowH0oszp
         gn6MakXhzJRa4Sc923g8v8lfJTYX4Dt2373bq0PgbM6cxqEUB5qjp4QRTmV/SNW22H2u
         Df+u2wkEcnnemKWUJVmMhNw7Nfv/UdL2IvBJehkmYmbB3N7vOAnGMwasr2E3qwpnWWsD
         65jij6e6JOZ2lufPikwgfxb1YPoR1eepwvJDF9IaBfHMCC0sAmQgT16KBJ3slhytWsuM
         aM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OjojgwXHUu9zF/M3I/YD6BlqRchfsfu1PM8JDHkSMGU=;
        b=I2C/0/xlG0QSvsliiKcK4pdbzWU7ocBb0luumf/egtd8B3c8ybT+PZdpM09x7D+v/P
         6ryS6+O2B5NR+p9gz28GrN7hwYIMXQyyQ4lcwGQhW8EsTFIwThABTAKKaZ+WYhF5MVCE
         0zgx6owDEwbSrBVpT+3fiMkn1nxFtSJsCwdwCfpxDOHyfXNCREmmxIE1eGfO8oGnMArr
         FgLAD6zJ88VdMwKKX0qWZ0DZdwGoVPXpTuAPpyxqgPdBnVIZwVRjMUD0JA+e2dPAEVI/
         yy10l1RafmC763HZ95yv32YuG8mcIZh2iZkjglgndQDAZV06sb8q+fS783mAAFqdtR0J
         zevg==
X-Gm-Message-State: APjAAAVehoGoT5rxe0yzFKW0KI3XVEu+kd4JqM5yedBO8HnTi2llEaIN
        C13GITOk+rP1RKtJAmt2NSCjUW2VnN1qNHVXv/OV1g==
X-Google-Smtp-Source: APXvYqxoCzbyHYo8HnOWYt9TIkhLOt8lZYzAyV1b0D1PG2lD86bFL+9LlcQQC1B4wJ6kcvTv5OyrNwbXqOm3ecenOz4=
X-Received: by 2002:ac8:3894:: with SMTP id f20mr65041576qtc.84.1558417992805;
 Mon, 20 May 2019 22:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190520214427.18729-1-marcos.souza.org@gmail.com> <20190520214427.18729-3-marcos.souza.org@gmail.com>
In-Reply-To: <20190520214427.18729-3-marcos.souza.org@gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 20 May 2019 22:53:01 -0700
Message-ID: <CAPhsuW4DWL2OFvn+mdRUwG5J90LsuP=bDUJMhnabvRcz8g-7Fw@mail.gmail.com>
Subject: Re: [PATCH 2/4] md: raid0: Remove return statement from void function
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shaohua Li <shli@kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT" 
        <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 2:45 PM Marcos Paulo de Souza
<marcos.souza.org@gmail.com> wrote:
>
> This return statement was introduced in commit
> 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2") and can be
> safely removed.

Wow, that's a really old commit. :)

I think 3/4 and 4/4 of the set makes git-blame more difficult to
follow. Let's not
apply them.

Thanks,
Song

>
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  drivers/md/raid0.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index f3fb5bb8c82a..42b0287104bd 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -609,7 +609,6 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
>  static void raid0_status(struct seq_file *seq, struct mddev *mddev)
>  {
>         seq_printf(seq, " %dk chunks", mddev->chunk_sectors / 2);
> -       return;
>  }
>
>  static void *raid0_takeover_raid45(struct mddev *mddev)
> --
> 2.21.0
>
