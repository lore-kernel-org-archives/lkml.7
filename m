Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96962C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614FD2081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578391496;
	bh=z+k0k9XyF2XaC/1qm3SPSPIGtpCcVnSsT8xBIPL/GDs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gwwYeocqT60YGft5J0CE+ofFqPXGqxCVa7sSJqVupHnviT8p/l3TiPNw6of2caNKL
	 SeAdM91F8hndxOMrNKdBE7RfFUyFFTXRxSzGWkrJpg8VXRaREcEpvoThw9RSqv/xek
	 f7gF6gxShJA9F/ho/BweR/HNlSTmMr7QstZ9fZIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgAGKEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:04:55 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46090 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGKEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:04:55 -0500
Received: by mail-oi1-f194.google.com with SMTP id p67so17371392oib.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:04:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9OKbMZWRAmiTF6ODcRzRiBwtRnKeMsOcJnKTjB3BHc=;
        b=gEPVAHVzzdOqXWzI19Y4TsUWCZsMvxsR2IzR939Zy6E2fpHd477Fk3K1tDzn84VqRF
         3zcZWrnvgSW+hT7ZJZgw7IH/hQxTbL05M5nlsGw4nSDwsxvGLMqoSGG1YHyw9TaDYaDL
         N5U2MNeng7CDjfLPekF/FTKjAvwfJhHh7RrIXMfKRN/jmwH4FHlWipFSNvv91cWZeZhv
         NNZD5Mvhswq6/g16xOVDcbkWCfjXAYL95CIxvzUMgAMY9d03ZL7JmWy+wNF2OLAbu10T
         rkZuqEE5djp+cyAbKVTyp1Gvx7FBjmuGAjhlspVSL5OdNjSVP6zOkqT/sxTWoJZOa1Mu
         j7Mw==
X-Gm-Message-State: APjAAAXE3rujs5fOJudbOHSYTnGnIINkxBrFF9G2SU2WGl6H+hJaYYOo
        ZbkivWBh9kUkjk4IcrhNdQ3R58GsuEmTMotlwEI=
X-Google-Smtp-Source: APXvYqyuID/tIK9mIb+yQZBB/bC/oQPe9u8oemmaCUDNeX4YehBT5sImEFsyMYn/0lipjpsQ9G820oWS1rko3emytaA=
X-Received: by 2002:aca:cd92:: with SMTP id d140mr6575824oig.68.1578391494788;
 Tue, 07 Jan 2020 02:04:54 -0800 (PST)
MIME-Version: 1.0
References: <20191226220205.128664-1-semenzato@google.com> <20191226220205.128664-2-semenzato@google.com>
 <20200106125352.GB9198@dhcp22.suse.cz>
In-Reply-To: <20200106125352.GB9198@dhcp22.suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jan 2020 11:04:43 +0100
Message-ID: <CAJZ5v0iJksVhrWwOCaSfg1HcmtTVTKAmF04iKuMvyO6vjm5rnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: clarify limitations of hibernation
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Luigi Semenzato <semenzato@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Pike <gpike@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 1:53 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 26-12-19 14:02:04, Luigi Semenzato wrote:
> [...]
> > +Limitations of Hibernation
> > +==========================
> > +
> > +When entering hibernation, the kernel tries to allocate a chunk of memory large
> > +enough to contain a copy of all pages in use, to use it for the system
> > +snapshot.  If the allocation fails, the system cannot hibernate and the
> > +operation fails with ENOMEM.  This will happen, for instance, when the total
> > +amount of anonymous pages (process data) exceeds 1/2 of total RAM.
> > +
> > +One possible workaround (besides terminating enough processes) is to force
> > +excess anonymous pages out to swap before hibernating.  This can be achieved
> > +with memcgroups, by lowering memory usage limits with ``echo <new limit> >
> > +/dev/cgroup/memory/<group>/memory.mem.usage_in_bytes``.  However, the latter
> > +operation is not guaranteed to succeed.
>
> I am not familiar with the hibernation process much. But what prevents
> those allocations to reclaim memory and push out the anonymous memory to
> the swap on demand during the hibernation's allocations?

Nothing in particular AFAICS, at least in theory.

The approach taken by the hibernation code is rather straightforward:
allocate enough memory to store a copy of every page (in RAM) that
needs to be saved.  These allocations are made one page at a time, so
in theory they should not fail as long as there is enough swap space
in the system, but I'm probably missing something here.
