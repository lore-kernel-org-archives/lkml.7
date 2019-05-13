Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B47BC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3322084A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YyIquQl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbfEMRdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:33:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40826 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbfEMRdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:33:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so7112846pgl.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QD95B1iz0eiAT5zjhUHU5qaacoyWblK1gxHUrCAprjc=;
        b=YyIquQl3x6IThms9Tne1idd1tJewYnFcxNEiCS5L0iYrMWAfgvCXGyB3dxX/C3c2iQ
         YuoTamSiPQv5uwf73PrXm6zQk7Fyp0RrD6HKxI8EWG5ELtP1PXRVYF9G6ZPsszJe0Gti
         mgSsNeaoLS4LGAZYuhG+6o3aj23LPDw3IJdt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QD95B1iz0eiAT5zjhUHU5qaacoyWblK1gxHUrCAprjc=;
        b=XFBZdvB8egYhM1TqUy/OZBNakEoYS+hZFo+AOASSaemwc3RamIl3pDxpynr3QFSn4A
         X7zFCZLf+SVrrqbfeF6ejw6d3jnmdt3vDSQY2VSvtW70c3YBqGnuy7oVlN3lEjmAGvnj
         oftLfPuSDd9Ti8BYdedf3kCR7xZUqbx5C13Qadd8po7P4KJRbpbK3/PXX8eByB/xZduv
         jOIrPuI6kYh39/oKbGPQ6nhGqeEJxiaRJaR2+o/AvLmvUPgOWEzProM0GgxotTs2Jflz
         Wrt5y5caKqCQvwHVwHdil7GKkPMDFX0Et0xXsXlnlK9o8N7nllmlHsbttbMjQzeGTU8j
         rwqw==
X-Gm-Message-State: APjAAAWqfQ7rKTCmKMZGWBWEB92oJFtmhzjcasUBWPvF0iFmxgswlEwC
        EOqxdYn/YRb9brTNvP7Gi0CSuw==
X-Google-Smtp-Source: APXvYqzfpVOja3frZMihnLcS65QApUeHpT/fme4zTNjWUqyvv9YKEY52RPJnjD+DGynB0+V9+u69eg==
X-Received: by 2002:a62:b508:: with SMTP id y8mr35103187pfe.113.1557768793349;
        Mon, 13 May 2019 10:33:13 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id 129sm18301755pff.140.2019.05.13.10.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:33:12 -0700 (PDT)
Date:   Mon, 13 May 2019 10:33:10 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/5] firmware: google: Add a module_coreboot_driver()
 macro and use it
Message-ID: <20190513173308.GA222195@google.com>
References: <20190510180151.115254-1-swboyd@chromium.org>
 <20190510180151.115254-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510180151.115254-2-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 11:01:47AM -0700, Stephen Boyd wrote:
> --- a/drivers/firmware/google/coreboot_table.h
> +++ b/drivers/firmware/google/coreboot_table.h

> @@ -91,4 +92,13 @@ int coreboot_driver_register(struct coreboot_driver *driver);
>  /* Unregister a driver that uses the data from a coreboot table. */
>  void coreboot_driver_unregister(struct coreboot_driver *driver);
>  
> +/* module_coreboot_driver() - Helper macro for drivers that don't do

Have you been writing too much net/ code recently? :) Or just copying
from platform_device.h I guess. Oh well.

Series looks fine to me.

Brian

> + * anything special in module init/exit.  This eliminates a lot of
> + * boilerplate.  Each module may only use this macro once, and
> + * calling it replaces module_init() and module_exit()
> + */
> +#define module_coreboot_driver(__coreboot_driver) \
> +	module_driver(__coreboot_driver, coreboot_driver_register, \
> +			coreboot_driver_unregister)
> +
>  #endif /* __COREBOOT_TABLE_H */
