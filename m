Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67BEC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950D5205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="CBIza3B1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfETTGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:06:19 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:43978 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfETTGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:06:19 -0400
Received: by mail-io1-f51.google.com with SMTP id v7so11876633iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 12:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QzZE9jFbHqOGJKb7odntY6nSTCezqxIRWPNodlHk2xo=;
        b=CBIza3B1gqmWZ19UAfEjcgM1l7DpiemU8uY4yUS22ENov5JFyxsZ3CBksQYSdxP3fY
         4MFg3eevc5IWAbIwbrAOTsswjBFfaH+0BBTcnQ4ayVDU2zVvSEi13iL0Kq0aduCc2Yfx
         8yaK18JSItLIa8GLI1v1J02rpFGUD0P+y6PhlUWVLWCXiWnDA75F28HRHyXjh+Ie+c9g
         y5E6zVLvOHr6qieIMlH4FERkw3WmsRIfzaMZYZIMv5mPCzNGPFzy5hkzMSmS/e6bYCxX
         o4GrOZxuj85UcljKrEOIzz1c1mcYUR6cFb7e9syLlshs4GYo5nJclkGkWQZAsWh7LnUY
         o7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzZE9jFbHqOGJKb7odntY6nSTCezqxIRWPNodlHk2xo=;
        b=YBJaJP3E7bbX9EwBqrePPoy0WX17Uz9qYWbvTynRXyobZ82gFviaY47R3Yr54XuuLp
         oLhfUSwJdfw/y9xrRuMHnFsBI56am2g+veFyaJIcpML57fYedFp443+rzlXqe7Au7crG
         2U29mGCoX0Dbx8P2bEAQpq2ZBrEQ2UNSRtotnNalOhNWhh4ZXTq3VgZdb2Rguo4qU46y
         abNpQfaUoR4bsNy8YMcq3VgNyj2cJ0PEqV0qOT5OKXj2muyEDSL4AT8k2cm1qlL/jvj8
         v4CPBfCp2pFKo1QknB39fR0RXi23ap6v/vOLPBBURVjIP0vNc9Wl6oKTywwFTbIPXZsy
         jjAg==
X-Gm-Message-State: APjAAAUcDgAVd2YbRrfKRTZvW6PddAsydWG0GNGDd5KYlCj8GMaCM3jV
        pkd/ZVkDq+UzAQeoNZHPNCfK6f5letrHNXYksfTcKA==
X-Google-Smtp-Source: APXvYqyloS6ZKCQ4Ac7ONK15oKaup7o7Pm35bkJPFMluGEfbd0oRHuQupykbysUKED2G5Ua3l/KlU8Pq4nc9KSYrIY4=
X-Received: by 2002:a05:6602:95:: with SMTP id h21mr20536731iob.109.1558379178175;
 Mon, 20 May 2019 12:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36la24t1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36la24t1.fsf@gitster-ct.c.googlers.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 20 May 2019 12:06:07 -0700
Message-ID: <CAGyf7-F-d-n39fJmjYc_2rjqQa4d7PFCx63LwW3m7PFetEgzEw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.22.0-rc1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2019 at 10:00 AM Junio C Hamano <gitster@pobox.com> wrote:
>
>  * The diff machinery, one of the oldest parts of the system, which
>    long predates the parse-options API, uses fairly long and complex
>    handcrafted option parser.  This is being rewritten to use the
>    parse-options API.

It looks like with these changes it's no longer possible to use "-U"
(or, I'd assume, "--unified") without adding an explicit number for
context lines.

Was it not intended that a user could pass "-U" to explicitly say "I
want a unified diff with the default number of context lines"? Because
it's always worked that way, as far as I can tell (certainly since
early 1.7.x releases). Is it possible, with the new parse-options
code, to restore that behavior? Removing that is likely to be a pretty
big disruption for Bitbucket Server, which has always explicitly
passed "-U" to "git diff". If the community wants to move forward with
the change, I understand. I'm not trying to roadblock it; I'm just
listing an explicit example of something that will be significantly
affected by the change. Perhaps Git 2.22 could emit a warning about
the change in behavior and then a subsequent version could turn it
into an error, to give us (and anyone else relying on this behavior)
more time to make adjustments?

I'm aware a unified diff is the default output, but many commands have
flags that essentially tell Git to do what it would do by default.
That can help counter changes in the default, as well as safeguarding
against new config options that allow specifying a different default
(as it were). For example, "git diff" has "--no-color", which could
override configuration and essentially applied the default
behavior--until the default configuration was changed in 1.8.4 from
"never" to "auto". By using "--no-color", even though we didn't "need"
to, we were protected against that change in the default.

Best regards,
Bryan Turner
