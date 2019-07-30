Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55B5C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFD020C01
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="P0noKexj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfG3XcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 19:32:11 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45067 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfG3XcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 19:32:11 -0400
Received: by mail-oi1-f193.google.com with SMTP id m206so49244777oib.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 16:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1ucMuWkvECgHfJc7Um+akVfVauMdXRgWlIE/s+6MMs=;
        b=P0noKexjpK3gtxTHPZ3M5T8JI5TxmLDyGAn5SEA+GHFyIk4IWl4ufsYeqPIoTrWp1E
         KTzMtmlKDhxbNF2afKOJhSKTysNNo17+iuT5ycT2GIzKeqJkcQDIoipfzf/5g+ti0I/8
         J0vl0CDycPFlohX0mzXfQikPh+e8aAQA9FcjXltnOgM+Teqc++jSbcS1KgIiQzb0gwW+
         AVoazMOZYrpIEF1Bw1vn8+1Lal/xg3ZHML2FZVYk6ZVLBpJyqJbXqPXDpasOTxv79KrR
         z8S/1uu/q7pcIdTSpiLuWM6uOTcaZF+htYA1qCADLsI+aQ7aHjATfX4jBLGkujko4oRL
         ueIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1ucMuWkvECgHfJc7Um+akVfVauMdXRgWlIE/s+6MMs=;
        b=B4tm822rJWMF0C65GmXQEsEJO65e8Mm9L7qSfKthaVtM5rBRZ9x4xdEy4PbhT9hUWe
         0UIvpMDTnqSCSney9m5BHO4DnvIz0TqQpZUxVAOms6d9y/oqeZ6C+V2Mhz50Vt2E7ZSo
         gZqpVtl9nwYp3T1hY+wJkoRbVK4CLqgsjJFi8+cCHmrybE/m+VHy2SRMIFd6o5VOX/DX
         clzJM/+Gk2Z0z6VKBxZbQJxpKdazcMOoCbJwtiW2yl+kxcVbK2EqFw9lLWkT6Es/wOXZ
         0JjhtH5X96ytAiyBQyId6KHUJi7zkyxHs09Z/TCtACJwUavQTlaZMMFzRHqQh51/k+IA
         nw5g==
X-Gm-Message-State: APjAAAUXw+RA35YBcsiriDmqse2jZGq1yE8x3hCTkTucBMnshsX52ceA
        5Uk2n5lAiKYfTWKEmXb1Ipuf8NEA8fj0WNIn588=
X-Google-Smtp-Source: APXvYqzhW/DunrSMVJnKBnkKibNTxtX7jF/ykqwlnBv5p1ahcHK/8fT/tjYR3+WqN1VKqMPa87MDiSg2nF+bcXQRNe0=
X-Received: by 2002:aca:3509:: with SMTP id c9mr61001740oia.179.1564529530082;
 Tue, 30 Jul 2019 16:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190730024309.233728-1-trong@android.com> <CANA+-vBKg_W88Oy_wJs1NNYaZ2ciJKO=Mrs47etYTDNXUKW9Uw@mail.gmail.com>
 <5d4090ea.1c69fb81.d5cab.4dcd@mx.google.com> <2085893.cJkfNvi94x@kreacher>
 <5d40c41f.1c69fb81.ac63f.947f@mx.google.com> <CAJZ5v0hj+e3+LZ+J1eOAT2REQne_J6aAXzkKVb0tJM4u9u--Rw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hj+e3+LZ+J1eOAT2REQne_J6aAXzkKVb0tJM4u9u--Rw@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Tue, 30 Jul 2019 16:31:59 -0700
Message-ID: <CANA+-vDJT9zFqpFXCgZC-y6_FdxnnAn7QiCxf80KavioBKeCLA@mail.gmail.com>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 4:06 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jul 31, 2019 at 12:26 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Rafael J. Wysocki (2019-07-30 15:17:55)
> > > On Tuesday, July 30, 2019 8:48:09 PM CEST Stephen Boyd wrote:
> > > > Quoting Tri Vo (2019-07-30 11:39:34)
> > > > > On Mon, Jul 29, 2019 at 10:46 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, Jul 30, 2019 at 4:45 AM Tri Vo <trong@android.com> wrote:
> > > > > > > - Device registering the wakeup source is now the parent of the wakeup source.
> > > > > > >   Updated wakeup_source_register()'s signature and its callers accordingly.
> > > > > >
> > > > > > And I really don't like these changes.  Especially having "wakeup"
> > > > > > twice in the path.
> > > > >
> > > > > I can trim it down to /sys/class/wakeup/<ID>/. Does that sound good?
> > > >
> > > > Using the same prefix for the class and the device name is quite common.
> > > > For example, see the input, regulator, tty, tpm, remoteproc, hwmon,
> > > > extcon classes. I'd prefer it was left as /sys/class/wakeup/wakeupN. The
> > > > class name could be changed to wakeup_source perhaps (i.e.
> > > > /sys/class/wakeup_source/wakeupN)?
> > >
> > > Alternatively /sys/class/wakeup/wsN
> > >
> >
> > Or /sys/class/wakeup/eventN? It's your bikeshed to paint.
>
> So actually the underlying problem here is that device_wakeup_enable()
> tries to register a wakeup source and then attach it to the device to
> avoid calling possibly sleeping functions under a spinlock.
>
> However, it should be possible to call wakeup_source_create(name)
> first, then attach the wakeup source to the device (after checking for
> presence), and then invoke wakeup_source_add() (after dropping the
> lock).  If the wakeup source virtual device registration is done in
> wakeup_source_add(), that should avoid the problem altogether without
> having to introduce extra complexity.

This addresses the issue with device_wakeup_enable(), but IIUC we
still have the general problem of multiple devices having the same
name, which leads to name collisions when identifying wakeup sources
with the name only.
