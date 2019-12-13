Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8922AC2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 02:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F86322527
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 02:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuRypg7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbfLMC22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 21:28:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36783 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbfLMC22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 21:28:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id x184so628881pfb.3;
        Thu, 12 Dec 2019 18:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kcY4vW7yllqEshMKzrDhyN2EOIzeLlx+C0/DdxIqz2w=;
        b=OuRypg7WPbgsbzXqMNFwelCuj1bgzo/QYm9qvCyeHDeSG+f2clYfeKpY+H4Ng0F9ku
         DVKXQ9WarAqA8E5RjIbWlCdPuRqvJ1TRi8ecCQ86R0hUr32kyJI236y5DEPQKmJhfOA8
         NY1Fv44SmqlJbQcQPG5aF3rr3iGunPN9ljFYq9oXNd8RR8QpEMcFi3YoOrd2pg15M2R+
         61v8gcdZ48p7e2O5olllSIFvWrA0EncrFIf0XWCdL98RbnCNNIJZ/hPCqYpg0elTNT1e
         36EcEnW6NpP+8Iq9NaeBvFE7LfyAkaM8Wjmm692FA6YwbVdFYYbqSXfo/6j5GskFsAVb
         EOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kcY4vW7yllqEshMKzrDhyN2EOIzeLlx+C0/DdxIqz2w=;
        b=r7h93iyYJ2CrLJefIA2eliiL7udZJeVGIhrfdIMDMkkokRbzamEMV1rCS81OnsHV7x
         OQwALzuTtd2YdSKdF5cyWCwqy0mRGnRGE8ioFBr8Akuo3YyLsOlk1rmOMJrnUe0LjCZp
         2+UWVfZTQ0Is9UsfcY+JFmTT84Ova7oWCpEt5U/jZ3V3CzWhD4wQSinGtIipvwTACgAE
         tTji+mtH7ZMPQQFBeo1qcyroOOBrQlZCVPnuerDWCGnk0yx7Fbo5n9J7J8unWSKLMhEy
         rxH896bam7qJ6uX5sYPn2bq578oLwS7AJLUVO9UvRMZR1FNvoMm++G9nRN05EpgGq6Gt
         VJsg==
X-Gm-Message-State: APjAAAUFrcJDbQSWPwNzV/WuWA0ZFwBzuROMaETHgez/85/kgsXtrDm3
        Kxr/WIrAWyyrCxAwn08stTU=
X-Google-Smtp-Source: APXvYqzL2g49YHLkzIDoFitpt9kzMoNUgeHsq4W26sk3QJBKz8DCP6Bguzk0Xv1mN9qlWR9Gaq/sdA==
X-Received: by 2002:a63:496:: with SMTP id 144mr14700508pge.207.1576204107508;
        Thu, 12 Dec 2019 18:28:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e10sm9014809pfm.3.2019.12.12.18.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 18:28:26 -0800 (PST)
Subject: Re: [ v2] hwmon: (pmbus) Add Wistron power supply pmbus driver
To:     Eddie James <eajames@linux.ibm.com>, Ben Pai <Ben_Pai@wistron.com>
Cc:     robh+dt@kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, corbet@lwn.net, wangat@tw.ibm.com,
        Andy_YF_Wang@wistron.com, Claire_Ku@wistron.com
References: <20191208134438.12925-1-Ben_Pai@wistron.com>
 <97651ec9-e467-dbd9-dcb8-b3efe1387fef@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c5d72bfe-0ebc-5d9a-ebad-092ff802cc5c@roeck-us.net>
Date:   Thu, 12 Dec 2019 18:28:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <97651ec9-e467-dbd9-dcb8-b3efe1387fef@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 3:54 PM, Eddie James wrote:
> 
> On 12/8/19 7:44 AM, Ben Pai wrote:
>> Add the driver to monitor Wisreon power supplies with hwmon over pmbus.
> 
> 
> Hi Ben.
> 
> 
> This driver looks very similar to the IBM CFFPS driver. If you think they are similar enough, you may want to simply add a new version to that driver that supports your PSU.
> 

It would be nice to have datasheets for those power supplies.

Eddie - is it possible that the IBM power supply supports the WRITE_PROTECT
command and has a write protect bit set ? If yes, I just submitted a patch
for the PMBus core to address the situation; see
https://patchwork.kernel.org/patch/11289717/

Thanks,
Guenter
