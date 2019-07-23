Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A10C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207C121955
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL1hJknP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732095AbfGWB4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 21:56:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35704 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbfGWB4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 21:56:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so19939268plp.2;
        Mon, 22 Jul 2019 18:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zdeVjAmSrferDd7T8hxsXdL0gr4l2xZ9zqxhMuU3IN4=;
        b=DL1hJknP7dOl9CjvZmvtrrFSLoqcpqlmYiN2kZoCeny4znXR65bo8ivkfAHSiRM8Io
         ciV5lejw6TLu5OncuR3jGwZHKmjXVnQpbP2HlGNCp5/18DPVq0rEGMRIk7NYUXKy9SQz
         AE359Z3Ib+/HgL9RChLa4wN7g0Vmm3Ubqrjglfe5yCw7/Y4pGBbi5JwE9SQD6McdFs/Y
         hdWQVG5eWZWRRNYC/wR0Z8IrBVFFuB8XzTj1CdTuQ/Wq0aynAWQ8W2wPHvlMahAq6O74
         ESiKZsWT+vZH5vvL2fcLwpdekXs87EFTsfQkYJmbOPZc2f1wPEgwIucBUAyT7rABq7sx
         WjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zdeVjAmSrferDd7T8hxsXdL0gr4l2xZ9zqxhMuU3IN4=;
        b=YfPZeZG24pGtObB/mZN5zZkf/uojQL6csCexQ/LaAAteX5GDu3f0iVDvRHjUTHzEaV
         W6HxZ/6e/lrb7S0kI9NslUlgwVFuWcf6Z5SEL0MzqwojyuGJrvyLx+qzhvfXQ8f6Aa1l
         PLT6UIAALf0MJsCi10fJ1kU/4sSFibnYvtNu5eXggq91XUbpEdtPuAgYNMJyUowoU5RY
         EKymcM6D9W668VDJcYbaikmmdpWvQkhS9nONOg5YdFAWoNVOWjhO4XpB9ADzKg3bzhzY
         7PyPyKeI8f/eL7ePxwmmNhx7L2BPp/IB6f5zuq5qmeVwoLIVT8RONbrVB8Ha4xdF/KEK
         Uk2w==
X-Gm-Message-State: APjAAAUAZe4/tHRZXuQFjEuhX0jWbSq4L7lS1Tfu/Dy+5r8N5Zgu00Kq
        SLconY4po7Tm9VMDs3jmWPw=
X-Google-Smtp-Source: APXvYqzKhsXfltpbJVJRV5E8B+0BKmnIOshdtuCdiVOvUrS5QqQf/Dmwvk82qizj9HvksQeH3+gOmg==
X-Received: by 2002:a17:902:44f:: with SMTP id 73mr78998934ple.192.1563846976747;
        Mon, 22 Jul 2019 18:56:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s11sm12752287pgc.78.2019.07.22.18.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 18:56:15 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: hwmon: Add binding for pxe1610
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>
References: <20190722192451.1947348-1-vijaykhemka@fb.com>
 <20190722192451.1947348-2-vijaykhemka@fb.com>
 <20190722200622.GA20435@roeck-us.net>
 <6E2B35D8-B538-4C96-B289-27A87ECD74DB@fb.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d3137d6b-8bf8-4da6-9da7-a42b8bc68fbd@roeck-us.net>
Date:   Mon, 22 Jul 2019 18:56:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6E2B35D8-B538-4C96-B289-27A87ECD74DB@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/19 5:12 PM, Vijay Khemka wrote:
> 
> 
> ﻿On 7/22/19, 1:06 PM, "Guenter Roeck" <groeck7@gmail.com on behalf of linux@roeck-us.net> wrote:
> 
>      On Mon, Jul 22, 2019 at 12:24:48PM -0700, Vijay Khemka wrote:
>      > Added new DT binding document for Infineon PXE1610 devices.
>      >
>      > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
>      > ---
>      >  .../devicetree/bindings/hwmon/pxe1610.txt         | 15 +++++++++++++++
>      >  1 file changed, 15 insertions(+)
>      >  create mode 100644 Documentation/devicetree/bindings/hwmon/pxe1610.txt
>      >
>      > diff --git a/Documentation/devicetree/bindings/hwmon/pxe1610.txt b/Documentation/devicetree/bindings/hwmon/pxe1610.txt
>      > new file mode 100644
>      > index 000000000000..635daf4955db
>      > --- /dev/null
>      > +++ b/Documentation/devicetree/bindings/hwmon/pxe1610.txt
>      > @@ -0,0 +1,15 @@
>      > +pxe1610 properties
>      > +
>      > +Required properties:
>      > +- compatible: Must be one of the following:
>      > +	- "infineon,pxe1610" for pxe1610
>      > +	- "infineon,pxe1110" for pxe1610
>      > +	- "infineon,pxm1310" for pxm1310
>      > +- reg: I2C address
>      > +
>      > +Example:
>      > +
>      > +vr@48 {
>      > +	compatible = "infineon,pxe1610";
>      > +	reg = <0x48>;
>      > +};
>      
>      Wouldn't it be better to add this to
>      ./Documentation/devicetree/bindings/trivial-devices.txt ?
> Sure, I didn't know about this file. I will add and send another patch. It is
> Documentation/devicetree/bindings/trivial-devices.yaml. How do I abandon
> this patch or just leave it.
>      

When you send v2, just add the device to the trivial-devices file instead
and describe the differences to v1 (ie this patch).

Guenter

