Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452B9C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110342084B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmFjBUsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfDPAUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 20:20:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46180 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfDPAUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 20:20:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so9418607pfj.13;
        Mon, 15 Apr 2019 17:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hGSRLXLadQOLX55DxvAINLcJwPboKn8ZaKLD5g5ABfk=;
        b=nmFjBUsYM9msfrovL5HTwoHxVo43G4+UeKNdS5QH+k7HD/YPb/O/dldlWjKACM5H1M
         8HGkS5m3EtWouV7z0dNwq5kz9hMU8xOZp9cPb0Y8D9a1W8WkSwD3B3nPqdHR106jgylN
         5PYesBxzHGUyuCjRtt97iZuzTuQ2xKE8/cxCWZS0j1VBz01OiapO5ojHtu9plN7gU6ks
         I0mCzo/5jCFYqJwdR5pWq1ysg8oeC91qNTz39pw2zn3byf8kxygZ85zvvhICleM1KlHJ
         SiF4EWpYKsAYjpUCNy0+TTnswBO3QLFkm4K3HS1zIsI52DN8RfNDegQQySRGZZ9OqZM3
         9U2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hGSRLXLadQOLX55DxvAINLcJwPboKn8ZaKLD5g5ABfk=;
        b=tYUf+bz1sbdDQLRV1Bq6Q/FzP6Nt7sWS/RmyXHpjrOrhi9sSGvXAnHQuWBzWWnZuu6
         TpjwAf7uKWZ2oXjvIg5W/rDKTx6I02//nFCvbNqdqXrp5b674m1js8xs+BGjmbHAn6u/
         HiwBiKBPzd2ffzTnyDH+v66DtF3BtKk1qtyRlZrSWL/5GC2tXMcsyTeVnAtA+17oMeLN
         aZzUh8Bkz6EDX9TeMSEBvdr1/gvHkFSNVw27NxsEqnP1Qf0VzxejU3IcU0H4E243RIQM
         HcrH1aVS59g1Y3i3ITgUhtVb2pfID2i7pjgbV4IQTUlPBqfhOwQS8HC2UpEFSB/xfI7P
         RSAw==
X-Gm-Message-State: APjAAAUsVPAr+XROrNOxnDsmW6YA3dfS/SIOIH+paBpXQbx0vUpnD1TW
        n3EuQsOxSsnlYmzcOhG6mqA=
X-Google-Smtp-Source: APXvYqz+Spzaqjsyrgcvief1vVTGeGZPlPzqd3ZotwlRs1OHaoj5oocNIkr3pm6AN0Dl/iZdG0p+dA==
X-Received: by 2002:aa7:8208:: with SMTP id k8mr80107297pfi.69.1555374047590;
        Mon, 15 Apr 2019 17:20:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s19sm69505548pfe.74.2019.04.15.17.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 17:20:46 -0700 (PDT)
Date:   Mon, 15 Apr 2019 17:20:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lei YU <mine260309@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Eddie James <eajames@linux.ibm.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH] hwmon (occ): Fix extended status bits
Message-ID: <20190416002045.GA4442@roeck-us.net>
References: <1555324640-152061-1-git-send-email-mine260309@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555324640-152061-1-git-send-email-mine260309@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 06:37:20PM +0800, Lei YU wrote:
> The occ's extended status is checked and shown as sysfs attributes. But
> the code was incorrectly checking the "status" bits.
> Fix it by checking the "ext_status" bits.
> 
> Signed-off-by: Lei YU <mine260309@gmail.com>
> Reviewed-by: Eddie James <eajames@linux.ibm.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/sysfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
> index fe3d15e..a71ca94 100644
> --- a/drivers/hwmon/occ/sysfs.c
> +++ b/drivers/hwmon/occ/sysfs.c
> @@ -42,16 +42,16 @@ static ssize_t occ_sysfs_show(struct device *dev,
>  		val = !!(header->status & OCC_STAT_ACTIVE);
>  		break;
>  	case 2:
> -		val = !!(header->status & OCC_EXT_STAT_DVFS_OT);
> +		val = !!(header->ext_status & OCC_EXT_STAT_DVFS_OT);
>  		break;
>  	case 3:
> -		val = !!(header->status & OCC_EXT_STAT_DVFS_POWER);
> +		val = !!(header->ext_status & OCC_EXT_STAT_DVFS_POWER);
>  		break;
>  	case 4:
> -		val = !!(header->status & OCC_EXT_STAT_MEM_THROTTLE);
> +		val = !!(header->ext_status & OCC_EXT_STAT_MEM_THROTTLE);
>  		break;
>  	case 5:
> -		val = !!(header->status & OCC_EXT_STAT_QUICK_DROP);
> +		val = !!(header->ext_status & OCC_EXT_STAT_QUICK_DROP);
>  		break;
>  	case 6:
>  		val = header->occ_state;
