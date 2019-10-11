Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025C3ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 22:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07BF206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 22:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfJKWc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 18:32:27 -0400
Received: from smtprelay0113.hostedemail.com ([216.40.44.113]:53640 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726255AbfJKWc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 18:32:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id E131418016C6C;
        Fri, 11 Oct 2019 22:32:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: owl40_14d93818d4721
X-Filterd-Recvd-Size: 2752
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Oct 2019 22:32:23 +0000 (UTC)
Message-ID: <28ed468bc58c0d0e92f459b45d8e43cd3d1458b2.camel@perches.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: vc04_services: fix warnings
 of lines should not end with open parenthesis
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Jules Irenge <jbi.octave@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        eric@anholt.net, wahrenst@gmx.net, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, daniela.mormocea@gmail.com,
        dave.stevenson@raspberrypi.org, hverkuil-cisco@xs4all.nl,
        mchehab+samsung@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        sbranden@broadcom.com, rjui@broadcom.com, f.fainelli@gmail.com
Date:   Fri, 11 Oct 2019 15:32:22 -0700
In-Reply-To: <alpine.DEB.2.21.1910112320550.3284@hadrien>
References: <20191011211637.19311-1-jbi.octave@gmail.com>
         <alpine.DEB.2.21.1910112320550.3284@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-11 at 23:23 +0200, Julia Lawall wrote:
> On Fri, 11 Oct 2019, Jules Irenge wrote:
> > Fix warning of lines should not end with open parenthesis.
> > Issue detected by checkpatch tool.
[]
> > diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
[]
> > @@ -337,9 +337,8 @@ static void buffer_cb(struct vchiq_mmal_instance *instance,
> >  			if (is_capturing(dev)) {
> >  				v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
> >  					 "Grab another frame");
> > -				vchiq_mmal_port_parameter_set(
> > -					instance,
> > -					dev->capture.camera_port,
> > +			vchiq_mmal_port_parameter_set(instance,
> > +						      dev->capture.camera_port,
> >  					MMAL_PARAMETER_CAPTURE,
> >  					&dev->capture.frame_count,
> >  					sizeof(dev->capture.frame_count));
> 
> You can't reduce the indentation on the function call.  It has to stay
> clearly in the if branch.
> 
> If you adjust the indentation of some of the arguments, you have to do so
> to all of the arguments.
> 
> Similar issues arise below.  There may be no way to make some of the calls
> look nice without a more severe reorganization of the code.

My suggestion would be to shorten the vchiq_mmal_port_parameter_set
function name (29 chars is just too long) and pass dev instead of
dev->instance as the first argument to this function.


