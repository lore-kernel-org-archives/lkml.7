Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29B8CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8714E2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="B4JsPq0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbfJWRxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:53:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46556 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731918AbfJWRxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:53:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so12282964wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Pd1hXIbyhKvoq4Ce5+sJpjUPNTW4sF25HitKZRQWVXw=;
        b=B4JsPq0LniaQyv7ddF8xlzipH8jpJjEDYGD/tK+Xo/3m1MT59+5PrNAWgDYT1tn0aG
         U0Rg0fgVroScAIzNCEbfrCAA3lMCE+u9rK1IhABFJX29n1lWNsw9JhLZygsvDShiTak+
         DiwcUt3XsAcTGcNS2i1QqozEN/v/MI791M7AiIOvHsZPoPNPEPYqYPpMYE35iGZ24N9l
         lSLOcdXUxBq+aptYNUfjawsJcSBo6V9FP8NTEApy0szgfq1XL+GbgcnDwvkBre76ecsC
         S4LKqNNqFKjl/7ieLyQpMcCZN7EtGwBgIw1E/JrVq4QxMMEyTM1MRiWf+3mTeBgnYD5Q
         P1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Pd1hXIbyhKvoq4Ce5+sJpjUPNTW4sF25HitKZRQWVXw=;
        b=hNzzfCwZCexouncON9kVRQCwsrboe9QEIlSrgBkIzbX4h1WMUYDMOjfyjXVHL9pQCj
         ahGjaYFF1CizmGOPZ/raKSydsy7bA+WClaME9Ugto6wMHoq3oZSWtQUuSg7jbCU6Hazq
         BmEapFhvg/cOZXr/0RSEbr2h/e3qWE9uZjob/gUpMqrxH53mEjtnBXgykItDIYSbOn3+
         vrYjpg5RZmaz0yfQ6VTp/5Pqjh5HbNOk6d6CJTRykxfNytGfcq6QDyBUl+V9CB9yWY9v
         uWdj+dKSfkk32Tf90kUpNMpMWlsLGQcc9B/tu2DZ+utyF1YAErZkjUNyDF6RqvgZ/s0W
         TNGA==
X-Gm-Message-State: APjAAAVRWg2NIDk0aP9bHh/Ki30bhbwEeN2qouPWqoFhr/CfAHTYYmzV
        UUlysbT0vX/y146qzoRmdFdRYg==
X-Google-Smtp-Source: APXvYqyV3FVHmPnXhN7309BG4pPr+cmN8g3UWW39XvABLAOl0v0PrEKVunEVe6dkZuTaCi3CQve2fQ==
X-Received: by 2002:adf:ee10:: with SMTP id y16mr9507135wrn.67.1571853213196;
        Wed, 23 Oct 2019 10:53:33 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id f143sm39085313wme.40.2019.10.23.10.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 10:53:32 -0700 (PDT)
References: <20191023161203.28955-1-jbrunet@baylibre.com> <s5ha79rph1j.wl-tiwai@suse.de>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 0/2] ASoC: hdmi-codec: fix locking issue
In-reply-to: <s5ha79rph1j.wl-tiwai@suse.de>
Date:   Wed, 23 Oct 2019 19:53:31 +0200
Message-ID: <1jv9sfcpr8.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 23 Oct 2019 at 18:23, Takashi Iwai <tiwai@suse.de> wrote:

> On Wed, 23 Oct 2019 18:12:01 +0200,
> Jerome Brunet wrote:
>> 
>> This patchset fixes the locking issue reported by Russell.
>> 
>> As explained a mutex was used as flag and held while returning to
>> userspace.
>> 
>> Patch 2 is entirely optional and switches from bit atomic operation
>> to mutex again. I tend to prefer bit atomic operation in this
>> particular case but either way should be fine.
>
> I fail to see why the mutex is needed there.  Could you elaborate
> about the background?

You are right, It is not required.

Just a bit of history:

A while ago the hdmi-codec was keeping track of the substream pointer.
It was not used for anything useful, other than knowing if device was
busy or not, and it was causing problem with codec-to-codec links

I removed the saved substream pointer and replaced with a simple bit to
track the busy state. Protecting a single bit with a mutex seemed a bit
overkill to me, so I thought it was a good idea to replace the whole
thing with atomic bit ops. [0]

Mark told me he preferred the mutex method as it simpler to understand.
As long as as it works it's fine for me :)

I proposed something that uses the mutex as a busy flag but it turned
out to be a bad idea.

With the revert, we are back to the bit ops. Even if it works, Mark's
original comment on the bit ops still stands I think. This is why I'm
proposing patch 2 but I don't really mind if it is applied or not.

[0] https://lkml.kernel.org/r/20190506095815.24578-3-jbrunet@baylibre.com

>
> IIUC, the protection with the atomic bitmap should guarantee the
> exclusive access.  The mutex would allow the possible concurrent calls
> of multiple startup of a single instance, but is this the thing to be
> solved?
>
>
> thanks,
>
> Takashi
>
>> 
>> Jerome Brunet (2):
>>   Revert "ASoC: hdmi-codec: re-introduce mutex locking"
>>   ASoC: hdmi-codec: re-introduce mutex locking again
>> 
>>  sound/soc/codecs/hdmi-codec.c | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>> 
>> -- 
>> 2.21.0
>> 
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> 

