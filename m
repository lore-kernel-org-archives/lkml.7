Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47607C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A6220820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554925857;
	bh=gLqxa+fXD7ZR+IdyPU5iivWrSAnfZHb5FWMr81rU764=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0Vkw4RjSdQmcd9MQ8Kxa7FRbd3baZYJSSGzIvWI9f9OfiHBe/j57DdLIalG8+JNj/
	 VDBXmVC2rjdBwNjlYTuddHS/YCJiy0x2T8v25sTZ5wawN8z3nb2VsTWVDN8hRg+DHO
	 hVQYjwEaSgChF2rpqZK2gmT7g6UK5FOgqttaHzr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfDJTuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:50:55 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:46384 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfDJTut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:50:49 -0400
Received: by mail-lf1-f45.google.com with SMTP id r25so2727541lfn.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yyqnNvbfmn5m1e4SIudC+WMARrUmp/Qx5i0nxm+Q0lw=;
        b=eVQ+3v+1kuVPCQhKn6JTctvz1ha2XK3y1oD4BjWDkgXVAfqE6/TQWRVurqMlxNzfaA
         rKuAaAp8gAkIFKC9/euTBToRXmNbqpaVY5UvBowdRbsgmFYQF75PNXT5bDtXDaSiSD1W
         g/50tACWbFVgSeXTeqshZtg2JQuQ91MQZMI4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yyqnNvbfmn5m1e4SIudC+WMARrUmp/Qx5i0nxm+Q0lw=;
        b=lRweGzw3J4O1wJfib+NiWcxsvjKMd7ohNmYtjY3wJpjpe9Kg0hsqrffgO1yW7MIRf7
         nJEUjvd34HAfZhp8PZRfLa/agnZwf2J9JGxxTGjriUfvHbgmXy0hLJIwmjL8DUnTs+HN
         sv2UYZiA+zExSmhoFM5Uo1CGa7RNzhJPrbga3j9imG6J97Cu3eAV6c2Z8jTveKyOr6L+
         pDEhB0QFhceXXAP5uvyJegRhepDszO+gl52CfsVn+ncEUore1HpqMS/4M4KRRtZmlv6A
         eh/Vw2FBQeUlzPBAauFWaSkByoY43N2qjMmXLY3NfwefQCXcueDNh0P22NEoG/e9QOIe
         gPCQ==
X-Gm-Message-State: APjAAAVSPww9Ew1ZA4weJ+JGEg+bmfJMi18BlUa+IAEahugeQjQhsMiQ
        ve9A9gwZhCaiqsOyeSlu3ximBmUxclA=
X-Google-Smtp-Source: APXvYqyexe83SDLHalpZ+OXrIo/mJgJ0o0UD/5vtTvjpKp+tBBQv5zlIkIrK7cJQj/TbQaRm1tnuDA==
X-Received: by 2002:ac2:518b:: with SMTP id u11mr7736357lfi.46.1554925847062;
        Wed, 10 Apr 2019 12:50:47 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id p76sm4114923ljb.63.2019.04.10.12.50.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 12:50:46 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id v22so3246870lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:50:45 -0700 (PDT)
X-Received: by 2002:a2e:420c:: with SMTP id p12mr24527546lja.1.1554925845465;
 Wed, 10 Apr 2019 12:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190409184917.65062-1-briannorris@chromium.org>
 <CAHk-=wg6_i9WcqiGu4kg97yAg1du26RpXdxd=uEjo4yXjotdiQ@mail.gmail.com>
 <CA+ASDXMptGi2H+E77xRJQEryWgEeqWYb8Xn=XxkK8Tio8RBkMw@mail.gmail.com>
 <CAHk-=whL3UEnKTpmr0bqL_6cW8cOn8mSCFAjAtpCfeMVq7Serw@mail.gmail.com> <CA+ASDXMYiDpYx06LDrZcn5gVWu_7q3DK5G0Eb1jmwjUJZAA_KQ@mail.gmail.com>
In-Reply-To: <CA+ASDXMYiDpYx06LDrZcn5gVWu_7q3DK5G0Eb1jmwjUJZAA_KQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Apr 2019 09:50:29 -1000
X-Gmail-Original-Message-ID: <CAHk-=whCWwWwdqbeYTDTSTWC11czp0QxR_FUuzeAgSpjRj7Gig@mail.gmail.com>
Message-ID: <CAHk-=whCWwWwdqbeYTDTSTWC11czp0QxR_FUuzeAgSpjRj7Gig@mail.gmail.com>
Subject: Re: [PULL -- 5.1 REGRESSION] Bluetooth: btusb: request wake pin with NOAUTOEN
To:     Brian Norris <briannorris@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 7:44 AM Brian Norris <briannorris@chromium.org> wrote:
>
> I think our key difference here is in how much we trust the device:
> knowing the quality of the firmware running on some of these devices,
> I wouldn't totally trust that they get it right.

No.

You claim that IRQ_NOAUTOEN makes any difference, It doesn't.

I claim that you should get rid of the disable/enable_irq() games you
play, and replace them with just requesting the interrupt.

At which point the whole  IRQ_NOAUTOEN dance is entirely pointless.

Just don't do it.

This has nothing to do with trusting hardware, and everything to do
with "why do you request an interrupt that you aren't actually ready
to accept, and the hardware isn't even properly configured to generate
yet"?

See my point?

               Linus
