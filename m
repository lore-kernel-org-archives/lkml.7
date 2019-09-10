Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F957C49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C999621670
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUggaBf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394027AbfIJPsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:48:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43270 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfIJPsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:48:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id u72so9942796pgb.10;
        Tue, 10 Sep 2019 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T0c9t1ysaQZfOfoAJ9kXidNtKg/M5DR/wmAFIZcRfSE=;
        b=gUggaBf9CrnACdRNJU4fi0N3ksiSeh0S+fddegeSVQPNvQ9LbK/mvPp6FNtQ8B/0YA
         f5obiejwArr7YxXhWgdxajXCPOyE+RLk8h1c7WEVokp1c8hP5vpNka9gJNpOAX6AO0Bw
         7NtkyDlfQOZBVevO4zmN//Xym/m4Z2C/aDu95QHA5ryBxEuqsfftFluUvWVB4aoYQqi8
         oTLkpxUigHGVMal5HBAOM21bEVPIp20FOybtg9cX0gvtQlL94Wlv2lnkwVlTVOv/sDc3
         TuRgxwB+8/zGDF8UhV1yBY1UxnIwHzlSxzGdWDYCnVQYIRYmMpwgEAtKaumQnlBmuFjV
         xoog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T0c9t1ysaQZfOfoAJ9kXidNtKg/M5DR/wmAFIZcRfSE=;
        b=Fd+uDqj/SPeYZeo8cPrZ3I4f8jgha7CNzj16wyTWPDi+0um9iBSUpOfAFF7X/NUg2u
         44jX+nrFQY8pHwZ/lryvyOi1bcRHZdEnYqdqpK79kkdhm55hR+/J5MZIzech/6Sgcx4p
         zQD3ja+TPkAWHRzkT9zxjGpsBevNc9eQiuiLge9Rl6npEcuA8XL2GZCa2MVBL/mfNp9j
         AwzdWBlTTE9tJHZMwkbt9rgi8HA3hKCZ4CmWFtIexH25kCuhsohf+8HgcguAUk3w97wA
         WLA8UDLNFt3ZiyTyOIWAbYgzmOrTLJ4dTRAuaMyQ5D3d3lccWwIjz9kNOQdwO1uOPMkr
         BsYw==
X-Gm-Message-State: APjAAAWLoa7X+LrY74sRKRNV3w9HnqHBhxLrraPw4MSOm/4tdfTzbQyy
        RzswyZfoUke91qpvboeFFoY=
X-Google-Smtp-Source: APXvYqxTgehaC8pLNfPoMA0zrAlo17oTECcp4HZpebr2fzzWuAhNnaxRpzxVWRL/gOsUSyZyaHugrg==
X-Received: by 2002:aa7:8edd:: with SMTP id b29mr36483870pfr.138.1568130479923;
        Tue, 10 Sep 2019 08:47:59 -0700 (PDT)
Received: from localhost (c-73-222-71-142.hsd1.ca.comcast.net. [73.222.71.142])
        by smtp.gmail.com with ESMTPSA id w13sm19882621pfi.30.2019.09.10.08.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 08:47:59 -0700 (PDT)
Date:   Tue, 10 Sep 2019 08:47:57 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Christopher S Hall <christopher.s.hall@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PTP: add support for one-shot output
Message-ID: <20190910154757.GC4016@localhost>
References: <20190909075940.12843-1-felipe.balbi@linux.intel.com>
 <20190909075940.12843-2-felipe.balbi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909075940.12843-2-felipe.balbi@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 10:59:40AM +0300, Felipe Balbi wrote:

>  /*
>   * Bits of the ptp_perout_request.flags field:
>   */
> -#define PTP_PEROUT_VALID_FLAGS (~0)
> -
> +#define PTP_PEROUT_ONE_SHOT (1<<0)
> +#define PTP_PEROUT_VALID_FLAGS	(~PTP_PEROUT_ONE_SHOT)

Here also, the bitwise not is backwards. ^

Thanks,
Richard
