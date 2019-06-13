Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE8AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C346721473
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfFMSm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:42:27 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:50856 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfFMSm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:42:27 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 5943E20024;
        Thu, 13 Jun 2019 20:42:23 +0200 (CEST)
Date:   Thu, 13 Jun 2019 20:42:17 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Yongqiang Sun <yongqiang.sun@amd.com>,
        Charlene Liu <charlene.liu@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Gloria Li <geling.li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Tony Cheng <tony.cheng@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>
Subject: Re: [PATCH] drm/amd/display: fix compilation error
Message-ID: <20190613184217.GA2385@ravnborg.org>
References: <20190613023208.GA29690@hari-Inspiron-1545>
 <CADnq5_PU_jvOskC-=+oRQdvYXZvu_n26ogoWTxLRxnW+ke4wDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_PU_jvOskC-=+oRQdvYXZvu_n26ogoWTxLRxnW+ke4wDw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
        a=4PFS9l_RyDpw6E2KiyoA:9 a=QEXdDO2ut3YA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex.

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

Am I right in assuming you took this patch?

I expect that new code using udelay was added to the amd tree,
and when merged with drm-misc-next it failed, because drm-misc-next no
longer had drmP.h included so no implicit include of delay.h

The root cause was that my original patchset should have been based
on the amd tree, and applied there :-(

	Sam
