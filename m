Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB69FA3735
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0C82089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC7bB0Eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394646AbfJQNfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:35:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32787 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbfJQNfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:35:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so1162841pls.0;
        Thu, 17 Oct 2019 06:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HRZw0egH7e60E3YrLTW6KLeAvZRaV263GSPwsEpHnaQ=;
        b=PC7bB0Eu73Z6Uvaxmb6KnYDuSNuM2AN8soCupCW1kBQRAoQuiQ3XMxS58psBUAuNcV
         /3X00l4GDcqb/gR/pCOa0q9X/ZGHZAe/Q0S0tZR+TXiK3dDaRBKGdMUf5VnO5JuU1vwG
         9rNQMpsGcI0qA1EA1ytT15vLmbxNi7atUOOXveqw7NP4tPT/LEVreKz/CM/hS8kLubul
         hvBcWSjmDUCZhG0+lH+oyM7yrZYkbzUBI8/Vv08a+PBpamEuHCyqwE4ulz4V7P4Q9735
         HVvzenPVYP6Ox+XOfQfDgtG9yBq/ZeJBecofyVlHcYf8FG+TXoP2NgZ+hTnlUd9tIVCK
         P3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HRZw0egH7e60E3YrLTW6KLeAvZRaV263GSPwsEpHnaQ=;
        b=CqMZYDD8kxVnOslTgzIQbK9m5zmXZDTZ/ma5OmBTRKcTMOvjBCW9EB71o9UrVWmubN
         XYG8U1Xy7wsmuGcYc+iiBRdxkWnS5uHp9iXUGhiT5R1pvXnzImnIQKpPsPHcrNQTEVaX
         1n3cbsinCV/lNNlk49dtxUwzIWs5BHTxDhCMEYAeNMIeIqleCX/oJyJdpnCoDW0C7jn1
         xT9/YFUEx4kY5snAiC7OjnowBKTspSe0HYda7WeFVHG/VDs8f50Mhob3JoV+w9VJp/bz
         bjsc+4IP14p0P7+N+GCpGmK8zM5dQWaKFAD5xLU6s4VOxyMTbKFs9FzZrHMf7u0kRRYi
         5CbA==
X-Gm-Message-State: APjAAAUgEnrZn0VQnT+bIpgNsf/UPPJToZfUEChA7aUiESfokmURsx+6
        DnS+GdJMfnn8JPa8lyt/en4=
X-Google-Smtp-Source: APXvYqzKxMWca29yudpmBf6GNcF/KRjzO/VPH35/hY7SFgA8oom/+W+0wulxVNjq5ZegK536zz9QrQ==
X-Received: by 2002:a17:902:44d:: with SMTP id 71mr4092886ple.195.1571319351587;
        Thu, 17 Oct 2019 06:35:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p24sm5582476pgc.72.2019.10.17.06.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 06:35:51 -0700 (PDT)
Date:   Thu, 17 Oct 2019 06:35:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jdelvare@suse.com,
        mark.rutland@arm.com, robh+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Document ibm,cffps compatible
 string
Message-ID: <20191017133549.GA23352@roeck-us.net>
References: <1570648262-25383-1-git-send-email-eajames@linux.ibm.com>
 <1570648262-25383-2-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570648262-25383-2-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:11:01PM -0500, Eddie James wrote:
> Document this string that indicates that any version of the power supply
> may be connected. In this case, the driver must detect the version
> automatically.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt b/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
> index 1036f65..d9a2719 100644
> --- a/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
> +++ b/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
> @@ -5,6 +5,9 @@ Required properties:
>   - compatible				: Must be one of the following:
>  						"ibm,cffps1"
>  						"ibm,cffps2"
> +						or "ibm,cffps" if the system
> +						must support any version of the
> +						power supply
>   - reg = < I2C bus address >;		: Address of the power supply on the
>  					  I2C bus.
>  
