Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B86C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1169D20665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561408709;
	bh=G4MvU9XMZU3qkxUIwcDtGSbbfXOo7hAa2geM2MQqJfk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lHCTmtEGnhp2krWmoOuWMOt6YBXX7EHyecy/ZtvUsCcNU1XwEwwll1n3oj5A8OJFK
	 fe+56dVdeW0Ny1rrsOHE1OaLom5Rt/fYPiM/jDLVkUyMqS8hWw/LL0P+NWhq5eRb1e
	 pienrRFn93vtGof+Zwa+GMG2GGBvWwNuXwCZfjU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfFXUi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:38:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40907 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfFXUi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:38:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id a21so13928812ljh.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v1ni3gZJ5DTYbVR+EneqvuBS0klKngeeCXjk7sRCSGw=;
        b=Kq4O+bMGVFxakj9kxG9tRFGL2K0FolT9Gw9P0jU0osuV0wrn2LvztvEJI5K2gdqAdO
         BTY7iQchISdZJb8oUShzSbisNENbHBS1Npx38UjU4RvSM4S5t/DaY+p0iignOeyWElQw
         9E9YKGwdKIThg4sSe1kFEnbIZ1quXo9mGQXZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1ni3gZJ5DTYbVR+EneqvuBS0klKngeeCXjk7sRCSGw=;
        b=lhXV0SajKUYgQtvLa33/2F9wsjGo8J+1lNJ0dkEO22iQzB6wkXuS8zbARj4aBuZVGt
         li/2k/rDXNO6L3GNpmt6qoSwLgeRM2CsYJAD9I9Lc5+GkmIO3I8Oxz7BemUBn1EVspvs
         TbHPwD1RUx+drrYsmzc2gLlSZ748oMpVz4b4/DaoR68LxWF6TW1pYIgU5m9hODMCw26x
         JUiMiPkwMvLHPf/azG91ppfna56PP6rXB9cnqY55Su/skm0hh+B0S6YhHf+/AGRZbikd
         q5jVe23kMxj01FkCuz15Alqz0M3+plVaPNF2GZmTU+i/lEvnahefnTOVVgGkwrkfHa66
         d2sQ==
X-Gm-Message-State: APjAAAX4i3rysdBzen9/7Fn4jgQEKRUPDjwmxDQDwtALWGwBC4hFiChM
        oFBXTPm8vZEcf2PCWFdY6f6kaMfmbZE=
X-Google-Smtp-Source: APXvYqy2v7NBOdtsPQWrhbQyxLJD1GCO43pHjDWejMumMo/PoPNNI/vgkRNNH10+jWn2kZtG3emSEA==
X-Received: by 2002:a2e:6c0f:: with SMTP id h15mr19052222ljc.36.1561408704378;
        Mon, 24 Jun 2019 13:38:24 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id u21sm1911728lju.2.2019.06.24.13.38.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 13:38:23 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id a21so13928718ljh.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 13:38:23 -0700 (PDT)
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr13248937ljj.156.1561408702960;
 Mon, 24 Jun 2019 13:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190624144151.22688-1-rpenyaev@suse.de>
In-Reply-To: <20190624144151.22688-1-rpenyaev@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Jun 2019 04:38:06 +0800
X-Gmail-Original-Message-ID: <CAHk-=wgQaCDiH09ocVA=74ceg9XyS=kRDF5Hi=783shCaKVRWg@mail.gmail.com>
Message-ID: <CAHk-=wgQaCDiH09ocVA=74ceg9XyS=kRDF5Hi=783shCaKVRWg@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] epoll: support pollable epoll from userspace
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Azat Khuzhin <azat@libevent.org>, Eric Wong <e@80x24.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:42 PM Roman Penyaev <rpenyaev@suse.de> wrote:
>
> So harvesting events from userspace gives 15% gain.  Though bench_http
> is not ideal benchmark, but at least it is the part of libevent and was
> easy to modify.
>
> Worth to mention that uepoll is very sensible to CPU, e.g. the gain above
> is observed on desktop "Intel(R) Core(TM) i7-6820HQ CPU @ 2.70GHz", but on
> "Intel(R) Xeon(R) Silver 4110 CPU @ 2.10GHz" measurements are almost the
> same for both runs.

Hmm. 15% may be big in a big picture thing, but when it comes to what
is pretty much a micro-benchmark, I'm not sure how meaningful it is.

And the CPU sensitivity thing worries me. Did you check _why_ it
doesn't seem to make any difference on the Xeon 4110? Is it just
because at that point the machine has enough cores that you might as
well just sit in epoll() in the kernel and uepoll doesn't give you
much? Or is there something else going on?

Because this is a big enough change and UAPI thing that it's a bit
concerning if there isn't a clear and unambiguous win.

               Linus
