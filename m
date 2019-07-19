Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C52C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1510D204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfGSQXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 12:23:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33621 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbfGSQX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:23:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id r6so27382427qtt.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 09:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oUXz0d2sCkAZZ39ImaGfhX/v8OXuvtWKItgSEuJlYwc=;
        b=r6Fq4gx31fA7wQ0e5vO8bMvVFpyYCZBhfkbnRdMy1JsYEJz4r9FzmG7KnfQJsjuFfg
         0Ib/NFV58y1+CaYlQE6oBQpomuAjn/Vf5gZ1g8nVqwlxcpF6xgWswLNGqrgKfp4DZbvf
         lyWtWP1aq2eQUc1O53ls0dL1onOgJQnhLFd6rcF9ITjesA41IF8fOrsQkfsEqQATMjYw
         hXyzL/wkD8cMlH6Kjb5tTfhXqyJvqio4/7DeEKWIpENQQurcVLkou+GJGaAGmmFMX43q
         yqprUaa+vbrAuv66ihYRzvQSNh6NmFvA/0pQzUbqm8QdEyY+ioJ9eox0irNEJw5THYlJ
         Y7dg==
X-Gm-Message-State: APjAAAVUNZiGJZsKUbyKeSdAXRrbv7TICbr4yOjUhdXJ1KuBWub3nEiT
        FgFKfic0+NkTJeYXcqI+YfH9hA==
X-Google-Smtp-Source: APXvYqz+ErwHBxlf1sHucIbLm0DyL84Yk3jgEmSNdOTU2HkTDb4Kn3xxe/vU6PzwLawamCk9r2NS0A==
X-Received: by 2002:aed:3f10:: with SMTP id p16mr37785031qtf.110.1563553408918;
        Fri, 19 Jul 2019 09:23:28 -0700 (PDT)
Received: from dhcp-10-20-1-165.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id n5sm17858967qta.29.2019.07.19.09.23.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 09:23:28 -0700 (PDT)
Message-ID: <617ef7670a35f0be6beba79ecdaba8be26154868.camel@redhat.com>
Subject: Re: [PATCH] drm/bridge: dw-hdmi: Refuse DDC/CI transfers on the
 internal I2C controller
From:   Adam Jackson <ajax@redhat.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Fri, 19 Jul 2019 12:23:26 -0400
In-Reply-To: <20190718214135.79445-1-mka@chromium.org>
References: <20190718214135.79445-1-mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-18 at 14:41 -0700, Matthias Kaehlcke wrote:

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 045b1b13fd0e..e49402ebd56f 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -35,6 +35,7 @@
>  
>  #include <media/cec-notifier.h>
>  
> +#define DDC_I2C_ADDR		0x37

This confused the heck out of me to read, DDC by definition happens
over I2C and this one address is just for a specific subset of DDC.
Perhaps this would be clearer if it was named DDC_CI_ADDR.

- ajax

