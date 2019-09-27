Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2351C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57BC21841
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vlJH88ij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfI0Qit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 12:38:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45095 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfI0Qit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 12:38:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so3853297wrm.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 09:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=H9qpcAXROEOSHATHIODGl5R6XLJmU3Nit6aFPlUl9PY=;
        b=vlJH88ijYnpukf4ZiGFC3tgXvxD1NRCykGaXRu7yCbSTKpcKP3ety0gptHFmz1x+9A
         R/Zij0mk9nhPfjOY+LKUIwqed8VuCJy6QuPiI87ofhmDeo6H6oLRNVsZ5zE71JbcpYs7
         uc7+vzjvAFtQ712pTxhRUUUTQcZwPb4HlY/iTEal88bUJii40H23wDmbW1J9zCSWVHGO
         4dLbPL+BvvZoXBrCGsugMVLtvI/uFbz+gafElcBGJnTW7LkFpuxjK4NBrzMpXkDvwg/i
         zRdsMSnPa1NibDmYOg/w0WIKy76RjgF1OahTmnNR5MoE/6qCzo8Gl5LJSwGSRso85PN5
         DL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=H9qpcAXROEOSHATHIODGl5R6XLJmU3Nit6aFPlUl9PY=;
        b=n1FS9byvI1cbcuK3CBuku0Q4ncY9IRnCxojtVjUTsULxYK11N2ga3RNQl4JGa1mcdP
         n6X0qoW6kqRVxQDF7yGMk079L+4KtZcPkRHZKqO5aWM2FFwn89nTRSfRXBqPcSbSjCzc
         S+xMNtAnxtdhRJ81ddtWkdqewBnjvYXYHmA45YJFBm2auFGBONYq17odYhBDwutPB+Bd
         Qhn3+CKBeEwpzsaUlAgW0n3dtbaorKQBtWaxk/TCb3jxLL7KVnYgOieQm+2SI8hMF5oM
         kuWUnXU5WLFYpaGeUly+7SCQ5o0bTslh2+0zfuPYQZzAxnSULtTgHjxnGcZ/4ZcP87ed
         e9vQ==
X-Gm-Message-State: APjAAAXnxpW86lNhkdncWQ++7bmPtqtjAAnQO6chTS3EsuUJDOcAZXDa
        7MGBBufHf5jR2783mjsFZstz1g==
X-Google-Smtp-Source: APXvYqyOToIhXgMB3p4wq1eYwswK4+ABcMmXeNT+QmoldWbGpxe9NmpO0SA2ZuMkhyc8J4VZ7vGPAw==
X-Received: by 2002:adf:f547:: with SMTP id j7mr3872939wrp.119.1569602327457;
        Fri, 27 Sep 2019 09:38:47 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j1sm6587771wrg.24.2019.09.27.09.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 09:38:46 -0700 (PDT)
References: <20190919102518.25126-1-narmstrong@baylibre.com> <20190919102518.25126-2-narmstrong@baylibre.com> <20190927001425.DFDC7207FF@mail.kernel.org> <8486dec0-8aea-ea39-2a52-7347a01c5c40@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] clk: introduce clk_invalidate_rate()
In-reply-to: <8486dec0-8aea-ea39-2a52-7347a01c5c40@baylibre.com>
Date:   Fri, 27 Sep 2019 18:38:45 +0200
Message-ID: <1jef011yp6.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 27 Sep 2019 at 08:40, Neil Armstrong <narmstrong@baylibre.com> wrote:

> On 27/09/2019 02:14, Stephen Boyd wrote:
>> Quoting Neil Armstrong (2019-09-19 03:25:17)
>>> This introduces the clk_invalidate_rate() call used to recalculate the
>>> rate and parent tree of a particular clock if it's known that the
>>> underlying registers set has been altered by the firmware, like from
>>> a suspend/resume handler running in trusted cpu mode.
>>>
>>> The call refreshes the actual parent and when changed, instructs CCF
>>> the parent has changed. Finally the call will recalculate the rate of
>>> each part of the tree to make sure the CCF cached tree is in sync with
>>> the hardware.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>> 
>> The knee-jerk reaction to these patches is that it shouldn't be a
>> consumer API (i.e. taking a struct clk) but a provider API (i.e. taking
>> a struct clk_hw). I haven't looked in any more detail but just know that
>> it's a non-starter to be a consumer based API because we don't want
>> random consumers out there to be telling the CCF or provider drivers
>> that some clk has lost state and needs to be "refreshed".
>> 
>
> Totally agree, I hesitated and obviously did the wrong choice, but
> this is a nit, the main algorithm is not tied to the API level.
>
> Should I resend it with clk_hw ? the difference will be small and
> the main subject is the resync algorithm.

Independent of the point above (partly a least), I wonder what will
happen in some particular use cases

* If clock is changed while in suspend. This clock can be a parent of
  the clock invalidated but currently is not. What happen, if later,
  it becomes the parent ?

  Since it is not parent on resume it won't be invalidated. CCF might
  still take a decision based on an invalid cached value.

* If a mux is changed while in suspend, the parent is not correct
  anymore. The proposed patch recurse through the parents, it might
  not invalidate what we need/expect ... things are getting a bit
  unpredictable

IOW, this change take a leaf clock and tries to tell CCF that any parent
of this clock should not be trusted, but it might get it wrong in some
cases.

I think we should do it in the opposite way:
 * Mark the "rogue" clock with a flag (CLK_REFRESH ?)
 * Let CCF update the children of these clocks based on the new status

Back to Stephen point, I don't know which API it should be, but I
think the platform (fw driver or power stuff - not only clock provider)
should be able somehow to trigger the mechanism to let CCF know
something sketchy may have happened.

For the parameter, maybe there should not be any (no struct clk or
clk_hw) ? Maybe it would better if we let CCF refresh all the "rogue"
clocks ?

>
> Neil

