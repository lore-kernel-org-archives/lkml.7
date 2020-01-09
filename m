Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5496C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CFF2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pw7J7O2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAIXFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 18:05:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30311 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727749AbgAIXFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578611122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFx45qTHz2JY0wspr7jk/iJLUduDK6Lhpsf8cM21O3Y=;
        b=Pw7J7O2fAaNYQBodaVE1EAG1FH6m9fdhHzRsUT09vj4IXWr3eyi/ilP/f5k3gr0P9jCs6X
        ng/nu05yz1GpwTzpxBQTIUFdK+w/5CmWiYwR0g4gjKJ+ycDNj+Uivj3mdyTKzc1CLOalBA
        LlKGJNqhIPpS9ZFEG9gpzYcMIc2jJqY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-2BVTDAdGN0-ysn2gKckTgw-1; Thu, 09 Jan 2020 18:05:15 -0500
X-MC-Unique: 2BVTDAdGN0-ysn2gKckTgw-1
Received: by mail-wr1-f71.google.com with SMTP id t3so27697wrm.23
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 15:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AFx45qTHz2JY0wspr7jk/iJLUduDK6Lhpsf8cM21O3Y=;
        b=ti4exzkDMdAOxN0003p1uxVRb+WGatewhLLPJnheJMgGHRmOFNu4c0eZNEaEXGQTqu
         LcabTbiOTXmOnTB+r7TqpxsHwgoD4kYVC5icoO2jgXDE4/aLhz7kXdi7mHHCoFwuanq3
         QzEUlzvmjgiBmiQ2uHHUelnfOC09amQbNRjqdtn0zmaSylqpJq20pdpciNgDZyqPCgVd
         afq8FjK+zo9h2zcKaTLFxJ4a2exTeAfBx/U7PKOezg+qjRK/0xriQbandgacJu+NJRa4
         iQ3tKoF6HVf25dnJAFplyRXuzQFj8NWIVpF6iq0AqJlnzl7DXXSSg6ZUBMuCePvssYp1
         uB8Q==
X-Gm-Message-State: APjAAAWqeC28CvQCmMMZrccu8cohvU4Mb/qOIiayCd1ci/5hkwvHV6YD
        DrWPdiEGhM9IEv7ZpM425JED1QQbx40XgSbKdQNSJP49E0XeaSi0GLeqHlfqHbxHUhvo0jFW5Mw
        wN1uzzyZEMfdn51LbUsKNi4qu
X-Received: by 2002:a5d:6ac2:: with SMTP id u2mr143469wrw.233.1578611113486;
        Thu, 09 Jan 2020 15:05:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvmhmMIsJeHkV1pqi8jbcQ5VJx686EjDVgH5CmJHOxiPWH4poWMludQqTFWKdndzLMlbxrLA==
X-Received: by 2002:a5d:6ac2:: with SMTP id u2mr143460wrw.233.1578611113237;
        Thu, 09 Jan 2020 15:05:13 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id r15sm90261wmh.21.2020.01.09.15.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 15:05:12 -0800 (PST)
Subject: Re: [PATCH 01/12] i2c: cht-wc: convert to use i2c_new_client_device()
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
 <20200107174748.9616-2-wsa+renesas@sang-engineering.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6e267f65-5884-c0d1-fecc-9d21ce7336a3@redhat.com>
Date:   Fri, 10 Jan 2020 00:05:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200107174748.9616-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07-01-2020 18:47, Wolfram Sang wrote:
> Move away from the deprecated API and return the shiny new ERRPTR where
> useful.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com> > ---
> Build tested only.

I've given this a quick test spin on hw which uses this drivers,
I've not noticed any regressions:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Also the changes look good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> 
>   drivers/i2c/busses/i2c-cht-wc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
> index b8fde61bb5d8..35e55feda763 100644
> --- a/drivers/i2c/busses/i2c-cht-wc.c
> +++ b/drivers/i2c/busses/i2c-cht-wc.c
> @@ -388,9 +388,9 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
>   	 */
>   	if (acpi_dev_present("INT33FE", NULL, -1)) {
>   		board_info.irq = adap->client_irq;
> -		adap->client = i2c_new_device(&adap->adapter, &board_info);
> -		if (!adap->client) {
> -			ret = -ENOMEM;
> +		adap->client = i2c_new_client_device(&adap->adapter, &board_info);
> +		if (IS_ERR(adap->client)) {
> +			ret = PTR_ERR(adap->client);
>   			goto del_adapter;
>   		}
>   	}
> 

