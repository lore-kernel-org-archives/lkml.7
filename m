Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84EDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 19:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D78E20872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 19:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdZI/B/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfCaTBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 15:01:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41035 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfCaTBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 15:01:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so9028028wrq.8;
        Sun, 31 Mar 2019 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4d8MBJ7vSrUn9szSzkAihcIg8Jqey+m4JALhsIIOGV8=;
        b=EdZI/B/w3s6ZPl47OTN5foMO9Rq7oR3x635kcrQw2SR6ibvdZEB7a6SoxAMlBV7HY2
         cl2q0/nOuhvoN+iaKSAusMb6dTCZOKK8wI5NMyQY7wwAjDRFCRsv7sanV9OuDzp803Yk
         LKblJUg+OKaYVvoPFW4sjptkXFu+zgU1JQWLEXIUOIU24yCscKwTT61YcH+wTUdN6lLy
         geAqGiXaJ/oz2VSFyU5n38TwbSwz+gk8v3e4jYX7jXA2TEw8y3nNiJ32FAAMSexkXLcl
         /yUevm2n8JB6vSpwGD6SUdyiKGVJts7sSNk8d5Oa6RNWNvIH359Doz3173yLVDjxdoI1
         5F+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4d8MBJ7vSrUn9szSzkAihcIg8Jqey+m4JALhsIIOGV8=;
        b=oNOaNm3StxEnJCF9LZmrCuxeH09fOAKa9EsKNcT6hCprIqezx8el2R5VqzZ4PYsSTC
         udUpNzRYRmZs4tGMk1bYCIa1pG9iqiIbRu4z5CKlc5y8FfSXPUsrar4+vRexb6RdFwZY
         GTRI7BWHqhCD0dZTR228Loj103C2L37R46GW1d/duepn5WIIc9sb+3Eph3HyX3zZG8BZ
         hrdBqZg3w/W5vGPdfY43iFq1OOInBb897e5mBiPYp4wB/BNFqGHrNlizrva+hbhaKWMh
         Kzm4c6H5wJURRK6eD8VIAcXmFUp/SBL3wRoImMR6dmoAS9bHo+MCj2Wv3v5mqjCxysG4
         15ng==
X-Gm-Message-State: APjAAAWZkcXc2a+7mMzI2wwP7kyTDhYeKTMIEYdFV2sbH903Id1WF2mR
        7Drb/czPynUqRLiepVU4VAA=
X-Google-Smtp-Source: APXvYqyY40Z2AbmUqlgHNWLZi37nRiAGkO04l47N7A0MhO/Kz6KNdwWI6cAe4WvT+VeWAyfSY4X+cQ==
X-Received: by 2002:adf:f147:: with SMTP id y7mr36411561wro.102.1554058880770;
        Sun, 31 Mar 2019 12:01:20 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id z17sm2551497wmc.7.2019.03.31.12.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 12:01:19 -0700 (PDT)
Date:   Sun, 31 Mar 2019 20:01:18 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 6/7] fbdev: sm712fb: Kconfig: add information about
 docs.
Message-ID: <20190331190118.3kaf7erdbk25yd5n@debian>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-7-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322051759.15007-7-tomli@tomli.me>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 01:17:58PM +0800, Yifeng Li wrote:
> This commits update the Kconfig description of sm712fb,
> and inform the user about the existence of documentation.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> ---
>  Documentation/fb/sm712fb.txt | 44 ++++++++++++++++++++----------------
>  drivers/video/fbdev/Kconfig  |  4 ++++
>  2 files changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/fb/sm712fb.txt b/Documentation/fb/sm712fb.txt
> index 906b48aa40e4..c9a8fe059ac7 100644
> --- a/Documentation/fb/sm712fb.txt
> +++ b/Documentation/fb/sm712fb.txt
> @@ -18,9 +18,10 @@ and it was also an inexpensive platform for non-x86 hobbyists to explore.
>  How to use it?
>  ==============
>  
> -You should not compile-in vesafb, since SM7xx can be used in a VGA
> -compatible mode, resulting conflicts with this driver. In addition,
> -the VGA compatible mode was never tested by the maintainers.
> +SM7xx can be used in a VGA compatible mode and a native framebuffer mode,
> +this driver is a native driver. By default, it has no problem taking over
> +the VGA driver automatically, but you should not attempt to use both at
> +the same time.

You added this in the documentation with just the previous patch.

>  

<snip>

>  
>  2D acceleration
>  ==============
> @@ -97,7 +103,7 @@ Missing Features
>  
>  The following features are not implemented in this driver,
>  
> -	* 2D acceleration on SM720 and Big-Endian CPUs.
> +	* 2D acceleration on Big-Endian CPUs.
>  	* More VGA modes.
>  	* dual-head support
>  	* hardware cursor support

You might want to squash the two patches for documentation instead of
having a separate patch to fix what you added in a previous patch.

--
Regards
Sudip
