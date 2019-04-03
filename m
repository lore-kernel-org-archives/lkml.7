Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED08FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45D82084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IuO71o9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDCRzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:55:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45881 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCRzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:55:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id y6so15656220ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDlJ0cv1qPh9d6Dl0gXApBvvRslFQ7alCD7k+kZyWqE=;
        b=IuO71o9k9yQaM8o8VZv9UauLopdPUrOU+V/wkukv7UK7s+qS2Vt+PE/CdtHO3X9VXa
         cvIOFJvmkOSVK716zXWDM7drXM4+o3L0fWYaZxRUSxnM3cAyzHsJfRFrF74v6I8dFIdp
         ELWeW4EOHtqAemqWD4/qm3xQJv+RwZ8Jip6eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDlJ0cv1qPh9d6Dl0gXApBvvRslFQ7alCD7k+kZyWqE=;
        b=jyPW1pYxSChLI+r3heIi1+m9HRVUxX4Z1dTT9OXqQolAIWtfRubvvQMfeNuXth8DOq
         vO+c19/yihG5QmH9fq8rsCMRwg+L+XGxVpZ+HXCQQHeVV6lhS59ucqEvI/5nBmTpUuUQ
         NumaitZczEvcJ/opBNmwL8JUlURFH9nuce+OWRhEZQc7KmnR113IRaVT9mlA9WnSl93T
         NtO+TGOtNpzalRd/C0tihmlIw+kHyW6Fck3mOJW7HS97itH6fhyq7o45ZnPjb1L5FmME
         Dd2P8uShvnTOfSNZEOAV9PKn7NIB/JdjxvvmwARdbyuLSQU4Zy0zlWdWY8uSaNbBPlWI
         /0LA==
X-Gm-Message-State: APjAAAWrf9HrwpR9+VvyAzskXbk5FRnpKoE9rU8JmpombX9TDp8YMKaR
        znxgcUIv1Nt8JGrtMbf9o2wSYWAH5d8=
X-Google-Smtp-Source: APXvYqwC8EFkTOi3mJsFEQUrqR1rN840+Z2N0od2RjBp2tDQgpLhilSuXrxta62CHqB2+CuYowGFvA==
X-Received: by 2002:a05:651c:157:: with SMTP id c23mr615544ljd.151.1554314139336;
        Wed, 03 Apr 2019 10:55:39 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id u2sm3433690lje.74.2019.04.03.10.55.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 10:55:35 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id k8so7288654lja.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:55:35 -0700 (PDT)
X-Received: by 2002:a2e:84ce:: with SMTP id q14mr645356ljh.80.1554314134582;
 Wed, 03 Apr 2019 10:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190403160526.257088-1-dianders@chromium.org>
 <CA+ASDXN-4Ya6cK5wsmARXxP0bJCGpMkoyu1t_fS7hqVFKF0ZBw@mail.gmail.com> <CAD=FV=UZCUp=Tq4DhKGJQm7bPvvM1Q=EUovWeBdoHVvQeu4eUA@mail.gmail.com>
In-Reply-To: <CAD=FV=UZCUp=Tq4DhKGJQm7bPvvM1Q=EUovWeBdoHVvQeu4eUA@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 3 Apr 2019 10:55:22 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMpk=QsTxeAmL-Eir242HC2fzbi8ENACMi3H27o63KOGA@mail.gmail.com>
Message-ID: <CA+ASDXMpk=QsTxeAmL-Eir242HC2fzbi8ENACMi3H27o63KOGA@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_spi: Transfer messages at
 high priority
To:     Doug Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Simon Glass <sjg@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ryan Case <ryandcase@chromium.org>,
        Randall Spangler <rspangler@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 10:49 AM Doug Anderson <dianders@chromium.org> wrote:
> On Wed, Apr 3, 2019 at 10:04 AM Brian Norris <briannorris@chromium.org> wrote:
> > Does anybody know what the definition of "too long" is for the phrase
> > "Don't queue works which can run for too long" in the documentation?
...
> So I think the summary is that I'm back to being convinced that the
> "system_highpri_wq" should be OK.

Makes sense.

> > > +       wait_for_completion(&params.completion);
> >
> > I think flush_workqueue() was discussed and rejected, but what about
> > flush_work()? Then you don't have to worry about the rest of the
> > contents of the workqueue -- just your own work--and I think you could
> > avoid the 'completion'.
...
> Thanks, I'll do that in v3 assuming someone doesn't convince me to
> switch back to a private workqueue.

You can do flush_work() in either case :) Then, if for some reason you
start queueing up other work on your private workqueue, you still
won't have to worry about inter-'work' dependencies.

Brian
