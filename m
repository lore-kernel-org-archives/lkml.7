Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D24C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8145D21721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Tx4JYWhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392504AbfFMQbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:31:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43772 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730869AbfFMIXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:23:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id w33so29929692edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 01:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Bn9xqnDM/Ok90ZnjEVBJg4kKO4htMBt6EOE/1PNGbnY=;
        b=Tx4JYWhFEQ4paC9UQ1Ati/km78v81wLDRhSY/EalqBBnEClwSXCW9SqfMkR5Vrt97P
         asT6jG34nVFATlS4QY9GC03yFsuX84G1WiY/34dLIHU4OzW53IBMnx5nM3J8Q9aRFyxv
         ibza93j6ghZQ06OAwkUKXmZmbeAEPcVcyZX8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Bn9xqnDM/Ok90ZnjEVBJg4kKO4htMBt6EOE/1PNGbnY=;
        b=afdc4XOHoBDgBOmKSJR7+KmjEzkgCIkT5Fk5VSpcLipITbkUK5N6tVEFgyauaTTPUZ
         K8OGLNuomc0Zv6tC9sRJpLp7dOZcsmln3Evfga+f9OHw9bqaNXe9+EJOnkDDlNzDESG7
         h4nmnuBsDQLUbrzRkUgJxBjbfnDVk3rtxqF7dISTv5b3X0JEut1RHkYj+iD+ftxYNcMk
         xSN1IOOXK98wTN+ysyPGqfTv9jTyw0cN9MAoZtI043mc1jMDvAEhB6kNuaI+Wmyhp0Tq
         nwT95dZxmU609A5Vi1Djo/WlX2vntWEwYdVetGdPjoRc/ue9kiEHHwnGyr5IdW3fntT+
         AA6g==
X-Gm-Message-State: APjAAAVqVDTFtqAAILU2KmUvsO6cgPZlblLqpZIxoQMSKx1z2kkK/Jxt
        m9Wn0oYph52mKTB487i4BPBtlA==
X-Google-Smtp-Source: APXvYqwxpvYDtacITPIdTW/7to+7XC+PPO1+2atPD+W6vFoXNBpF2kvJ27BXQ7Kw1crdOAPDQ9j4Lg==
X-Received: by 2002:a50:d1d8:: with SMTP id i24mr87310538edg.57.1560414230421;
        Thu, 13 Jun 2019 01:23:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a3sm669461edr.48.2019.06.13.01.23.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 01:23:49 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:23:46 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Tony Cheng <tony.cheng@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Yongqiang Sun <yongqiang.sun@amd.com>,
        Gloria Li <geling.li@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: fix compilation error
Message-ID: <20190613082346.GH23020@phenom.ffwll.local>
Mail-Followup-To: Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Tony Cheng <tony.cheng@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Yongqiang Sun <yongqiang.sun@amd.com>,
        Gloria Li <geling.li@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190613023208.GA29690@hari-Inspiron-1545>
 <CADnq5_PU_jvOskC-=+oRQdvYXZvu_n26ogoWTxLRxnW+ke4wDw@mail.gmail.com>
 <20190613024854.GA25104@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613024854.GA25104@hari-Inspiron-1545>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 08:18:54AM +0530, Hariprasad Kelam wrote:
> On Wed, Jun 12, 2019 at 10:35:26PM -0400, Alex Deucher wrote:
> > On Wed, Jun 12, 2019 at 10:34 PM Hariprasad Kelam
> > <hariprasad.kelam@gmail.com> wrote:
> > >
> > > this patch fixes below compilation error
> > >
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In
> > > function ‘dcn10_apply_ctx_for_surface’:
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2378:3:
> > > error: implicit declaration of function ‘udelay’
> > > [-Werror=implicit-function-declaration]
> > >    udelay(underflow_check_delay_us);
> > >
> > > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > 
> > What branch is this patch based on?
> > 
> > Alex
> 
> Hi Alex,
> 
> It is on linux-next

drm-misc-next has Sam's header cleanup. I guess we pull linux/delay.h in
implicitly somewhere, but not for all configs.
-Daniel

> 
> Thanks,
> Hariprasad k
> > > ---
> > >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > > index d2352949..1ac9a4f 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > > @@ -23,6 +23,7 @@
> > >   *
> > >   */
> > >
> > > +#include <linux/delay.h>
> > >  #include "dm_services.h"
> > >  #include "core_types.h"
> > >  #include "resource.h"
> > > --
> > > 2.7.4
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
