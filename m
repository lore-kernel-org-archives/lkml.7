Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E7CC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BAE24BAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUaTBxs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfFCQSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:18:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37786 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfFCQSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:18:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id bh12so1097716plb.4;
        Mon, 03 Jun 2019 09:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p4sHeMSwuiO6XHZeDrH9mLgYjDqfs6hfLwvHwXhnh6Q=;
        b=QUaTBxs2hk4MFyRB4Y9D/HBIuusX7H88wACTIFBVB4OMXVQ208dODgIKwWAdDBjzfr
         mdr2i/4w0bbZWAWviw3/c+5aE6ApmJFp0KedwAbanFkdDPxDDuVLD6QqqVGpmlxRvhwk
         5zYZ/cGNJjBxYORG/YRZThjBSfQ+POwHgmlUpifLmJ7SxyR5f2U9RTEzCi/CO8o2bXJM
         pIlsmwcZHWfidKdTX7VyUpRc8H8BRiDlp8EpC9nvR21pUr5t45JXWgC4n/ETFxtCaWuc
         mPY6A2rtL20IlOM543ULfCFQwQe3WEM5t9BU38B4RzEUxMLFPJs7f//aitDT14qdDElN
         wFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=p4sHeMSwuiO6XHZeDrH9mLgYjDqfs6hfLwvHwXhnh6Q=;
        b=lILSJ69HVJ0IcJlyVzTFHaPeVFTlf3AFfsoAsMqSXEC4Ur1RnuwWlWAlgo4r9ImGgy
         7JAM6lYY3ycfBVvgO1bKh9XXgvbNz6Y441J8DF1E3Oy6Z+9NWOw2CXIpBv7w/mTYeHiK
         Q82a1criKaRnM79PSGEn9DzEIYohZmnaN4aul80IuLSrKKGjGjqxJmNP5eeSEi3MaTW5
         QItRHMFRcm3YbzLKK9vDRLqWe4nj7LIfNntc/924gW3/kkrKxLCacOfBjZg2olaIK3Dt
         GOsXcmi+q1qtNmiMD0cqiiQ0NcqVrTWO648bxDeAC9Vr2Nq0RhIDblNUvTvQHM3IJz/S
         vuFw==
X-Gm-Message-State: APjAAAVzeCs4BmuHnqn2UKoRaQimrGC4xrrZRBV6QUYB2nC08/qj+Sem
        cn/2VZW94kNIxjI0cE9/syw=
X-Google-Smtp-Source: APXvYqzNkbi/w84kqvDZRwpwMcg/rqSTN6cdXAR0R4mIyZEAvW5LnyVvKq3tfJnau3koZq1L+U4OUA==
X-Received: by 2002:a17:902:29e6:: with SMTP id h93mr29425315plb.297.1559578685438;
        Mon, 03 Jun 2019 09:18:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a1sm286255pfo.153.2019.06.03.09.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:18:04 -0700 (PDT)
Date:   Mon, 3 Jun 2019 09:18:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Cc:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>, Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: pmbus: protect read-modify-write with lock
Message-ID: <20190603161802.GA11107@roeck-us.net>
References: <20190530064509.GA13789@localhost.localdomain>
 <5ecab585-7e74-ea9f-8d33-93ab024e1a14@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ecab585-7e74-ea9f-8d33-93ab024e1a14@nokia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 01:11:45PM +0000, Sverdlin, Alexander (Nokia - DE/Ulm) wrote:
> Hi!
> 
> On 30/05/2019 08:45, Adamski, Krzysztof (Nokia - PL/Wroclaw) wrote:
> > The operation done in the pmbus_update_fan() function is a
> > read-modify-write operation but it lacks any kind of lock protection
> > which may cause problems if run more than once simultaneously. This
> > patch uses an existing update_lock mutex to fix this problem.
> > 
> > Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
> > ---
> > 
> > I'm resending this patch to proper recipients this time. Sorry if the
> > previous submission confused anybody.
> > 
> >  drivers/hwmon/pmbus/pmbus_core.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> > index ef7ee90ee785..94adbede7912 100644
> > --- a/drivers/hwmon/pmbus/pmbus_core.c
> > +++ b/drivers/hwmon/pmbus/pmbus_core.c
> > @@ -268,6 +268,7 @@ int pmbus_update_fan(struct i2c_client *client, int page, int id,
> >  	int rv;
> >  	u8 to;
> >  
> > +	mutex_lock(&data->update_lock);
> >  	from = pmbus_read_byte_data(client, page,
> >  				    pmbus_fan_config_registers[id]);
> >  	if (from < 0)
> > @@ -278,11 +279,15 @@ int pmbus_update_fan(struct i2c_client *client, int page, int id,
> >  		rv = pmbus_write_byte_data(client, page,
> >  					   pmbus_fan_config_registers[id], to);
> >  		if (rv < 0)
> > -			return rv;
> > +			goto out;
> >  	}
> >  
> > -	return _pmbus_write_word_data(client, page,
> > -				      pmbus_fan_command_registers[id], command);
> > +	rv = _pmbus_write_word_data(client, page,
> > +				    pmbus_fan_command_registers[id], command);
> > +
> > +out:
> > +	mutex_lock(&data->update_lock);
> 
> This has to be mutex_unlock()...
> 

Not only that - it is also recursive.

Guenter
