Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C8DC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0001321850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfGDMjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:39:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51012 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfGDMjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:39:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 3C0E028A758
Message-ID: <6b8d2c435335a81d362d18f23bc4229601b2f512.camel@collabora.com>
Subject: Re: [PATCH v2 1/2] media: uapi: Add VP8 stateless decoder API
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        fbuergisser@chromium.org, linux-kernel@vger.kernel.org,
        Pawel Osciak <posciak@chromium.org>
Date:   Thu, 04 Jul 2019 09:39:10 -0300
In-Reply-To: <1562164149.4604.9.camel@pengutronix.de>
References: <20190702170016.5210-1-ezequiel@collabora.com>
         <20190702170016.5210-2-ezequiel@collabora.com>
         <1562164149.4604.9.camel@pengutronix.de>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Thanks a lot for reviewing.

On Wed, 2019-07-03 at 16:29 +0200, Philipp Zabel wrote:
> On Tue, 2019-07-02 at 14:00 -0300, Ezequiel Garcia wrote:
> > From: Pawel Osciak <posciak@chromium.org>
> > 
> > Add the parsed VP8 frame pixel format and controls, to be used
> > with the new stateless decoder API for VP8 to provide parameters
> > for accelerator (aka stateless) codecs.
> > 
> > Signed-off-by: Pawel Osciak <posciak@chromium.org>
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > --
> > Changes from v1:
> > * Move 1-bit fields to flags in the respective structures.
> > * Add padding fields to make all structures 8-byte aligned.
> > * Reorder fields where needed to avoid padding as much as possible.
> > * Fix documentation as needed.
> > 
> > Changes from RFC:
> > * Make sure the uAPI has the same size on x86, x86_64, arm and arm64.
> > * Move entropy coder state fields to a struct.
> > * Move key_frame field to the flags.
> > * Remove unneeded first_part_offset field.
> > * Add documentation.
> > ---
> >  Documentation/media/uapi/v4l/biblio.rst       |  10 +
> >  .../media/uapi/v4l/ext-ctrls-codec.rst        | 323 ++++++++++++++++++
> >  .../media/uapi/v4l/pixfmt-compressed.rst      |  20 ++
> >  drivers/media/v4l2-core/v4l2-ctrls.c          |   8 +
> >  drivers/media/v4l2-core/v4l2-ioctl.c          |   1 +
> >  include/media/v4l2-ctrls.h                    |   3 +
> >  include/media/vp8-ctrls.h                     | 110 ++++++
> >  7 files changed, 475 insertions(+)
> >  create mode 100644 include/media/vp8-ctrls.h
> > 
[..]
> > +    * - __u8
> > +      - ``num_dct_parts``
> > +      - Number of DCT coefficients partitions.
> 
> I assume this must be no larger than 8. Is this mandated by the spec? If
> so, should it be documented here and checked by v4l2-core?
> 

Good catch.

Yes, it's mandated. The header [1] contains a two-bit field
called "log2_nbr_of_dct_partitions", so partition count must
be 1, 2, 4 or 8.
  
[1] https://www.rfc-editor.org/rfc/rfc6386.html#section-9.5

I'll add this to the documentation.

Also, I think this can be checked in std_validate().

Thanks,
Ezequiel

