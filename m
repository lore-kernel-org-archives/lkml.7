Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043A7C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 16:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46F02077C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 16:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DCyns65O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfKJQAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 11:00:01 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41673 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfKJQAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 11:00:01 -0500
Received: by mail-oi1-f193.google.com with SMTP id e9so9427988oif.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 08:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h+YUD2WvRKAp40jyOGFeoD1xEis0jky10NsQDZqufMM=;
        b=DCyns65OmKpHr/7szeQZBS3eagcFeBLXjv4ZVnFzoV+n4a20e8HrXBrRvxI0KmBrpS
         LOOYGOnHCEWM6Vl2YgorGNhBH+aryiMHeokXLl+ewlzIBye6/4ttf+eWp/AYvUHVwV1j
         N7Bw5rqBWP4SykY7R9nDjtlQcbXt8Vj17FuVc/no0uBQvaGjPS8R0XbfLEw/xQC0dj+V
         z6LcJQMA8QeivurTYYjDU8o9RT2iJtb6GRqmbnXTrB0Tlctqdwh3WXvh+Vt28E/BYpu/
         KYs6JLyor+jiciIEIZ04R9WT4+iCH7WdFKDYcWJZUi4HX8R6A4igsFdteCcjPoNZMIw5
         /9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h+YUD2WvRKAp40jyOGFeoD1xEis0jky10NsQDZqufMM=;
        b=X26oDbhJgjkpnv4N9lhRPEH0x7gygFFP7pEwyUvZZ3QGhTZUHSoBzml0mSAuOodvrx
         LWZtEgl9f/4CLAmtvNyndzVv9cHAYgD2iS2Gy+PQdlM+n0KskIurBINOdOnxb/nRNvwY
         XaM+6x2lMIZ5Gld3vEF5D2JWa/h7lQri7oV9LqV62NpCQARP6U0DsAnsTise55Dp9gO6
         KZc+JbJBuRBHQ8LtBYPSLt42yorrvkJHeYKzs0Pz6XVHAannrLNGwvyyjYYweK1F+9Ed
         wfzpG50F8d9AZBKp76tOsioBPkUJ02j046SVr/GUYc/B08R+LF2TxhUV+Dc8h22jwEgk
         hE2Q==
X-Gm-Message-State: APjAAAWfiW5WUTfNmgA4IGAmn53Kw9drqdL2ZXigWDn85cT7Gk4xa1x+
        0KQilhGAo6P5tMJYp1e9y65+IStCQnGY0eoImrP6CA4V
X-Google-Smtp-Source: APXvYqzX5X0Yfnv790nGV0sCxf4G6KTyIeWhAfyr21qT68AdV82YNkRSmdLC+vr4/11OZvYJK4BfueLvDckrjGo4CGo=
X-Received: by 2002:aca:451:: with SMTP id 78mr20238408oie.170.1573401600442;
 Sun, 10 Nov 2019 08:00:00 -0800 (PST)
MIME-Version: 1.0
References: <20191109155836.223635-1-colin.king@canonical.com>
In-Reply-To: <20191109155836.223635-1-colin.king@canonical.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sun, 10 Nov 2019 16:59:49 +0100
Message-ID: <CAMpxmJVC5GGhR0z_4CkF7Opfw-5HpEKD8fUrKsgBZTbz0wDd-Q@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/davinci: fix memory leak on
 clockevent on error return
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Colin King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 9 lis 2019 o 16:58 Colin King <colin.king@canonical.com> napisa=C5=82=
(a):
>
> From: Colin Ian King <colin.king@canonical.com>
>
> In the case where request_irq fails, the return path does not kfree
> clockevent and hence we have a memory leak.  Fix this by kfree'ing
> clockevent before returning.
>
> Addresses-Coverity: ("Resource leak")
> Fixes: 721154f972aa ("clocksource/drivers/davinci: Add support for clocke=
vents")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/clocksource/timer-davinci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/ti=
mer-davinci.c
> index 62745c962049..910d4d2f0d64 100644
> --- a/drivers/clocksource/timer-davinci.c
> +++ b/drivers/clocksource/timer-davinci.c
> @@ -299,6 +299,7 @@ int __init davinci_timer_register(struct clk *clk,
>                          "clockevent/tim12", clockevent);
>         if (rv) {
>                 pr_err("Unable to request the clockevent interrupt");
> +               kfree(clockevent);
>                 return rv;
>         }
>
> --
> 2.20.1
>

Hi Daniel,

this is what I think the third time someone tries to "fix" this
driver's "memory leaks". I'm not sure what the general approach in
clocksource is but it doesn't make sense to free resources on
non-recoverable errors, does it? Should I add a comment about it or
you'll just take those "fixes" to stop further such submissions?

Best regards,
Bartosz Golaszewski
