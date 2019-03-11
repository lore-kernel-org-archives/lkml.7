Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F81FC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8862075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qid6xTOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfCKI7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:59:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33859 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfCKI7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:59:22 -0400
Received: by mail-ot1-f65.google.com with SMTP id 98so3251708oty.1;
        Mon, 11 Mar 2019 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqQ/4lIi+se9SSbWVvecDZQVa0ImY33ObgKGWqsK5Q8=;
        b=qid6xTOQ/2AOEzRO5jqsehMOkeur6kb5gVpOLIDIGKiommyjQCqc+LqkPUcxIphLhw
         OuOM7WjQczuqMJjTvW9Wi24A1jMG/nsXEXZMSsEcS+sFCXnDZuhwLeFH9Z3aBiEF4aE+
         gXg+CbrIOGK2SujKvZp7+I4QY1sojhb1E/YdIrC7LcKjM2/YiQQ5AG0ov80rQUmmYYGE
         K3pxhU0j7KcgBRNlsCp4r9XKl2nLLEONabIzfslDidBnw74t6kd7nqAzHJidQeCnGzgk
         4mrcQsrBFB6kObpqDJAXHYQCoFG8OHkEcLMgfaWS9Y4zaK8yfsjqkQLPwwbuCAJ+HqfI
         Khsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqQ/4lIi+se9SSbWVvecDZQVa0ImY33ObgKGWqsK5Q8=;
        b=IcWIc28eumAOdwfip9gyB6sbyr+bIC6I/7YvR1K8I5Iw7ok24hb1uW16zUlGn4Ja9H
         KOuaHXKsyiA8Kp7e2fj+FIgjXW+uf/lPfhiULjLzvpg4vEltjubnKbVc9ykoKkYM50aI
         P+CY1396+K6t3T5QhyRFO9ePQszX1Dbc41+2SkdwBam5B7/3xZmSGQVou1geXZpZl+L6
         Az9qe+pHpRTnBfzY3ouioRLee2YviXxGgNr77nqtz9JWvozG+aPrpt6jbvNUrLz7KBT0
         hSOE4gsglNAwl9C7r9pkBS4SVMSwOZ3CA+B/KGzWEGaMfSoutnxo10bKoXs/p4H4xB3X
         l90g==
X-Gm-Message-State: APjAAAVuEyouZRK1/s4va8ONafUDuow2ounEPUeqHQ72eucUfeX9V2tb
        eRBQmQaYUdoBKW8CuiKMaIHZvf6NkdrCk7huE5k=
X-Google-Smtp-Source: APXvYqy2W7VawzA1Mh2rHyBJ6gce/KFnIyscKYfDeXbUY9O8RqriRvsR141NrXWmgY1dxcvFCZYo76IL7GeN/95vz4c=
X-Received: by 2002:a9d:69d4:: with SMTP id v20mr20740196oto.41.1552294762076;
 Mon, 11 Mar 2019 01:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190310174640.dksy7pfkptrbcdgj@smtp.gmail.com>
In-Reply-To: <20190310174640.dksy7pfkptrbcdgj@smtp.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 11 Mar 2019 10:59:11 +0200
Message-ID: <CA+U=DsoTGLtnbkKoffm8TW6p_OhTfe2ViE3fEshKX9wJMPUzww@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] staging: iio: ad5933: add ABI documentation
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com,
        "Ardelean, Alexandru" <alex.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 7:47 PM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Add an ABI documentation for the ad5933 driver.

There's already an ABI documentation for this driver.
See:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/staging/iio/Documentation/sysfs-bus-iio-impedance-analyzer-ad5933

Apologies for not mentioning this sooner.

Could you check for other references for ad5933 in the kernel (in staging) ?
I don't think I missed other stuff, but it's good to check.

>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-ad5933          | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad5933
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ad5933 b/Documentation/ABI/testing/sysfs-bus-iio-ad5933
> new file mode 100644
> index 000000000000..8a60dd178b1f
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-ad5933
> @@ -0,0 +1,39 @@
> +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_start
> +Date:          March 2019
> +KernelVersion: Kernel 4.19
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               The start frequency. Set this to define the frequency point at
> +               which the device should start the next frequency sweep.
> +
> +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_increment
> +Date:          March 2019
> +KernelVersion: Kernel 4.19
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               The frequency sweep increment. Set this to define the amount by
> +               which the frequency is incremented after each scan point. After
> +               the measurement at a frequency point is completed, the next
> +               measurement will be made at a frequency point
> +               'frequency increment'Hz higher than the previous one unless a
> +               repeat frequency command is issued. This behavior will follow
> +               until the defined number of frequency points have been measured
> +               or frequency sweep is somewhat reset.
> +
> +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_freq_points
> +Date:          March 2019
> +KernelVersion: Kernel 4.19
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               The number of increments. This defines the number of frequency
> +               points in the frequency sweep.
> +
> +What:/sys/bus/iio/devices/iio:deviceX/out_voltage0_settling_cycles
> +Date:          March 2019
> +KernelVersion: Kernel 4.19
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               Number of settling time cycles. This sets the delay between a
> +               start frequency sweep/increment frequency /repeat frequency to
> +               be proportional to the excitation signal frequency times the
> +               number of settling time cycles.
> --
> 2.20.1
>
