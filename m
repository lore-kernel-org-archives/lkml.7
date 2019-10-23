Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961C9CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 04:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F5721872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 04:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRpEwZZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732951AbfJWEvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 00:51:09 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37153 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731061AbfJWEvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 00:51:08 -0400
Received: by mail-io1-f66.google.com with SMTP id 1so11981579iou.4;
        Tue, 22 Oct 2019 21:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OKxxrxrRmQ9OEs+TDHwbhEPuOlHTRldEW91bPkMwe+Q=;
        b=IRpEwZZlH/NAmDOc3Du/eDq/g+6Akr2uQN+kUqqLGi0wZTRTzWoKAPqu9spG3AFt5C
         5juvxtVr6WBPWT4HaSsFXNSytOWs1BOd59LjkzyUNpWOBrwfcifGhbnB+sfIYJuXCIq1
         1l/3l5qvC3626rlS1xRPCcTwJ9+ksmo3D3b4kcW9+Kf8x8HL60Ojp/8024pg0XDqINi+
         VXXoKRVxuItscwoVyM8fjc8FlpWMmw+ydN4eD83AxEKSaQumjs/101MqmW9BgSMvVFbW
         fbTb0EQHTQpxT12fe4hi3g18dPuawSTN8ZIclIeRxsy3xxiW9vNf8gTGSlVbbcb9sGCm
         rqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OKxxrxrRmQ9OEs+TDHwbhEPuOlHTRldEW91bPkMwe+Q=;
        b=Xfms6utAeQMITGKZL8+t3/y0170rCaXK2o9zewWjbuRWsSCyF9pu58pw8uIxxVXByi
         yuBinG5CYwo8AjFXl8Em9gZ6ooSyoUmv2+e1QDq7gNZjtdVOSCZ8FUfxq2pfmefdThk9
         btGqe0jhpNen8ykV86P74AO3ss8KbxZuoaykN3bbgVHXgtin82PU607lw+xgIwmKF2y1
         BhBRipfVyuyfIR+9ZMB1+x7GJnOKNCeKjrLapFD4tHMPBh0Zy7oyePDcdT/h6USNxxHB
         fNp+NGrXM3HvCf6XliS7X3E0ABBKKpTrjqGxKJILfJw1BxiuN16i5xp/jY+nEvnEskGT
         P14w==
X-Gm-Message-State: APjAAAVx4ycdcFK5reEhmr7SeLH4fURmDOru4vPUwqlBBOE/9bpWMCol
        pzk/tYHostu8x1em1dUGCpkcdSk3VtZmOi467N8=
X-Google-Smtp-Source: APXvYqzE3Bfo7kvQ7+hwzW34J5gf2Zonf08iEAJCaNyVdJIDx3jMMth3umOadUschVo/Fh/wlZsrQzPbyY+oaHCxDHs=
X-Received: by 2002:a05:6638:632:: with SMTP id h18mr7358032jar.107.1571806266511;
 Tue, 22 Oct 2019 21:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191021201848.4231-1-navid.emamdoost@gmail.com>
 <fb5d5331-9a89-8370-1e61-396dd05f291a@web.de> <2a6cdb63-397b-280a-7379-740e8f43ddf6@xilinx.com>
In-Reply-To: <2a6cdb63-397b-280a-7379-740e8f43ddf6@xilinx.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Tue, 22 Oct 2019 23:50:55 -0500
Message-ID: <CAEkB2ES=S64T9FH8bSj=muXD3hSXc3-MWEVt_0sggoTdZFQswg@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers: Fix memory leak in ttc_setup_clockevent
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback, I updated this patch and sent v2.
Also, I submitted a patch to fix the error handling path in
ttc_setup_clocksource(). Here is the link to it:
https://lore.kernel.org/patchwork/patch/1143242/

On Tue, Oct 22, 2019 at 3:51 AM Michal Simek <michal.simek@xilinx.com> wrot=
e:
>
> On 22. 10. 19 10:26, Markus Elfring wrote:
> >> In the impelementation of ttc_setup_clockevent() the allocated memory
> >> for ttcce should be released if clk_notifier_register() fails.
> >
> > * Please avoid the copying of typos from previous change descriptions.
> >
> > * Under which circumstances will an =E2=80=9Cimperative mood=E2=80=9D m=
atter for you here?
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/process/submitting-patches.rst?id=3D7d194c2100ad2a6dded545=
887d02754948ca5241#n151
> >
> >
> >> +++ b/drivers/clocksource/timer-cadence-ttc.c
> >> @@ -424,6 +424,7 @@ static int __init ttc_setup_clockevent(struct clk =
*clk,
> >>                                  &ttcce->ttc.clk_rate_change_nb);
> >>      if (err) {
> >>              pr_warn("Unable to register clock notifier.\n");
> >> +            kfree(ttcce);
> >>              return err;
> >>      }
> >
> > This addition looks correct.
> > But I would prefer to move such exception handling code to the end of
> > this function implementation so that duplicate source code will be redu=
ced.
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/coding-style.rst?id=3D7d194c2100ad2a6dded545887d0275=
4948ca5241#n450
>
> Just a note. Maybe you should also consider to fix this error path in
> ttc_setup_clocksource() when notifier also can fail that there is no
> need to continue with code execution.
>
> Thanks,
> Michal



--=20
Navid.
