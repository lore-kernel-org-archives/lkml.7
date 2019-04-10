Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4ABC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A3C20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfDJH3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:29:42 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43718 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfDJH3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:29:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id t81so898018oig.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 00:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMNfoh1QiLkMX//RrEvNEUFn4+oXvE/O/TIlPbe3V9c=;
        b=bKXi/sWAkY+wlYjjlzwJynNijaOnbDvQZxe37+lD79v3tjmHQUbBM1KW46/laZGsbp
         ojqe16nB29/YjczgXhAGcOXeiulN7faCPqX6VgRTqYN/osqko7kjhEu6N5qsUKmoPNDf
         41J8II30RhHIGTWnmuzMTrtm/XEn7WnQ9xovBZdufo3d8t4ucstRYFU/Exj//qliCRAe
         8ExUvOxHIBetvygSZyIBEbbqz1TrJrU3LDCfbQgCxnh7xMXRq6VQgwybz5UpMsEIp9x6
         G3WBxWGtgWm42Lx6D0F31jMDaIO/lY2uKT8OGKqm1Sk2A7UyxxHadWSwQm2IYBFKKTDl
         u7Fw==
X-Gm-Message-State: APjAAAV+qSov2TyPL4tQrT/UUEzUK7V108rFqvCkNNHpYosR2t/PdVwA
        qPr+pofWtuVl7UrG54BQSkGSxEB2X1seVw5aIt4HsQ==
X-Google-Smtp-Source: APXvYqx904N5zTd5Nq412RESdy3L+HEkJCKWgZQkUck0Zv05LXseZ1evwLYWvbJA4yBVPmDaHi+8q3vezbtYrYXpT+A=
X-Received: by 2002:aca:aa14:: with SMTP id t20mr1571911oie.166.1554881381458;
 Wed, 10 Apr 2019 00:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190409123134.19350-1-omosnace@redhat.com> <20190409123134.19350-3-omosnace@redhat.com>
 <alpine.DEB.2.21.1904100819290.2020@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904100819290.2020@nanos.tec.linutronix.de>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 10 Apr 2019 09:29:32 +0200
Message-ID: <CAFqZXNvGY7ZMQ-zxa=6sm0v-VK6u9U+RzDAhiYFKCvDpDbQdrw@mail.gmail.com>
Subject: Re: [PATCH ghak10 v7 2/2] ntp: Audit NTP parameters adjustment
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 9:03 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 9 Apr 2019, Ondrej Mosnacek wrote:
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 2c62c0468888..1c372ad7ebe9 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -86,6 +86,26 @@ struct audit_field {
> >       u32                             op;
> >  };
> >
> > +#define AUDIT_NTP_OFFSET     0
> > +#define AUDIT_NTP_FREQ               1
> > +#define AUDIT_NTP_STATUS     2
> > +#define AUDIT_NTP_TAI                3
> > +#define AUDIT_NTP_TICK               4
> > +#define AUDIT_NTP_ADJUST     5
> > +#define AUDIT_NTP_NVALS              6 /* count */
>
> That should be an named enum and the id argument should be the same type.

I kind of instinctively went for macros to be consistent with the rest
of the file, but on second thought that's really not a good reason to
keep doing the wrong thing... I'll change it to enum in v8.

>
> > @@ -720,14 +721,29 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
> >                       /* adjtime() is independent from ntp_adjtime() */
> >                       time_adjust = txc->offset;
> >                       ntp_update_frequency();
> > +
> > +                     audit_ntp_set_old(ad, AUDIT_NTP_ADJUST, save_adjust);
> > +                     audit_ntp_set_new(ad, AUDIT_NTP_ADJUST, time_adjust);
> >               }
> >               txc->offset = save_adjust;
> >       } else {
> > -
> >               /* If there are input parameters, then process them: */
> > -             if (txc->modes)
> > +             if (txc->modes) {
> > +                     audit_ntp_set_old(ad, AUDIT_NTP_OFFSET, time_offset);
> > +                     audit_ntp_set_old(ad, AUDIT_NTP_FREQ,   time_freq);
> > +                     audit_ntp_set_old(ad, AUDIT_NTP_STATUS, time_status);
> > +                     audit_ntp_set_old(ad, AUDIT_NTP_TAI,    *time_tai);
> > +                     audit_ntp_set_old(ad, AUDIT_NTP_TICK,   tick_usec);
> > +
> >                       process_adjtimex_modes(txc, time_tai);
> >
> > +                     audit_ntp_set_new(ad, AUDIT_NTP_OFFSET, time_offset);
> > +                     audit_ntp_set_new(ad, AUDIT_NTP_FREQ,   time_freq);
> > +                     audit_ntp_set_new(ad, AUDIT_NTP_STATUS, time_status);
> > +                     audit_ntp_set_new(ad, AUDIT_NTP_TAI,    *time_tai);
> > +                     audit_ntp_set_new(ad, AUDIT_NTP_TICK,   tick_usec);
> > +             }
>
> Yes, that looks much more palatable! Nice work!
>
> With the above addressed:
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>
>

Thanks!

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
