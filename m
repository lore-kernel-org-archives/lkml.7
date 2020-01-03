Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D5BC00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884BA222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVw2XaEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgACIAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:00:36 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33771 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgACIAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:00:35 -0500
Received: by mail-ot1-f65.google.com with SMTP id b18so38352022otp.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 00:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NxA2yBNeWlIfszkTmeiVyLhyQ77gT+nUBeVRVNBKmek=;
        b=BVw2XaEu0R7rg3maZaoUSFcqIbOaLflaNcJ+ucJBxRPEGNYHx98DacR+6GlgV1Fzqd
         j2XZDX2H+fEOdpmEAv+kiU+mINa5K1clT9ttqyTb97+zzycg/T0mIPIlRSFikpEVuclo
         GWMCQXplQfXHhYjMz576QTAWkN43Y3xfO26p+RB4njfgl/qlM3mMFhpO7pyWIjy2AyxH
         TiebLUAqMmlxS4kRx+ArRdkoddQlOk/XUPAHvAgJJigVJZP1aY2iEB92XXQ1OIXl0gOD
         lCTmOciPXUkO9xBStiQ0YBnTRg1uBAjpR4bZrOZ0rIfyzQtCDgJDy2hhhOGGoSq/haXy
         r+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NxA2yBNeWlIfszkTmeiVyLhyQ77gT+nUBeVRVNBKmek=;
        b=fV3JjG2/aRsgDntAXxo8qrqKMJxsl4FLx33nFXVLcZgkN2G33njqxSa9Njxdzqd42y
         0+WYi+SWLjEhsoxt5VAES1++dapEItcLwLKX3wIUZCKnKg83aJEz+zKRnfRO3t3Jjc6f
         23j71EtHEXKAMh3OJR6pcxgbXRDiRDIUsuIWQAtBP/uGR6fx6XM2ukktU0AnkpMUoDLY
         hh0rrQAsCoZMdvxnGsFIE7VY41RuZLCUx1Rk7ACNOTqJ8pEy8Pw3d7pxCaToduxul6Rd
         JC0N1f+uk0PrHtEct0OQUtSU/UAipfgkWtcbylitXzNSXcdRj+PZbR/5/zP/i9HxIn+T
         YPEw==
X-Gm-Message-State: APjAAAXHWdTMlpYOUGw5DUXah13yTG1oPshtyI9QSsBXxH2rvaWNBgQM
        YQ8q2Dp0nNIcm1y87Z0AeYjfbGKw9IOnGQp8BvWh6VAhrSqbQQ==
X-Google-Smtp-Source: APXvYqwvl8gOQtzlio1zgF8wQ0u/+5/67E7v6LZI4sB4pQsaZP2Lf/dnuD0DbbPSBDu6ogsv2ek8lf2xDndGz7vXLrA=
X-Received: by 2002:a05:6830:159a:: with SMTP id i26mr98432619otr.3.1578038435305;
 Fri, 03 Jan 2020 00:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20200103030248.14516-1-wenyang@linux.alibaba.com>
In-Reply-To: <20200103030248.14516-1-wenyang@linux.alibaba.com>
From:   Justin Capella <justincapella@gmail.com>
Date:   Fri, 3 Jan 2020 00:00:23 -0800
Message-ID: <CAMrEMU8wB4c0TFTSJ4ixQg_gSnW72n_T3ip8ZfZFAk8xWjaKsA@mail.gmail.com>
Subject: Re: [PATCH v2] ftrace: avoid potential division by zero
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, xlpang@linux.alibaba.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -               do_div(stddev, rec->counter * (rec->counter - 1) * 1000);
>
> +               stddev = div64_ul(stddev,
> +                                 rec->counter * (rec->counter - 1) * 1000);


Is a rec->counter > 1 assertion needed here?
