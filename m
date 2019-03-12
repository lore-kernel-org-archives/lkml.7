Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B22C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22492173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwpRD2WB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfCLWwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:52:42 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:37710 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCLWwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:52:41 -0400
Received: by mail-pf1-f182.google.com with SMTP id s22so2894778pfh.4;
        Tue, 12 Mar 2019 15:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+zjiX7dOtnqO9UeNMZu2JA3zDMs2qfAVu5ZR9QhVnv0=;
        b=CwpRD2WBh6ImOBttJmjaQ6xd65jEySj+i9SscKgjn2/Ecz8/s7lNJqgP1EFf8Y8Y8i
         1au4+GqVMtpg9zRNyWQJ0Rwpg/+6HV8u/U48fZgx8D3v2VJTJplAyHKcbjfZxLIVtCtv
         MNcudi/dlzPIfr/dNR37TArT9Aul6XngNUbL8VYJSbMJE8Yn3FZultQjEgLXLAIHEheX
         Xj/tN8aohi6bPl8ax05HhxLZFXYXF6OLZtJFh1ojRb6uK+4KtSnES1ERY/V3lCvtZoGI
         dWRZjWxG0dTTjqeSOW9eWDYHmtp8YDTzkxGzHAx4+PGHPuYAQ+fuRww2uH6amqmDCS6T
         HVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+zjiX7dOtnqO9UeNMZu2JA3zDMs2qfAVu5ZR9QhVnv0=;
        b=dMNdbp8yXgN2jZgRc+g9xhm6h+5Hz9peG9dc5EUqWUkArMH5wOkE6x+DecoO7PERS9
         nuWdKCbPYLknjDLEX2z7J+nN9cvd+bgJP02TJT6WFmuOXMlpH/EREcBJxXQIqUvxRZ5o
         DE48iuL2GJ1nHCTOB4413XM9b0xOG/Ed0XCqu9kowserZS2XqAUr1pboudfNUVelQB0r
         jv9wq1jt1fd+Q4Ss8aCqqDrAqMGzubgDihMxErwhMXqjjklKqslk6J6R6ODF1jETW1pD
         6AyyTqOcSLU/wV+/vgAtSB3TXXFnwVA8HQTKqvfR7NLJMuKZyVPu7Xm+GD6JIC4Av5gW
         QnVQ==
X-Gm-Message-State: APjAAAWcMnTsTaz57iTF4yh3Deo9pni3nqDpQzIAhitXmZ+5k/7D/jcH
        HcTKWedypsbbbagSvYmaeSI=
X-Google-Smtp-Source: APXvYqwElSqzB4gY7GckAYy0OVzp4EHhTGx2s6uK48eapKEdHYk0dNxiS3hOqbHk2ABjmw8QOXhDvA==
X-Received: by 2002:a17:902:6942:: with SMTP id k2mr41828274plt.136.1552431160955;
        Tue, 12 Mar 2019 15:52:40 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id i72sm27345363pfj.147.2019.03.12.15.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 15:52:40 -0700 (PDT)
Date:   Tue, 12 Mar 2019 15:52:36 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina3221) Add averaging mode support
Message-ID: <20190312225235.GA29097@Asurada-Nvidia.nvidia.com>
References: <20190312220431.26710-1-nicoleotsuka@gmail.com>
 <20190312223759.GA31590@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312223759.GA31590@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 03:37:59PM -0700, Guenter Roeck wrote:
> > +average                 Averaging mode. Supports the list of number of samples:
> > +                          1, 4, 16, 64, 128, 256, 512, 1024
> 
> This is the number of samples, so I think "samples" would be a better
> attribute name. This would also avoid confusion with other _average
> attributes.
> 
> I'll need to check with other chips if this is the best approach and
> name for the attribute, especially to see if it should be chip-wide
> or per sensor.

Will wait for that then. Another thing is that the conversion times
are also configurable. And I plan to use the update_interval in the
ABI once this average is added. This means that average value will
be changed via this 'average' node (or other name), and conversion
times will be changed via the 'update_interval' node by following
the formula: update_interval = channels * (vbus_ct + vsh_ct) * avg

> > +	for (i = 0; i < ARRAY_SIZE(ina3221_avg); i++)
> > +		if (ina3221_avg[i] == avg)
> > +			break;
> 
> Please use find_closest().

OK. Thanks
