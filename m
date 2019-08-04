Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8C5C433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 17:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305F32070D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 17:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564940905;
	bh=ggEn9CNkrRVbsmb8JS/qtor2ggCZ+icfElBh7ri1eOY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1jX4c3VaquwhYCWy7l5NZhnNc2Uyh/qWGzir3QaOKXZpS0qbMKpdNUTBCXf7Et+cq
	 DbdspCONcjUXfEfRU/oFwnsLSLg3kKRgewgL84v3EP+bUznl+jWPRWQ642f4/O9ogT
	 r9MZdWoHuN5FNoZOH4akbhoIFNPIvyiZzgZXhz2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfHDRsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 13:48:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32851 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfHDRsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 13:48:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id h10so5810660ljg.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rtj7voNPnR4Wiu+uq0F+P27/AFOcsLAfhzZSJLzdH5E=;
        b=P5aqPh8FSawTh+Z9CFacvErR5U0UMmC5gluSOokj58/8tSepT3b34XLtcSJjUbH2MD
         R+MU0q9eLGwQVSdSKAV5UNOuUphnRuigcmlh+bWcingqC+Bj2OZIJlQzb5ZlGnp1StlF
         I8U4Sw7iu0sB6HCq7WRgxi4Ip649XLmLNAFKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rtj7voNPnR4Wiu+uq0F+P27/AFOcsLAfhzZSJLzdH5E=;
        b=fs/al9vNZF/TJCgvGeF4qCb+42DhMj31K12/Iss1hgEPdadC+k2laWnI8OFhhQvLxJ
         gkRdvNAEfLKmgou5q4cx0cvUOZb+5YhgtFOwKtIY6N7hQvqcmxgqIi01wmjTObSOo8Y2
         JdScdfQnbaTgc0zmFjhYeAyMckq7bFGVLQXNTbCVGzdErT/3aEEsWuBdt3eokYkEp+6B
         Jp+sq6Jf94xy1RD+R0VgvMZi2cw5DlpfwnaMUTnnlSpVVR8PpBUS7+SUfs3xlfkolY2q
         U+p19LQAX4AYIv2rYZx4pjVRZtNvMRv6M6Mu5Q6vFIRWFFig6JJcDtrwPwvno0OWa/GZ
         x27w==
X-Gm-Message-State: APjAAAX9DFCAzA4wDUnCLQuK/FGVHi2FXz+MeK60FF05LtJaoYwF30R0
        pZ/onfDdX8A5nAoS4Or3G08HVs8GhZ8=
X-Google-Smtp-Source: APXvYqyZrLkgPFLOhW5GIMZOX4Q40G+T5zfrdstuQNgtUPHMH4l1gpjorSGG7GTdt4oQoHGlaThHPQ==
X-Received: by 2002:a2e:98c9:: with SMTP id s9mr52039212ljj.176.1564940892312;
        Sun, 04 Aug 2019 10:48:12 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id r68sm14066380lff.52.2019.08.04.10.48.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 10:48:11 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id y17so52713321ljk.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 10:48:11 -0700 (PDT)
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr72983638ljk.90.1564940890784;
 Sun, 04 Aug 2019 10:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
 <CAHk-=whZzJ8WxAeHcirUghcbeOYxmpCr+XxeS9ngH3df3+=p2Q@mail.gmail.com> <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
In-Reply-To: <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Aug 2019 10:47:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgT7Z3kCbKS9Q1rdA=OVxPL32CdBovX=eHvD2PppWCHpQ@mail.gmail.com>
Message-ID: <CAHk-=wgT7Z3kCbKS9Q1rdA=OVxPL32CdBovX=eHvD2PppWCHpQ@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID MAINTAINERS file update for v5.3
To:     Micah Morton <mortonm@chromium.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 11:11 AM Micah Morton <mortonm@chromium.org> wrote:
>
> The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:
>
>   Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/micah-morton/linux.git
>   tags/safesetid-maintainers-correction-5.3-rc2

Hmm.

This pull request was apparently not caught by pr-tracker-bot for some
reason, so it didn't get the automated "this has been pulled" message.

I'm not entirely sure why - it was cc'd to lkml, and I see it on lore as

   https://lore.kernel.org/lkml/CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com/

so the email itself made it through the system. And it has "GIT PULL"
in the subject line, so the pr-tracker-bot should have looked at it.

I see a couple of _potential_ reasons why it might have been overlooked:

 - maybe the "--" marker after your explanation made pr-tracker-bot go
"oh, the rest is just a signature"

 - the fact that the git link looks more like a regular web thing, and
the branch name is on another line. Does pr-tracker-bot only trigger
on kernel.org things?

 - maybe pr-tracker-bot ignores follow-up emails with "Re:" in the subject?

but it could be something else too.

Adding Konstantin to the participants, since he knows the magic.

This is not a big deal, and I have probably missed a lot of other
cases where the pr-tracker-bot doesn't react to pull requests, but I
really like how it gives a heads-up to people about their pulls
without me having to do anything extra, so I generally try to look for
failures when I can.

Konstantin?

                  Linus
