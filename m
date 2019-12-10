Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADD4C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07FD20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYOET9ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfLJOuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:50:17 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46245 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfLJOuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:50:17 -0500
Received: by mail-io1-f66.google.com with SMTP id t26so7630172ioi.13;
        Tue, 10 Dec 2019 06:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EopU7gHpRZaFwvjzHn1zzfgni4g/N/UohJ2TWwA1/m0=;
        b=vYOET9ni2r/x+WsiXrE22CAhuCTJnazMZnB6tLnbsJJvL+/CzhU1nqV1u6g92L2TNW
         9sAEay9IDtRMUHOayxwKfjT2r9lN4koXTLKoLVKDzZBZDWLgiNin4xODz2NgytLN1/72
         hSSQLiWGAvpQ7f2Y//zUXwIJC82LiIBHDcfAmnjHonbk5FQwzEZiOjSEo0561jYZhJQq
         9yWghFa/pG9x9CtBfd3VU/Oe4JciVfoezbgYDgf4VpZQxVfHPdKyvhhMhqOAQUU3XcXu
         VPxq27c1c96xJRk8NXIqa8i9pLr3WYopimSbG/2WEAdS8VXGN5q5zikx6CNmL00QOCP9
         dCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EopU7gHpRZaFwvjzHn1zzfgni4g/N/UohJ2TWwA1/m0=;
        b=pZ5JkB9yXAmlgCcVOaYlWXNeqyJDdFlc9JGT8462BRLf5t+5gAUM7FoNsaOckUTU2i
         HSfkW/SM9WBY9L3Ewvxc6Peiv8YP7dfL6FaATIFF7JFezO/zf73pW1er5Q3iL3emiWAI
         OsdFspy6BFmNrqeSCWfJw7E5DKFj9gG4w6GGemR3IZf0OYE9guqo9RGPZ1+/XM9wwcZi
         A5MQTKf5+DdeEcVi4YvzQU/EvX+kx9dDnRituhAmfELakFMyBbwA9VuGN8PtZ7TMzT5A
         mKOfVioxTgPtoIbE4AbWTrPRoFIEXVogQzRwoLO7WoZEbH6Igd+v/NjPq9uUKBn2EQIh
         6e5w==
X-Gm-Message-State: APjAAAX3fKvm/QgQ6nsN2Bp8TjqKemxUXnHPp+GZzGxX6MY569tLyUVF
        v3YNfw0CT40zEcPJy9oswAepx4St1dM9sn/vlZA=
X-Google-Smtp-Source: APXvYqyg+Q4PiSVD+TRIfNYYQb9a80Ve7CWTpf0XRMvR2kxSQvCVSYQFM+LAKN06jjFUHKWALrHPxHKTq7zl/ShAp7s=
X-Received: by 2002:a6b:e008:: with SMTP id z8mr24398133iog.246.1575989416712;
 Tue, 10 Dec 2019 06:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20191101143126.2549-1-linux.amoon@gmail.com> <7hfthtrvvv.fsf@baylibre.com>
 <c89791de-0a46-3ce2-b3e2-3640c364cd0f@baylibre.com>
In-Reply-To: <c89791de-0a46-3ce2-b3e2-3640c364cd0f@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 10 Dec 2019 20:20:05 +0530
Message-ID: <CANAwSgQx3LjQe60TGgKyk6B5BD5y1caS2tA+O+GFES7=qCFeKg@mail.gmail.com>
Subject: Re: [RFC-next 0/1] Odroid C2: Enable DVFS for cpu
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil / Kevin,

On Tue, 10 Dec 2019 at 14:13, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 09/12/2019 23:12, Kevin Hilman wrote:
> > Anand Moon <linux.amoon@gmail.com> writes:
> >
> >> Some how this patch got lost, so resend this again.
> >>
> >> [0] https://patchwork.kernel.org/patch/11136545/
> >>
> >> This patch enable DVFS on GXBB Odroid C2.
> >>
> >> DVFS has been tested by running the arm64 cpuburn
> >> [1] https://github.com/ssvb/cpuburn-arm/blob/master/cpuburn-a53.S
> >> PM-QA testing
> >> [2] https://git.linaro.org/power/pm-qa.git [cpufreq testcase]
> >>
> >> Tested on latest U-Boot 2019.07-1 (Aug 01 2019 - 23:58:01 +0000) Arch Linux ARM
> >
> > Have you tested with the Harkernel u-boot?
> >
> > Last I remember, enabling CPUfreq will cause system hangs with the
> > Hardkernel u-boot because of improperly enabled frequencies, so I'm not
> > terribly inclined to merge this patch.

HK u-boot have many issue with loading the kernel, with load address
*it's really hard to build the kernel for HK u-boot*,
to get the configuration correctly.

Well I have tested with mainline u-boot with latest ATF .
I would prefer mainline u-boot for all the Amlogic SBC, since
they sync with latest driver changes.

>
> Same, since the bootloader boots with the max supported freq of the board,
> there is not real need of DVFS except for specific low-power use-cases.
>
> And still, some early boards still use the bad SCPI freq table, we can't break them.
>
> Neil
>
I will leave this to your expert domain knowledge if you want to
enable this now.

Here is output of on the latest kernel.
*cpupower*
#  cpupower frequency-info
analyzing CPU 0:
  driver: scpi-cpufreq
  CPUs which run at the same hardware frequency: 0 1 2 3
  CPUs which need to have their frequency coordinated by software: 0 1 2 3
  maximum transition latency: 200 us
  hardware limits: 100.0 MHz - 1.54 GHz
  available frequency steps:  100.0 MHz, 250 MHz, 500 MHz, 1000 MHz,
1.30 GHz, 1.54 GHz
  available cpufreq governors: conservative ondemand userspace
powersave performance schedutil
  current policy: frequency should be within 100.0 MHz and 100.0 MHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency: 100.0 MHz (asserted by call to hardware)

*powertop*
# powertop
            Package |            CPU 0
 100 MHz    47.1%   |  100 MHz    41.5%
 250 MHz     0.0%   |  250 MHz     0.0%
 500 MHz     0.0%   |  500 MHz     0.0%
1000 MHz     0.0%   | 1000 MHz     0.0%
1296 MHz     0.0%   | 1296 MHz     0.0%
1.54 GHz     0.0%   | 1.54 GHz     0.0%
Idle        52.9%   | Idle        58.5%

> >
> >> Patch based on my next-20191031 for 5.5.x kernel.
> >> Hope this is not late entry.
> >
> > Re: "too late".  FYI... when you post things as RFC, it means you're
> > looking for comments (Request For Comment) but that it's not intended
> > for merging.

Ok  thanks for this input.

> >
> > I didn't see any comments on this, but I also didn't see a non-RFC
> > follow-up, so I didn't queue it for v5.5.
No problem.
> >
> > Kevin
> >
>
-Anand
