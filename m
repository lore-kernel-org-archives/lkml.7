Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18E3C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88802080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlff+T0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfFMQyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:54:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45925 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbfFMCtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 22:49:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so10798284pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 19:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2kfw74gaPiQLBivN6WnAdASClOTarpBowH5hE17A4dU=;
        b=mlff+T0EI3xPNdUTq8+8uEb3J8W+RDh37tnQqBQJXniyQlQ9E+5o/Zv7YgMkxdBb/e
         V/9kn+Z4oq7ipWZSeVf/S7tAdZzMryM/tIeV8BNnJShHmE1QEm8dLZiiHnuhdajxwwuI
         boACWHwcLQUTS/4l11AC8ZQcwniFXKKQH0J8SHKF9M+c+TLLlVQ4ni3xRWq2/U9njKkr
         CUPrnaIw/0FBBiljnWpU8pTgoZGeb/b8Z9Gt5nfPX/YV3IsgRNNyq/tuQ1Ey/eXMKy9X
         NHOqoVmk+Yr19mGOTiRBel66idcIpQP8lL1chpDXGMCksduSYpj/o5lx6q772k6Vm0s8
         oVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2kfw74gaPiQLBivN6WnAdASClOTarpBowH5hE17A4dU=;
        b=bgpfmQb1sy/Kz5chxJOCft+n0v6KHApR2UUcKxqA0dk3EyCi2VPNZDVydOiNBPFVvr
         AGfnOJnXK6qU8AhQyLN9OuouR3TzMydGKmp36d4nF7J079a9QrAiKpkoxNEBXXK0rJQd
         uu35C/P7k02JhL+khhqWybpnEQio2Ee7H9vj4wL4kaDwqBqB6onlY0Xfa7cxANKiPchU
         TmlGaAU8napV5plmgRcYp0InH166qOCc6Ekn8RjPZXvwmjwT2Za/IfWl0iJRR/jmqLuQ
         ua7jVOtFbSfSUGHgH8kK5wWyHqCqGUHlRaYwndo1T9gYeZY0kPe/H7UqiqTE5bInPGmU
         zv6g==
X-Gm-Message-State: APjAAAWYoDLH3Tvr2wpyClOB7QBEmPz4aIlGCNUQQ8Zh7guG01jEgwlW
        UhKuKtK7U77HaWJS+WxRdH0=
X-Google-Smtp-Source: APXvYqy7N3/apEzke72gAXr2P0AbPFJhZcmBqH52rWR9JzsFn/eGdg3Ub81yBSOKIDg4uEckTBEePw==
X-Received: by 2002:a65:4306:: with SMTP id j6mr27990148pgq.418.1560394141664;
        Wed, 12 Jun 2019 19:49:01 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id y5sm781057pgv.12.2019.06.12.19.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 19:49:01 -0700 (PDT)
Date:   Thu, 13 Jun 2019 08:18:54 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Alex Deucher <alexdeucher@gmail.com>,
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
Message-ID: <20190613024854.GA25104@hari-Inspiron-1545>
References: <20190613023208.GA29690@hari-Inspiron-1545>
 <CADnq5_PU_jvOskC-=+oRQdvYXZvu_n26ogoWTxLRxnW+ke4wDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_PU_jvOskC-=+oRQdvYXZvu_n26ogoWTxLRxnW+ke4wDw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 10:35:26PM -0400, Alex Deucher wrote:
> On Wed, Jun 12, 2019 at 10:34 PM Hariprasad Kelam
> <hariprasad.kelam@gmail.com> wrote:
> >
> > this patch fixes below compilation error
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In
> > function ‘dcn10_apply_ctx_for_surface’:
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2378:3:
> > error: implicit declaration of function ‘udelay’
> > [-Werror=implicit-function-declaration]
> >    udelay(underflow_check_delay_us);
> >
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> 
> What branch is this patch based on?
> 
> Alex

Hi Alex,

It is on linux-next

Thanks,
Hariprasad k
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > index d2352949..1ac9a4f 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > @@ -23,6 +23,7 @@
> >   *
> >   */
> >
> > +#include <linux/delay.h>
> >  #include "dm_services.h"
> >  #include "core_types.h"
> >  #include "resource.h"
> > --
> > 2.7.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
