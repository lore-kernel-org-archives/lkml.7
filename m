Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1300C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D0C20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YAUBhxw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfCYJfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:35:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37387 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730327AbfCYJfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:35:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so9247191wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 02:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Rle8vsvUTQ0auhIf9QOOwZv4gCpStzfFAzM2K4rd5bI=;
        b=YAUBhxw07k758cPR309I54mxOBzO4+i34SGMAJRJF0dJ6SBAJIRbN3OuPKtbfURt7j
         6vtJ3zINHrUu+3z7r1Q8Q9svGY5oTHOp348UJC7MP4FOnGyF+hKkPl/GliTKjL3rl5/K
         iJtsW9fHYUQh9SbuE65iW6QsB8aHgr40tai5IGUHjG77LyYsvizvwy+5kWr9dcUQJQUm
         f4qDbuxVvDsxkWsHu/BVx+u1Z3Niob3BAIA2qx2gnRMygGsCeFK0N1f58/4uxTJlcWcD
         /9kpEjeWrZgfTjWHYx5Ksq7ciMl3ge6CP5Hz05dSLnbEwr1YRTOUftm45VMFJignrcfb
         ndFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Rle8vsvUTQ0auhIf9QOOwZv4gCpStzfFAzM2K4rd5bI=;
        b=fJDZsKNMQ1UMW3wjCq8z/E69bQhO4Vd/44gIX6UrsnWM3mUpvbLbRZ8fiOuqAhWR3t
         Fbb1XD2su3Y0SbCjC9B7p+0lF7n9RxT9FeJQin/8LkxdbpoE6OuYCoqj38nnU51K/5/O
         k5UEZcSctuLctEIDi5coLaS/HJmm6O7yVHqrMmHr9bxzkXbsiPK03VXK1TrtkH01KEoy
         igFyWdYa1zoblrYZotpNCFpBwvkawYdcs7gRCOEyT48R+mYN1O6YUVRmZZRToZrxlaS1
         8uLbsfyOtX0G/1rw6j2xcpwv8SgqH93c2tZ0cHSHd/b1ND+v8UKpQkekjzM6SnnTCS2C
         8J7Q==
X-Gm-Message-State: APjAAAVCEhc1z2bVSqWBLKNMi+QVXiAZl1AbWrgUK9qAXNr1tNwa59lJ
        WawUTjR7ns0jpcbYyxWnDXfArQ==
X-Google-Smtp-Source: APXvYqw07YGN7PdMNPwcdpQiIOjKaQolrQkpUtYAXCiqrVWvj9vrMc0Bo9HVgjF7iILK4VArYgeLoA==
X-Received: by 2002:adf:f286:: with SMTP id k6mr6509521wro.137.1553506515639;
        Mon, 25 Mar 2019 02:35:15 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id 3sm20408847wrk.68.2019.03.25.02.35.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 02:35:14 -0700 (PDT)
Message-ID: <47e944da1c3b0a11cf46fc5ad5678ba961b9f9d3.camel@baylibre.com>
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        thierry.reding@gmail.com, narmstrong@baylibre.com,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Mar 2019 10:35:12 +0100
In-Reply-To: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-03-24 at 23:02 +0100, Martin Blumenstingl wrote:
> Back in January a "BUG: scheduling while atomic" error showed up during
> boot on my Meson8b Odroid-C1 (which uses a PWM regulator as CPU supply).
> The call trace comes down to:
>   __mutex_lock
>   clk_prepare_lock
>   clk_core_get_rate
>   meson_pwm_apply
>   ..
>   dev_pm_opp_set_rate
>   ..
> 
> Jerome has also seen the same problem but from pwm-leds (instead of a
> pwm-regulator). He posted a patch which replaces the spinlock with a
> mutex. That works. I believe we can optimize this by reducing the time
> where the lock is held - that also allows to keep the spin-lock.
> 
> Analyzing this issue helped me understand the pwm-meson driver better.
> My plan is to send some cleanups (with the goal of re-using more of the
> goodies from the PWM core in the pwm-meson driver) after this single fix
> is merged (they can be found here: [1]).

Thanks for fixing this Martin.

As for the future enhancement, I'd like to know what you have in mind.
As I have told you previously, I think the clock bindings of this driver are
not great.

The global name of the input clocks are hard coded in this driver and it
sucks. CCF is evolving to rely less on these global names.

In addition, the 'clock' binding should be used to refer to the clock
'consumed' by the device, not to define a setting (as done now). 'assigned-
clock' binding can be used for that.

This would be a significant change in the binding meaning of this driver,
which probably calls for a v2.

Last, instead of specifying the parent to be used, I think we should come up
with some code to let the driver pick the most appropriate parent for the period/duty requested.

> 
> Dependencies: none
> 
> Target version: please queue this for -fixes so it makes it's way into
> v5.1-rc (so we can get it backported from there, because this issue has
> existed since the pwm-meson driver was introduced).
> 
> 
> [0] http://lists.infradead.org/pipermail/linux-amlogic/2019-January/009690.html
> [1] https://github.com/xdarklight/linux/commits/meson-pwm-for-5.2-v0
> 
> 
> Martin Blumenstingl (1):
>   pwm: meson: use the spin-lock only to protect register modifications
> 
>  drivers/pwm/pwm-meson.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 


