Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6B9C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91B4214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHdvsZja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfDVRfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:35:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44252 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfDVRfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 13:35:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so6021457pfm.11;
        Mon, 22 Apr 2019 10:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jmrhYNL/ByE6hmjbtkEhEpY7aO/3rzFj/0dilHff4Yg=;
        b=OHdvsZjazjKiWUhDTgiR6hy9CU+mGJMuwt3/p+SkUpiAOYdOacleifvHEOq5Yk3J93
         mCMMdP/GHuKkdngN/9/W4xyhDkWkwsbCi9y9l4GbocId2PmSzycX6BHBjS2Zvg0Htsdh
         JSMaxKdBGlxPUsgplZmX6Q9h0pu3+bXfmLFF4fDCeYyXjH0M+anxCm3eGV3LQ70mtatq
         pDFnkxp1Hv58CTW8qD+MJ9tq2/+phcyPV7xphOe/bQAv1jW9L2MCOF8uGq9yOLfmzkid
         C0lfFd2SE44kOZPvo+X0h1ol6BnEZs6EWppJtwJ+9utiCsG8eW+y85Fru446S2x/bfzH
         bXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=jmrhYNL/ByE6hmjbtkEhEpY7aO/3rzFj/0dilHff4Yg=;
        b=Tu8kWTTTAFrVEDBvFoNtbhCxjvAnXzAXpqOj9B/hla/A5UzMfSz5T0nE5PNPd1gkka
         wx02o5aEJbGPMxJXiL7DnsIEqdb6lqrxztfv3MZ1T6mJ20IyGEaS5lb+XUNvYh7CzjZj
         Nlx0G3m1pATMhmFCq1MiS0AsxzKGUoIdpVLl49ZeYuX6bEryibbks9ytUZVolUXMV3mU
         VsrOY5oom2ibTD2L5gVXNt5TfUbPL71OYRe4WsSYj2Fyh2vNrnEBAtYFtBBki+stuwnn
         MNEhD4kl2jqXKoNB5nVCGXfrBrt7MjmLhxRXDjZoXFap2m7l/R9mMLEvFFETcYacrDU3
         66+Q==
X-Gm-Message-State: APjAAAVEkO9E+3I4+iNDC7xGgJCKWu9d6YINiq2DOMLEjMF3qZJgk2kP
        YsqFAWOVpKFtoaOby4mJwWs=
X-Google-Smtp-Source: APXvYqwYRJquRAkmpVuEjmc/qeAjcM9Loa4PJNTiaejBIifT99xstigK65+9j1IItNnM1SZqbeXSVg==
X-Received: by 2002:a65:6108:: with SMTP id z8mr20019624pgu.106.1555954537381;
        Mon, 22 Apr 2019 10:35:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s187sm15366162pgb.13.2019.04.22.10.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 10:35:36 -0700 (PDT)
Date:   Mon, 22 Apr 2019 10:35:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH] docs: hwmon: remove the extension from .rst files
Message-ID: <20190422173534.GA1656@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 08:14:55AM -0300, Mauro Carvalho Chehab wrote:
> On almost all places, we're including ReST files without the
> extension.
> 
> Let's remove the extension here	as well, in order to use just
> one standard.
> 
> Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/hwmon/index.rst | 322 +++++++++++++++++-----------------
>  1 file changed, 161 insertions(+), 161 deletions(-)
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 3fa14fe7b49c..ee090e51653a 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -5,11 +5,11 @@ Linux Hardware Monitoring
>  .. toctree::
>     :maxdepth: 1
>  
...
> -   ir38064.rst
> -   isl68137.rst
...
> -   lochnagar.rst

You never actually sent the patches to convert the above files to .rst.
It looks like you did convert the files in your tree and added them to
the index. Since I don't have those patches, this patch does not apply.

Guenter
