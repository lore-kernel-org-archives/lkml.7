Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AA1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806EF22CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tbdGs/7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfHVN7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:59:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38693 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732074AbfHVN7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:59:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id w11so3058180plp.5;
        Thu, 22 Aug 2019 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gQMErqPW+Y+kyijobMVXbQaJgQ9U/p2mbhMShsZvhmY=;
        b=tbdGs/7b5IYevDXx+SAWNGYEyip3VRS9QZ3yImh2nJ/Z9tgTGX+k8kX0/XTlhuOy4J
         Ey6C8iymNu46T8xiFw7oZ3/cXx9FBg58J6g1a3vxrPBRMQ1aPQ+otf4a/i4wUdwWxpnN
         kvJ3HshSmOkDIHTQrghV10SdhQG1W/4jCcQbehZLz4pulKIkHAtVtmA06vtRm05p+tVH
         ZCSOIX5+2dawJP9Cgn4y6ci+z9O4rPHgzU63kMx7A5qS7PUEInbo3yxz6mt/Uh6HMk/+
         zVzxEosK3Q7lM9hJBHo+aqg58hsgvlZiaBLbFasi5VnDrKTQiiRDvVbRbs5DJRkppGu1
         q/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gQMErqPW+Y+kyijobMVXbQaJgQ9U/p2mbhMShsZvhmY=;
        b=Ltszalk+Jdagi9CWkRpvifL6EVBR52tCHaA/CbaBJw7gIM1Xk2qPOVysnKqtT9slMd
         qP/b9a4ARANnNyLKBUvIRldGxptZGIS9buHF2IEUjijkKPAsoYhVocpdrL2Aoexov68s
         VbY/7sWg/emPX2hC3wBUoATqNNYHeFmUqMnguCl3EwDJCs3PcSe8H9hywO4ihBlY408+
         nTiJ2/oRkuVwaDptQ07pq1z+/bSsH/xckYNM+B9nq5e7avjl01/uBKXdQJ4bN/kL6rLl
         mDe9EhPLBRsQiDRtfF9PGF4OXWcJrV/+0fKfDSu8E3lhmUcN2m5DUrJcvEhgqq+B+yfx
         cnBg==
X-Gm-Message-State: APjAAAVUjN3ssVXziJ+Dp/3rCZKURO+4sxUqLLngDodoGdp1vwz0/mu2
        Gx/i3rG9HkyYH9mBmvWj83k=
X-Google-Smtp-Source: APXvYqxxFMSue8E1e+xVFW8I5bTOFVzjtqZ4z3kHW7Zq9wWlq6SPsozB8axnGLvnvTwawGipkiE2bA==
X-Received: by 2002:a17:902:1a4:: with SMTP id b33mr38545181plb.141.1566482358390;
        Thu, 22 Aug 2019 06:59:18 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p10sm29038551pff.132.2019.08.22.06.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 06:59:17 -0700 (PDT)
Date:   Thu, 22 Aug 2019 06:59:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] typec: tcpm: fix a typo in the comparison of
 pdo_max_voltage
Message-ID: <20190822135916.GC8144@roeck-us.net>
References: <20190822135212.10195-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822135212.10195-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 02:52:12PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There appears to be a typo in the comparison of pdo_max_voltage[i]
> with the previous value, currently it is checking against the
> array pdo_min_voltage rather than pdo_max_voltage. I believe this
> is a typo. Fix this.
> 
> Addresses-Coverity: ("Copy-paste error")
> Fixes: 5007e1b5db73 ("typec: tcpm: Validate source and sink caps")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

I think you are correct.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 166b28562395..96562744101c 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1439,7 +1439,7 @@ static enum pdo_err tcpm_caps_err(struct tcpm_port *port, const u32 *pdo,
>  				else if ((pdo_min_voltage(pdo[i]) ==
>  					  pdo_min_voltage(pdo[i - 1])) &&
>  					 (pdo_max_voltage(pdo[i]) ==
> -					  pdo_min_voltage(pdo[i - 1])))
> +					  pdo_max_voltage(pdo[i - 1])))
>  					return PDO_ERR_DUPE_PDO;
>  				break;
>  			/*
> -- 
> 2.20.1
> 
