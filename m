Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B18C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 23:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E50206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 23:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573686968;
	bh=cCH3+gHX9V2Vil2BLhsq6QoiHtnqApnZxMBCAMCOwsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EqBrdorwTv6V8wm7hrEi6LDprSsczNrNtB1N2HUQWywKqqXpGGK/ulhHOFbXbxb82
	 z/RMTtAgduuN6B9tivZBKyo4+tkasB0hd2bcfWwWKrxD4d3YX14o/iiQLvGLVx0m7K
	 3xTqXgUjHCwTDI+4Blt3pmEGcidwWYggHMitJX5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfKMXQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 18:16:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45088 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfKMXQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 18:16:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id z4so2694782pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 15:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2bXwg3bB3QH2Fpq4L/DVdXRuHrsZITMmQgu/SA19YHI=;
        b=lMuPuEcQdoYypdpOE8QX1RvlEyoMm14utr4lvC3yb7hHdM0F+9UcTNUHROrZDjiT5A
         vhBizcrSjX1Rn/wdW7kw8eG3O9aca5q23TivvWLxInZHJODm0BwgTAw1e+OHfeC1jbmG
         HEa82lBmFjHIG4ypPz+yd0w+2Uc3/XWAZa4Yknm6ADfu8/mW8m1ciWgKJVjmAZFY7Vck
         PR5S3grF7GOgxhw5uqWLUY+UAZE6DxQlAVgsHADHQMjVtmN4w3d1Ayg+dbWOnkHwN8ns
         mSvDIdioUsZjA8MnRr8pK/rzygbFzeun7oEGjkboX7x+7UmiucGEoaRhsAxCaqKBzSsZ
         Z7SA==
X-Gm-Message-State: APjAAAWcLPBBoyjLo+mvgQzhW/UNb8PQRgBKstVhdJtCzSOcP99f9Cgr
        5vHOKKnw38yxaeYaIU0H8Og=
X-Google-Smtp-Source: APXvYqwrA2CkYSZ/oRxHv92TXqtzcHVQwcWJdcdMjB0L/beksCpr4IhNX/aZiH8fMPwMVQvkV59N1g==
X-Received: by 2002:a17:90a:9502:: with SMTP id t2mr7149881pjo.14.1573686964959;
        Wed, 13 Nov 2019 15:16:04 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a25sm3873248pff.50.2019.11.13.15.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 15:16:03 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BE03D403DC; Wed, 13 Nov 2019 23:16:02 +0000 (UTC)
Date:   Wed, 13 Nov 2019 23:16:02 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Tim Murray <timmurray@google.com>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] firmware_class: make firmware caching configurable
Message-ID: <20191113231602.GB11244@42.do-not-panic.com>
References: <20191113210124.59909-1-salyzyn@android.com>
 <20191113225429.118495-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113225429.118495-1-salyzyn@android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 02:54:26PM -0800, Mark Salyzyn wrote:
> +config FW_CACHE
> +	bool "Enable firmware caching during suspend"
> +	depends on PM_SLEEP
> +	default y if PM_SLEEP

I think the default y would suffice given you have depends on PM_SLEEP,
however this also works. So, again:

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
