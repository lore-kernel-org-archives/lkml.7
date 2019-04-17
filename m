Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2934FC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95A0205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cluWanpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733216AbfDQTsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:48:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37820 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbfDQTsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:48:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so25294pgc.4;
        Wed, 17 Apr 2019 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jD4t7ZMs5EXCYZ5VFvTHZgqBtravUrGVeV/sa0xSuR4=;
        b=cluWanpmZqiOR7P42PjN3dbFGxEKxwX1T1gIp4j8LfPPFMxv2gdJvSRjYaKNuboZiY
         3LkObegDKKXRb8yk68vpAouC/i2lKJvVoAWKwYnhqHUxRZKylXrSEd7hqMuKYoPwx5yD
         x65MUlO9nUICwqq84XA64RR4J0hIVrO+5disRQsZt84SmS/y9M9xrmh1hhJBvStWca4f
         X9uqHOnef3tqYsf2hnRi/P7R8FmWk9h7QJBEYbdGM5wi3WjPkaDA6W2sqDy+8MrdaeRc
         7avb0/a5EzOWg0J//nJ9+8GDmYiXynoWgJ6Sg9lNadaaFYD01+u4lkbXRMqlriYs4nct
         poVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jD4t7ZMs5EXCYZ5VFvTHZgqBtravUrGVeV/sa0xSuR4=;
        b=LtLHWKRyF4t3OBX90N8M001V/zAfzH8osfJsBFvdj6LFc1SlIktadYaU1TQndxLJr/
         OTym6pY0QcbdJFuRhjnHYGoto7wag4BSWTuTQwiVDyQTFFJDAwuTozHOd7QK4C7lDS30
         68XPkdw+sJUi+nOmzEa/HWk2j6CnRl++JrVUfUhHoTRzTvgzI/dvRzV3vmHO3nATLvtK
         q50PE/ut3F7b8k9c8n5x04l0DE+uK2gDBpQr6s6LykEB5OdKaSDgfDRI4vPjMCrRwyPc
         wnGOsDK79I3m84wHM8OlLnuTsiso3MOtyf5tQDNquFuuKX3yNxf5IuNG5Zuh+cL36cfi
         +cSw==
X-Gm-Message-State: APjAAAWgzuxNLENbApGkUc4jH4LtBjhU2mCvxRdL7y4xLXACOrAJLQr9
        j09bmvGYH8LGzpQGc+pOvG5HhxK+pgw=
X-Google-Smtp-Source: APXvYqzn4Us/DH4j4G8brnXuFuvn3QZpvWjZl4t28MDAC8itfhYrWOIf0c4ei9sRwx/5bUbf0H4/Tg==
X-Received: by 2002:aa7:8384:: with SMTP id u4mr90877158pfm.214.1555530502912;
        Wed, 17 Apr 2019 12:48:22 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id b2sm70423162pfo.150.2019.04.17.12.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 12:48:22 -0700 (PDT)
Date:   Wed, 17 Apr 2019 12:48:18 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina3221) Add voltage conversion time settings
Message-ID: <20190417194817.GA22652@Asurada-Nvidia.nvidia.com>
References: <20190416235548.22733-1-nicoleotsuka@gmail.com>
 <1ad27385-e62a-d4f0-2590-c50458119f12@roeck-us.net>
 <2a193494-a33e-dac0-456a-241d7b3e59ad@roeck-us.net>
 <20190417183949.GB5073@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417183949.GB5073@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:39:49AM -0700, Nicolin Chen wrote:

> > Thinking about it ... does it even make sense to cache reg_config twice,
> > or would it be better to just update the local copy and use regmap_write()
> > to send it to the chip ?
> 
> I remember the reason of adding the read-back was to prevent race
> condition. But now we have mutex protections for all sysfs nodes,
> maybe it's not necessary anymore. I will read the code carefully
> and see if it's safe to remove it -- will do in a separate patch.

I just recalled a second thought for the reason why I left them
there as it'd logically require a copy to restore upon failure
of regmap_write, that might not look so neat as the read-back:

	old_config = reg_config;
	reg_config &= mask;
	reg_config |= val;
	ret = regmap_write(reg_config);
	if (ret) {
		reg_config = old_config;
		return ret;
	}

Would you prefer this?
