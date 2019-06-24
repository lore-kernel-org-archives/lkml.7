Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F61EC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304542083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0ZOIPzJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfFXHVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:21:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45027 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfFXHVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:21:20 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so1926153iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 00:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rRYD08uEOW6jHrjgv0dXHWz0dSOkoJBUbYYXM6hia+M=;
        b=0ZOIPzJOIW81mQOo9Abzgc1wEIKgyK9mpk44HMHlNquRvqK1UJk9Z0J5QB0h9Wl6Xm
         +RBZUo5G7lxjMfHHUsZi5afzbNtd+v65zeYjsEU5/mcyoZDR6uA90b8ozuYvCmxlSOEU
         sNnlRlfK9QUuU6vVIU8GMkY8p7Wrx9ExfMtI/NCucCQDvVmlp2i0fPKdI03PsFLci1dV
         kN5f1dsqr9PbBpoV2jmE//4nKtMFKtx+qSVHKIhjA3tKTJzL7jhg97g5pQM/kJQAvO6J
         EnQfA71tnvEgEY7wWkQPg5FvRYWsVlbvKCb4LSi1LQCpsne7O0xrZOdhBllf2KK6NUsa
         95NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rRYD08uEOW6jHrjgv0dXHWz0dSOkoJBUbYYXM6hia+M=;
        b=kkna2/bFgDKGyxcwmf6SPjp28MR9FbdMh/TZwzybSetRiyzZJJhDcY0bGBgoeWVZtm
         S4hIs01pWWHrRRxLvqYSYOH01LqgCLUWJUfU/P2ufZPCQSgvXuwr78Y0Ox+Ln1yvclzT
         p1CrHwBBbChz2NQAzPkXikZVu7WtbgffpvJ/F75j59ClF+Q5Yhy2HmoedrWg7NQH9RvX
         gTg2suVREooNv4mLg+i0VaUvZX/wuPrupD5HFEtFTmxXBStCilUe+BLgQhMb4WEBkN3g
         FJv3C6ZfLaO881WyNPHRfGfFwSxOmkkbU1U3wFpQUJpRC7mQL1wAiBshES6tlRrNXk8K
         g/aA==
X-Gm-Message-State: APjAAAWOngs9SFF3Wtm20oCoLo9YS85JWQSraSVo1RnORtfgnXFQpX8o
        TNVfz0Q/6ll8JL7bKRVnb/3wXo5qQePbfLlkHqSUiTN90Ag=
X-Google-Smtp-Source: APXvYqwmfI+mGWxHOSQwh+smr+2AsnMoFa+nhOVINzC/PYNsF18ld5h/oPC845ZsqFBHEgBqdnp2ZEyQ1xFhL93MxyQ=
X-Received: by 2002:a02:5b05:: with SMTP id g5mr120533961jab.114.1561360879228;
 Mon, 24 Jun 2019 00:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190605083334.22383-1-brgl@bgdev.pl> <1ac8cfcf-1d77-9b6b-4aab-4171f6cf80fc@ti.com>
 <1a66e067-631c-c7a4-288b-3934737bee8c@linaro.org>
In-Reply-To: <1a66e067-631c-c7a4-288b-3934737bee8c@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 24 Jun 2019 09:21:08 +0200
Message-ID: <CAMRc=MecrpzwC0-8x=1dAipf+j7h+C54pHCfbZidFGXtAyv7Pg@mail.gmail.com>
Subject: Re: [RFC v3 0/2] clocksource: davinci-timer: new driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 24 cze 2019 o 07:40 Daniel Lezcano <daniel.lezcano@linaro.org> napisa=
=C5=82(a):
>
>
> Sekhar, Bartosz,
>
> if the sparse warning is not fixed, the driver won't hit this kernel
> version. Please fix it before the two next days otherwise it won't make
> it for v5.4.
>
> Thanks
>

Hi Daniel,

will do, I just came back to the office.

Sekhar, how do we want to handle the rest of the platform code with
this driver? Do you think it can make it for the next release?

Bart
