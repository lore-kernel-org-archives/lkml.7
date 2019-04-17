Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BEDC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A41920651
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kaRdi/Bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732717AbfDQO6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:58:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36407 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732705AbfDQO6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:58:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so12136603pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=hIIpO1OGr0PquEHJp7NBXCSjbjqUDnrfVggfwDKE5Ec=;
        b=kaRdi/BsoXyg7ycbecceYvj8s+gF82c7yHcGiJBFbVQBRyw/BVYSKGr6u9DvgWaxcu
         8IlRveljndKVAw0r316IK3HepHmU0EbRzOpu3Nb9jECXkj7GxOxUmmIxpVJtGdCgt/Gt
         KSOksD9atfnf2B92t4ODEooA1TnGf97rZeHs5OujITw1Zoty8fxClyOwW44ipbdwiMAj
         lSzOTE6KLiJKVaCWAL/DAyycDSV1yRMc02FRyASygbJq7c0JjIHk6Igkn/qN13m4BzOO
         tygknYJs4uIf2zaWXujevR1bry9ckrc11RJT6KY66X0Y+gPBLJh80bCR3E/vdLkOVYw0
         rQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hIIpO1OGr0PquEHJp7NBXCSjbjqUDnrfVggfwDKE5Ec=;
        b=kPPF3qEBD3e1XRyWbtDmIZvAChJmpKF1MEE4yOTsvwV22Wyq9m9xOAAY9FwkyktnHk
         Y/UUDMFyi12diDeX2DgYvCYoyhOYdLO1d49BWzHT8/EEpNAtcmMMu1l+QA0BEzTkERGB
         bOMi8JMvRQjMLf3s7NNIzSrOhf+5fCZ5fqXp/SDB0+Nw+GH97i0eSEAV+iwOLsqziV+G
         NtUguk8mlVPYIGmAoa/aVuN6Ij5Xn8VrB0TMPGT331birFX+Elo8rrYXPSxdQm7hJ238
         kuazTIoVgjexrP0vgqm+F9rI1oDuIPVK04x81zyRvoeH5U+JYi2WvyH9tAh8P3fA8WGJ
         NbaQ==
X-Gm-Message-State: APjAAAXrlS4BZjd9xD4Iat41H9hd5PZaOI7PnXLB/hWvJItJ2DYrV1kW
        T8W+Xxr6wdPsA7UWWmvqEk7D5w==
X-Google-Smtp-Source: APXvYqxwrjUTE3hfcE3g3k5h/5Cuuk3xuspztOmJVt9obrvqFxeUV0A7PlPWphuz1+3kkH0OAA2/vA==
X-Received: by 2002:a63:4101:: with SMTP id o1mr79426348pga.17.1555513100546;
        Wed, 17 Apr 2019 07:58:20 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:e160:e5a1:483a:1ded])
        by smtp.googlemail.com with ESMTPSA id l4sm39616917pgh.17.2019.04.17.07.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 07:58:19 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        patchwork-bot+notify@kernel.org
Subject: Re: [PATCH 0/7] arm64: meson: g12a: add audio devices
In-Reply-To: <3eec8b122aa4912dfa67aeb37ad2c941c34c0a38.camel@baylibre.com>
References: <20190412125136.28232-1-jbrunet@baylibre.com> <7h5zrdpytg.fsf@baylibre.com> <CAOi56cU0dHoyRzTXeKGoiFwTms4WuJ7LV2EXTJLoEmOsC8OyrA@mail.gmail.com> <3eec8b122aa4912dfa67aeb37ad2c941c34c0a38.camel@baylibre.com>
Date:   Wed, 17 Apr 2019 07:58:19 -0700
Message-ID: <7hmukon0fo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Tue, 2019-04-16 at 12:22 -0700, Kevin Hilman wrote:
>> On Tue, Apr 16, 2019 at 11:52 AM Kevin Hilman <khilman@baylibre.com> wrote:
>> > Jerome Brunet <jbrunet@baylibre.com> writes:
>> > 
>> > > This patchset adds most the audio devices of the g12a SoCs.
>> > > 
>> > > Kevin, couple of things worth noting:
>> > >  * This patch depends of the new audio clocks binding recently applied
>> > >    by Neil [0].
>> > 
>> > Was this supposed to be part of the clk-headers dependency PR I
>> > received?  /me looks... It looks like it's applied right after the tag I
>> > pulled, so I doesn't look like it.
>> > 
>> > If I should queue $SUBJECT series up for 5.2, I'll need another stable
>> > tag.
>> 
>> Also, this doesn't apply cleanly anymore to my v5.2/dt64 branch.  When
>> the stable tag is ready, do you mind doing a rebase? (or telling me
>> what it currently applies to, and I will do the rebase.)
>
> Hi Kevin,
>
> Until we have a solution for the drive strength in pinctrl, I won't be able to
> submit the audio pins. I doubt it will happen in this cycle.
>
> Without the pins, audio won't work anyway ... so no rush
>
> If it is ok with you, I'll resend at the beginning of the next cycle. Clk and
> ASoC deps will be merged by then, so things should be more straight forward.

Works for me, thanks.

Kevin
