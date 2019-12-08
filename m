Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9517BC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 09:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6324E206D6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 09:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfLHJoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 04:44:22 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50234 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfLHJoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 04:44:21 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id AA5A728A186
Message-ID: <c6b45437882f01892b29b6660a9ddabf29f5ff80.camel@collabora.com>
Subject: Re: [PATCH] media: davinci/vpfe_capture.c: Avoid BUG_ON for
 register failure
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 08 Dec 2019 06:44:11 -0300
In-Reply-To: <a9448f56a067ed82aa3ce29492a02eb03dff32d0.camel@collabora.com>
References: <20191206010029.14265-1-pakki001@umn.edu>
         <a9448f56a067ed82aa3ce29492a02eb03dff32d0.camel@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Aditya,

On Fri, 2019-12-06 at 06:20 -0300, Ezequiel Garcia wrote:
> Hello Aditya,
> 
> Thanks for the patch.
> 
> On Thu, 2019-12-05 at 19:00 -0600, Aditya Pakki wrote:
> > In vpfe_register_ccdc_device(), failure to allocate dev->hw_ops
> > invokes calls to BUG_ON(). This patch returns the error to callers
> > instead of crashing.
> > 
> 
> I'm curious, are you actually getting this type of crash?
> 

Oops, it seems I was too fast to say this looked good.

The driver is not dynamically allocating dev->hw_ops;
as you can see hw_ops is not a pointer.

struct ccdc_hw_device {
        /* ccdc device name */
        char name[32];
        /* module owner */
        struct module *owner;
        /* hw ops */
        struct ccdc_hw_ops hw_ops;
};

Please, don't submit patches without testing, at the very
least compile testing.

Thanks,
Ezequiel

> > Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> > ---
> >  drivers/media/platform/davinci/vpfe_capture.c | 21 ++++++-------------
> >  1 file changed, 6 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/media/platform/davinci/vpfe_capture.c b/drivers/media/platform/davinci/vpfe_capture.c
> > index 916ed743d716..6d394a006977 100644
> > --- a/drivers/media/platform/davinci/vpfe_capture.c
> > +++ b/drivers/media/platform/davinci/vpfe_capture.c
> > @@ -168,21 +168,11 @@ int vpfe_register_ccdc_device(const struct ccdc_hw_device *dev)
> >  	int ret = 0;
> >  	printk(KERN_NOTICE "vpfe_register_ccdc_device: %s\n", dev->name);
> >  
> > -	BUG_ON(!dev->hw_ops.open);
> > -	BUG_ON(!dev->hw_ops.enable);
> > -	BUG_ON(!dev->hw_ops.set_hw_if_params);
> > -	BUG_ON(!dev->hw_ops.configure);
> > -	BUG_ON(!dev->hw_ops.set_buftype);
> > -	BUG_ON(!dev->hw_ops.get_buftype);
> > -	BUG_ON(!dev->hw_ops.enum_pix);
> > -	BUG_ON(!dev->hw_ops.set_frame_format);
> > -	BUG_ON(!dev->hw_ops.get_frame_format);
> > -	BUG_ON(!dev->hw_ops.get_pixel_format);
> > -	BUG_ON(!dev->hw_ops.set_pixel_format);
> > -	BUG_ON(!dev->hw_ops.set_image_window);
> > -	BUG_ON(!dev->hw_ops.get_image_window);
> > -	BUG_ON(!dev->hw_ops.get_line_length);
> > -	BUG_ON(!dev->hw_ops.getfid);
> > +	if (!dev->hw_ops) {
> > +		printk(KERN_ERR "could not allocate hw_ops\n");
> 
> I'd drop this error message, as hw_ops is not really allocated here.
> 
> > +		ret = -EINVAL;
> > +		goto rvalue;
> 
> Instead of a goto to a return, just return -EINVAL here.
> 
> > +	}
> >  
> >  	mutex_lock(&ccdc_lock);
> >  	if (!ccdc_cfg) {
> > @@ -211,6 +201,7 @@ int vpfe_register_ccdc_device(const struct ccdc_hw_device *dev)
> >  	ccdc_dev = dev;
> >  unlock:
> >  	mutex_unlock(&ccdc_lock);
> > +rvalue:
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL(vpfe_register_ccdc_device);
> 
> With those changes, the patch looks good.
> 
> Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
> 
> Thanks,
> Ezequiel
> 


