Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F32FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4810E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="iR6fQZTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbfC0KRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:17:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43544 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfC0KRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:17:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so9876224wrx.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 03:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BSU848d+uIwIge1eBZ45gm0TfOgJu1rjx1iins1eI/o=;
        b=iR6fQZTml7X6F60uvhUK6hiweIFTJeKoXntLbFpHvbK7isUb/4//5cxPaSbazW8J3s
         X4RdrQ/HiiuMODc86Fdin5nD1mp6oOng4Jyhrqrnf7bqeGzPAcNgE44jwB6/YYXZvAMc
         hDWjPXPOjt60kJicQp7n7Jqgg2DopQ3K0oihNtCJinJRpONp3WQSUJQpK41ULyltxh9q
         Pu46JcEfukGioxcLBmVpHdNsTjEjvlUT+JDu/WhNHFfLK0MxZYNiQDJs4WvpCxRbX7UL
         69bO7mayVOaKYTqnqpHzq6UAx4vPP7X8mtpeavblljIDCJ8t3NFf6rA1ERxbISjZ9HNr
         r3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSU848d+uIwIge1eBZ45gm0TfOgJu1rjx1iins1eI/o=;
        b=Q+g+TiNIXoWcAhDqFIrmNTfOSsQCWF2G+eZ237/zd6lyV7gAjyRmH/05olPkQbLMRA
         twEmkyAkY51FSzikkPUj2qcGf67Lci2Vluhw7Bz8J+QWtVzd+GLV35vmxuV5GCHBo8ET
         ypmuO6HPnHEY9Y6E8RTXs07t1xB6W72BTiekZGTgCUKLnTuuOlkXXXnGY7ni4mfcVywE
         G/9K1+VHMSWllLRZVYd27ktWoQLwo3C5saXNI04kd0KnILugeD/GisZrQJkjfwr4tcpt
         n8SBHoI75MkvHjHh2o4bEeVrnhFZ6kha/Qyq3Wr5DWvk36dQLfdP6cF7wwdlGcqJYbeR
         mh6w==
X-Gm-Message-State: APjAAAU4RZL6dX7yMB8Hi1oISyXdF7fLvv6Gf/mxbkEPZslHDUOr9Vmc
        b+HUsPo3wESPLAwh0FuRMqR0k2YNbmdC4jitxt825A==
X-Google-Smtp-Source: APXvYqwpbZLQAc4hfL96QKMAEClaeKoDA6+PyFFD1p5Cscc3tu34VGjnDOcwucmjPQs5fkyuu7/0JcKJfeuk3go2tUA=
X-Received: by 2002:adf:d081:: with SMTP id y1mr22540739wrh.283.1553681853784;
 Wed, 27 Mar 2019 03:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190325135557.3423-1-axel.lin@ingics.com> <CAMRc=MfvguEhfqXBWa8o12WF6xbHM7yEiOZC+N01UDAQYQs7Zg@mail.gmail.com>
In-Reply-To: <CAMRc=MfvguEhfqXBWa8o12WF6xbHM7yEiOZC+N01UDAQYQs7Zg@mail.gmail.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Wed, 27 Mar 2019 18:17:22 +0800
Message-ID: <CAFRkauAkN=QAdqF4Qrq=PRS29yifLegrjPTU2=ngZtrkLbY58w@mail.gmail.com>
Subject: Re: [PATCH] regulator: max77650: Convert MAX77651 SBB1 to pickable
 linear range
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> what tree is this patch based on, because it doesn't apply on top of v5.1-rc2.
Hi Bart,
You can use linux-next or regulator tree.
However,  due to build dependency you need to manually apply max77650
mfd drvier manually  because it's not exist in these tree.

Alternatively, you can check the difference of your tree with
linux-next regarding max77650-regulator.c changes.
Then pickup related patches first so you can cleanly apply this patch.

Regards,
Axel
