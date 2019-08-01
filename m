Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6FFC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B5F206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbfHATQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:16:30 -0400
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:55866 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726118AbfHATQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:16:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C848318029123;
        Thu,  1 Aug 2019 19:16:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ring06_8f6c4551ca725
X-Filterd-Recvd-Size: 3026
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Aug 2019 19:16:24 +0000 (UTC)
Message-ID: <ce8c8a7342282467c3b681fd1b0874817250c16e.camel@perches.com>
Subject: Re: [PATCH][drm-next] drm/amd/powerplay: fix a few spelling mistakes
From:   Joe Perches <joe@perches.com>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Colin King <colin.king@canonical.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Aug 2019 12:16:23 -0700
In-Reply-To: <CADnq5_OdBM83zkkgtjwzQ0jqsiDP5wZoMXioGcq4mycX2=Tavw@mail.gmail.com>
References: <20190801083941.4230-1-colin.king@canonical.com>
         <CADnq5_OdBM83zkkgtjwzQ0jqsiDP5wZoMXioGcq4mycX2=Tavw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-01 at 15:02 -0400, Alex Deucher wrote:
> Applied.  thanks!
> 
> Alex
> 
> On Thu, Aug 1, 2019 at 4:39 AM Colin King <colin.king@canonical.com> wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There are a few spelling mistakes "unknow" -> "unknown" and
> > "enabeld" -> "enabled". Fix these.
[]
> > diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
[]
> > @@ -39,7 +39,7 @@ static const char* __smu_message_names[] = {
> >  const char *smu_get_message_name(struct smu_context *smu, enum smu_message_type type)
> >  {
> >         if (type < 0 || type > SMU_MSG_MAX_COUNT)

This looks like an off-by-one test against
SMU_MSG_MAX_COUNT where type
should be >=

> > -               return "unknow smu message";
> > +               return "unknown smu message";
> >         return __smu_message_names[type];
[]
> > @@ -52,7 +52,7 @@ static const char* __smu_feature_names[] = {
> >  const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature_mask feature)
> >  {
> >         if (feature < 0 || feature > SMU_FEATURE_COUNT)

here too

> > -               return "unknow smu feature";
> > +               return "unknown smu feature";
> >         return __smu_feature_names[feature];

Perhaps instead it should be against ARRAY_SIZE(__smu_<foo>)

Also, the  __SMU_DUMMY_MAP macro is unnecessarily complex.

It might be better to have some direct
index and name struct like

struct enum_name {
	int val;
	const char *name;
};

And walk that.

Perhaps add a macro like

#define enum_map(e)
	{.val = e, .name = #e}


