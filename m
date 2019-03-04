Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD32C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A806A2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E25l6/jM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfCDNAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:00:31 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32926 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfCDNAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:00:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id z7so4249353lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 05:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7Oixl/pTRpgQCobmQscRts1cxJ22eK4zSuUgB2IRSus=;
        b=E25l6/jMr7LVYb4H+gCoSEqgzwB7hzBu4wMQA8XHUFNDeIuLcTG88S/uUkMeZvkEOf
         9tifnsFqRtoD0n2Zau9MG/3TsUMn7CLxwLP17NA0x4aLxqR4/9BpCbRUTJUhekiUodGo
         ve3COipSloB8aQkc2VWlwAW6nZlWfXhM5mykxeVLM90aRUzOGueKYOx63+9iMX7jdRN2
         z/kUlT4mAr4KHPULbw/hK+uGmfXu6PLjS1NsZMXxdeOJl3qvfX7/eYxA27E+yuWiMfcS
         vFsvpvwwX67uhV3uVenFzn/Zizv+TRUR8UUftxL8sj+Z52JN67yrnMUb+tJVFz5y1GU3
         hLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7Oixl/pTRpgQCobmQscRts1cxJ22eK4zSuUgB2IRSus=;
        b=hQ8qe2QoqSLmcC7SoORBobQwPByRLZJRnN/uagZz7YEX/Zw/b+O27/IJIq8eOfM3Lm
         JzpBsBfcqHb+RormshbRyBQ+yxqWpBqTUPkp5jxj2GWm3QOn1nipS+2ajvXLm8pwk4i6
         Dc882uDqy0xmVF6Q5Ly6MBE8EMgW/NdJdXw9Ze9kXbtBotTBKUki8KfXzizCJ8n/R3HN
         FEeCbxW+xaWNq1VsH+mlCJQqC4CKTM2ymUYBos4fcAlV40a4e4uJ8d9Yz1Ab7uqoLjT+
         jG/FD3FWvqe06Vz+vF/61IqH8N+47L5WiUeNs7dfK2kr6hzJqdH/ikGVUMu2KQUuXity
         f4nA==
X-Gm-Message-State: APjAAAWdIlFmLMfnb6Kh4im5qyMGWQLpDCU9DecEFeTmIskFudZGkXm9
        7OG0rtsDVDdvSfIkqWZioEBP/rR2VfP4CyewiTyYWQk=
X-Google-Smtp-Source: APXvYqwuwbrWZT6Q+LWLif2jxGGQDNHSYLlYV21Lmoi48RmMvs/0E0kF8cvNreHuS76q6C71fahggvMseXjosIHY/u4=
X-Received: by 2002:a2e:8701:: with SMTP id m1mr6945682lji.132.1551704428836;
 Mon, 04 Mar 2019 05:00:28 -0800 (PST)
MIME-Version: 1.0
References: <362a9b5f-8908-17f5-3594-6c3c68789dea@molgen.mpg.de>
 <CAEJqkggKGTn0ojWzuYGfoYehDnOf=je5L-7-M1kWogutPGMg3g@mail.gmail.com> <874l8ic0l4.fsf@codeaurora.org>
In-Reply-To: <874l8ic0l4.fsf@codeaurora.org>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Mon, 4 Mar 2019 14:00:40 +0100
Message-ID: <CAEJqkgjYRu1Az6ec1ksQfLZ71fa062Us7XkOzw8BZ2bEoUe8BQ@mail.gmail.com>
Subject: Re: Warning at drivers/net/wireless/ath/ath10k/mac.c:5625 ath10k_bss_info_changed
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, ath10k@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo., 4. M=C3=A4rz 2019 um 12:59 Uhr schrieb Kalle Valo <kvalo@codeaurora=
.org>:
>
> Gabriel C <nix.or.die@gmail.com> writes:
>
> > Am Mo., 4. M=C3=A4rz 2019 um 12:28 Uhr schrieb Paul Menzel <pmenzel@mol=
gen.mpg.de>:
> >
> >> Resuming from ACPI S3 on the Dell XPS 13 9370 with Debian Sid/unstable=
,
> >> Linux 4.19.20 showed the warning below. It=E2=80=99s not reproducible.
>
> [...]
>
> >> [ 3018.992916] Call Trace:
> >> [ 3018.992921]  ? ath10k_conf_tx+0x7a/0x4b0 [ath10k_core]
> >> [ 3018.992937]  ieee80211_bss_info_change_notify+0xab/0x1a0 [mac80211]
> >> [ 3018.992946]  ieee80211_reconfig+0x661/0x12a0 [mac80211]
> >> [ 3018.992962]  wiphy_resume+0x7f/0x120 [cfg80211]
> >> [ 3018.992969]  ? wiphy_suspend+0x270/0x270 [cfg80211]
> >> [ 3018.992971]  dpm_run_callback+0x59/0x150
> >> [ 3018.992972]  device_resume+0x97/0x190
> >> [ 3018.992973]  async_resume+0x19/0x30
> >> [ 3018.992974]  async_run_entry_fn+0x39/0x160
> >> [ 3018.992976]  process_one_work+0x1a7/0x3a0
> >> [ 3018.992978]  worker_thread+0x30/0x390
> >> [ 3018.992979]  ? pwq_unbound_release_workfn+0xd0/0xd0
> >> [ 3018.992980]  kthread+0x112/0x130
> >> [ 3018.992981]  ? kthread_bind+0x30/0x30
> >> [ 3018.992983]  ret_from_fork+0x35/0x40
> >> [ 3018.992984] ---[ end trace 3af618ca97bd4a0a ]---
> >> ```
> >>
> >> Please find all Linux messages attached.
> >
> > I reported that twice and no one seems to care about.
> >
> > http://lists.infradead.org/pipermail/ath10k/2018-November/012398.html
> > http://lists.infradead.org/pipermail/ath10k/2018-December/012658.html
>
> Does this patch help:
>
> ath10k: Drop WARN_ON()s that always trigger during system resume
>
> https://patchwork.kernel.org/patch/10837139/
>

Without to test this patch I can confirm it will help , I dropped the
WARN_ON()'s in 4.19 already.
If I remember right 4.19 has one WARN_ON() triggers while 4.20 got two.

https://gitweb.frugalware.org/frugalware-current/blob/master/source/base/ke=
rnel/ath10k-drop-WARN_ON-added-in-cd93b83ad927b2c7979e0add0343ace59328b461.=
patch

BR,

Gabriel C
