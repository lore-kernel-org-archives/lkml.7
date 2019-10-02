Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0E5C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10D921848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3xaUt8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfJBVoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 17:44:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43527 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfJBVoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 17:44:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id v27so384797pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 14:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Utf5M1idf2buPTzn1CVF8rxTf5cVxXahETs/DaKiNis=;
        b=M3xaUt8sd02dZGe4DPmvT90aqmBi2cvGVSovauj0vgBiqy29njVa/dlH+wIuqpMcKz
         kwITAp40GngOPQ2YVZ/gwrw90iMoQdKJvTUzTa0V1VWHZ8krzvvqMvPyHf8JC7CxQb3X
         snZqo2+jrReRzXnofN9rkWfiK2aF1XjgxBhlIujwtdgmMdIWgyMzx11xxsXou95b6N2u
         HKRzvMLdJyrEf6iSOL8vtv0GcqmxPiU2T9AZ2jpcVRFK73leIWPVa+tT0Jj35+VhuYuX
         Z4uC3PADmo7DBn3d86QZ45CPBZBzERNHLUwS144q5mnWvPPG6CK87ii5ptzxlmyyQe84
         X6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Utf5M1idf2buPTzn1CVF8rxTf5cVxXahETs/DaKiNis=;
        b=ekw9o8/SQlSUO2zVZZ4vH7UOS2eUM+H8EeO1y4IAwqmYHn+zlHKwAssaa3ueDF089s
         s25Z2FXWWGuzBEhXBBpO7tYf84/oZddXvTp/fQer096mHwwra73znTBO1MQYw5WoAwQ4
         PgwbmNHC2D9qBvXHndtxvi4fEkoO7TmWmzpOl0NECyK4SzvmyiqY7h50N1XI2Q1RLl8y
         1PJagDvKZ/ZmPM8MnChf2kwHIK70dBIwhBaG/ubTR1UGp3h+7A7Hd56u34XK8P58EGKb
         p6NY/cBeGNISUpq44oqUcEl63MAcKapgETQyfcFbtAKv33RuAU4t36UTmm/1itm4MzNL
         3flw==
X-Gm-Message-State: APjAAAVK6FlJLfQ0v0Aix4rpQrZvqFzaaLzondCI43RMuMeIXRNdrLYh
        q8LmRi5mhBot6DpLQIdroFJ+pIhbmyE4Js1nCTrNsw==
X-Google-Smtp-Source: APXvYqwmS6yUrRxO8pfbPbwvbcEQW39IJQhiquCtoAJBHGQ4cKBNNnHAcNCdaXN4aNhg/EZwr2gGCtxqrRW91whHXKM=
X-Received: by 2002:a62:798e:: with SMTP id u136mr7263870pfc.3.1570052642514;
 Wed, 02 Oct 2019 14:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=GVdHhsdHOMpuhEKkWMssW37keqX5c59+6fiEgLs+Q1g@mail.gmail.com>
 <20190924174728.201464-1-ndesaulniers@google.com> <a2e08779-e0ba-2711-9e0d-444d812c0182@roeck-us.net>
In-Reply-To: <a2e08779-e0ba-2711-9e0d-444d812c0182@roeck-us.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Oct 2019 14:43:51 -0700
Message-ID: <CAKwvOdnG6tTHHx5aL8oA3ta_mW24aZ37JX+=HQ9YphearL4DOg@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon: (applesmc) fix UB and udelay overflow
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        jdelvare@suse.com,
        =?UTF-8?Q?Tomasz_Pawe=C5=82_Gajc?= <tpgxyz@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 5:01 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Again, I fail to understand why waiting for a multiple of 20 seconds
> under any circumstances would make any sense. Maybe the idea was
> to divide us by 1000 before entering the second loop ?

Yes, that's very clearly a mistake of mine.

>
> Looking into the code, there is no need to use udelay() in the first
> place. It should be possible to replace the longer waits with
> usleep_range(). Something like
>
>                 if (us < some_low_value)        // eg. 0x80
>                         delay(us)

Did you mean udelay here?

>                 else
>                         usleep_range(us, us * 2);
>
> should do, and at the same time prevent the system from turning
> into a space heater.

The issue would persist with the above if udelay remains in a loop
that gets fully unrolled.  That's while I "peel" the loop into two
loops over different ranges with different bodies.

I think I should iterate in the first loop until the number of `us` is
greater than 1000 (us per ms)(which is less of a magical constant and
doesn't expose internal implementation details of udelay), then start
the second loop (dividing us by 1000).  What do you think, Guenter?

--
Thanks,
~Nick Desaulniers
