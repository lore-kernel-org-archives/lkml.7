Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF7CC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 17:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80CF206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 17:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nyJy/Vlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfLORsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 12:48:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46752 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfLORsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 12:48:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id z124so2309198pgb.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 09:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w9+UiOGVkK1BZoeebEE52j+LZqBaO3qIB0OJdAQ3OHU=;
        b=nyJy/VlfYg60c83riZ6WZy+M02vBHoiD0UwM5JFAjdZE6E9/2/3sjWO/ZsgaKxoh7b
         Ss4TZIVXaUZHvc1ujHwyNkGhKa72hKg0l+cTjUg3A09eeGL6dffHqQNnlts5ssGwKXUU
         00PpDgXuK3QWfFF+F7cs51nZXkB7M/f8r9KF7EsS3JboQnWzs5JiYKd4i0bwf4ANOGLB
         K1haGK/YeFgz1F9Vl46XR8okDBHBuPkMEvv4Kga3torxhw4sMS/DkHTabIpk77dTIBlK
         8TwuDCtOAhkb6cprx76UaTnIaX8zx0MT9XF6eP+UOOprX0oCRpiDHVvt0zU0wYAhsE5k
         4m9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w9+UiOGVkK1BZoeebEE52j+LZqBaO3qIB0OJdAQ3OHU=;
        b=tf+bms0Kt/noLXVo5F59m2Q6/Xof3FV+DaM8BtnzTI4VODpqC1KKfrRN72HNVIMdSS
         fpzKUfLq14C30Q1nBq2B54+2APgXPNj4x9WccqJu2lfLZWdEwtwpl/tszyvirNcevBx7
         pgoiQUanAtDZa9wBFFmqFIEaEzTTi1f7AnemtvCNIpXHMieZQeZzhLFrrOBJXtI6XiPF
         uc//e7texCF046LVBX7isQ7y1InFqaPkdSnHixOoMOXjZMKCKzjVRdH+iPvIfq4k3qaP
         T3MAHv8iqrTqF42dA1zuYpVrkDNJPJ7j/lvm8egVVN/kva8d7AW0730tdAE4hDQc2d0/
         GtqQ==
X-Gm-Message-State: APjAAAUdewWOuhqp52/BF9LbcFcbO4Ib3hced4LcCkGJsm1GYBEHo8br
        pvONIvDd/PxBcua+9ZNDEeMa
X-Google-Smtp-Source: APXvYqzVi9Z9A1Z0HWXzz41ItmKgbO0s5dTv4qor5DHTibPPjPANNo4NnAp94xBbPHWUKBX5WeKHMQ==
X-Received: by 2002:a63:1f16:: with SMTP id f22mr12724174pgf.2.1576432121814;
        Sun, 15 Dec 2019 09:48:41 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:78f:3e30:ad66:df45:6a09:a260])
        by smtp.gmail.com with ESMTPSA id g10sm18142126pgh.35.2019.12.15.09.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Dec 2019 09:48:41 -0800 (PST)
Date:   Sun, 15 Dec 2019 23:18:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, c.barrett@framos.com,
        a.brela@framos.com, peter.griffin@linaro.org
Subject: Re: [PATCH 4/5] media: i2c: imx290: Add support to enumerate all
 frame sizes
Message-ID: <20191215174834.GD11427@Mani-XPS-13-9360>
References: <20191129190541.30315-1-manivannan.sadhasivam@linaro.org>
 <20191129190541.30315-5-manivannan.sadhasivam@linaro.org>
 <20191203085604.GC5282@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203085604.GC5282@valkosipuli.retiisi.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Tue, Dec 03, 2019 at 10:56:04AM +0200, Sakari Ailus wrote:
> On Sat, Nov 30, 2019 at 12:35:40AM +0530, Manivannan Sadhasivam wrote:
> > Add support to enumerate all frame sizes supported by IMX290. This is
> > required for using with userspace tools such as libcamera.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/media/i2c/imx290.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> > index d5bb3a59ac46..f26c4a0ee0a0 100644
> > --- a/drivers/media/i2c/imx290.c
> > +++ b/drivers/media/i2c/imx290.c
> > @@ -468,6 +468,25 @@ static int imx290_enum_mbus_code(struct v4l2_subdev *sd,
> >  	return 0;
> >  }
> >  
> > +static int imx290_enum_frame_size(struct v4l2_subdev *subdev,
> > +				  struct v4l2_subdev_pad_config *cfg,
> > +				  struct v4l2_subdev_frame_size_enum *fse)
> > +{
> > +	if ((fse->code != imx290_formats[0].code) &&
> > +	    (fse->code != imx290_formats[1].code))
> 
> Please use a loop over imx290_formats instead.
> 

May I know why? What benefit does it provide over current method?

Thanks,
Mani

> > +		return -EINVAL;
> > +
> > +	if (fse->index >= ARRAY_SIZE(imx290_modes))
> > +		return -EINVAL;
> > +
> > +	fse->min_width = imx290_modes[fse->index].width;
> > +	fse->max_width = imx290_modes[fse->index].width;
> > +	fse->min_height = imx290_modes[fse->index].height;
> > +	fse->max_height = imx290_modes[fse->index].height;
> > +
> > +	return 0;
> > +}
> > +
> >  static int imx290_get_fmt(struct v4l2_subdev *sd,
> >  			  struct v4l2_subdev_pad_config *cfg,
> >  			  struct v4l2_subdev_format *fmt)
> > @@ -820,6 +839,7 @@ static const struct v4l2_subdev_video_ops imx290_video_ops = {
> >  static const struct v4l2_subdev_pad_ops imx290_pad_ops = {
> >  	.init_cfg = imx290_entity_init_cfg,
> >  	.enum_mbus_code = imx290_enum_mbus_code,
> > +	.enum_frame_size = imx290_enum_frame_size,
> >  	.get_fmt = imx290_get_fmt,
> >  	.set_fmt = imx290_set_fmt,
> >  };
> 
> -- 
> Regards,
> 
> Sakari Ailus
