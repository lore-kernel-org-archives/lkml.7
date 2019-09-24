Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86452C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4475B2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nsB7Q+qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504087AbfIXIJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 04:09:07 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41442 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409392AbfIXIJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 04:09:06 -0400
Received: by mail-yb1-f194.google.com with SMTP id x4so368252ybo.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 01:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oytvwTJ/h++ppV0afAZb6O2XZSdvl/Vc69K9QBOB/1I=;
        b=nsB7Q+qjaMYUId+8LsfJGaz0hmV70zOa+b32OgGfRwJiHbfQ/Qh3Wuq1hdAYuLsScy
         GCFwfdqUZj9Twgo/ZDpsOICE2FztUhXDuDGl4Rfqm7QHou3CPGBwjPRhkkAj90y1nVhf
         J6QiHjDnwuRo+2YP44RMBn3wXMrOR1UKgUmMagAz1sIHPfcHm/IepjBNIjJwL6OJHpL1
         LKEiZAeNGqjhQ2c4EvkDWaz6sGUi5oHuyILSJHo/gWd8KP4yCYApb1ZqTucdWowT7BHn
         k2BpmoXk1E3/Fra3cyexYK0s5IqTkN0gD6ZLlGCo7txBa77c0j3OZMPC5V7HQFyZwpoq
         LuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oytvwTJ/h++ppV0afAZb6O2XZSdvl/Vc69K9QBOB/1I=;
        b=K+oz5gDRgxetBxvXN/kHzJYIvdk1cPBE+xXAkirlo9OTfsu4r3QMW5XzL373dK+kD9
         SYh5rPgECnsFPasRcriNIFQpHme6QyhkUdrfaYPJvwp8Ss/eR2za0zZCuhWDtIWfdU/9
         wehST49F0dB/YeUUeb5nEN0SZwQ0CT04uLG5pnnGAna8aRjp0GEErZHXBc9hNj+eLHBF
         jjPfEHnKpuuwL2TuA73tH80si9M6B8nVsky+jC1LnDQ6YAx2WrPLdDKaZOMZ83qO7Rho
         PhTA+Hjo2pCjAkIqTxbQMNNFYOkzJ0Qzd/X3EPL2WCp0P+UEFdCDkW7Fl9+w2+2HAUw9
         7PuA==
X-Gm-Message-State: APjAAAXjT9p0doa/X/5Ootq+a+7KyXSy6PjlAHHbpIcCk3lUy0VUY+/B
        T4Uk9TWLVYt0lTjCSjwpfZrmnHD8Xb+jlOeE+0pdRw==
X-Google-Smtp-Source: APXvYqw27y/Qen9avOGLVC1H7Ty4V0crxs6S2bV+PW+p3P+bzFt3FmBWB9gwHx9i22bWEUc/UxHPSbS2ENiDKbUB7eA=
X-Received: by 2002:a25:a421:: with SMTP id f30mr1060469ybi.287.1569312545144;
 Tue, 24 Sep 2019 01:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190920062713.78503-1-suleiman@google.com> <1ec0b238-61a7-8353-026e-3a2ee23e6240@redhat.com>
 <alpine.DEB.2.21.1909201221070.1858@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1909201221070.1858@nanos.tec.linutronix.de>
From:   Suleiman Souhlal <suleiman@google.com>
Date:   Tue, 24 Sep 2019 17:08:53 +0900
Message-ID: <CABCjUKA4gPScr7oTWMpthtH-tz51Z8_cUvm6r779Y-G_qCHo=Q@mail.gmail.com>
Subject: Re: [RFC 0/2] kvm: Use host timekeeping in guest.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        john.stultz@linaro.org, sboyd@kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, Tomasz Figa <tfiga@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 7:23 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, 20 Sep 2019, Paolo Bonzini wrote:
>
> > On 20/09/19 08:27, Suleiman Souhlal wrote:
> > > To do that, I am changing kvmclock to request to the host to copy
> > > its timekeeping parameters (mult, base, cycle_last, etc), so that
> > > the guest timekeeper can use the same values, so that time can
> > > be synchronized between the guest and the host.
> > >
> > > Any suggestions or feedback would be highly appreciated.
> >
> > I'm not a timekeeping maintainer, but I don't think the
> > kernel/time/timekeeping.c changes are acceptable.
>
> Indeed. #ifdef WHATEVERTHEHECK does not go anywhere. If at all this needs
> to be a runtime switch, but I have yet to understand the whole picture of
> this.

Yeah, I will try to make this a runtime switch.

As for the PTP driver, I don't think it will work for us because we
need CLOCK_MONOTONIC and CLOCK_BOOTTIME to match the host, and from my
understanding, PTP doesn't solve that.

Thanks,
-- Suleiman
