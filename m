Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE47AC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 02:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25D620B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 02:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXAUC0Vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfHSC4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 22:56:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33893 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfHSC4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 22:56:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so290900pgc.1;
        Sun, 18 Aug 2019 19:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8KUldHqdiyJfIYKI91smI3BWWSLCesS4OFhanXdAB/8=;
        b=sXAUC0VsPZ95/x3N+AJoCZaVM9xS1RsBjh1x32rDiJer2EZDEL5FRDXLQhowUIipwZ
         Ol7LpEgSmYsZX0Q1AC9+esB45wtPow6MUvTI4jY0xqpwXhSDP6M6NxiMMYKpM5/JyUz4
         nWFYnzpGn8T6XgEfyJZwQzwQry8qtUrCRlvBXvqCdjqU8pxHdxS1DbbMDFhwTazG78Y9
         25Uo7881pnKWUgzPR9qqHMFInYdW0si0OmvnNnm63a94a6bTX4IIyn4AL6QTebL+9J+Q
         cmcBhbRNrnhYphMBq7LvfyBfMtZOE82vkXXiVOhQ56qZOpZSLavb3O0lf8sFz3hTlUob
         LLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8KUldHqdiyJfIYKI91smI3BWWSLCesS4OFhanXdAB/8=;
        b=QZ9COTh+vCpgy5V/aG9PBqOSEADWXQMwa5E7KuPwtQdsHSIrpPJU/wc7QooB02r3AM
         nC+XHwXtFcoxwgN9LOKo460hOwoRSvE7dMuTrCr/KI2tp4XanacQTz3/s7XzT1NzZUFw
         B6FYyt/B3qGchrnC9YIcgZreeKGDopk+0Oe/LF4Jyf/d8kyFlFIvwXz2RZ/BxWs8kvCY
         fP3n14mMTJGefgDeHgfJuQG5BVJegRwNxQaEgYkNoVE3VuxWZPOm3QqqkGjvqAPb4Wib
         2K9nsvM1ch92NsAQ10Ml6USXz43oB0+vknjYcPuqS7Ij0nSd3qmwDYinY/tYpKIHX5kz
         toTQ==
X-Gm-Message-State: APjAAAWX1vpFc4Mmr/S7WAZkPNVEcSG4H/XXcd0kafOewrGj0Ny6hYrL
        TJQUFxB2z42aGNbdWNSHKTA=
X-Google-Smtp-Source: APXvYqzdebKbzf683EonE73ov8DQqsTH4NZnIqlhEvoNm5ygQFU9oeZxDW4BBWxfXZGqHc12vT2ubQ==
X-Received: by 2002:a63:595d:: with SMTP id j29mr18224659pgm.134.1566183409576;
        Sun, 18 Aug 2019 19:56:49 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id s72sm16976535pgc.92.2019.08.18.19.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 19:56:48 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] hwmon: pmbus: Add Inspur Power System power supply
 driver
To:     Joel Stanley <joel@jms.id.au>, John Wang <wangzqbj@inspur.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        duanzhijia01@inspur.com, Lei YU <mine260309@gmail.com>
References: <20190816101944.3586-1-wangzqbj@inspur.com>
 <CACPK8XegTePdmykMzZHnW=g6hyEGr7jiW3TP8AvdzSwZGr=2gA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8c6a287f-49f0-bb36-71d0-2bce8eb19ff9@roeck-us.net>
Date:   Sun, 18 Aug 2019 19:56:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XegTePdmykMzZHnW=g6hyEGr7jiW3TP8AvdzSwZGr=2gA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/19 7:20 PM, Joel Stanley wrote:
> On Fri, 16 Aug 2019 at 10:19, John Wang <wangzqbj@inspur.com> wrote:
>>
>> Add the driver to monitor Inspur Power System power supplies
>> with hwmon over pmbus.
>>
>> This driver adds sysfs attributes for additional power supply data,
>> including vendor, model, part_number, serial number,
>> firmware revision, hardware revision, and psu mode(active/standby).
>>
>> Signed-off-by: John Wang <wangzqbj@inspur.com>
> 
>> +static const struct i2c_device_id ipsps_id[] = {
>> +       { "inspur_ipsps1", 0 },
> 
> Convention would be to use "ipsps" here, instead of "vendor_device"?

ipsps1, but good catch.

>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, ipsps_id);
>> +
>> +static const struct of_device_id ipsps_of_match[] = {
>> +       { .compatible = "inspur,ipsps1" },
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(of, ipsps_of_match);
> 
> Do we need the of match table? I thought the match on the device name
> from the i2c table would be enough. I will defer to Guenter here
> though.
> 

Strictly speaking it is unnecessary, but it is kind of customary to have it.
The automatic detection also only works if the i2c device ID would be "ipsps1",
without vendor ID embedded.

I would recomment to have both, but name the i2c device "ipsps1" as you suggested,
for consistency.

I'll also have to check if we need of_match_ptr below in the assignment of
of_match_table. Probably not, but it would save a few bytes if CONFIG_OF
is not enabled.

Thanks,
Guenter


> Assuming the device tables are okay:
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> Cheers,
> 
> Joel
> 
>> +
>> +static struct i2c_driver ipsps_driver = {
>> +       .driver = {
>> +               .name = "inspur-ipsps",
>> +               .of_match_table = ipsps_of_match,
>> +       },
>> +       .probe = ipsps_probe,
>> +       .remove = pmbus_do_remove,
>> +       .id_table = ipsps_id,
>> +};
> 

