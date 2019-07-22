Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3B6C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D170D218C9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8HWUQlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbfGVUGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 16:06:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36082 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfGVUGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:06:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so17894953pfl.3;
        Mon, 22 Jul 2019 13:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dc1nDbjKpnpP+a+/MmVe5NpW+Or0aQ+dHKZXZgx9JfE=;
        b=b8HWUQlFI4Bi3Vsm9h3pIL1BtPQ+jCsskWoS3LtjbQqMzNMt/ByjHN8SUdmCg4wCvg
         56aMy7KRNlT5Nyv+O+oWRkgwIWjVJ2hfQ7yczoZweGJLJbOe914LSiJsaHRGx1lr1FEp
         kC9Nx9QUUS8SrXKa1bvAwrbSDDSaqBTJf3vN7+Y9D1MKF5fnMwXNinoN/Q6WIk6TAK31
         Oyh8D5d5wUR/yIWMJzLhxnW5kMJ8eC5r+RY7gIrkOtwVc9IcKgB7bzqnOE/g1m/CMBl4
         rX5e6DeeEXM4oGUG5qWj0EvzUlLdkjOqwsn9BvkYvFtenYXanekOBprQdaWBcQktjGdG
         EBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dc1nDbjKpnpP+a+/MmVe5NpW+Or0aQ+dHKZXZgx9JfE=;
        b=ny9IQVkApLwXVLRZ7sjniX07lKNC1O+1aYoClk1CxWOP6zuTz+9AOdBCpQ1OHYCfe0
         l0QEc3yE4N86rza6u9DjJkRVsGSlt+AjkAyTDNRPhwdZfRvMJREGIUcQRTu+tpHta98K
         jq2V8NYyywUdap3GIhwXp4v0n0RIMrBWfTJGChWn+HHguWomPvGULBwVL3Vw/v7pqBrX
         342ewQDSaCL1jxRnGiLYRobrLFTAxII8h6wWdOkDcDziE8dMqKe5yB343mg+ujP/A7Ib
         e3LcU8k4KgddwLLQvxoHF9BBc9/HBFU5kaofqPD33XVYyqiwtwBY/o4Ye8icGpQCJarB
         dcfw==
X-Gm-Message-State: APjAAAVGWjlnMHbe8emA2XFs2qnU3EJ1pNW6VlFK+S7/DBVaWHsqOn3I
        vqw56uIHwbhOwJmUgUx2QH0=
X-Google-Smtp-Source: APXvYqwrrfr8vZZ2zi0ljFQ1dG1N1h86xfW6V0hOrIDJx0pWBHs5P2AHff6cpF9shtD3j/eNTJY0qA==
X-Received: by 2002:a63:1046:: with SMTP id 6mr75083719pgq.111.1563825984205;
        Mon, 22 Jul 2019 13:06:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b26sm44559517pfo.129.2019.07.22.13.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 13:06:23 -0700 (PDT)
Date:   Mon, 22 Jul 2019 13:06:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        sdasari@fb.com
Subject: Re: [PATCH] dt-bindings: hwmon: Add binding for pxe1610
Message-ID: <20190722200622.GA20435@roeck-us.net>
References: <20190722192451.1947348-1-vijaykhemka@fb.com>
 <20190722192451.1947348-2-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722192451.1947348-2-vijaykhemka@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 12:24:48PM -0700, Vijay Khemka wrote:
> Added new DT binding document for Infineon PXE1610 devices.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  .../devicetree/bindings/hwmon/pxe1610.txt         | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pxe1610.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pxe1610.txt b/Documentation/devicetree/bindings/hwmon/pxe1610.txt
> new file mode 100644
> index 000000000000..635daf4955db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/pxe1610.txt
> @@ -0,0 +1,15 @@
> +pxe1610 properties
> +
> +Required properties:
> +- compatible: Must be one of the following:
> +	- "infineon,pxe1610" for pxe1610
> +	- "infineon,pxe1110" for pxe1610
> +	- "infineon,pxm1310" for pxm1310
> +- reg: I2C address
> +
> +Example:
> +
> +vr@48 {
> +	compatible = "infineon,pxe1610";
> +	reg = <0x48>;
> +};

Wouldn't it be better to add this to
./Documentation/devicetree/bindings/trivial-devices.txt ?

Thanks,
Guenter
