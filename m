Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B270EC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C16C21848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfJBOv2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:51:28 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33790 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfJBOv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:51:26 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so26742149qtd.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 07:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BFBQJKcoWFEsoedh3fU5Yan3pHcHh9XjwUhZKy85y8A=;
        b=AvB0iNDL7w2KazAF5hr0rP1gedm6EW+1XAt5sLzt+KXz8gM2SoZX2pGxuSigd6DEud
         2gFJTtyMmhGQagIuv+xCV7NSPBmb9bTe75R81096DjJrSEG6XWhdYMeAMgIQgPk2bTw2
         KHUUhAd3n34QTDjg70pi6IkDiwETKl/JxrdRXaCoEPx2fEx8Cset+1O4/4HBC0Ii0VfU
         vxow06u661vcn18B5bFsCvIlkmxdwVUQxDSh9XYmx6MrSsXOXZggmo+ZqU7ZC4ci5+fq
         6qieaBFf6iGsJX5L45DOnuT0pm6yDYbIxLHQwXwRl9scBvzRxscPaBf+Zb9xRbgie4YM
         JmGw==
X-Gm-Message-State: APjAAAWOnIhhK5JIbsSi6Ou1KkQ9Xnylrcgh73RSItjkIAqdw75uyCD5
        ZrL1HGXvdpFB/INOlL1Q0YrmAKEkVsojaaAsYdE=
X-Google-Smtp-Source: APXvYqxytpKY7md+ImYxw2tgO2LdMMwX5MTobPRAkiWizRa+eDP+sDnPS94ixm658TSE7sUrUSJHRI/Q/drWU7Qw1LM=
X-Received: by 2002:ac8:4a01:: with SMTP id x1mr4410955qtq.304.1570027885656;
 Wed, 02 Oct 2019 07:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191002120136.1777161-1-arnd@arndb.de> <20191002120136.1777161-5-arnd@arndb.de>
 <CADnq5_PkTwTBbQY9JatZD2_sWjdU5_hK7V2GLfviEvMh_QB12Q@mail.gmail.com>
In-Reply-To: <CADnq5_PkTwTBbQY9JatZD2_sWjdU5_hK7V2GLfviEvMh_QB12Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 2 Oct 2019 16:51:09 +0200
Message-ID: <CAK8P3a0KMT437okhobg=Vzi5LRDgUO7L-x35LczBGXE2jYLg2A@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amd/display: fix dcn21 Makefile for clang
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 4:17 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> I'm getting an error with gcc with this patch:
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.o
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c: In
> function ‘calculate_wm_set_for_vlevel’:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:964:22:
> error: SSE register return with SSE disabled

I checked again with gcc-8, but do not see that error message.

> > -CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse -mpreferred-stack-boundary=4
> > +CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse $(cc_stack_align)

Nothing should really change with regards to the -msse flag here, only
the stack alignment flag changed. Maybe there was some other change
in your Makefile that conflicts with my my patch?

       Arnd
