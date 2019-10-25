Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870B7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4B621D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438874AbfJYJny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:43:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:56989 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436857AbfJYJnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:43:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 02:43:53 -0700
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="210676068"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 02:43:51 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 949E920ADF; Fri, 25 Oct 2019 12:43:19 +0300 (EEST)
Date:   Fri, 25 Oct 2019 12:43:19 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Documentation: media: *_DEFAULT targets for subdevs
Message-ID: <20191025094319.GO5433@paasikivi.fi.intel.com>
References: <20191025085617.23132-1-ribalda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025085617.23132-1-ribalda@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 10:56:16AM +0200, Ricardo Ribalda Delgado wrote:
> Some sensors have optical blanking areas, this is, pixels that are
> painted and do not account for light, only noise.
> 
> These special pixels are very useful for calibrating the sensor, but
> should not be displayed on a DEFAULT target.
> 
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
> ---
>  Documentation/media/uapi/v4l/v4l2-selection-targets.rst | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/media/uapi/v4l/v4l2-selection-targets.rst b/Documentation/media/uapi/v4l/v4l2-selection-targets.rst
> index f74f239b0510..a69571308a45 100644
> --- a/Documentation/media/uapi/v4l/v4l2-selection-targets.rst
> +++ b/Documentation/media/uapi/v4l/v4l2-selection-targets.rst
> @@ -38,8 +38,10 @@ of the two interfaces they are used.
>      * - ``V4L2_SEL_TGT_CROP_DEFAULT``
>        - 0x0001
>        - Suggested cropping rectangle that covers the "whole picture".
> +        This includes only active pixels and excludes other non-active
> +        pixels such as black pixels.
> +      - Yes
>        - Yes
> -      - No
>      * - ``V4L2_SEL_TGT_CROP_BOUNDS``
>        - 0x0002
>        - Bounds of the crop rectangle. All valid crop rectangles fit inside
> @@ -60,8 +62,8 @@ of the two interfaces they are used.
>      * - ``V4L2_SEL_TGT_COMPOSE_DEFAULT``
>        - 0x0101
>        - Suggested composition rectangle that covers the "whole picture".
> -      - Yes
>        - No
> +      - Yes

Was this intended?

v4?

>      * - ``V4L2_SEL_TGT_COMPOSE_BOUNDS``
>        - 0x0102
>        - Bounds of the compose rectangle. All valid compose rectangles fit

-- 
Sakari Ailus
