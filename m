Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75FEC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1DF20706
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8swaD0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfLFOjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:39:45 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44742 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfLFOjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:39:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id d199so3432962pfd.11;
        Fri, 06 Dec 2019 06:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=irYNqKPLHshq/aQvOEy9WqNzGmfWQrAlrNW/wTAkb1U=;
        b=I8swaD0/efsTUzN0rwN5fqcT2d0qBUB+9t5phKehvb58plhMdhclYqff6QDdCqAknw
         Co/U+RxCxpNkCZ+3u9MkhvYFF+xdatN2uIRygf8GFvra9yrIm+k//cKsYRdL4TFYPgLb
         CmBXbvT9AzX2TPTlo8aVpCWJlC6iMPQL6KCKnbXWFCT6rbhtUVlkOTfeDM7ap/0Y0t10
         ZmdChr0BqNX1XD78SQy2wBkwH7e9ZRs9sf2oLZD/ROPwOrv9ms5VwiMWIkYLsC/Mrh3P
         eWRfEMtFmLV1QTxSlp9RT5QKqBDOvquXAFZGAvW/tFEWOsPUxx2qsMbsHmOP2PrlN+FW
         YTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=irYNqKPLHshq/aQvOEy9WqNzGmfWQrAlrNW/wTAkb1U=;
        b=QKHHzg66JDzx5A1mivFi25+05XcRzMRzc5AYrdnO7S37G2Vjp9tS7Vw9JCmj5UIB/q
         CN4RnBiWEpEbKcVwAKX4eVH7GFPd3Feg0rPXTD88D4SE+sSyfEMfyDve+uF5PPor09oE
         F/WV+6I5yPM0V0UwIUghT+OjcUvHPPeL+vFfHO4ykhZXU0gf3BWXMkwtVTsBNXA5pd1A
         0qusB10S/tbL4RLAZwT73zeS8ZFBvQe+WS/p5hi1T8agR9D/9c2Hkd8vzD1t/Qv3hhcL
         bt50RDnI7oRDliTUHXIFwyVpUeHVbE2ArozZERrFv2JJJVOOllyHPcEbGlqpsCWS5GsR
         9baQ==
X-Gm-Message-State: APjAAAU5uQ3PaIv5hx3gfdLH65p0LurDoTdIQcVOQVfC5woXmSkWaUog
        hSfqe7a+nZrgyO9dl71l58JC+xry
X-Google-Smtp-Source: APXvYqzCiYipDLDiHc06A/YWriJlXA+sFvNuqJij2Yu0x2xReX9LY6An4j/v1bgWMkItMfwztVwhdw==
X-Received: by 2002:a63:c207:: with SMTP id b7mr3853777pgd.422.1575643183855;
        Fri, 06 Dec 2019 06:39:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e11sm15791532pgh.54.2019.12.06.06.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 06:39:43 -0800 (PST)
Subject: Re: [PATCH v2 0/2] hwmon: Add UCD90320 power sequencer chip
To:     Jim Wright <wrightj@linux.vnet.ibm.com>, jdelvare@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191205232411.21492-1-wrightj@linux.vnet.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <955b4485-aaa4-a255-752e-5ae336e9130f@roeck-us.net>
Date:   Fri, 6 Dec 2019 06:39:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191205232411.21492-1-wrightj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/19 3:24 PM, Jim Wright wrote:
> Add support for TI UCD90320 power sequencer chip.
> 
> Changes since v1:
> - Device tree bindings text file replaced with YAML schema.
> - Device driver files are unchanged.
> 
> Jim Wright (2):
>    dt-bindings: hwmon/pmbus: Add ti,ucd90320 power sequencer
>    hwmon: Add support for UCD90320 Power Sequencer
> 
>   .../bindings/hwmon/pmbus/ti,ucd90320.yaml     | 45 +++++++++++++++++++
>   Documentation/hwmon/ucd9000.rst               | 12 ++++-
>   drivers/hwmon/pmbus/Kconfig                   |  6 +--
>   drivers/hwmon/pmbus/ucd9000.c                 | 39 +++++++++++-----
>   4 files changed, 85 insertions(+), 17 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
> 
Series applied to hwmon-next.

Thanks,
Guenter

