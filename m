Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC7BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFBF217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="aIy+fvw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfCNL0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:26:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36253 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfCNL0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:26:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id d18so3956304lfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 04:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J50BQq7ZhBQEHG7nFspoFyJAV31HxzLMKmsJsbWcXwI=;
        b=aIy+fvw0q0puZiakhLKQgC6pow5tu8iNmEaeWRq6Jy2Kw9IFzguGM3inhzTG4IkJCD
         WJFEu5NHbUPGnH/MAbxxnL8WntqbKdVrmlNaTteG9U2aqSxMB5+UE52YRV+U8p+LTV2D
         VLWjS4a6HHsCI309FnCi9dOyWtdFwQwgdc5qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J50BQq7ZhBQEHG7nFspoFyJAV31HxzLMKmsJsbWcXwI=;
        b=F+6zrwF9GYtvFfoUABMJFpy9TQA2d2K3Lm4zP8bI63VMICSoEQR9K/pvf7klwD6ekl
         tn19MmVViNSi38xUzO8+nyr8GCFsUB4xLIvA8L3PE8zWOH1p+o1TH9p7YQNhfdPuYcfL
         7GWdCXm1XtNcEnC/xt2UlZZr5IRp5sV1HkZdddM33mvIAjUwZKlmtGXMDWsoBDx6Lm7O
         xBN/PD251jsyscI+GAchqfRA/YE4rE+tulBpT36SzjBOu3sagVUET9+wDjpqI0iU6MTx
         fbJvXELEf90JWEFw6mOrs6VEizFZl3xlBe4uA7N9jUCxbPNdivrc3q3DyW55g6uxyzlS
         qUTQ==
X-Gm-Message-State: APjAAAXiR9uMitqO2VcaEQzxewTdQVpKu9Qmv6Rd4K5LdNhHg8t2PCoP
        D3BqfKA9WJozOVvR2oTk+PlAyg==
X-Google-Smtp-Source: APXvYqzKgshN3qn8ruWKsuNri1E5ul92hxJ/FkSaXZh3Kys8EqFA0zMHqV3661KI9KCrd2RU/Td4sA==
X-Received: by 2002:ac2:533b:: with SMTP id f27mr6289027lfh.8.1552562800492;
        Thu, 14 Mar 2019 04:26:40 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 28sm2643341lfr.16.2019.03.14.04.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:26:39 -0700 (PDT)
Subject: Re: [PATCH 4/4] leds: netdev trigger: allow setting initial values in
 device tree
To:     Pavel Machek <pavel@ucw.cz>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-5-linux@rasmusvillemoes.dk>
 <20190314102911.GA15173@amd>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <6fb71b90-1ae3-9d93-6e0c-c95e441ced7a@rasmusvillemoes.dk>
Date:   Thu, 14 Mar 2019 12:26:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190314102911.GA15173@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2019 11.29, Pavel Machek wrote:
> On Wed 2019-03-13 21:26:15, Rasmus Villemoes wrote:
>> It can be quite convenient to initialize a netdev-triggered LED with a
>> device name and setting the rx,tx,link properties from device tree,
>> instead of having to do that in an init script in userspace.
>>
>> +                The optional child node netdev can be used to
>> +                configure initial values for the link, rx, tx and
>> +                device_name properties. For example, setting
>> +                linux,default-trigger = "netdev" and adding the child
>> +                node
>> +
>> +                netdev {
>> +                    rx;
>> +                    tx;
>> +                    link;
>> +                    device-name = "can0";
>> +                };
>> +
>> +                can be used to replace 'linux,default-trigger =
>> +                "can0-rxtx"' that relies on the deprecated
>> +                CONFIG_CAN_LEDS.
> 
> I'm sorry, but no, not like this. I see it works for you, only having
> single can device, but it would quickly break with two of them and two
> ethernets are rather common.
> 
> So this will need to be device = <&phandle_of_ethernet_device> or
> something like that. There may be example with usb port triggers.

Huh? I have two CAN devices, and there are two LEDs on the front panel
labeled CAN-A and CAN-B; my device tree nodes for that are

		cana {
			label = "cana:green:activity";
			gpios = <&gpio0 10 0>;
			default-state = "off";
			linux,default-trigger = "netdev";

			netdev {
				rx;
				tx;
				link;
				device-name = "can0";
			};
		};

		canb {
			label = "canb:green:activity";
			gpios = <&gpio0 5 0>;
			default-state = "off";
			linux,default-trigger = "netdev";

			netdev {
				rx;
				tx;
				link;
				device-name = "can1";
			};
		};

and this works just fine. The only change from the old DT is the
addition of the netdev nodes and changing linux,default-trigger from
"can0-rxtx", "can1-rxtx" to both "netdev".

Rasmus
