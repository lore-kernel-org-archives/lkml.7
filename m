Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56269C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235FE20700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CGln5oh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfC0QCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:02:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41241 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfC0QCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:02:03 -0400
Received: by mail-oi1-f193.google.com with SMTP id v7so13287100oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 09:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pHeA537fnJ4pDsXCjDzNIfpxL7R52PMocjY0p5DVxuc=;
        b=CGln5oh6SzqQpxM3IHknaVbdPN/vj5l+fcaGLrWWEwTzUNRcoDJf82UJP+KudbYqr3
         pJGXFWv7Cqzanos4kvRdTlKMjWfglK5n6ud5B2ivruTA1ZKmhWfp9HTfCWR41L2e/GYS
         exkg1bGKNiH1iBHgygTUayrgSfobeYmH8PmfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pHeA537fnJ4pDsXCjDzNIfpxL7R52PMocjY0p5DVxuc=;
        b=UTQespWObPZe8Ol0ph8GiQabBsnDbcOIlWYhMcLbQNwKXTtpuXz034ftrshom1IzE3
         1JeZefAPGiImOBp4ZM8JRJzfky3VOkHfrdzpJAIGPe3njCTPsYQi3/enS6nMwaO//d4y
         9ePQeUHupjGDMjFV/5B63bEqo0y5qCE0oEl3cSojuCrHnwO7EY2L2ET9OsarKRTUNv2h
         Uj+TDMFYOZ4BIuog4iW2ZFGj6FjFcVJHaAsm/Jupn6WRmIGPrMs/mB6l+HP4zAcxCB3m
         ffO6/K9yYtkf/wyt5y6dYhptOct5hYNndl8aQnARelbVQQsuYoQBD2zf4kyvpPUBJxzP
         SIIQ==
X-Gm-Message-State: APjAAAUOhZHgl9aIe2Q/PTtVEgr/hpkYS4ZYOqW9fHUYTdHKrCQVd+Xj
        dyFux4PZeOda48oYnlkpwg12FekdZcg=
X-Google-Smtp-Source: APXvYqx8oiLwwGEHzR4NZk8m9CF8nRvj6r33n9UBJommP85lxv8k7xU3bTbhbRmAGbdWdApKxTkgeA==
X-Received: by 2002:aca:6209:: with SMTP id w9mr20308411oib.47.1553702522701;
        Wed, 27 Mar 2019 09:02:02 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id v1sm3388866oto.47.2019.03.27.09.02.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 09:02:01 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id 67so13217225oif.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 09:02:01 -0700 (PDT)
X-Received: by 2002:aca:558d:: with SMTP id j135mr19842683oib.49.1553702521007;
 Wed, 27 Mar 2019 09:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <1553339772-25012-1-git-send-email-rushikesh.s.kadam@intel.com>
 <31755c704928710da998353192157ddfd903080c.camel@linux.intel.com>
 <CAHX4x87iQgjX8wHOYNCD7nYQJZKoirgCimPax11bMX_DGMEudw@mail.gmail.com> <de917efc4ded94b3fbc70913207881b3a0c10b52.camel@linux.intel.com>
In-Reply-To: <de917efc4ded94b3fbc70913207881b3a0c10b52.camel@linux.intel.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Wed, 27 Mar 2019 10:01:49 -0600
X-Gmail-Original-Message-ID: <CAHX4x86DKshGWj8D4nYje3fUvETG14jD4jNt+VgpejmzU2Dnog@mail.gmail.com>
Message-ID: <CAHX4x86DKshGWj8D4nYje3fUvETG14jD4jNt+VgpejmzU2Dnog@mail.gmail.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ISH firmware loader client driver
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        benjamin.tissoires@redhat.com, jikos@kernel.org,
        jettrink@chromium.org, gwendal@google.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 8:22 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2019-03-26 at 18:39 -0600, Nick Crews wrote:
> > Hi Rushikesh, I know I've been reviewing this on Chromium, but I have
> > some more larges-scale design thoughts.
> Hi Nick.
>
> Does this fundamentally change, the way it is done here or can wait for
> subsequent revisions later?

I don't have any official stakes in this, as I'm not the maintainer or
anything, so
I'm just preaching what I think would be good design :)

I think I would like to see most of my suggestions addressed. At the
very least there
are some actual bugs (infinite loops, accessing bad memory, not
reporting all errors)
 that need to get fixed. Of course I'm not the one that has to write
or test it, but I imagine
that the one large design change I proposed of where memory is
allocated shouldn't be too
hard either. I worry that "subsequent revisions" to upstream won't
happen, since it's hard enough
to get a patch accepted. Maybe that concern isn't warranted though, I
don't have that
much experience on the LKML.

Is there a really tight deadline for this? If so then I would say we
should apply what
we currently have to the Chromium tree, and upstream the final version
when it's done.

Thanks,
Nick

>
> Thanks,
> Srinivas
>
