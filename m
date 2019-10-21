Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD55DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF3221BE5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="BYR1nPjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfJURsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 13:48:37 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46876 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJURsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:48:37 -0400
Received: by mail-yb1-f193.google.com with SMTP id h202so4280438ybg.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/aQ2Xv1WKwqQ6Cs7AfPTa0eGi7XzsweDvCsXYGNh4y0=;
        b=BYR1nPjjeKpiDFQPn+BoJTU76YiI0GfclJ9zGb/84dK/s6dMl3t0GKOk9y4Gem07Bx
         DYseBAQdislf/vUqD2wm9CsjwQWlfcIiaJQoruk86prLwOaPmPmoZ/sj2b/spt4Q4/OB
         bZk1kWKGA7w50ce0Kj54dYbBAIuSTzMNPE5pOKNj/Ugi7vmcvPfUXM0ZH1gU7w2vN4FF
         bjMqmpGI1tfwdbooJMHCuVtTwyu9rD41ntTGyfNvod8Dou/au2AAsaCoOK5VxzfUd7yG
         d2jDVydbKatZPEUMmygmZpOOO+bbirNPW7HbGN3E7fJz6tegpgA2PObik4Jp29PvMfE6
         dAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/aQ2Xv1WKwqQ6Cs7AfPTa0eGi7XzsweDvCsXYGNh4y0=;
        b=DZ+7speEEFdrSt+j2yXYe1AvdWgWfVv9KeYaQqaLHRisuXnKSBz+lHfw1vRg8lDPgO
         WLA/jyBdp+aTAHE/FJDSMUtK9ioI9SYT/J5dvpB1WxrVh2HFPIE5vsdjS+KJZ5bzWWrO
         kOVDM10UUG24tuwlw9/OlqUfjunFUeUTSoCzG19e+77rOUx4E6A6XyoZGpEKP+JzWB6v
         xwpK5G0CNd5jTM9ofuJrLU8aDe+tn5LI+EiwvwecfZ+3kfE5L/usX0JrFa+AU4McsT5q
         5Bh61BK7TelNp6rvbFyAr3Khx21Gswb13+xhOJQHZGsyx66iPgTVDXRjtdlOuYVFO7pW
         u5ZQ==
X-Gm-Message-State: APjAAAXlyrKURuQCCQrx0KsHn5NCKmy3363gA26pJCpd8qB5e+t75zB6
        KZDaIQss0tKxGt9Gw8vNKxayYw==
X-Google-Smtp-Source: APXvYqzqDfFNGR9QqQ5nnvsB1IFVw6u/ZZPtSYlAbTyxlHYUl8FsAB4/vZgMdLMARfM5qbe7KIcSkw==
X-Received: by 2002:a25:2394:: with SMTP id j142mr16061531ybj.201.1571680116379;
        Mon, 21 Oct 2019 10:48:36 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id n185sm3677429ywf.86.2019.10.21.10.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 10:48:35 -0700 (PDT)
Date:   Mon, 21 Oct 2019 13:48:35 -0400
From:   Sean Paul <sean@poorly.run>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add Mihail to Komeda DRM driver
Message-ID: <20191021174835.GD85762@art_vandelay>
References: <20191021150123.19570-1-mihail.atanassov@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021150123.19570-1-mihail.atanassov@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 03:01:56PM +0000, Mihail Atanassov wrote:
> I'll be the main point of contact.
> 
> Cc: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>

Acked-by: Sean Paul <sean@poorly.run>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 94fb077c0817..d32f263f0022 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1251,6 +1251,7 @@ F:	Documentation/devicetree/bindings/display/arm,hdlcd.txt
>  ARM KOMEDA DRM-KMS DRIVER
>  M:	James (Qian) Wang <james.qian.wang@arm.com>
>  M:	Liviu Dudau <liviu.dudau@arm.com>
> +M:	Mihail Atanassov <mihail.atanassov@arm.com>
>  L:	Mali DP Maintainers <malidp@foss.arm.com>
>  S:	Supported
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
> -- 
> 2.23.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
