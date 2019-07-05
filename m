Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA78C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F0F21670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX1TZpQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfGEUfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 16:35:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36528 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfGEUfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:35:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so11073402wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 13:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k4BDG3Gb73jNiTZtUtMpfoGK9P735tSlZRxVBA+5Xuo=;
        b=nX1TZpQU+TbhqeOxzhSX4XmNGFaXHjLcXDfAjecwM99P/9gcUkcZDA2xYl/mGET6EB
         4haXduw99strraMo4+Ckg4vPzdkgMw8l9MXuV9Q5g2QxNEoprNRn8FFTKPBpcvjOhcDJ
         HMuiTPtI7+OHJV6/a5oGZwA8aYpXwy+dVAogdGAxngs1OIG8eqOAOxbjjRNcp+LduAuS
         xdqXVZNZhwn/wLh8w6YT2IYXIt0J3jJoaY39Sz6x7IJJ+VE8wHu7a7+RxJp68MsNCpVP
         ctPZsRbu+L5tfaDSiKV9sO/8urpNSVwCf+ygtaXQ7+hkEw0KuviPK6GLVf9Jc7mM48du
         3elQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k4BDG3Gb73jNiTZtUtMpfoGK9P735tSlZRxVBA+5Xuo=;
        b=M9nYuBUBc+JObFVTL5V3V8bWE3SXhPnUrnW87w/kP+FCmb5FxaxaTTTjj+0LGy+CkN
         hvdcf00+1jg0Q+Cg182pBoFivL/gdthAlmnxugxlIXjr7GXQsHcrHVXEQ401jQdwmFBT
         0Jz+D8nP05ie1LUNseeGvdxwRz9iMKnLmYf2MthAHYf+oTlacbTfPNNQkmkE8WFDBH/c
         QBzfjN7IDkM05ZJsmSaQEbP7AwGxiC7grwMJnnYSU3SwfTP3m5xAYlr50CQc6oRA1CfH
         /mWfh8Dla9YkQlMUXW5Zhl/STbiTNMfAlGr6m5xYH3p2Tj8rEEb2XFNfvqlyQdnE6zo/
         GC8Q==
X-Gm-Message-State: APjAAAWm7Dsf3Yj4hxring9vD3oL18pz1hW5KKnRakmeG1YNhmiJ24L7
        KD6U/cbKspoY/QmyTZEQSw9dzNy3XTsz2uXjHJI=
X-Google-Smtp-Source: APXvYqylofBLb1zWU/YUKF/s0FvCOodi1bulZJCl9uZLM9sGngoWbxuKh3qcs9cAqp86dnu11iDr4FNC6I1CcmwPjBM=
X-Received: by 2002:adf:d847:: with SMTP id k7mr2848276wrl.74.1562358908599;
 Fri, 05 Jul 2019 13:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190530000819.GA25416@obi-wan> <20190604202149.GA20116@obi-wan>
 <CADnq5_OqVSz7Vfo0zP88i=wJur=wtz6Jd99ZTiQSbFNBcc3j7w@mail.gmail.com>
 <20190616144309.GA8174@obi-wan> <20190704201535.GA21911@obi-wan>
In-Reply-To: <20190704201535.GA21911@obi-wan>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 5 Jul 2019 16:34:57 -0400
Message-ID: <CADnq5_Oh76ABprkBrnJBaamv4gi15szfkJi8hM_Ys=d_4xTr+g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay/smu7_hwmgr: replace blocking delay with non-blocking
To:     Yrjan Skrimstad <yrjan@skrimstad.net>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 4:15 PM Yrjan Skrimstad <yrjan@skrimstad.net> wrote:
>
> On Sun, Jun 16, 2019 at 04:43:10PM +0200, Yrjan Skrimstad wrote:
> > That is an interesting observation to me. I am actually running
> > lm-sensors, although only every 15 seconds. I suppose that this might
> > be the reason this happens to me.
>
> Though I don't think this should reasonably cause problems with the
> system, even if it does here. Is there an update on the status of this
> patch?

Applied.  sorry for the delay.

Alex
