Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B971C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178972081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556832969;
	bh=TcA1aVo56EWK9nPg3bPJPfdQwwHlZCjgo6j2Lx3KVP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=codgNS55kODogkbRIU+RTVwv+AWorYBr5gW27xt8pcfRrtJZJgTQD2tl+8CaMNjbD
	 T760rmDHfDk01SrCTQ6Hvieq1hui68uHLoggUsDBdDzn6g7JyU5uQSP4LdiPeOOq27
	 +vMF+NT7H+M1/nmmFJEMiKdxxcxI8/RgFQZur7lE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfEBVgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:36:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40787 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBVgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:36:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id w6so3517215otl.7;
        Thu, 02 May 2019 14:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QOVychIUmtDG8Tll/ecV8whoYD0pZhfgpjrLj+GI7lA=;
        b=P61jLT5/FAYMIFhaieyqRt/Q1QotErIkYPZe/eCAJbfA0wkTQdN/8DdU4rDgH7I1zq
         cj/21HRsz2Gl0YagOn6iUk4WZLO/76cXiOxiis5Xa2pMWzgiCZ4I+mXFn4CDaYU1chm7
         ylG7V4v4nQVyaxp5fT/1BzLFrDqgqp/mfIVNgS7679pJO0PYr6U4ufqksHDHo97jMIIb
         W9uhIWYE9jOqCCVVA3X4f5nFxECZsZL4X07N1RZMRyCnafBl/3wmXHEmNm7xg1WuJlrD
         2dpC5wMZP2CVj2IsVuEcQOGGai9fJ//F5q/BF4bR1pjM2htxRLLbhhnoS27xIcw2l59C
         qQkg==
X-Gm-Message-State: APjAAAXE5zMJbDTzBW7zhmpOTtTje4u+KP9eqe6bBm/Gx2pnKjS6a0PI
        ertlLbIJW4wph4BjdXlQeg==
X-Google-Smtp-Source: APXvYqzIKpF2SpUiGqboXp/KmEVvROVVZj0uRCj2SNazB/0BEXuociHSUGYQnO9Q7HpLJFsgEabH2g==
X-Received: by 2002:a9d:7d06:: with SMTP id v6mr4009955otn.187.1556832966725;
        Thu, 02 May 2019 14:36:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n185sm213641oif.8.2019.05.02.14.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 14:36:06 -0700 (PDT)
Date:   Thu, 2 May 2019 16:36:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/panel: simple: Add FriendlyELEC HD702E 800x1280
 LCD panel
Message-ID: <20190502213605.GA20606@bogus>
References: <20190501121448.3812-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501121448.3812-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 May 2019 17:44:47 +0530, Jagan Teki wrote:
> HD702E lcd is FriendlyELEC developed eDP LCD panel with 800x1280
> resolution. It has built in Goodix, GT9271 captive touchscreen
> with backlight adjustable via PWM.
> 
> Add support for it.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../display/panel/friendlyarm,hd702e.txt      | 29 +++++++++++++++++++
>  drivers/gpu/drm/panel/panel-simple.c          | 26 +++++++++++++++++
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
