Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC35C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F85218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UTnWdLsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfCOHPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:15:15 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36352 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfCOHPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:15:14 -0400
Received: by mail-vs1-f65.google.com with SMTP id j12so4809785vsd.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ZsRcmGgX07taPTFmR8odR6bONfGDkN8f589/AZGEf4=;
        b=UTnWdLsJxdi072pjUPEgeiUvu2yXgce2keArrTCgRIdcgfQvktIqbXxnpn01xCmg2X
         M2zl5V99CrmQ3HlO/N4ckG8sZ3hm8+fwOmyJBWL7kRZRRxC8Aif6AtMp0LVuvHFzclXp
         30bKPXH1sy/LyGYuKMnwZnEOHwfKOT7sUlLC5HhPVp81JDkR3UC+FV17UAd9WRWI5GDo
         DMiGr0w4tvDs/AvL8UZE726lDCPS/Pc72VA706nRgRcuSNDBAv5iMrqD6pn0R+0DDiP6
         dHed6ZOShK6Y+iAZFiQwEkOcZUzDC7mRZxsxHnt4DN3bbdbHZ15D4DGympG8T6UqSnps
         vXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ZsRcmGgX07taPTFmR8odR6bONfGDkN8f589/AZGEf4=;
        b=lesUax97AqSOvJtm0zrlsAjWZF1nQbw5bqdu9DfQ4ed1xIyNj8AkNeGe9E1ccxmkO9
         hMF36vfcoWTr3wGwNBr6q5hYPgE7WOBIzBkOVvHDwVKPi0aR2bMQvtcKeSdv43tkwFVG
         pNiUUgeLnab7kH6KbxI01aj6pMztVjgg0raLZIXvfS94UVVXbFhIEIFMY0qCnxIawCoR
         R7a/j4u7aIPRWdrhTDAzxC6rz1ZOFNWSUckdp0AtY6hGPflec9ja20duJHLS2wroeAQ7
         NZHJ2F08lHFDThy1qkIU5VbXMfJ6d4nfFGfKR9bdEJPz5o+fetnWCWB3Wgy6OILBjqzN
         M+Fw==
X-Gm-Message-State: APjAAAWc5QDvfCf9JsFYvpSxnUxGCPieIVGNxKvyANdIYmFbF2oUR5Op
        L2WKNaIbplKlGVItgZuOOUSTIBws30qE/VWYB4tD6g==
X-Google-Smtp-Source: APXvYqzgKMGTE7QirCEeY/w82dJ06x68v9Qhy12a0p61ot3GxhefqibDraoYt2QB/01QbZk1hL4wpaD8XcaX7n+AjF8=
X-Received: by 2002:a67:ffc6:: with SMTP id w6mr1138465vsq.213.1552634113694;
 Fri, 15 Mar 2019 00:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190314130113.919278615@infradead.org>
In-Reply-To: <20190314130113.919278615@infradead.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 15 Mar 2019 00:15:02 -0700
Message-ID: <CABPqkBT9_ayhH2puPtLiemtM=VOXxNhC4AXrKkOaDMatWifLxQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/8] perf/x86: event scheduling cleanups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 6:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> These here patches are the result of chasing a bug in the TSX Force Abort
> patches.
>
> The first patch is simple and fixes the issue and should be marked /urgent and
> backported.
>
> The rest is the result of having a hard look at how all that event scheduling
> stuff worked while trying to figure out wth was going wrong.
>
> Stephane, since you were involved with writing much of that code, can you
> please have a good look? I _think_ I got it, but... :-)
>
Will do today.
But you did not send me PATCH 1/8 apparently.
