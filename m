Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13BCC32770
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7849524653
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfsLly0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgADQ3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 11:29:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38991 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgADQ3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 11:29:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so24804273pga.6;
        Sat, 04 Jan 2020 08:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xg4ooeb4ZqD5RUJja+KKcwjjVJIN28IYYLoomRMkZSE=;
        b=MfsLly0BVG4U2BVJOBiEw/leGY5GskyTW3deWOm+jYg7rRLD8ShxcnWonHK/f1wlek
         ObdsdYrr305sRxIwWLrduvt7EE2kM2k5VxmNXQb+9l5vUjFN1BaeOHKzlOplpJiIdfSy
         A0jTQFfoIHG2pc3a7716hzAXG6iQZnI7HfJQY7zx1UDxQocRNIG/FswD5LcrVWxLmWPC
         I231T4APvpJy1EZ5tr/ASS2Yop5XfNY+xfycYAjxKeNte3zssujCmWLeVv10EhX/madD
         8kvgyUY6X775xiNPB2KulbmIGmmdi3qXRuSk8YPHD2mDuoN37YOHKcFazyXvf4YhxUBJ
         R0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xg4ooeb4ZqD5RUJja+KKcwjjVJIN28IYYLoomRMkZSE=;
        b=bs1ucxQx0M2kufcb1HUYmqUkCPQ99nFbHLISZW/fwPi1bkgfi7RJmavC+XQOO8+Hkn
         IUvewPRe1LXv+1rvhggXBuJU5hXH2jj3DPk7m1z7hFRylZrq31YutciKBXLid5UvxGyQ
         LLDgcR84W7ASm8letB8cPQai0Z0jVmOHd1ERw313dkm1eZyGrQFn3j/RGBdnT5Deonfe
         9xmnjuR2sGeVp1zpocBVXQIjbiE5mMX+EeGu9le6WLkOuBdPKRHntVCxyyjGIdQe3L02
         II8qB9KZwBuK6uPBARJhOhW5I4KsisytVt2jz07rbYmw7nxH0nnghe0F6jw9O2W7Zjd7
         B+ow==
X-Gm-Message-State: APjAAAUWyut5EJUuad4Ty/c+v2y9b5f2Ni80d+/YU1mujgf+MmSACR8Q
        kl8XPL/BUcYORYy1B+IFNps=
X-Google-Smtp-Source: APXvYqwdgptw3Ge/84SYGAHM8emhnTsyMb+shqkQAOh3BTP0m5/lsTlI8Cmz0EslUcROLY32EfsJ4Q==
X-Received: by 2002:aa7:848c:: with SMTP id u12mr97193118pfn.12.1578155357545;
        Sat, 04 Jan 2020 08:29:17 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m22sm70927215pgn.8.2020.01.04.08.29.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jan 2020 08:29:17 -0800 (PST)
Date:   Sat, 4 Jan 2020 08:29:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, bjwyman@gmail.com
Subject: Re: [PATCH 2/3] hwmon: (pmbus/ibm-cffps) Add the VMON property for
 version 2
Message-ID: <20200104162916.GA20041@roeck-us.net>
References: <1576788607-13567-1-git-send-email-eajames@linux.ibm.com>
 <1576788607-13567-3-git-send-email-eajames@linux.ibm.com>
 <20200104162810.GA30243@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104162810.GA30243@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2020 at 08:28:10AM -0800, Guenter Roeck wrote:
> On Thu, Dec 19, 2019 at 02:50:06PM -0600, Eddie James wrote:
> > Version 2 of the PSU supports reading an auxiliary voltage. Use the
> > pmbus VMON property and associated virtual register to read it.
> > 
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> 
> I assume you are ok with v1 reading (or trying to read) this voltage.
> 
Ah, never mind, you don't. Sorry for the noise.

> Applied to hwmon-next.
> 
> > ---
> >  drivers/hwmon/pmbus/ibm-cffps.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> > index a564be9..b37faf1 100644
> > --- a/drivers/hwmon/pmbus/ibm-cffps.c
> > +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> > @@ -28,6 +28,7 @@
> >  #define CFFPS1_FW_NUM_BYTES			4
> >  #define CFFPS2_FW_NUM_WORDS			3
> >  #define CFFPS_SYS_CONFIG_CMD			0xDA
> > +#define CFFPS_12VCS_VOUT_CMD			0xDE
> >  
> >  #define CFFPS_INPUT_HISTORY_CMD			0xD6
> >  #define CFFPS_INPUT_HISTORY_SIZE		100
> > @@ -350,6 +351,9 @@ static int ibm_cffps_read_word_data(struct i2c_client *client, int page,
> >  		if (mfr & CFFPS_MFR_PS_KILL)
> >  			rc |= PB_STATUS_OFF;
> >  		break;
> > +	case PMBUS_VIRT_READ_VMON:
> > +		rc = pmbus_read_word_data(client, page, CFFPS_12VCS_VOUT_CMD);
> > +		break;
> >  	default:
> >  		rc = -ENODATA;
> >  		break;
> > @@ -453,7 +457,7 @@ static void ibm_cffps_create_led_class(struct ibm_cffps *psu)
> >  			PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> >  			PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> >  			PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
> > -			PMBUS_HAVE_STATUS_FAN12,
> > +			PMBUS_HAVE_STATUS_FAN12 | PMBUS_HAVE_VMON,
> >  		.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> >  			PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> >  			PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT,
