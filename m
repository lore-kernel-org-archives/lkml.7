Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C1DC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C43205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403937AbfEXNwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:52:44 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41207 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403909AbfEXNwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:52:43 -0400
Received: by mail-vs1-f68.google.com with SMTP id w19so5787261vsw.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 06:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wkXuNyY+BPK06cBRjiKGUSp8g87URqk4aYlZC7CDaI=;
        b=OtHQxq9gk5UZAxWRfA4bx/PHjvDCXzWHE5SA3YupxsuhhDg+DyobzbYHynIQedcUt2
         BnbKu1Jyzp4W5B7aDw1StWOCw9RZAyBvCurQqa5vQUMNcCBW4F2A5QkxX1CzNG0sLfGO
         BC16fFGMYeicRsYQYQzAOLMfn49b/q/FG7qPwJPyplOe69hLFXSkIfkAPvw4dljnvUeq
         PG7NJWjXqH8cQj56IFyGLL5lJXsajl56LpdmUvW6CvOEwRD98fPnLWL9Uh7TtLt7+FtK
         9GCcpr3Ns0SZZK8NGP7MR3p87JHWZF9xAvHcRvluPzI3feUWqPUDD2ABFkGlq47KuzLm
         Jwdg==
X-Gm-Message-State: APjAAAWhZcI8fvnSjDu860lCYsW4D5OAC+cmkHR78yVOHGOnkvhITeXT
        8ZZe4iByxmCrwIxG+kcaVE5iiQkkNPW7FVcTCgu98w==
X-Google-Smtp-Source: APXvYqx1BviKXWBNCPF7WMrnr2OOPxRTRziJl0o1SV5/wIzq8V4kIAVRBFQjsqx2jPhgYz332/R9XIBBbBq9E8AWYS8=
X-Received: by 2002:a67:f309:: with SMTP id p9mr50802170vsf.216.1558705962670;
 Fri, 24 May 2019 06:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190426145946.26537-1-ghalat@redhat.com> <CAKbGCscqbvOaXPTdmxatNLBygdu=WC0hVUKx0_WnqUR4+dj_zQ@mail.gmail.com>
 <20190524080602.GA19514@kroah.com>
In-Reply-To: <20190524080602.GA19514@kroah.com>
From:   Grzegorz Halat <ghalat@redhat.com>
Date:   Fri, 24 May 2019 15:52:31 +0200
Message-ID: <CAKbGCscp6gLFEuu+xn24KM6Gy=x=pW9bnJGF_2CY3jzbnyV5_g@mail.gmail.com>
Subject: Re: [PATCH] vt/fbcon: deinitialize resources in visual_init() after
 failed memory allocation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019 at 10:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> How?  How are you triggering a memory allocation failure in a "normal"
> system?
> Anyway, I'll queue this up, but it really does not seem like anything
> anyone would see "in the wild"

I've seen this crash twice in ours customer environment under low
memory conditions.
There is a report in Debian bug tracker:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=804443
and LKML bug report:
https://lkml.org/lkml/2017/12/18/591

--
Grzegorz
