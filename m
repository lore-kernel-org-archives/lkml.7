Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F41C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322E920663
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehfKR8su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390039AbfDRUDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:03:18 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40781 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRUDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 16:03:17 -0400
Received: by mail-it1-f195.google.com with SMTP id k64so5203389itb.5;
        Thu, 18 Apr 2019 13:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZYv0D/Lv/S4Y4YZ8eIubZ2MXBI/HA3x1HiaAk8MnBM=;
        b=ehfKR8suZEuFpo/3C3nrgotliOuk+x/F3gWWjkja0Ebp1p5MIb9430CiRfFEKT26/z
         k+c778HqEjZnV0Y3vLUj79wdR/9jpHO5TNubLPeqvxz2MRaXlwI+CCQNdIah+frVGWzV
         jvbmScf1ycmUduoQ9SI9eWCTt12ca5aBI0a8HbxHB1ix0FFve8NvCSETD0FZWfYKI7j5
         7rANMLl43P4lqWLTmJqirfdxnyU+g+CTKTBUr3zeqfUvv6j0YgGEU35K0Fs9BIPPcvsu
         5SWaG+E+M0pxm4xKF1NhUUv1hWVuWVOAdoKy9nfA5iLEilB3gFhvlXlh59O5ZwUoYYVU
         +9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZYv0D/Lv/S4Y4YZ8eIubZ2MXBI/HA3x1HiaAk8MnBM=;
        b=SSAbvPsQ/l1BWIHSKd2i6pxlSYR3CVl+nMVOPkA2JAQRTp2f5ZHRY3rnRwOQWvxHEq
         ZcV+c7WAQAMdL3XozPl/j+vKwXdJd94MEjHDgVOlcptPuchdRD5HTddys7+GFmeWSmtR
         uEXZ3i1GdCLPD8S+yTAvuAssP2IjfpDO+FV9uBjy0AfL8BpNm8RZu/7Bjx5c1Mn+fitb
         ZVxdHYITP2UEJhsNABOwxTtB+rSiOrgaqYczV/UiVj0OesEQ30F5s+Gytn8DrTNJMLl1
         5mP88KNZfHoNcmHIC5jSxcW1+JSYI8hLAoSvAyjw1SRlymlraa14nwesIv2N5evaF1Az
         +FPA==
X-Gm-Message-State: APjAAAUaIrlqFzL3y13FpCghblmbq1sc/P13xCohQEUU5QsyaVdqejGr
        AGbKKgJXA9EIQRlvbMD0Bz8ARggwN1LWGXMXMvw=
X-Google-Smtp-Source: APXvYqxNaubvWSOjsrtrr4GirXHe1UInOYW/HaqPhxSXx9GG2VlrGH+CkyzUdvijE0/GsQd4JTTPgjnuK7QgY2BJlEw=
X-Received: by 2002:a24:2244:: with SMTP id o65mr4754255ito.126.1555617796594;
 Thu, 18 Apr 2019 13:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190405073020.10361-1-andrew.smirnov@gmail.com> <20190417223708.4irrwrm4q7vig3vh@earth.universe>
In-Reply-To: <20190417223708.4irrwrm4q7vig3vh@earth.universe>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 18 Apr 2019 13:03:05 -0700
Message-ID: <CAHQ1cqGNKr0M4KZmX3gG+Wk4N39VezGO15VxEC6rzbLdzHQ-7w@mail.gmail.com>
Subject: Re: [PATCH] power: supply: sysfs: prevent endless uevent loop with CONFIG_POWER_SUPPLY_DEBUG
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Chris Healy <cphealy@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 7:35 PM Sebastian Reichel <sre@kernel.org> wrote:
>
> Hi,
>
> On Fri, Apr 05, 2019 at 12:30:20AM -0700, Andrey Smirnov wrote:
> > Fix a similar endless event loop as was done in commit 8dcf32175b4e
> > ("i2c: prevent endless uevent loop with CONFIG_I2C_DEBUG_CORE"):
> >
> >   The culprit is the dev_dbg printk in the i2c uevent handler. If
> >   this is activated (for instance by CONFIG_I2C_DEBUG_CORE) it results
> >   in an endless loop with systemd-journald.
> >
> >   This happens if user-space scans the system log and reads the uevent
> >   file to get information about a newly created device, which seems
> >   fair use to me. Unfortunately reading the "uevent" file uses the
> >   same function that runs for creating the uevent for a new device,
> >   generating the next syslog entry
> >
> > Both CONFIG_I2C_DEBUG_CORE and CONFIG_POWER_SUPPLY_DEBUG were reported
> > in https://bugs.freedesktop.org/show_bug.cgi?id=76886 but only former
> > seems to have been fixed. Change debug prints to use pr_debug insted
> > to resolve the issue.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
>
> I think we should just drop these debug messages, just like I2C did.
> They don't offer any useful information considering the info is already
> exposed to userspace via the uevent.

OK, sounds good, will do in v2.

Thanks,
Andrey Smirnov
