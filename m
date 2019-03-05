Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E501C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D49206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551744274;
	bh=eakGeNICj4jEUX4n8UM/wdXRJq9TWHaCTjj5SRWOFpo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YrSUUGGcxD5WrMbopWoTcf5hrizmrZSfdzdrE9xBumA5SMk9eBRxFjTJfC16Q5/VY
	 nsv3XavEhuDC/TGfAcXpPVQ2CdYbTwXXkkRMcaMd/72L8BAD5m4tcT4CKlFCPWvJjX
	 y8+imkv9JqQVqMUp7rE+4Zw1pZvcz3UdUuawIEP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfCEAEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:04:32 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36644 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfCEAEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:04:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id v10so5947480lji.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+or+R9ZXBalBggrOHVcu1Z47tiNZfL9C2jfjaW2L08=;
        b=M0UMb6JdBnBIp6SCfuvGBMn4scTD1lzprnlBLpuzDtuEWi6Eb9z3fRGl44/4vWrs2O
         nUFfCqCxj0e+QLkaBeVO/WND8wnulNTTeKFyDzxEMCYBF6OvPQvnsFVWsuyAdywYtO6H
         4LiHh4PS0sQGMQetphZxWjGTOHZbJKAL881SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+or+R9ZXBalBggrOHVcu1Z47tiNZfL9C2jfjaW2L08=;
        b=S2BpVaG7lJx7WyBwxkt6LIl0MPz1YHn6XD2Cxua+0+pZImiogOtRX1tKfnl836mlBP
         9IaRkRqKVn/bbimMP1Vt6WComC3nlB5tTscdiHEFhu4DE4Y/3sVAamEtPt+0wypESMmD
         eabQEfhSImbg96zqvaaZqJ5SN/c3NgZKTua7ZFVrgxnaZxsKvstf0qHPBVtDdATM0MTU
         ENoaj2czFelJGsU9Ey9hVQLsOP73l5C/jBOrMIfSj1gOzk4vSd4wuZnfg++o7ja6ZXub
         JW9ORd7VFs/CgkQPSH3ST3vfcgqfDlqymxHXgibjlTj+uaFEvKqaNN49MsoLlWYqgtNp
         /DPQ==
X-Gm-Message-State: APjAAAWfi7SE80YZTnpEnUzaAhzOsFs7Qz6y/wwEOaV8TQAK3DJD6yid
        df7qXklGhUcuWObKNnO5BwBwO7InXbA=
X-Google-Smtp-Source: APXvYqzMWxU4qiQ2Gr2QajOmvHVI/DbSy3brsKLEItzlSfdPd9SHjfVK3GmfXDT7xoxDLqE9k8e+aw==
X-Received: by 2002:a2e:8018:: with SMTP id j24mr11609143ljg.118.1551744269041;
        Mon, 04 Mar 2019 16:04:29 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id j64sm1597986lfg.42.2019.03.04.16.04.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 16:04:28 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id z23so4845141lfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:04:27 -0800 (PST)
X-Received: by 2002:a19:40c2:: with SMTP id n185mr11458417lfa.67.1551744267351;
 Mon, 04 Mar 2019 16:04:27 -0800 (PST)
MIME-Version: 1.0
References: <20190207154519.8635-1-kaslevs@vmware.com> <20190213094445.1774f959@gandalf.local.home>
 <20190219121212.6c46b979@gandalf.local.home> <20190304105836.33f80dc3@gandalf.local.home>
In-Reply-To: <20190304105836.33f80dc3@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Mar 2019 16:04:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wipy3J4r-dLim3QvNA2jVPi2uPCi=rTDiMYikBi5OiKnQ@mail.gmail.com>
Message-ID: <CAHk-=wipy3J4r-dLim3QvNA2jVPi2uPCi=rTDiMYikBi5OiKnQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: Make splice() and tee() take into account
 O_NONBLOCK flag on pipes
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Slavomir Kaslev <kaslevs@vmware.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 7:58 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I'm still just hearing crickets about this? Should I just send this
> directly to Linus or Andrew?

I'll take it. It looks sane.

Of course, if it turns out that this breaks something that assumes
that splice blocks purely based on the SPLICE_F_NONBLOCK flag, we'll
have to revert it. Looking at the history of splice, it does look like
it has always ignored O_NONBLOCK.

                 Linus
