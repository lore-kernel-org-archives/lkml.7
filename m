Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B9EC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C6E20640
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iVydF1wQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLCJdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:33:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38192 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCJdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:33:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so2625851wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 01:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZaaTzB9B+KCHVUkdR37ZgN+trAYMPzah4PHL0bT6fiA=;
        b=iVydF1wQ/0vgHkuScgqf254M2NgW1SCwaXfH8upjUBcTDJ+xqoU2DJYQvUB3zHCbA4
         k8D4XT2StG+r/EPuGb7sb2JeoRzvniMPtuFUPZ16EInVXOmfmCC1xSuuWrkKSql6MU6/
         SS231G5wNpT9fEsjpgqWU4f4FxrkcCDYJvkkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ZaaTzB9B+KCHVUkdR37ZgN+trAYMPzah4PHL0bT6fiA=;
        b=jXyqB01cLcgALbKI2lgx6xeYsssELlpWYWQAK5RiPEqyqMkLEaOUtWlpOhpkXqcLc+
         HR1DpzQFcHpQgvzCrOk3H0L/i+ROP5fEx1F5mGgyN0D1iWSFC6cydutqP+iPc5o5eSzQ
         W8Ddtdc0sHJvPpD2seGn/wIfHeb3vEy6I+V3586rqmd/3xf6e9xSTYv/6BxUVApgsCgG
         fBzbQm2UFwcRghcu3S3n6iFPSItA3/4fLKxhp/eU0qI8lLa2qcqxa+iU2LxQoSj4168r
         iQfcxm6gJSeFgfGmyyCYT4/Vu8PK84znjMReOy/19vbZuRsUULHR3W1Abqz4LPOGZFB8
         Yh/A==
X-Gm-Message-State: APjAAAXDcCRQaErM/VSlWj5vNIjZyv5QhR0xNCEEIQ6PM0fFsReuup3X
        d/0C8rEDRIzFVr+YNVGu0+89c+2DPfw=
X-Google-Smtp-Source: APXvYqz+J633fcXdBMYZwoxzR3wo7HbfzMMPymK979NzaZ2U6MB3HPM+JckPDdwUIGCUS4tLBkdSgQ==
X-Received: by 2002:a1c:8153:: with SMTP id c80mr33780098wmd.58.1575365617059;
        Tue, 03 Dec 2019 01:33:37 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id z13sm2382476wmi.18.2019.12.03.01.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 01:33:36 -0800 (PST)
Date:   Tue, 3 Dec 2019 10:33:34 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/dp_mst: Fix build on systems with
 STACKTRACE_SUPPORT=n
Message-ID: <20191203093334.GB624164@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191202133650.11964-1-linux@roeck-us.net>
 <CAMuHMdUz7gewcFPE=cnVENGdwVp6AZD7U4y1PtwXTAmoGmvGUg@mail.gmail.com>
 <837a221f0fc89b9ef6d3fbd2ceae479a5c98818a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <837a221f0fc89b9ef6d3fbd2ceae479a5c98818a.camel@redhat.com>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 01:49:47PM -0500, Lyude Paul wrote:
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
> I'll go ahead and push this to drm-misc-next, thanks!

drm-misc-next-fixes since it's in the merge window. drm-misc-next is for
5.6 already.
-Daniel

> 
> On Mon, 2019-12-02 at 16:20 +0100, Geert Uytterhoeven wrote:
> > On Mon, Dec 2, 2019 at 2:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > On systems with STACKTRACE_SUPPORT=n, we get:
> > > 
> > > WARNING: unmet direct dependencies detected for STACKTRACE
> > >   Depends on [n]: STACKTRACE_SUPPORT
> > >   Selected by [y]:
> > >   - STACKDEPOT [=y]
> > > 
> > > and build errors such as:
> > > 
> > > m68k-linux-ld: kernel/stacktrace.o: in function `stack_trace_save':
> > > (.text+0x11c): undefined reference to `save_stack_trace'
> > > 
> > > Add the missing deendency on STACKTRACE_SUPPORT.
> > > 
> > > Fixes: 12a280c72868 ("drm/dp_mst: Add topology ref history tracking for
> > > debugging")
> > > Cc: Lyude Paul <lyude@redhat.com>
> > > Cc: Sean Paul <sean@poorly.run>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > 
> > Gr{oetje,eeting}s,
> > 
> >                         Geert
> > 
> -- 
> Cheers,
> 	Lyude Paul
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
