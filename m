Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B99C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 21:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB6C20833
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 21:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBQT62eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfLCVam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 16:30:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33720 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726583AbfLCVam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 16:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575408640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVkHv3p11mXgV99QlMIl1/3VrE+Xsk2FfcjR6WYk0Vk=;
        b=NBQT62eh6XBZYq21ZnJIz+QWEdZiep7p0AmtnfnR0+hHcuBNgRzSGH4FM68wYH1us5Eg2E
        q6tIggSHgVMtfvX4VIe+8L/uZqF9KJHqW/Ic/QVD3TCV8w9xxkLwLQDkC77OfH0Ai1OMUp
        r/FM+dMox7pR16P8i78DNtW7m9T8msw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-KgjCbRt-NZGC9U6zhpT7dw-1; Tue, 03 Dec 2019 16:30:37 -0500
Received: by mail-qt1-f198.google.com with SMTP id j14so3483445qtr.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 13:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=oVkHv3p11mXgV99QlMIl1/3VrE+Xsk2FfcjR6WYk0Vk=;
        b=EMGzwqAcyKXA81jhjtoTeyBr5xTi/oy2MZa4laMdtkAjTYYTBuQXe/sUOmur4m7xZ2
         TrzZvp8fRINFHJcZOG614GKGQTgAlrNQ7lLNarZ3RHlM8rf76FbeczqDOZvGrFo93kXE
         SbA6gx1rtip0uydjFErtBa+tf7DnILVonsgNmNbTpoFb+716Lx03KVcn0MQs7fo/mGme
         XR1s/90+EDd1uLcEn4GqrbkeAkoAh2/cFuvxhq95K1C/VZwK0JtFasmxWaFQ9MCeux+0
         5Ff966xCbiYGAsRixLxsuq4LjOGQq1dtlDGPJSFMHp2Ba4X++CQZrYMyxXsKyQpSNPht
         mbpQ==
X-Gm-Message-State: APjAAAUx4/ZTbONlJB9nL38iM9cUK5nJroqH9K8NjpW/+9iM3ImDz7wB
        nY1onvPhNUOQDXutSPs+ynaZaVTSEA78Pz5NGTdK96vxnFzg8uTExWQF89p6KENKeViU5j1vADn
        WsHJ4FZxiU4jfqR/WHX+rB7QW
X-Received: by 2002:a05:620a:1663:: with SMTP id d3mr7770114qko.204.1575408636933;
        Tue, 03 Dec 2019 13:30:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqx54quaeILrvI+YvFwX3cJ/jz6a0mLjjFo5Z7L28rGml0sLqP9j6m4hoyBRsSJspupT20C76w==
X-Received: by 2002:a05:620a:1663:: with SMTP id d3mr7770089qko.204.1575408636721;
        Tue, 03 Dec 2019 13:30:36 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id k50sm2628629qtc.90.2019.12.03.13.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 13:30:35 -0800 (PST)
Message-ID: <b35216fce6ed8f822d9147b2fa96a7cd840d96a9.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Fix build on systems with
 STACKTRACE_SUPPORT=n
From:   Lyude Paul <lyude@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 03 Dec 2019 16:30:34 -0500
In-Reply-To: <20191203093334.GB624164@phenom.ffwll.local>
References: <20191202133650.11964-1-linux@roeck-us.net>
         <CAMuHMdUz7gewcFPE=cnVENGdwVp6AZD7U4y1PtwXTAmoGmvGUg@mail.gmail.com>
         <837a221f0fc89b9ef6d3fbd2ceae479a5c98818a.camel@redhat.com>
         <20191203093334.GB624164@phenom.ffwll.local>
Organization: Red Hat
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: KgjCbRt-NZGC9U6zhpT7dw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-12-03 at 10:33 +0100, Daniel Vetter wrote:
> On Mon, Dec 02, 2019 at 01:49:47PM -0500, Lyude Paul wrote:
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > 
> > I'll go ahead and push this to drm-misc-next, thanks!
> 
> drm-misc-next-fixes since it's in the merge window. drm-misc-next is for
> 5.6 already.
> -Daniel

Ahh, that explains things :). Pushed, thanks for the patches!
> 
> > On Mon, 2019-12-02 at 16:20 +0100, Geert Uytterhoeven wrote:
> > > On Mon, Dec 2, 2019 at 2:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > On systems with STACKTRACE_SUPPORT=n, we get:
> > > > 
> > > > WARNING: unmet direct dependencies detected for STACKTRACE
> > > >   Depends on [n]: STACKTRACE_SUPPORT
> > > >   Selected by [y]:
> > > >   - STACKDEPOT [=y]
> > > > 
> > > > and build errors such as:
> > > > 
> > > > m68k-linux-ld: kernel/stacktrace.o: in function `stack_trace_save':
> > > > (.text+0x11c): undefined reference to `save_stack_trace'
> > > > 
> > > > Add the missing deendency on STACKTRACE_SUPPORT.
> > > > 
> > > > Fixes: 12a280c72868 ("drm/dp_mst: Add topology ref history tracking
> > > > for
> > > > debugging")
> > > > Cc: Lyude Paul <lyude@redhat.com>
> > > > Cc: Sean Paul <sean@poorly.run>
> > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > 
> > > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > 
> > > Gr{oetje,eeting}s,
> > > 
> > >                         Geert
> > > 
> > -- 
> > Cheers,
> > 	Lyude Paul
> > 
-- 
Cheers,
	Lyude Paul

