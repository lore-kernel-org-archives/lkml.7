Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8D2C2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D40E24676
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575652622;
	bh=DatOl7pENgsZgL0vR4s62JyPzJa3DWGO0o2jk6RhY+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=S6j4io3TNxhYSZhCgP869eNECJgZsCQ19IvF73Z9S9IM409aBk7fIir/DuiJOULoB
	 cqDceWPv4ejQP4VNw4UG0NUQnH/veiM7VyaXJt9maR3OipD/S/uaXDDDcyCvkI/WkI
	 lJfg8oHuG34B8HkIzk8HhYCXuDiOZ3CwCsPNY0Us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLFRRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:17:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfLFRRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 12:17:01 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C94B92467A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2019 17:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575652620;
        bh=DatOl7pENgsZgL0vR4s62JyPzJa3DWGO0o2jk6RhY+0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JS1ov9al4yWI6/QL523l9ach20dToYwDP+KU3yVcpX3vBvzAc3PCMzTcOJA4kljpz
         AQPhphRcCVklKttzte21SP1RlBNCU6Xi2isBU5TdWulpSidmWPgyggWkd878rk/q0G
         RPNpADADRAbBT7mSYDx80hfgfD3ByiKEvut5d7ss=
Received: by mail-qv1-f46.google.com with SMTP id b18so174390qvy.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 09:17:00 -0800 (PST)
X-Gm-Message-State: APjAAAXTK3WgiP3HwFTUTBWc4E5pZcQNfYJI2gKsMUcZbzqgD1x4muNy
        WOU4JtawIjZn/qeR0RxMCvUCOvwHs+5Gx7nv5w==
X-Google-Smtp-Source: APXvYqwkk7GbRzINAc/hil6dytSPRwReJ1m9qwTkMDI3l2OrHW3YbesEyJygFRTdl24EpZsgkA+a/rv7yHAxvc5lf+g=
X-Received: by 2002:a05:6214:11ac:: with SMTP id u12mr13749702qvv.85.1575652619951;
 Fri, 06 Dec 2019 09:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20191118173002.32015-1-steven.price@arm.com>
In-Reply-To: <20191118173002.32015-1-steven.price@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 6 Dec 2019 11:16:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL2-3+rBHJzfsQfz=hKt3kt+wh5tmXd0Wa-1QFLo3=57w@mail.gmail.com>
Message-ID: <CAL_JsqL2-3+rBHJzfsQfz=hKt3kt+wh5tmXd0Wa-1QFLo3=57w@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: devfreq: Round frequencies to OPPs
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 11:30 AM Steven Price <steven.price@arm.com> wrote:
>
> Currently when setting a frequency in panfrost_devfreq_target the
> returned frequency is the actual frequency that the clock driver reports
> (the return of clk_get_rate()). However, where the provided OPPs don't
> precisely match the frequencies that the clock actually achieves devfreq
> will then complain (repeatedly):
>
>   devfreq devfreq0: Couldn't update frequency transition information.
>
> To avoid this change panfrost_devfreq_target() to fetch the opp using
> devfreq_recommened_opp() and not actually query the clock for the
> frequency.
>
> A similar problem exists with panfrost_devfreq_get_cur_freq(), but in
> this case because the function is optional we can just remove it and
> devfreq will fall back to using the previously set frequency.
>
> Fixes: 221bc77914cb ("drm/panfrost: Use generic code for devfreq")
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)

Applied.

Rob
