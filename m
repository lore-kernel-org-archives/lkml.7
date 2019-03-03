Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FB1C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 22:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD93220835
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 22:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA0OwvYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfCCWmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 17:42:15 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44031 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfCCWmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 17:42:15 -0500
Received: by mail-lj1-f194.google.com with SMTP id z20so2636471ljj.10;
        Sun, 03 Mar 2019 14:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nLadaurLpYY+D5xcHmIFiZmMqTojc+LObuTL1Wve3Pg=;
        b=eA0OwvYkj3okxrP6K+3va4dXNbHdFIzgjtWcfjPCf992fErE7u7E3MfzGm4uYx2BIB
         NJD0S9OSIDjNE9a6jZqHPGXthlgO0Nt0nwOOOmSREOKTYmbceqiXLzMY9BNzbqjnh6WM
         IHgA95WxuL+9lHkM+G1czMoO7hCB7DXVZ+hikQhqDINICwN7yAtJz/ZL3EctTceWmV/O
         ax+6fnb5vts8BPXfci6EhOLLsP5vUyRayHqKu83PH82loNM0SXaBZJqtEi3UMDkt2vv7
         rgOQvGXSroR0uwBh87q+Wk6ht6Q/In9AlhVUAvWIgYcYzwbYK6g8O+wQue0clpNZQWu9
         gAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLadaurLpYY+D5xcHmIFiZmMqTojc+LObuTL1Wve3Pg=;
        b=mTF55ggsQPNPOS69iEGqzheOXts3xpwKa936HrcaVRacggtrUV08KZ/bvLd8glzD4v
         jphmGiTWZKoMlvyKYzoGN8dW5byUz8VQt+hk994RTSC43xFM9CXa6YJIR2EMJ4f9sJom
         IaZ87G1R8PyhGxQ0VXB3ZepHsA9GLUBJ+gQRyZemVNE4GGHtKHkBiL27/TdLkX/KPF8c
         C1WOqYMTqPDunPwboBZOuE+e/DFp3Atow8rguX8mPWE/JTJfehby6tOu+ZFZb/nOsABW
         RpezMl0W3Q4HdA97p8HqGUe23gsNTaAdPJnW54QNC3yNSPWqsuqdQbOdQBeUj0xpLeNW
         A0aw==
X-Gm-Message-State: APjAAAWtRD5T5MbVeGt9MhzmADs5Plqc4Vh8IL4ChAEbRSkMAKaoVcX0
        L1N9nVwIS1tJ7urvRqkH80VpTY8GjtCoHlGnKJg=
X-Google-Smtp-Source: APXvYqwj9FK+cc/kUJelTxnDgfySaxalaCS8C+BSiH3CBXaRoT9edDwl/8hYjRc3MEvBnNH7Plwugh9Xs3T5R7+nZfY=
X-Received: by 2002:a2e:90cd:: with SMTP id o13mr8763570ljg.153.1551652932902;
 Sun, 03 Mar 2019 14:42:12 -0800 (PST)
MIME-Version: 1.0
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
In-Reply-To: <9956076.F4luUDm1Dq@aspire.rjw.lan>
From:   Gabriele Mazzotta <gabriele.mzt@gmail.com>
Date:   Sun, 3 Mar 2019 23:42:01 +0100
Message-ID: <CABFtUbT6gRQETzZqR7QY6WYDKzF2ZVZ-Y2XQ-bOZnrmBZSnPvQ@mail.gmail.com>
Subject: Re: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I applied these patches on top of 4.20. The max frequency of all the
cores now reflects the actual value and it's updated whenever I
change the power source.

Regards,
Gabriele

On Fri, 1 Mar 2019 at 13:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi All,
>
> This is how I would fix the issue reported in BZ 200759 (see this patch series
> from Yu too: https://marc.info/?l=linux-pm&m=155137672924029&w=2).
>
> Patch [1/2] causes intel_pstate to update all policies if it gets a _PPC change
> notification and sees a global turbo disable/enable change.
>
> Patch [2/2] makes it update cpuinfo.max_freq for all policies in those cases.
>
> The patches here have not been tested yet, so testing would be much appreciated.
>
> Of course, comments are welcome too!
>
> Thanks,
> Rafael
>
