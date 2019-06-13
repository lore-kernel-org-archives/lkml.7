Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3E7C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A224E21721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfFMWcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:32:10 -0400
Received: from smtprelay0116.hostedemail.com ([216.40.44.116]:46495 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725616AbfFMWcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:32:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0234B1822408D;
        Thu, 13 Jun 2019 22:32:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bells74_f85ac43e0702
X-Filterd-Recvd-Size: 3034
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 13 Jun 2019 22:31:46 +0000 (UTC)
Message-ID: <39e6c0f7d7529da9906a17450a8bcdf416297520.camel@perches.com>
Subject: Re: [PATCH 2/2] media: v4l: xilinx: Add Xilinx UHD-SDI Rx Subsystem
 driver
From:   Joe Perches <joe@perches.com>
To:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Vishal Sagar <vishal.sagar@xilinx.com>
Cc:     Hyun Kwon <hyunk@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Dinesh Kumar <dineshk@xilinx.com>,
        Sandip Kothari <sandipk@xilinx.com>
Date:   Thu, 13 Jun 2019 15:31:44 -0700
In-Reply-To: <20190613220507.GA2473@smtp.xilinx.com>
References: <1559656556-79174-1-git-send-email-vishal.sagar@xilinx.com>
         <1559656556-79174-3-git-send-email-vishal.sagar@xilinx.com>
         <20190613220507.GA2473@smtp.xilinx.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-13 at 15:05 -0700, Hyun Kwon wrote:
> On Tue, 2019-06-04 at 06:55:56 -0700, Vishal Sagar wrote:

trivia:

> > diff --git a/drivers/media/platform/xilinx/xilinx-sdirxss.c b/drivers/media/platform/xilinx/xilinx-sdirxss.c
[]
> > +static int xsdirx_get_stream_properties(struct xsdirxss_state *state)
> > +{
[]
> > +	if (valid & XSDIRX_ST352_VALID_DS1_MASK) {
> > +		payload = xsdirxss_read(core, XSDIRX_ST352_DS1_REG);
> > +		byte1 = (payload >> XST352_PAYLOAD_BYTE1_SHIFT) &
> > +				XST352_PAYLOAD_BYTE_MASK;

Is XST352_PAYLOAD_BYTE_MASK correct ?
Should it be XST352_PAYLOAD_BYTE1_MASK ?

> > +		active_luma = (payload & XST352_BYTE3_ACT_LUMA_COUNT_MASK) >>
> > +				XST352_BYTE3_ACT_LUMA_COUNT_OFFSET;
> > +		pic_type = (payload & XST352_BYTE2_PIC_TYPE_MASK) >>
> > +				XST352_BYTE2_PIC_TYPE_OFFSET;
> > +		framerate = (payload >> XST352_BYTE2_FPS_SHIFT) &
> > +				XST352_BYTE2_FPS_MASK;
> > +		tscan = (payload & XST352_BYTE2_TS_TYPE_MASK) >>
> > +				XST352_BYTE2_TS_TYPE_OFFSET;
> 
> Please align consistently throughout the patch. I believe the checkpatch
> --strict warns on these.

I believe not.

Another possibility would be to use a macro like:

#define mask_and_shift(val, type)	\
	((val) & (XST352_ ## type ## _MASK)) >> (XST352_ ## type ## _OFFSET))

> > +		sampling = (payload & XST352_BYTE3_COLOR_FORMAT_MASK) >>
> > +			   XST352_BYTE3_COLOR_FORMAT_OFFSET;

So these could be something like:

		sampling = mask_and_shift(payload, BYTE3_COLOR_FORMAT);


