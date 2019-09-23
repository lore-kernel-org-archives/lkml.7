Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4E0C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08C92053B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="msDryTCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503182AbfIWVvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 17:51:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46164 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387520AbfIWVvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:51:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so8744908pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 14:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tk7amWzRilJXyJe6+zs5MYd1x1tWjNgH2dbflW/o9v8=;
        b=msDryTCaccOtQFvzl8l37QzIkUJvMEX3W7Z01qhinubhqGLtANJOGiUhoGSjhFDTZv
         SZ2LrA/8829/mUnbTJ3t2RO/kFrQn0a3wRUZ5jT1pb6wEPdCBTFWlCuRxJaOTGQk4E4r
         gt3Ee2QMlM2iSnNdqQNAB5Dj6GuaazcxmWqyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tk7amWzRilJXyJe6+zs5MYd1x1tWjNgH2dbflW/o9v8=;
        b=ey3cUBqrkGuz3xF19B++oWTsGJUjIWKV10NucvCv2CZtgKvF5eN5S0WMFL2BHc+6F4
         MerORvwZddZciwDscqXrmU01JnYilmzzPwnXm2eo6nYRulLFduBdoYaFiJOu2cyCiJfM
         j41RK7hEi+7p48BiLBCz7za+Yx0MQ0/1vsXjehmKWPH4F1n2ygpd6fahIxSB5845e2yG
         wefuqmyIiyr42ZfmgY7A6/J06MNsF1/8bTmaBoUg/9lbHbOUbOHva5BxqjBq1lSW60n1
         zZ+BNpEveiW67Xfydi0f5eWIBVvT691b5u9OsxrRVMjEMut94OTdCcMemk2nSz6NuxHr
         5SJA==
X-Gm-Message-State: APjAAAVpjQjQNM/7lSCJzKDSNPfqVB6BjvOaW/76gBCgpfdZZ9Ueh+gH
        QrYtEs5bgXvJdcgJ1ZznnOA8eg==
X-Google-Smtp-Source: APXvYqzyDPjPrs2/kSAMfLvql1LRV4Gi3ZeG6MdGfxrPr6j8+kEfTS4Z9/aBndbv8MMSxyd7sUf07g==
X-Received: by 2002:a63:6195:: with SMTP id v143mr2001713pgb.73.1569275465989;
        Mon, 23 Sep 2019 14:51:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 65sm12698426pff.148.2019.09.23.14.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 14:51:04 -0700 (PDT)
Date:   Mon, 23 Sep 2019 14:51:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: Re: [PATCH V8 7/8] Docs: misc: xilinx_sdfec: Add documentation
Message-ID: <201909231450.4C6CF32@keescook>
References: <1562458542-457448-1-git-send-email-dragan.cvetic@xilinx.com>
 <1562458542-457448-8-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562458542-457448-8-git-send-email-dragan.cvetic@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2019 at 01:15:41AM +0100, Dragan Cvetic wrote:
> Add SD-FEC driver documentation.
> 
> Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
> Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> ---
>  Documentation/misc-devices/index.rst | 1 +
>  1 file changed, 1 insertion(+)

Hi! It looks like Documentation/misc-devices/xilinx_sdfec.rst went
missing in this revision (and when committed upstream). It looks like it
was present at least in the V7 of the series:
https://lore.kernel.org/lkml/1560274185-264438-11-git-send-email-dragan.cvetic@xilinx.com/

-Kees

> 
> diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
> index a57f92d..f11c5da 100644
> --- a/Documentation/misc-devices/index.rst
> +++ b/Documentation/misc-devices/index.rst
> @@ -20,3 +20,4 @@ fit into other categories.
>     isl29003
>     lis3lv02d
>     max6875
> +   xilinx_sdfec
> -- 
> 2.7.4
> 

-- 
Kees Cook
