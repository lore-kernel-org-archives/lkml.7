Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1A1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9C220830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtxRfT3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfDJTtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:49:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41968 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJTtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:49:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id v7so2840335oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xmlYEM+J/2cMmGlthhnUTjy2DiLN1af1AGnHmddTDaU=;
        b=HtxRfT3RNOpEPUkxV6+jcJxpfRjTPbIMBmrhjy5t6j7nK3J+rd91vIIe1Rwcu0aWsT
         p81b0zvdga2VmnM6S9NVkB+QDtFcjFgzvRKx+jtkmOiRVpCKtPQSZkTDSD5/EG31iBvf
         aCsZi0JA/TEvji9y+SFuYtqLe1dD1uvv3KeUZhIhsnP8JTbxgCHF3saZZur+UkZayjiM
         zdx67u4B8RH8jO5pqA3PLlymN70HmWUjDESmHNPz3igIYYVJKTVtk+ksWjb0bdtVJQa5
         wArSQQmKIqDv4rynw6aSMD29j/tV+6KvTIy7zgeLJCZxOzQIOcFxiTiNsMT5Bbzoqbs2
         Gyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xmlYEM+J/2cMmGlthhnUTjy2DiLN1af1AGnHmddTDaU=;
        b=unKstWIXWI5DvjBLgplI4hsASLULjIXfvJf1K3OVl1s5X9ivLGWFIbqWaMd2u/CHPb
         AnRun6fN2lTIzhlV2T5KGXaYqJDdo9jzcjiX4Pzy0GEeLIyLq0bg8XtIWM8gim0hNIwd
         xCWCUZ9GuIyxIxkWE5XD4Pt9G+YCUPSoxblQmRtu63+BpdXR+eHfMDKgN8ZDe8/gknlU
         Z+QN1idv3N2DHCDqOj0SbqjWtTjHSzVhR/fPqNRwzmVPYGyJyBfBb7SleYO1+ThPzYOV
         uLeM+7BGTg1J2uk8XJgM3DP7Qq2FrnE0RMdpPvaocFS3yFTlnJgzHovdDcmkCKKS4vTE
         8eYg==
X-Gm-Message-State: APjAAAX274lg+AUpKFSTqcB6RIWB0KbAa/K8ns5AIpcgOQXITb2UbYXK
        V+W//k4DS366B3i7jRtdYhI=
X-Google-Smtp-Source: APXvYqyvpjIMC6A6S1DtFzFgyYEKRn4762prueHGZbTP09WGsPEaPrOE9bui9FCHkiX3PugpjVTPHQ==
X-Received: by 2002:aca:abce:: with SMTP id u197mr3815635oie.67.1554925752408;
        Wed, 10 Apr 2019 12:49:12 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:94ff:e494:a926:8d07])
        by smtp.gmail.com with ESMTPSA id m22sm8076677otq.47.2019.04.10.12.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 12:49:11 -0700 (PDT)
Date:   Wed, 10 Apr 2019 14:49:09 -0500
From:   Madhumthia Prabakaran <madhumithabiw@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: Remove typedef in struct sdio_data
Message-ID: <20190410194908.GA13242@madhuleo>
References: <20190409161617.29871-1-madhumithabiw@gmail.com>
 <20190410064954.GE6095@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410064954.GE6095@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 09:49:54AM +0300, Dan Carpenter wrote:
> On Tue, Apr 09, 2019 at 11:16:17AM -0500, Madhumitha Prabakaran wrote:
> > diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
> > index bafb2c30e7fb..b0623c936940 100644
> > --- a/drivers/staging/rtl8723bs/include/drv_types.h
> > +++ b/drivers/staging/rtl8723bs/include/drv_types.h
> > @@ -220,7 +220,7 @@ struct registry_priv
> >  #define BSSID_SZ(field)   sizeof(((struct wlan_bssid_ex *) 0)->field)
> >  
> >  #include <drv_types_sdio.h>
> > -#define INTF_DATA SDIO_DATA
> > +#define INTF_DATA struct sdio_data
> >  
> 
> Just get rid of INTF_DATA data as well.  It's only used once a bit lower
> in the file.  (Get rid of the ifdef around it).

But, reference of INTF_DATA is also included in file 
./drivers/staging/rtl8723bs/include/drv_types.h:487:
return &dvobj->intf_data.func->dev;

thanks for the review
madhumitha


> 
> regards,
> dan carpenter
> 
> 
> 
