Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FD3C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C10621479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0Az7iHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfDTDMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 23:12:42 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46840 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfDTDMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 23:12:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id s24so5606338otk.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 20:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nsby3r1McbkZMSmZ0BcydHpE4vwRehK0xlPN+cMJu4k=;
        b=D0Az7iHb04B8XyJHQUHkwI8CbDwXf7k+3c47Wb2P1VSXZhmTpG5b9+CiAPCDo+uNB1
         fHA8Kj3BvEOSWyInsSGRbZvMHxUXhNGow2UsEhLHQJoXGs+fzD2VCJ0o+3dzxSplBVjA
         edS06G6brffhFZal+xH6LT7rSF7SQCBGDo6tYX8fYOsOjge75Uh2KG9ZKx2JdhmMP1Oo
         I9yagGNmTgZ986MFG1KHKFrtBDBndn+5NVVCjYiblA+twD6HapCkMTrGLzp+5yo8ZAg9
         EXWTsS5A7eSPxT97h9Wi+UyXQonxvi6gLBVszjo+k9S6Mse62EDR1Hi85RZeTgTBvtw4
         Lh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nsby3r1McbkZMSmZ0BcydHpE4vwRehK0xlPN+cMJu4k=;
        b=XfS3n9KVSBBiuQLm4kb+O3UYMdXTw9HWopX0Uh3i3+haWgaKRlV1KN+9J+MMO8pGn2
         5zEiO8YHbeYj+C9BEy4jlmr8wzutAasKHDS2NAzmHYB8B5TYKHB5OcPX+I8iYR21SJun
         s5j9I+KwDxQyA+K2z2ZDSVtQgTRPNiTiHZ2TBJnRRaF1gvDNUpgJQFgnHzTgrcU/tPTf
         gCW4KBVpkIGEJwi/IXW+bKUB+NyREt5RF+8dBgNjEpM0FWtqhUEOAYXinX+9YV2kmqz4
         JfQO7LfB5KxItENb7hl1CR/lgPXTIfpUi4IrXHZHzdf9gHBiipjmrK89PLdMr4xOx7LW
         UQ+Q==
X-Gm-Message-State: APjAAAW4Y6/IdqWzwWMZLFBkv26sJSf6rFhZJgdPwKLqLBVhonygdye7
        ii8EGqdy7CxigT2VpeZP8xY=
X-Google-Smtp-Source: APXvYqyE6z5iBDwilt6A035qktTnQNM/6pwZLyj0msq00MnYfx+yCrHS2FD/ZEvukHQUI/LrcnnybQ==
X-Received: by 2002:a05:6830:1051:: with SMTP id b17mr3835750otp.341.1555729961626;
        Fri, 19 Apr 2019 20:12:41 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:151b:11be:d797:d50])
        by smtp.gmail.com with ESMTPSA id 189sm2895721oii.58.2019.04.19.20.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 20:12:40 -0700 (PDT)
Date:   Fri, 19 Apr 2019 22:12:38 -0500
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     gregkh@linuxfoundation.org, f.fainelli@gmail.com, eric@anholt.net,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: vc04_services: Cleanup in ctrl_set_bitrate()
Message-ID: <20190420031236.GA23925@madhuleo>
References: <20190419212321.7325-1-madhumithabiw@gmail.com>
 <2d48664a-eb36-4fcc-7bc5-b1b480dbce9a@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d48664a-eb36-4fcc-7bc5-b1b480dbce9a@i2se.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19  :49, Stefan Wahren wrote:
> Hi Madhumitha,
> 
> Am 19.04.19 um 23:23 schrieb Madhumitha Prabakaran:
> > Remove unnecessary variable and replace return type.
> >
> > Issue suggested by Coccinelle.
> >
> > Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> > ---
> >  drivers/staging/vc04_services/bcm2835-camera/controls.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > index e39ab5fae724..f87fa7f61db3 100644
> > --- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > +++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> > @@ -607,18 +607,13 @@ static int ctrl_set_bitrate(struct bm2835_mmal_dev *dev,
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
> > +	return 0;
> 
> i don't understand why we can remove here the function call.

I overlooked the function call. I will fix it.

> 
> Stefan
> 
> >  }
> >  
> >  static int ctrl_set_bitrate_mode(struct bm2835_mmal_dev *dev,
