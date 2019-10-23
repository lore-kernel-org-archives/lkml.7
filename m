Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8E7CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6659E20663
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv70QZPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406026AbfJWNoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:44:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40168 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390619AbfJWNon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:44:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so12974094pfb.7;
        Wed, 23 Oct 2019 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bqtujpqNbAQZJihzkVcd83j8KH7ymy87CfXaLggRLzI=;
        b=gv70QZPxr2QwDImicOJ1btC3vgXVITVLotvnT607VxEd8XS3mo/bGtx97d/jSuVlbr
         dyknHxENLL/MOdE0rdHVwQVdcdbhcN3/Yi02vJHWZsVEyNMShMjGeH2gqeLtICIPKWvK
         qbVr+84wC5WFR7qEq6t998irZjaFIzwMFTSQWY8TYE3zrUYVfuami09BD7Y8xpGyOfvy
         b/rbasGj/axsSZt02719YmCyf0EqBJi+sx+ZeOzpRnkxnnX6J7CW2kamhYMCQQtifDkD
         jiZrVeHyyOEsCdBaboc2bfyys/BRD0UaTASvn/ktI4dc2JDrFsFqHg/cMfi/7sS7v84b
         HVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bqtujpqNbAQZJihzkVcd83j8KH7ymy87CfXaLggRLzI=;
        b=J96CzqDuln15H4a86c8VE+UayOxIipl9Dbw9P/jT5TmdLt4/WBjv1tlEpZZb3lamWN
         C2zrwPRHLkTHVwxbv31kZ/k1P7Qpc09GyAGOyuj4XjkwoPz303uHxWoEBmactzDJauDD
         4PvJjp/0zDNczD/CPfSTs1mk3z/X4Z5y+LCCBZoprOZKxIMHUmD7ksIFfRWCq5BJVza1
         5uO00ELokeRmw2yLCkzNmVVzhZX6tFbdu/Zy9SGtY9u+ITeaSSZIw020Lgn1n2gOGSk5
         P3Lo5YL843OsubQhO1nf/Ns9sDsDqAC9ZUXpXuQNUwsgFP/QPNm6lGLtz8PTRTp7DOW+
         mJaw==
X-Gm-Message-State: APjAAAWiVq3K9gA6yTEtGJdLs9TRgQmJjEpTeVMfBRW5raHWuPUczwi8
        GLhn06oeJyGS3B0NC7lhvjX+HYUz
X-Google-Smtp-Source: APXvYqz4CGQL2G6j+rGwttfWxPjzpe667CQOGCSti7mkoDtHvcYAlhF1fK0vri6y+Q+kUEkfwqg90w==
X-Received: by 2002:a63:7845:: with SMTP id t66mr9987694pgc.31.1571838282149;
        Wed, 23 Oct 2019 06:44:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c9sm4026398pfb.114.2019.10.23.06.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 06:44:41 -0700 (PDT)
Subject: Re: [PATCH V2] usb: typec: Add sysfs node to show connector
 orientation
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Puma Hsu <pumahsu@google.com>
Cc:     gregkh@linuxfoundation.org, badhri@google.com, kyletso@google.com,
        albertccwang@google.com, rickyniu@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191022085924.92783-1-pumahsu@google.com>
 <20191023083221.GB8828@kuha.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <644d890b-86e8-f05a-cd4c-32937d971a45@roeck-us.net>
Date:   Wed, 23 Oct 2019 06:44:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191023083221.GB8828@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/19 1:32 AM, Heikki Krogerus wrote:
> +Guenter
> 
> On Tue, Oct 22, 2019 at 04:59:24PM +0800, Puma Hsu wrote:
>> Export the Type-C connector orientation so that user space
>> can get this information.
>>
>> Signed-off-by: Puma Hsu <pumahsu@google.com>
>> ---
>>   Documentation/ABI/testing/sysfs-class-typec | 11 +++++++++++
>>   drivers/usb/typec/class.c                   | 18 ++++++++++++++++++
>>   2 files changed, 29 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
>> index d7647b258c3c..b22f71801671 100644
>> --- a/Documentation/ABI/testing/sysfs-class-typec
>> +++ b/Documentation/ABI/testing/sysfs-class-typec
>> @@ -108,6 +108,17 @@ Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>   Description:
>>   		Revision number of the supported USB Type-C specification.
>>   
>> +What:		/sys/class/typec/<port>/connector_orientation
>> +Date:		October 2019
>> +Contact:	Puma Hsu <pumahsu@google.com>
>> +Description:
>> +		Indicates which typec connector orientation is configured now.
>> +		cc1 is defined as "normal" and cc2 is defined as "reversed".
>> +
>> +		Valid value:
>> +		- unknown (nothing configured)
> 
> "unknown" means we do not know the orientation.
> 
>> +		- normal (configured in cc1 side)
>> +		- reversed (configured in cc2 side)
> 
> Guenter, do you think "connector_orientation" OK. I proposed it, but
> I'm now wondering if something like "polarity" would be better?
> 

Yes, or just "orientation". I don't see the value in the "connector_" prefix.
I also wonder if "unknown" is really correct. Is it really unknown, or
does it mean that the port is disconnected ?

Guenter

>>   USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
>>   
>> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
>> index 94a3eda62add..911d06676aeb 100644
>> --- a/drivers/usb/typec/class.c
>> +++ b/drivers/usb/typec/class.c >> @@ -1245,6 +1245,23 @@ static ssize_t usb_power_delivery_revision_show(struct device *dev,
>>   }
>>   static DEVICE_ATTR_RO(usb_power_delivery_revision);
>>   
>> +static const char * const typec_connector_orientation[] = {
>> +	[TYPEC_ORIENTATION_NONE]		= "unknown",
>> +	[TYPEC_ORIENTATION_NORMAL]		= "normal",
>> +	[TYPEC_ORIENTATION_REVERSE]		= "reversed",
>> +};
>> +
>> +static ssize_t connector_orientation_show(struct device *dev,
>> +						struct device_attribute *attr,
>> +						char *buf)
>> +{
>> +	struct typec_port *p = to_typec_port(dev);
>> +
>> +	return sprintf(buf, "%s\n",
>> +		       typec_connector_orientation[p->orientation]);
>> +}
>> +static DEVICE_ATTR_RO(connector_orientation);
>> +
>>   static struct attribute *typec_attrs[] = {
>>   	&dev_attr_data_role.attr,
>>   	&dev_attr_power_operation_mode.attr,
>> @@ -1255,6 +1272,7 @@ static struct attribute *typec_attrs[] = {
>>   	&dev_attr_usb_typec_revision.attr,
>>   	&dev_attr_vconn_source.attr,
>>   	&dev_attr_port_type.attr,
>> +	&dev_attr_connector_orientation.attr,
>>   	NULL,
>>   };
>>   ATTRIBUTE_GROUPS(typec);
> 
> thanks,
> 

