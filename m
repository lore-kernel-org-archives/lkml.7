Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E929C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99C32072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgAIKP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:15:29 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:58619 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgAIKP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:15:29 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M1pfy-1irghj1B7o-002ESQ for <linux-kernel@vger.kernel.org>; Thu, 09 Jan
 2020 11:15:27 +0100
Received: by mail-qt1-f175.google.com with SMTP id d5so5432986qto.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:15:27 -0800 (PST)
X-Gm-Message-State: APjAAAWeEAe4ETeznO3GbdhuyZ3+xjhHJqjLRippVDnevcjJkxZg4QhD
        wtfUjSFLGUvAI0HZZzG7FINrClP6hWvJgWCY0v8=
X-Google-Smtp-Source: APXvYqzHV85HzfRjo8JlOR7BQz04so9X1K640UDSw+epDZK35idc8VpNX/nwHxi15Ydw7e0XfccuvrKcfiArbEs3SrU=
X-Received: by 2002:ac8:6153:: with SMTP id d19mr7257120qtm.18.1578564926199;
 Thu, 09 Jan 2020 02:15:26 -0800 (PST)
MIME-Version: 1.0
References: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
 <CAK8P3a3=q2zX9xQo7eZKp7e70rAeNB8VoSjg2aE06QJuSw8y3Q@mail.gmail.com> <20200109093442.4jt44eu2zlmjaq3f@vireshk-i7>
In-Reply-To: <20200109093442.4jt44eu2zlmjaq3f@vireshk-i7>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 9 Jan 2020 11:15:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3wnn3E9DEfAoXNAurZ3Yop-Y3d_9+3mARY2v5y2B5dAw@mail.gmail.com>
Message-ID: <CAK8P3a3wnn3E9DEfAoXNAurZ3Yop-Y3d_9+3mARY2v5y2B5dAw@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, peng.fan@nxp.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:CqTd4qZC67ym+p5h/uuW+mbbanvKbbqb3v0pSh43/1kGmRagk8r
 6PEoY7oAilBHDfDijR0paIm3JTh0IDt9JI7aq5z4ULVKYqzEvkltPyc94GZpvE7gmXV+p5g
 NZx0H6YG3EVWHVu0NgHbc57CJ2SObALV6jaF0XwBUEJDqhPWInsB+X0xYoR6qJPVAy22pTc
 Af9KjGmRHJZg0MY6jpx5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Im2U+1dhrSs=:Z+yOeBP8SvmRdTHVLpAC5J
 eRCxrCBqPSVZXrUleWcthJO2SChPPwRtGnbSkpjOJ1gr6n/s2w5advJ2OaxNkd1DmAUVp0+JN
 lHQAsfcmWJKxKAH9tU1WCxx3wvRkWv7z8qkQP719bhl6pm0ySMyuH/262isq80iLfGIBBAxOp
 5dt2QZSIeYhR2DYnzTNKu5rD/PHG4x+YUI+ePCQYtLLt2UvJF3CfMDxnbLvT6fUD8PSTSB5Fl
 a/W2AHZ7NSB+ac2iIYVCKdcExUjKYHoG9n9kb7BiIuJ9dXoFfcQMx+4WHnH2dDkSXY+fG0M5y
 KgMR9NSQ69xFzW57OAWddRBiNkahGSDS9UzDlwvYpo8k3KHqInbkErTW6T8Kkl2Rfe5Bx5DJ9
 GWzQZovYuAjb/BvqcX+HCRPsZmLxy33L8WyhCXl3EYZ9SuB5/LtKUYtN7+E+H0o0JtUJHKpl7
 c3n4iPc9aKpn238bBAJoFBqns2C/CpgRa4/KryJfJ4Y0wzwW2AB+rJN9Akwyt2NAaPZQTivNC
 BLVWZ30bxqk55iiyo7kZEyoq0SAA8dQe6FgdhFN9jDaN4Ja/T7PgwQjjIqGr8JA5VsG3fh6m9
 KeRcehVZuYWxH0QxUVsg3hEK4/hWmg6OWU21gQ1z7FQISVwaznE4BpZQotlP4S4FPrzXQGxLi
 ov+Ipmzhh8j6k50/lEbEOY7P7upflN6gJQ870PAyNgzgY8VmVZnCFICXO3TlBptdttnq/oAip
 6UKxtVZlAn9j81rPhqDKOMMtITT/knoaNqf0DWwi+l4eyDTi4Qupqt/ZllpPIZqbdbASSmrKH
 E6lZ39L9WtGdmQf0S+4RAKR+rXez2RHanKBZ3SV4H94kNbOLu+348q0puG9XgA39keLCSLNE4
 7c/qY/IvRkyHElxvgV2w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 10:34 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 09-01-20, 09:18, Arnd Bergmann wrote:
> > On Fri, Nov 29, 2019 at 10:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> > This looks odd: rather than guessing the transport type based on
> > random DT properties, I would prefer to have it determined by
> > the device compatible string, and have different drivers bind
> > to one of them each, with each driver linking against a common
> > base implementation, either as separate modules or in one file.
>
> Since there are no platforms using the scmi binding in mainline kernel
> for now, it won't be difficult to add new compatible strings. So
> should this be done like:
>
>         compatible = "arm,scmi", "arm,scmi-mailbox";
>
> or just
>         compatible = "arm,scmi-mailbox";

I would keep compatibility with the existing binding and make a plain "arm,scmi"
mean the version with the mailbox, while for new transports, I would
require them to have both the existing compatible string and a more specific
one.

        Arnd
