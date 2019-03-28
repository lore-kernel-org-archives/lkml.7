Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F08C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE90621773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="w+ewEVCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfC1JiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:38:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42478 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1JiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:38:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id p20so22228798qtc.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 02:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLcpAB3+41mrCKhdOLJCaZrMND605YNaO019G/DhRww=;
        b=w+ewEVCxvkEKA1wLxheOErNIe5pqzOsB2BfAxDl7k5UeSdp36p1jjmpLOKVQ/2MD93
         WsvYmwxX9at+OlpyWTec8lVl/t1o/Xhu1IlPA6Bdx1FO3+6p/uNYj1kZbE73HPsNRc/a
         22Gm5e0Du3AUJkPPQf2p5wGvnL4rqhOCm356BAROjKduLtLjnE/GLkxTuiiLIL8uKnp8
         ZyEQtHpa9Ifm4ESCVH3tFEx/Rn3Uv6BqnS1JjHepJ2mIdznydhInUJKcpkfK0i+vLu8O
         Npsy+9HLcrzLyDFzz3NZJuWqyKTTB0LXNQJeboOGYZVylCBtQamYCxpMATnARA8oUJ0s
         Qg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLcpAB3+41mrCKhdOLJCaZrMND605YNaO019G/DhRww=;
        b=B5SjzINGynpV5xJI4Hy2ORG9fYwFhOlLaWBympiaU4HDJkt8CML0ak2xsradFxe4Le
         b62kbwnHZOo2aGXsvXJe6oAIZW0lm6WjOtpKeg6q9iCcIpUUnwZEXU68OYo0kUfvbrF7
         WKrepFHeq2fUuK6cO9gYmz3egPZznejdh5jfXLFXeRoaIbsup6u912fgLn24NJm0BfPu
         a2US4wOYIXWJZuZEzOF7nE04n+ZCloNzPyljeRRpxu5E8Z9GA6y29YA5AjzQzuhReO3L
         /iHev5md++Yb2tmXp3zmcRnT8Aq0WsgCv+l6gS4imVvHIee0yhMzzMPHk7MLPLGZGPtE
         Bn+w==
X-Gm-Message-State: APjAAAXEOuXHq/BDlUlXD/tcpJ136OHv/vvBhe+r8Soh2zKVSjB46/J/
        u46xFQwFYeAsMv6lLxv1c4zgEJAlPAGwmi8NISopZg==
X-Google-Smtp-Source: APXvYqw17hsCZrT39BWL+90VPfVAM7zCrnXuBPgtWRI6rEwMNQv4LWemSktO4cwD/UoqHzyVY/JDTz7ik2Nu3riMRz0=
X-Received: by 2002:ac8:6b98:: with SMTP id z24mr11323185qts.248.1553765892674;
 Thu, 28 Mar 2019 02:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAB4CAwc-SFtw4+74Qe-vX57JRGDjJMt9xM2+ev3OiipzwxBPBw@mail.gmail.com>
 <20171116124431.GS17200@lahna.fi.intel.com> <CAB4CAwfHx8DgCYk0piVnrTa7YP2=6A8Le4ekoENFPyNVF9g1rw@mail.gmail.com>
 <20171117064904.GZ17200@lahna.fi.intel.com> <CAB4CAwdGQjXc6gsswyCgLTfFRN9CgcC=OJ6pz4rX-HCn8AT-TQ@mail.gmail.com>
 <20171121105205.GP22431@lahna.fi.intel.com> <CAB4CAwcjXi=YX+0PEC6wBdfAZ=am+BceB4HCFzTXzdts_FE2vQ@mail.gmail.com>
 <20171121120422.GR22431@lahna.fi.intel.com> <CAD8Lp444FNHZh6fLUfhfp1i_UBpMbS5QuvJ4FuZn7PKH1Ucy=A@mail.gmail.com>
 <20190327172940.GR3622@lahna.fi.intel.com> <20190328091729.GV9224@smile.fi.intel.com>
In-Reply-To: <20190328091729.GV9224@smile.fi.intel.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 28 Mar 2019 17:38:01 +0800
Message-ID: <CAD8Lp44xuzHj4uu3a-Y9wscSyEmuG6=nbww6T9-9FaYZT_qYsw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: intel: save HOSTSW_OWN register over suspend/resume
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Chris Chiu <chiu@endlessm.com>,
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

On Thu, Mar 28, 2019 at 5:17 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Hmm... Can you confirm that laptop you declared as a fixed case and the
> mentioned here is the same one?

They are definitely not the same exact unit - originally we had a
pre-production sample, and now we briefly diagnosed a real production
unit that was sold to a customer. There could be subtle motherboard
variations as you mention.

> If it's the case, I recommend to ping Asus again and make them check and fix.

We'll keep an eye open for any opportunities to go deeper here.
However further investigation on both our side and theirs is blocked
by not having any of the affected hardware (since the models are now
so old), so I'm not very optimistic that we'll be able to make
progress there.

> Meanwhile, Mika's proposal sounds feasible and not so intrusive. We may
> implement this later on.

Chris will work on implementing this for your consideration.

Thanks for the quick feedback!
Daniel
