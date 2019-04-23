Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C72C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1186214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+XOdqWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfDWNgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:36:10 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34567 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWNgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:36:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id v10so11292007oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 06:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rnJqCqpjZuGWNAaHeRBe5a/70WgmeQJC/iIWiElLinA=;
        b=J+XOdqWWf3QnLVr6LObWfdULuHZgU7u6mQqvi+Jpm2KyIYlyuYlB35ZSR+mDdtRDLp
         25UvUjui4JGRHrEloyh5MtbWdhsgiHMQYDyOYlQ1XcsVzjo22AmxpwNN5TWLX7hQKdSb
         yhC5htt4GTBEG1i0HvIZcqQETJ0vLbz7R29QlMmOkBDn9XPicuaipaWRLtLIzFSBQdYc
         8SwPcnbCWoLYT9ZCeRNT4QwUSv1c63gaQyQaT278cQRo2x4sFkDyjc1PeywU5RCnQxkn
         yageI3cewIELy+4NZRIURtH3grNcpFKdx0fJGGe0XkT2wMctFzp6kcf5+xXIX5dilom2
         t6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rnJqCqpjZuGWNAaHeRBe5a/70WgmeQJC/iIWiElLinA=;
        b=AZA/j1slZyMIcxa7V+Lniv0J8ni96G7CpdZhVVf2wLMhKHWFXVlseQpRKhVj+tvIxp
         MpyZs/O9HKlvlRIATw9MDfQoIOOBQ+AGtoiu8UcXYPQIDez3hnB9ALQ7PrEyLr+qVIMa
         DJQe6Xc6Z+CX/dFfhpCNNITld6iNNgiqHS6+FRfMmlfHVfz+3pdsy5pHKjfsQKNBsBtG
         y2sENyc9M75IqLtsIkFy+Oh2lLcfWkyG1XGIYca3p/zVO8Cz1tnM8soJ01ARr+ocHsxv
         5lBrEo0Wx6acmBzogZoOk2MZEoqU/1wZnl0/kXvBNnQCpDH8reiCr2IWtuCL9aV189Sd
         x47g==
X-Gm-Message-State: APjAAAWUX3DRLTp01FGtfC9ZWZy+kwMwOWXXduNIfxsCf5LlSGeREWsT
        8ogF7b4Kv8qSjHTp6nRR3Xs=
X-Google-Smtp-Source: APXvYqwvbJAUE0FJXmEZdy2TYItB1O9aG1pA7k5wYJZG22ygbfCjMX/yx0Qy9YQ+vv21xLAErdYbcg==
X-Received: by 2002:aca:d88b:: with SMTP id p133mr1855306oig.56.1556026568946;
        Tue, 23 Apr 2019 06:36:08 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:fd8f:ea25:f4b2:9189])
        by smtp.gmail.com with ESMTPSA id i136sm269431oib.42.2019.04.23.06.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 06:36:08 -0700 (PDT)
Date:   Tue, 23 Apr 2019 08:36:05 -0500
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: vc04_services: Cleanup in ctrl_set_bitrate()
Message-ID: <20190423133603.GA6310@madhuleo>
References: <20190420165644.11892-1-madhumithabiw@gmail.com>
 <20190420195103.GA18489@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420195103.GA18489@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20  :51, Greg KH wrote:
> On Sat, Apr 20, 2019 at 11:56:44AM -0500, Madhumitha Prabakaran wrote:
> > Remove unnecessary variable and replace return type.
> > In addition to that align the function parameters with parentheses to
> > maintain Linux coding style.
> > 
> > Issue suggested by Coccinelle.
> > 
> > Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> > 
> > ---
> > Changes in v2
> > 
> > 1) Fix my own error of removing function call from the variable.
> > 2) Align the function parameters with parentheses.
> > 
> > ---
> > ---
> >  .../staging/vc04_services/bcm2835-camera/controls.c    | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > index e39ab5fae724..71eb349c3138 100644
> > --- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > +++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > @@ -607,18 +607,16 @@ static int ctrl_set_bitrate(struct bm2835_mmal_dev *dev,
> >  			    struct v4l2_ctrl *ctrl,
> >  			    const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
> >  {
> > -	int ret;
> >  	struct vchiq_mmal_port *encoder_out;
> >  
> >  	dev->capture.encode_bitrate = ctrl->val;
> >  
> >  	encoder_out = &dev->component[MMAL_COMPONENT_VIDEO_ENCODE]->output[0];
> >  
> > -	ret = vchiq_mmal_port_parameter_set(dev->instance, encoder_out,
> > -					    mmal_ctrl->mmal_id,
> > -					    &ctrl->val, sizeof(ctrl->val));
> > -	ret = 0;
> > -	return ret;
> > +	vchiq_mmal_port_parameter_set(dev->instance, encoder_out,
> > +				      mmal_ctrl->mmal_id, &ctrl->val,
> > +				      sizeof(ctrl->val));
> > +	return 0;
> >  }
> 
> Why does this function even return anything at all if it can not fail?

I looked at the function vchiq_mmal_port_parameter_set, which calls
another function for setting the port parameters, which inturns sends an
synchronous message. If it is able to send the message successfully, it
returns 0. It can also fail and can return any other value. Also the
function ctrl_set_bitrate is not evaluated anywhere for true or false,
so it is safe to return the value we get from
vchiq_mmal_port_parameter_set instead of returning 0 always.


> 
> Why not return the value that vchiq_mmal_port_parameter_set() returned?
> 

I will change the code to return the value from
vchiq_mmal_port_parameter_set directly.

> thanks,
> 
> greg k-h
