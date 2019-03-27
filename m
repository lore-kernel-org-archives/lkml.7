Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D56AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7F52075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="GSp2gQ4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbfC0IWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:22:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43607 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfC0IWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:22:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id v32so17776417qtc.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 01:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9N7G4SXxxflaznZL02nr8bUCHyyuiqF79wG1F3oBrPI=;
        b=GSp2gQ4ytZBtekjDDokDRdU6CUSQVMwkSpCODQIxR5OdnFs6ghXrWhP1876s2jvR6A
         q9pzhPCMU6DxcS8uD3BMxNotxI3OVsOJW8EMQWDyyKJn4FQDk0GH3jK5HPqYpSWZKrl2
         WfrPxk0lig7aWwzlJ+dzPI4cEP9dtKEcjhRqYorBjYK0nvAICm4Bc4Z+QjJvnjy/lcK7
         BRyxvst866QrFakSgfLKohIbv3I+9boaKMHWfshBn9jvDMUa9fTrr5GePas5W6FAMprl
         cMpceZF7BEyrgXXezXDRgSZFvAdY87RcgAwIJDSKzQcAqa0z3zsW1DRudcYvA6c3cKnb
         akkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9N7G4SXxxflaznZL02nr8bUCHyyuiqF79wG1F3oBrPI=;
        b=lqWQtalVaPQ+xQq5RqcRRzRXFEhjr1K66jGvXWo8385tUMK96p/13Wlnu9Cy3NWpu1
         8o4nMXqkjeyl+bhi+Or3EhNKFlT36Oqh3mpnpct3NunQjuSLbmtXJNwO+sPOBZrySH1w
         udPVclF0PpsUw4CVvmvvAcQfZJj4XOlSclU+ApveGHqWuNDwagIAcj2LCfqnHYUQZ2zc
         taTkGik1k9bGEjkn3s7Z9ca2QA00CgHE1DJaFV/dQjMJwZyafWWHHnocjvaOfhZjqzpH
         1tGtDNffqIg3MCC8/HkPL22j2noYzl+vf4YpPV3FSDOQM8WWbQn2YSrRF8MKT02or8Li
         Tkjw==
X-Gm-Message-State: APjAAAXyERVg8selvmylbAVHhKbm34TX9467v95W0cgNnKnV7tWA/niM
        1cuqilVv8yxNLnNOJVwl1Sy9GxeSFYscjGA0pzSF7A==
X-Google-Smtp-Source: APXvYqxT2BL45ouNGKh25w9jDR6X4LrWWaOYfKSen/rDMe21j3MChBGFAhWhJ8cIEZq80x/KF54QiD+ImWmFyBGsdjQ=
X-Received: by 2002:ac8:f24:: with SMTP id e33mr30614964qtk.256.1553674936231;
 Wed, 27 Mar 2019 01:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20171115080446.GY17200@lahna.fi.intel.com> <018180A5-B0D2-418E-9DBC-EF5F310F7295@endlessm.com>
 <20171115101302.GA17200@lahna.fi.intel.com> <CAB4CAwc-SFtw4+74Qe-vX57JRGDjJMt9xM2+ev3OiipzwxBPBw@mail.gmail.com>
 <20171116124431.GS17200@lahna.fi.intel.com> <CAB4CAwfHx8DgCYk0piVnrTa7YP2=6A8Le4ekoENFPyNVF9g1rw@mail.gmail.com>
 <20171117064904.GZ17200@lahna.fi.intel.com> <CAB4CAwdGQjXc6gsswyCgLTfFRN9CgcC=OJ6pz4rX-HCn8AT-TQ@mail.gmail.com>
 <20171121105205.GP22431@lahna.fi.intel.com> <CAB4CAwcjXi=YX+0PEC6wBdfAZ=am+BceB4HCFzTXzdts_FE2vQ@mail.gmail.com>
 <20171121120422.GR22431@lahna.fi.intel.com>
In-Reply-To: <20171121120422.GR22431@lahna.fi.intel.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 27 Mar 2019 16:22:04 +0800
Message-ID: <CAD8Lp444FNHZh6fLUfhfp1i_UBpMbS5QuvJ4FuZn7PKH1Ucy=A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: intel: save HOSTSW_OWN register over suspend/resume
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Chris Chiu <chiu@endlessm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika,

Digging up this old thread again...

On Tue, Nov 21, 2017 at 8:13 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Nov 21, 2017 at 07:54:26PM +0800, Chris Chiu wrote:
> > Yup, I checked the value of the corresponded pin. It shows following before
> > suspend
> > pin 18 (GPIO_18) GPIO 0x40800102 0x00024075
> >
> > Then after resume
> > pin 18 (GPIO_18) GPIO 0x40800102 0x00024075 [ACPI]
>
> OK, so ownership is changed to ACPI.
>
> > What else register do you suggest me to compare? The PADCFG2 is invalid
>
> It's fine APL does not have PADCFG2.
>
> Hmm, I don't understand how this can work in Windows either. The Windows
> people told me that they don't save and restore anything else than
> padcfg registers + ie. If the ownership is changed to ACPI it means you
> don't get interrupts anymore (only GPEs) and that applies to Windows as
> well.

In the mails after the one quoted above, we reported back to you that
the new BIOS from Asus solved the issue.

However, during the time that has followed, we have had numerous user
reports from Asus E403NA, X540NA, and X541NA laptops (basically the
same models that we originally discussed) where the touchpad stops
working after suspend/resume, even with the latest BIOS. We managed to
get an affected E403NA unit in-hands again, and confirmed that
HOSTSW_OWN was being lost like we had observed before.

Unfortunately as this was a customer laptop we had to return it
immediately, before we could investigate further. We don't have access
to any more units since they are old models now.

However I'm wondering if you have any other ideas or if you think
something like our workaround patch might be acceptable under these
circumstances:
https://github.com/endlessm/linux/commit/f391452299f62a3d0cbe5333be90f69e9895d8ff

Thanks
Daniel
