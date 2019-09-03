Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6CBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D52E208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ytLJ19Vt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfICKcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 06:32:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40757 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfICKcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 06:32:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id c3so16878704wrd.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ha7HjVApVIBrr3dxuJowVFNfwudTzAl93+qSCHVKi3o=;
        b=ytLJ19VtqKQkrSduGoMwp10Fu27RtDH5pjVgQZOxbuE8vHTf+8T0E/MZ34oCV5Il45
         ZP0Il/BGpffqJnrS002ccwaD3fxM3rfTt+QoGSmDciLQGp1aptcRUQMulGFXEzxMlBLF
         ZRAtgAmBoARYA82XGzGJTFLHI/8jTrXRwTh7ddLGkHdjLz760zmweZotaqjH+IWwSCuN
         Ht2tDqZmRsR2/RkAYpwqLU6nJAte1hJXXF72AYVu7e9/s0wy/cI00tIzpzo8y06z0zj3
         WSWPvfnlZupKclk0Sx72sXdpJNzdGl+7SG2qfibSKGp/pG9nQbOmBGyVWo+nseFWpVn2
         rdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ha7HjVApVIBrr3dxuJowVFNfwudTzAl93+qSCHVKi3o=;
        b=bsykIqd/9UACARxI5Mh+j5q2cNsadhbnBkTU2GPTRI32JLwEZ+jHwESdOXtnVl4Dbx
         mMZAtUCqxyNEnTORWZgbal63aaneii3xBAuX4vZ8jAez5x1LUuqSKQzs5Tz3Oo9TtJUE
         4u0ZznGn8pRyy8YETlnlXWt3M6hJsHmaSec2Wug7mXtLulTPzOjI3eWnO9XNh0VfTdZ1
         yKb85ZsnWuqOsXJf3Uo8mNPmMXcUW1bV+m+goAnW+SNMlPlo4Gs/Zg3wBt+vb7B1T9hj
         j52VON0XuPBlOCFbsRTnsyC/Kt+NiZkor+RVn/LuK0BnSAagVBJV2XNO7zuIVVLs9YLY
         suNg==
X-Gm-Message-State: APjAAAWC6gxoy0XQuPsCjm29I2aQSbpBangEeORE/DLJwvIgt0P+MKZ9
        j31H5oqKfmFBoVE/iEUq+fz9Dw==
X-Google-Smtp-Source: APXvYqxF9Oxg1RATCNL9Oem2wg9vobFnyZUl0s1lWrf+uPQaBXKhD9qrGpGTgHjp1EpsQ3PWRbUa3g==
X-Received: by 2002:adf:f486:: with SMTP id l6mr26819612wro.232.1567506770616;
        Tue, 03 Sep 2019 03:32:50 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t123sm19799566wma.40.2019.09.03.03.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 03:32:49 -0700 (PDT)
Date:   Tue, 3 Sep 2019 11:32:48 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the kgdb-dt tree
Message-ID: <20190903103248.dvmylw5ewcvc5wvq@holly.lan>
References: <20190903071657.2caa0c46@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903071657.2caa0c46@canb.auug.org.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 07:16:57AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   f12dc871e3ec ("kgdb: fix comment regarding static function")
>   c60d67aad7b7 ("kdb: Replace strncmp with str_has_prefix")
> 
> are missing a Signed-off-by from their committer.

Oops. Fixed!


Daniel.
