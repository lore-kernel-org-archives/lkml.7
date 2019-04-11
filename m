Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E53C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1170A2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bl6PDDXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfDKPdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:33:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35831 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDKPdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:33:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id m10so5632680otp.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q8N1+kXs+T1Y/W9zehSt5c7P2vOSKnCC/i1Jb4Cdp9A=;
        b=bl6PDDXh3XfRI3fZPfuU0LuBd0RaOqIElUPs3sYXIMB9TFz4HYEA6Uhxm2h+sgzwF+
         62mjeAEt62QLC5AeNZRCXfFceIuaXpjfBVjsGR7hMmGl5DZqBrCkdyEH1/lCsj34h19V
         wAKNtDbgpFe0H9t7rbx0CzGJCxAOW7oPWmX8dHWJxWYN/jAQQ69jwgGrVLA5RgpRteLA
         Os14g270cJ7vGLTGKD4gGvwZYzlr9Yjva8LJhC+GmVXx+gABal6xRJ5QsTWarjaSk1nf
         geKq5ot2rDBjtf6cjsNte4uiAJFitcdbHOccY7dZv+PmRMRXbL38OwZcM9zeCSbZSb5V
         hgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q8N1+kXs+T1Y/W9zehSt5c7P2vOSKnCC/i1Jb4Cdp9A=;
        b=Sz9Ihjd0iY32WYqDrt7WBmczXPk+BohkuvyJnnuweufYVeHKmQ1GH/swidWtJrLob5
         WKMqiYfsCaHtv7pGZKWngjtpmyMUwG67fDew7Y2jLpN7uYA0+E3SlzDB4iZ+erfmH0KJ
         atylXeNH6gvY+NQBih4Yc+UgPul7b1GVXt/w5cozMlc4Ckxlp6PlP2WYUmREPxbX6UyR
         tQptwn6yB4kRZVTWg/G6/K8+tRwNefqVMiU8BEekE2qO4jIVVmxzpROj5mVwH6N5GUMl
         kAeI6qpqCEprlCYNyNCjk5+YQ29r/j4xc+0GI9eR+A85+UtpmVCp6THgaGafTv/inGbi
         YbCg==
X-Gm-Message-State: APjAAAUprYHNVEeiM9i5KUL9gWN0jjFIbvf/UHOFc3uz8/NSPXLDe5nD
        yZqSh2NMLGmpH75kL15xBWI=
X-Google-Smtp-Source: APXvYqy7GhKiRp+yKQ7LG21uz2KuQnMhtRtFRYHo1XqO91QSN1n9W0HsdI7m44iR8eamwqZAayXRqg==
X-Received: by 2002:a9d:7616:: with SMTP id k22mr31154474otl.51.1554996814947;
        Thu, 11 Apr 2019 08:33:34 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:dd26:e4e7:c0ed:7fbb])
        by smtp.gmail.com with ESMTPSA id g17sm14911619otq.45.2019.04.11.08.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 08:33:34 -0700 (PDT)
Date:   Thu, 11 Apr 2019 10:33:32 -0500
From:   Madhumthia Prabakaran <madhumithabiw@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: Remove typedef in struct sdio_data
Message-ID: <20190411153331.GA8557@madhuleo>
References: <20190409161617.29871-1-madhumithabiw@gmail.com>
 <20190410064954.GE6095@kadam>
 <20190410194908.GA13242@madhuleo>
 <20190411081328.GF31633@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411081328.GF31633@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 11:13:28AM +0300, Dan Carpenter wrote:
> On Wed, Apr 10, 2019 at 02:49:09PM -0500, Madhumthia Prabakaran wrote:
> > On Wed, Apr 10, 2019 at 09:49:54AM +0300, Dan Carpenter wrote:
> > > On Tue, Apr 09, 2019 at 11:16:17AM -0500, Madhumitha Prabakaran wrote:
> > > > diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
> > > > index bafb2c30e7fb..b0623c936940 100644
> > > > --- a/drivers/staging/rtl8723bs/include/drv_types.h
> > > > +++ b/drivers/staging/rtl8723bs/include/drv_types.h
> > > > @@ -220,7 +220,7 @@ struct registry_priv
> > > >  #define BSSID_SZ(field)   sizeof(((struct wlan_bssid_ex *) 0)->field)
> > > >  
> > > >  #include <drv_types_sdio.h>
> > > > -#define INTF_DATA SDIO_DATA
> > > > +#define INTF_DATA struct sdio_data
> > > >  
> > > 
> > > Just get rid of INTF_DATA data as well.  It's only used once a bit lower
> > > in the file.  (Get rid of the ifdef around it).
> > 
> > But, reference of INTF_DATA is also included in file 
> > ./drivers/staging/rtl8723bs/include/drv_types.h:487:
> > return &dvobj->intf_data.func->dev;
> > 
> 
> Actually, I maybe misunderstood your email.  I'm not sure what you mean
> about "&dvobj->intf_data.func->dev;".  I just meant to replace
> INTF_DATA with "struct sdio_data".

Sorry, I wasn't able to align my thoughts over ifdef. Thus, the
confusion in fixing it.

However, I edited it now.

Thanks,
Madhumitha


> 
> regards,
> dan carpenter
> 
