Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E15C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 21:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC71206CD
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 21:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvZan/wT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfINVIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 17:08:47 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:36810 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfINVIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 17:08:47 -0400
Received: by mail-oi1-f176.google.com with SMTP id k20so5436151oih.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 14:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jMW5QQfqB3GgO3Rwut+y8ooMRK6oMNFBtSgXBDuvbgY=;
        b=HvZan/wTdVlLNfNBct/c1zeuudQeshyJ69LVka0uJo6QZJZo61cdvd+XXNRN0uAfcd
         mNzatB28Ta5FEYbS5cfOJzsSDH5QkOqZN4x+d1vF6pcackIOVqwSvfheY2l+MUlNueE0
         lf7pi3eDjXxGYy9rATo0prNP0WfwnDS27R/Ode++EuNQ3wgXCZs0L5t2GetmQmWVa05z
         8hPCTxflzywUPju7Uf5g4+PZtS+rzmSL+dgiNENDhkTEd5xIZtzLPfvewT4Q2i8Bn3mr
         1b+qVHom0OkoHtSK7Y5ZxhaA5JvsACyQ2uu5alvI/SIf2NNKBq6GlFfA7ZqB4RIuf6yf
         Cr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jMW5QQfqB3GgO3Rwut+y8ooMRK6oMNFBtSgXBDuvbgY=;
        b=OZeiQewhJDy1IWCABXh/jat2O2NmT2xOh4QjXM3/upr16w7KCGZJQ58n7ryLAZjD/+
         lGTczLyAzeD6tW+wC1kzHn10ZuTkWnTmpvAfsYuL4sbxPHCWWt6pObs4Q/6PQBSLdtW4
         Y+0Bcq0wto3Rzgf7cKbAtdzZMlOwl7DuAIJJMuIDRjKBaAknFL3T+UhRoD/lE6dWY30p
         lr+H98p9EN5VGAbfJUR3H1SpmYTbLuk460474l7HPrxY6USTx0Dz81viMe8KXz5FzlRZ
         /Quh0pEY3BQShE4lSoKcj7vX+VlNRzFaL06ssbTHUEQLITaoEY9asiQwL7MWUnKnjHlY
         ezZA==
X-Gm-Message-State: APjAAAXrqXi4UQYFivWvRLXinJIT3VIRISM5yiA1lQbUoVaGUExAmNKh
        u5Y2Fl0FPlF9pW5mEPdXHCSwELUtIneyYyCvxis=
X-Google-Smtp-Source: APXvYqzfdOCMLTAlz0b2bARRrW5zytkIb1s5zlrSoVgDJNzlQtpbzvMiBem0XyrOtygyCcs/mxPD4cgAbfUaj5V97r0=
X-Received: by 2002:aca:7509:: with SMTP id q9mr8093677oic.111.1568495326122;
 Sat, 14 Sep 2019 14:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190707065710.GA5560@kroah.com> <20190712083819.GA8862@kroah.com>
 <20190712092319.wmke4i7zqzr26tly@function> <20190713004623.GA9159@gregn.net>
 <20190725035352.GA7717@gregn.net> <875znqhia0.fsf@cmbmachine.messageid.invalid>
 <m3sgqucs1x.wl-covici@ccs.covici.com> <CAOtcWM0qynSjnF6TtY_s7a51B7JweDb7jwdxStEmPvB9tJFU4Q@mail.gmail.com>
 <20190821222209.GA4577@gregn.net> <CAOtcWM0Jzo+wew-uiOmde+eZXEWZ310L8wXscWjJv5OXqXJe6Q@mail.gmail.com>
 <20190909025429.GA4144@gregn.net>
In-Reply-To: <20190909025429.GA4144@gregn.net>
From:   Okash Khawaja <okash.khawaja@gmail.com>
Date:   Sat, 14 Sep 2019 22:08:35 +0100
Message-ID: <CAOtcWM0P=w-iBZzwekVrSpp7t2WO9RA5WP956zgDrNKvzA+4ZA@mail.gmail.com>
Subject: Re: [HELP REQUESTED from the community] Was: Staging status of speakup
To:     Gregory Nowak <greg@gregn.net>
Cc:     "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simon Dickson <simonhdickson@gmail.com>,
        linux-kernel@vger.kernel.org, John Covici <covici@ccs.covici.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 3:55 AM Gregory Nowak <greg@gregn.net> wrote:
>
> On Sun, Sep 08, 2019 at 10:43:02AM +0100, Okash Khawaja wrote:
> > Sorry, I have only now got round to working on this. It's not complete
> > yet but I have assimilated the feedback and converted subjective
> > phrases, like "I think..." into objective statements or put them in
> > TODO: so that someone else may verify. I have attached it to this
> > email.
>
> I think bleeps needs a TODO, since we don't know what values it accepts, or
> what difference those values make. Also, to keep things uniform, we
> should replace my "don't know" for trigger_time with a TODO. Looks
> good to me otherwise. Thanks.

Great thanks. I have updated.

I have two questions:

1. Is it okay for these descriptions to go inside
Documentation/ABI/stable? They have been around since 2.6 (2010). Or
would we prefer Documentation/ABI/testing/?
2. We are still missing descriptions for i18n/ directory. I have added
filenames below. can someone can add description please:

What:           /sys/accessibility/speakup/i18n/announcements
KernelVersion:  2.6
Contact:        speakup@linux-speakup.org
Description:
                TODO

What:           /sys/accessibility/speakup/i18n/chartab
KernelVersion:  2.6
Contact:        speakup@linux-speakup.org
Description:
                TODO

What:           /sys/accessibility/speakup/i18n/ctl_keys
KernelVersion:  2.6
Contact:        speakup@linux-speakup.org
Description:
                TODO

What:           /sys/accessibility/speakup/i18n/function_names
KernelVersion:  2.6
Contact:        speakup@linux-speakup.org
Description:
                TODO

What:           /sys/accessibility/speakup/i18n/states
KernelVersion:  2.6
Contact:        speakup@linux-speakup.org
Description:
                TODO
What:           /sys/accessibility/speakup/i18n/characters
KernelVersion:  2.6
Contact:        speakup@linux-speakup.org
Description:
                TODO
What:           /sys/accessibility/speakup/i18n/colors
KernelVersion:  2.6
Contact:        speakup@linux-speakup.org
Description:
                TODO
What:           /sys/accessibility/speakup/i18n/formatted
KernelVersion:  2.6
Contact:        speakup@linux-speakup.org
Description:
                TODO
What:           /sys/accessibility/speakup/i18n/key_names
KernelVersion:  2.6
Contact:        speakup@linux-speakup.org
Description:
                TODO

Thanks,
Okash
