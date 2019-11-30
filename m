Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0889C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 14:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874282073C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 14:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMkJgp7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfK3OJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 09:09:38 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:45641 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfK3OJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 09:09:37 -0500
Received: by mail-pj1-f65.google.com with SMTP id r11so6799566pjp.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 06:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FKtvrB0Mt1dPDCU0lQQZ0+l4lFfg4eSb8vzPxs0x5Z8=;
        b=NMkJgp7dKL3T2uJcSbqnKzitPUjziDIfJ3LtXAhLmdnMzmv40dWWMkIqR1yKeiK+sI
         wCpyM5e8aHnsEfAZblNQgMSBbCbB8v2WFqNdByM6hZ3+z1o87nyVUenCwdt74D4+ulIO
         hAkbVXihxpLwP842/1Leq7lDEJr1QpvEeTE30S/uHthFsrG1XRv9Hx9was377htC/oBL
         g2K7hL6jrlQnP32lkWxK4Z54hEcMCXTbNwYEhUaTTfnUNX7qoivwHzVexEkbfpDXHZoK
         dmFi1XUaUbRfELLhcxQKs3S8F/R0o7A5bm8aDCkpbf5pVHtNV5B/JPdlS6CxxUiSIk5a
         uVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FKtvrB0Mt1dPDCU0lQQZ0+l4lFfg4eSb8vzPxs0x5Z8=;
        b=MIl+5vL1AMrVFoxUlcVY0VtdYYkUeLE+xdYuhUszORSolzl5VW4F9dLKvsi04EgXkz
         U09pAkycYJa7FuGVzHAXiwd42R+EhFyL9cNWc5iywzoYbUROegVTTEeBCZtIv+x3aED1
         CVQo2JtkCbS3eWjOg8qqlsfv+OMRJxNEr5LHGgxVfr/aQZo9rbvIIvkw/NZEDFcf5x2i
         eRKKbtnOVkwrhetoI97UH8rFBVyx/XB+S4irh6ilGehUJz68ULi/BYWSVjuK4oPLhbLo
         UhNGmBDQo61ThxL33Zwxhmm8gBIrmWDL6Tw0DnOHsBrClbPq/ohcrS1nCJdIxKvqLQig
         aHUA==
X-Gm-Message-State: APjAAAWudli64cITWHSpyA35BXZn9i5tDQ2aJ6GCnWSGFSLaLkUmmjlj
        Yd8ZM+wC68cDVljzf72nyU9Z
X-Google-Smtp-Source: APXvYqzDwytiCfrEZJAt8NDxceGrzYgYfocCmVVy6k9xea1LbWHW7Mwlsg5/EklXVb4xjzRje9x+UQ==
X-Received: by 2002:a17:90a:c697:: with SMTP id n23mr434520pjt.37.1575122976893;
        Sat, 30 Nov 2019 06:09:36 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:980:53e7:19a8:fb8d:d702:6994])
        by smtp.gmail.com with ESMTPSA id p16sm28346128pgm.8.2019.11.30.06.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Nov 2019 06:09:36 -0800 (PST)
Date:   Sat, 30 Nov 2019 19:39:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, c.barrett@framos.com,
        linux-kernel <linux-kernel@vger.kernel.org>, a.brela@framos.com,
        Peter Griffin <peter.griffin@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-media <linux-media@vger.kernel.org>
Subject: Re: [PATCH 3/5] media: i2c: imx290: Add RAW12 mode support
Message-ID: <20191130140929.GA23629@Mani-XPS-13-9360>
References: <20191129190541.30315-1-manivannan.sadhasivam@linaro.org>
 <20191129190541.30315-4-manivannan.sadhasivam@linaro.org>
 <CAOMZO5Btkd0NLM5RBFZHD5dryE7mR5JZRLC2X__pQNmjHGCywA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5Btkd0NLM5RBFZHD5dryE7mR5JZRLC2X__pQNmjHGCywA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On Fri, Nov 29, 2019 at 04:49:25PM -0300, Fabio Estevam wrote:
> Hi Manivannan,
> 
> On Fri, Nov 29, 2019 at 4:07 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
>                }
> > +
> > +               imx290->bpp = 10;
> > +
> > +               break;
> > +       case MEDIA_BUS_FMT_SRGGB12_1X12:
> > +               ret = imx290_set_register_array(imx290, imx290_12bit_settings,
> > +                                               ARRAY_SIZE(
> > +                                                       imx290_12bit_settings));
> 
> Could you please write the ARRAY_SIZE and its parameter in the same line?
> 
> It would improve readability.
> 

I don't favor this change but Sakari did this to supress the checkpatch
warning while applying my initial patch, so now I did this here itself
to maintain the uniformity.

Thanks,
Mani

> Thanks
