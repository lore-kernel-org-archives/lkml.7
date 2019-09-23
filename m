Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E32C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BC92064A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502062AbfIWMvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:51:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:30376 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502051AbfIWMvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:51:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 05:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,539,1559545200"; 
   d="scan'208";a="189048713"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga007.fm.intel.com with SMTP; 23 Sep 2019 05:50:59 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 23 Sep 2019 15:50:59 +0300
Date:   Mon, 23 Sep 2019 15:50:59 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>, Ayan Halder <Ayan.Halder@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds output-color format/depth support
Message-ID: <20190923125059.GI1208@intel.com>
References: <20190920094329.17513-1-lowry.li@arm.com>
 <20190923121604.jqi6ewln27yvdajw@DESKTOP-E1NTVVP.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190923121604.jqi6ewln27yvdajw@DESKTOP-E1NTVVP.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 12:16:12PM +0000, Brian Starkey wrote:
> Hi Lowry,
> 
> On Fri, Sep 20, 2019 at 09:43:47AM +0000, Lowry Li (Arm Technology China) wrote:
> > From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> > 
> > Sets color_depth according to connector->bpc.
> > Adds a new optional DT attribute "color-format" to represent a
> > preferred color formats for a specific pipeline, and the select order
> > is:
> > 	YCRCB420 > YCRCB422 > YCRCB444 > RGB444
> > The color-format can be anyone of these 4 format, one color-format not
> > only represent one format, but also include the lower formats, like
> > 
> > color-format         preferred_color_formats
> > YCRCB420        YCRCB420 > YCRCB422 > YCRCB444 > RGB444
> > YCRCB422        YCRCB422 > YCRCB444 > RGB444
> > YCRCB444        YCRCB444 > RGB444
> > RGB444          RGB444
> > 
> > Then the final color_format is calculated by 3 steps:
> > 1. calculate HW available formats.
> >   avail_formats = connector_color_formats & improc->color_formats;
> > 2. filter out un-preferred format.
> >   avail_formats &= preferred_color_formats;
> > 3. select the final format according to the preferred order.
> >   color_format = BIT(__fls(aval_formats));
> 
> Is there a specific use-case for the DT property for selecting color
> format?
> 
> I think in general the color format should be determined according to
> the rules in the CEA spec. There's also the drm_mode_is_420_only()
> helper we can use to determine if YCBCR420 must be used. For the cases
> where it's optional, I think we can default to RGB444.

That is the policy we have in i915. We have a vague plan to add
a new property for the user to select the encoding explicitly
(which would also allow things like YCbCr 4:4:4), but IIRC no
one has actually sent a patch for that.

CTA-861 sort of seems to say that one should favor YCbCr over
RGB iff both sides support it, but I think RGB is probably the
better default because it means straight passthrough (minus the
annoying full->limit quantization range trickery).

-- 
Ville Syrjälä
Intel
