Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68950C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4779E22CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392116AbfHWNNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:13:45 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35005 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731783AbfHWNNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:13:44 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1i19Np-0000Gv-Lb; Fri, 23 Aug 2019 15:13:37 +0200
Message-ID: <1566566016.3023.21.camel@pengutronix.de>
Subject: Re: [PATCH v3 5/7] media: v4l2-core: Add new helper for area
 controls
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jacopo Mondi <jacopo@jmondi.org>
Date:   Fri, 23 Aug 2019 15:13:36 +0200
In-Reply-To: <CAPybu_0iodVnn1Fa5BFi7zc7ugwpN926wCJaoKU548zqrNJ5iw@mail.gmail.com>
References: <20190823123737.7774-1-ribalda@kernel.org>
         <20190823123737.7774-5-ribalda@kernel.org>
         <1566564998.3023.13.camel@pengutronix.de>
         <CAPybu_0iodVnn1Fa5BFi7zc7ugwpN926wCJaoKU548zqrNJ5iw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-23 at 15:05 +0200, Ricardo Ribalda Delgado wrote:
> On Fri, Aug 23, 2019 at 2:56 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > 
> > On Fri, 2019-08-23 at 14:37 +0200, Ricardo Ribalda Delgado wrote:
> > > Adding a V4L2_CID_UNIT_CELL_SIZE control requires a lot of boilerplate,
> > > try to minimize it by adding a new helper.
> > > 
> > > Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
> > > Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
> > > ---
> > >  drivers/media/v4l2-core/v4l2-ctrls.c | 25 ++++++++++++++++++++++++-
> > >  include/media/v4l2-ctrls.h           | 16 ++++++++++++++++
> > >  2 files changed, 40 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
> > > index b3bf458df7f7..33e48f0aec1a 100644
> > > --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> > > +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> > > @@ -2660,7 +2660,6 @@ struct v4l2_ctrl *v4l2_ctrl_new_std_menu_items(struct v4l2_ctrl_handler *hdl,
> > >  }
> > >  EXPORT_SYMBOL(v4l2_ctrl_new_std_menu_items);
> > > 
> > > -/* Helper function for standard integer menu controls */
> > 
> > Why move this ...
> > 
> > >  struct v4l2_ctrl *v4l2_ctrl_new_int_menu(struct v4l2_ctrl_handler *hdl,
> > >                       const struct v4l2_ctrl_ops *ops,
> > >                       u32 id, u8 _max, u8 _def, const s64 *qmenu_int)
> > > @@ -2684,6 +2683,30 @@ struct v4l2_ctrl *v4l2_ctrl_new_int_menu(struct v4l2_ctrl_handler *hdl,
> > >  }
> > >  EXPORT_SYMBOL(v4l2_ctrl_new_int_menu);
> > > 
> > > +static void area_init(const struct v4l2_ctrl *ctrl, u32 idx,
> > > +             union v4l2_ctrl_ptr ptr)
> > > +{
> > > +     memcpy(ptr.p_area, ctrl->priv, sizeof(*ptr.p_area));
> > > +}
> > > +
> > > +static const struct v4l2_ctrl_type_ops area_ops = {
> > > +     .init = area_init,
> > > +};
> > > +
> > > +struct v4l2_ctrl *v4l2_ctrl_new_area(struct v4l2_ctrl_handler *hdl,
> > > +                                  const struct v4l2_ctrl_ops *ops,
> > > +                                  u32 id, const struct v4l2_area *area)
> > > +{
> > > +     static struct v4l2_ctrl_config ctrl = {
> > > +             .id = V4L2_CID_UNIT_CELL_SIZE,
> > > +             .type_ops = &area_ops,
> > > +     };
> > > +
> > > +     return v4l2_ctrl_new_custom(hdl, &ctrl, (void *)area);
> > > +}
> > > +EXPORT_SYMBOL(v4l2_ctrl_new_area);
> > > +
> > > +/* Helper function for standard integer menu controls */
> > 
> > ... here?
> 
> Because I screwed up :). Let me fix that sorry.
> 
> I will push all your changes to:
> 
> https://github.com/ribalda/linux/tree/unit-size-v4
> 
> plus any other comment and then I will wait 2-3 days for resend

Awesome, thanks! Feel free to add

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
