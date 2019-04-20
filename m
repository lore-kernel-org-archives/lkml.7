Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA751C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 17:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A257A208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 17:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EiESZaYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfDTRmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 13:42:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37040 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfDTRmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 13:42:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so9724630wmf.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 10:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7VKLWu5181bgc/51MBOuinUxPdi3QIMWCt3J71/byE8=;
        b=EiESZaYeSH1ka+mp/G69ZWH29IQ3UtEYZW/21cMvZKIvyff9zok7fZZL+kT/hhEdxv
         vC0mfIFpsLZljMU1bumfgekkqCDWCgL6vrmb9XRL14oNtoGSRwZNvbDKemmOnjh87840
         M5zRMymWXuyAPTeWShBbzChylr/GVO0LDhkSTBO9N91+0jn3d7ih7DVlYWmzgRSv3RNz
         Whga29UukD3x3rn0LkEmBOjvP6baMi7daANxJCcN593Jx23RyWKyZHys9X9Va0A3y3+v
         5cNLxhaoGVN+j1yeK6Dbxyad76gTpslud/lKqRzGs2E/RP4vmmbLWdGu+44XBVvkYz7T
         L6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7VKLWu5181bgc/51MBOuinUxPdi3QIMWCt3J71/byE8=;
        b=Aze7zNQsnnesVyRu13ulx4D5Lj1a92LjEvNsGpnEa12PJOcvVgERddiSwbmjLta880
         4JQ73jOvy6ufmDlYqQekYLzED99rOCf0smQU2yZGyUbOZjD/yP8IXACbhNsY0FWJVK+z
         51cu5JHHR+QFHK53qXhv81hHfkxFBHyrEBPD5kdzLchFHJamNt9gRc1+HpcbXWUz1tUd
         IndXU0RAywcO6wT20s0mvlvIlHHV6cPHmkHxceHa9w9TpiJ8A+LwdYvG/o4fRtHJISJy
         rWBGaccTelu6UtihDw5I3wedCw+epUGLb/YLWYqBvVC6a+nT2JdcoqnNPj+c8eIPMWRp
         rlSw==
X-Gm-Message-State: APjAAAVJheE3pk8xKwlHrlTPca1HPhl7arqnPnEm3v8WpGc6e7t0DTN6
        24Yu7N0ODzZ1s2Aixhmw2rlrftoLaSq+iw==
X-Google-Smtp-Source: APXvYqwLWT293QftS45TYu0Q2m8W0ZJVmhRnhiXhNqDI8zOl8KpKDMG4aTU1nmEfe82XD8DkaBT8jQ==
X-Received: by 2002:a1c:6c04:: with SMTP id h4mr6615508wmc.135.1555782127364;
        Sat, 20 Apr 2019 10:42:07 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id u6sm10674866wrg.72.2019.04.20.10.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 10:42:06 -0700 (PDT)
Date:   Sat, 20 Apr 2019 19:42:04 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     airlied@linux.ie
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] agp: Add bridge parameter documentation
Message-ID: <20190420174204.GB23311@Red>
References: <1513798010-12089-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513798010-12089-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2017 at 07:26:50PM +0000, Corentin Labbe wrote:
> This patch add documentation about the bridge parameter in several
> function.
> 
> This will fix the following build warning:
> drivers/char/agp/generic.c:220: warning: No description found for parameter 'bridge'
> drivers/char/agp/generic.c:364: warning: No description found for parameter 'bridge'
> drivers/char/agp/generic.c:1283: warning: No description found for parameter 'bridge'
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Hello

gentle ping

Regards

> ---
>  drivers/char/agp/generic.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
> index 27a022f806fa..cf50a180c8d6 100644
> --- a/drivers/char/agp/generic.c
> +++ b/drivers/char/agp/generic.c
> @@ -207,6 +207,7 @@ EXPORT_SYMBOL(agp_free_memory);
>  /**
>   *	agp_allocate_memory  -  allocate a group of pages of a certain type.
>   *
> + *	@bridge: an agp_bridge_data struct allocated for the AGP host bridge.
>   *	@page_count:	size_t argument of the number of pages
>   *	@type:	u32 argument of the type of memory to be allocated.
>   *
> @@ -355,6 +356,7 @@ EXPORT_SYMBOL_GPL(agp_num_entries);
>  /**
>   *	agp_copy_info  -  copy bridge state information
>   *
> + *	@bridge: an agp_bridge_data struct allocated for the AGP host bridge.
>   *	@info:		agp_kern_info pointer.  The caller should insure that this pointer is valid.
>   *
>   *	This function copies information about the agp bridge device and the state of
> @@ -1277,6 +1279,7 @@ EXPORT_SYMBOL(agp_generic_destroy_page);
>  /**
>   * agp_enable  -  initialise the agp point-to-point connection.
>   *
> + * @bridge: an agp_bridge_data struct allocated for the AGP host bridge.
>   * @mode:	agp mode register value to configure with.
>   */
>  void agp_enable(struct agp_bridge_data *bridge, u32 mode)
> -- 
> 2.13.6
> 
