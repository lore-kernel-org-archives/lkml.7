Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D88C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09ED2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X44x0V9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbfGSQp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 12:45:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44766 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732025AbfGSQpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:45:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so14404469pfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9ox+hcUaXeVD4tc0YldET6IMK+Omc2FU2Q1gv/EWehQ=;
        b=X44x0V9a+sokJTAGdlKVeu6VcXVl/zAIOWaTLIT4dXyg1q+zOA40uFDPd27HZzgJnE
         K27Z1heRoupSPaK7W8N/1YYgItwR+A4YVHCpMjjo81DTd3a+VClJkSEkMmQgiykgW6SZ
         KzSGo4wnPK8ZEQYJS/FdqgPkStyyOfypjyU6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ox+hcUaXeVD4tc0YldET6IMK+Omc2FU2Q1gv/EWehQ=;
        b=kKtS3jstMhMgm0ZUbNmM04Q+W+BzPHZBkz+9vaEoaJDNxGCZL5+qMInaKBVUwqd8x3
         MJlq36u87vje0XNUf6x2zrxSN9YwLJ489Lz3vXng2vXFcCXGPp3Dya6bApUoZ3NZ5IXI
         NdHio13/tfP5VHERUa8u04V+qCNSpJHA3IQNkMjX9XCnoGGALQLQ9yA5FpwjLOpB9WW2
         tglTg4s8tEwCjigE376Gop2K0TUd5u7poIKHWfk5knoEptOyi6oyKiAJAHRiterUrJcv
         v/QXkwERPfQvsz8C0JLFaKGRV29t5HT3X5p+yv2DEHxClYwCbz3zKrSRIVczJAMGcI1O
         IbkA==
X-Gm-Message-State: APjAAAVeTEtEqcFyu52nVxl9d0i2544RONYshEkBD9d3Bsk/w0OlWOr/
        rIlYHDiCxXrVs51FyL7JwLJ4ZA==
X-Google-Smtp-Source: APXvYqxlCE3BwSLOJCCg8GbPXFzSE34jYnVwv7lx4A5VeODhSmUC9VAnFub1+04PhbSEoSw7mGeV0Q==
X-Received: by 2002:a17:90a:2562:: with SMTP id j89mr59051915pje.123.1563554749429;
        Fri, 19 Jul 2019 09:45:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 81sm52126164pfx.111.2019.07.19.09.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 09:45:49 -0700 (PDT)
Date:   Fri, 19 Jul 2019 09:45:45 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Adam Jackson <ajax@redhat.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: dw-hdmi: Refuse DDC/CI transfers on the
 internal I2C controller
Message-ID: <20190719164545.GU250418@google.com>
References: <20190718214135.79445-1-mka@chromium.org>
 <617ef7670a35f0be6beba79ecdaba8be26154868.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <617ef7670a35f0be6beba79ecdaba8be26154868.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 12:23:26PM -0400, Adam Jackson wrote:
> On Thu, 2019-07-18 at 14:41 -0700, Matthias Kaehlcke wrote:
> 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > index 045b1b13fd0e..e49402ebd56f 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -35,6 +35,7 @@
> >  
> >  #include <media/cec-notifier.h>
> >  
> > +#define DDC_I2C_ADDR		0x37
> 
> This confused the heck out of me to read, DDC by definition happens
> over I2C and this one address is just for a specific subset of DDC.
> Perhaps this would be clearer if it was named DDC_CI_ADDR.

I was also a bit confused about the terminology, some places call 0x37
the DDC address and 0x50 the EDID address.

DDC_CI_ADDR sounds good to me, thanks for the suggestion!

I'll wait a day or two before respinning, for if there are more comments.
