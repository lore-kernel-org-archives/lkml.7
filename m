Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EF7C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CD020645
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbfDQLKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:10:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:10951 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfDQLKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:10:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 04:10:39 -0700
X-IronPort-AV: E=Sophos;i="5.60,361,1549958400"; 
   d="scan'208";a="135085063"
Received: from rauchh-mobl.ger.corp.intel.com (HELO [10.249.32.153]) ([10.249.32.153])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES128-SHA; 17 Apr 2019 04:10:35 -0700
Subject: Re: [PATCH 04/20] drm/fourcc: Pass the format_info pointer to
 drm_format_plane_width/height
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Emil Velikov <emil.velikov@collabora.com>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
 <194fd02a37172de6f2a799fee5c98ced5e7e9d76.1555487650.git-series.maxime.ripard@bootlin.com>
 <776131c6-b8be-4302-ea9a-f7d84203f28c@linux.intel.com>
 <20190417110119.ygp6h7kpzzo5a27l@flea>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <8d909dcf-16de-7462-1cc6-2713778ed8b1@linux.intel.com>
Date:   Wed, 17 Apr 2019 13:10:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417110119.ygp6h7kpzzo5a27l@flea>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 17-04-2019 om 13:01 schreef Maxime Ripard:
> On Wed, Apr 17, 2019 at 12:47:48PM +0200, Maarten Lankhorst wrote:
>>> +/**
>>> + * drm_format_info_plane_width - width of the plane given the first plane
>>> + * @format: pixel format info
>>> + * @width: width of the first plane
>>> + * @plane: plane index
>>> + *
>>> + * Returns:
>>> + * The width of @plane, given that the width of the first plane is @width.
>>> + */
>>> +static inline
>>> +int drm_format_info_plane_width(const struct drm_format_info *info, int width,
>>> +				int plane)
>>> +{
>>> +	if (!info || plane >= info->num_planes)
>>> +		return 0;
>>> +
>>> +	if (plane == 0)
>>> +		return width;
>>> +
>>> +	return width / info->hsub;
>>> +}
>>> +
>>> +/**
>>> + * drm_format_info_plane_height - height of the plane given the first plane
>>> + * @format: pixel format info
>>> + * @height: height of the first plane
>>> + * @plane: plane index
>>> + *
>>> + * Returns:
>>> + * The height of @plane, given that the height of the first plane is @height.
>>> + */
>>> +static inline
>>> +int drm_format_info_plane_height(const struct drm_format_info *info, int height,
>>> +				 int plane)
>>> +{
>>> +	if (!info || plane >= info->num_planes)
>>> +		return 0;
>>> +
>>> +	if (plane == 0)
>>> +		return height;
>>> +
>>> +	return height / info->vsub;
>>> +}
>> Why the null checks? None of the other inlines for drm_format_info
>> perform them.
> Unless I'm mistaken, the subsampling only applies to the planes with
> the chrominance, which are always >= 1. Therefore the plane 0 is
> always the luminance, to which the subsampling doesn't apply.
>
> Or are you talking about something else?


The info == NULL check. :)

