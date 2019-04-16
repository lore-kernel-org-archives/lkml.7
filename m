Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85761C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F3E204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pplIFn2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfDPPyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:54:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44268 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDPPyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:54:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id g12so10524509pll.11;
        Tue, 16 Apr 2019 08:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QjNwgTzj2VLh0qcoo831Db9PNBzQdanF0bYhx8TMj20=;
        b=pplIFn2StKe7LmwD488tABselbryFRQLxtwYY6QJ7O7lHgXIAHnXX+DEZ7lYcIUGX1
         WiSpulf7ChEayBMEubbcLei+p1GLzcy2PJEtxOcVAwq9RU3kR4EKa+Xg8snT/WPK5CYn
         +scNcH3EZxrcJ3WNIVW2BszDDwiAjdnTAPSw/+iQ2qztijE3nFTDsG6u4+I43G3dT0K3
         3qqbm2ZgJp3WdAF66DAjyQ2lvP6rpXc+2McwRy8sRav/UlsTiJhwA5DaVWDyIPK07W+a
         vocHmG/uzXyWvnF3kd4JsI3cMQ4xba9x+uSBxRwDE6GK9BQ1dCSsdsDAxGvX+ouDTNQX
         OlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QjNwgTzj2VLh0qcoo831Db9PNBzQdanF0bYhx8TMj20=;
        b=hAt+tIVyGAhty5NVEYn9SMfUpo+9oEv6u045mkN8Jfvpl7X9FQ+Fxv7S9cZEptiStR
         F7ATYO6c7BPk8RN2ToGmlGRQuCtakK0/IwoK5bavVsbWZFsRdpH9PiFKjyDsOjYhgKwk
         GsxUSVEQnp0bZrF8Su4uM4vJKWDy80UJg1rqn9DjWUkS9UbgXjqwYJ+M5aFpI4rxp7TF
         dnMBUsOhZVPcB/xAsBUzVkW7/6FssnEzUWeBIcqI3E4i5+je2f735/lfvH3+mgVMj8F1
         HvuLajgKXeE1fzfRjGP1Vapxp3u8EPx1D3rny1vHFv0vM9quMDKVtXKNV93XUFmk4CLN
         lAfA==
X-Gm-Message-State: APjAAAVq83AZGpkTDrnsihpRcS/PEfoZtg6PU6Y6RfdpdwI8X6zNWtkY
        A2AxmT+Giw3y6ePppoXc6GQ=
X-Google-Smtp-Source: APXvYqyUhOkNjJ8aWn/owSQr4AuPI1zwlWwO7fCUegu+YbPAdJjIlFAbY0dKRk6uRodFl3cunRF1NA==
X-Received: by 2002:a17:902:bd4b:: with SMTP id b11mr46585134plx.68.1555430062623;
        Tue, 16 Apr 2019 08:54:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s20sm71511950pgs.39.2019.04.16.08.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 08:54:20 -0700 (PDT)
Date:   Tue, 16 Apr 2019 08:54:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Patrick Venture <venture@google.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, trivial@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Add ir38064 as a trivial device
Message-ID: <20190416155419.GA8871@roeck-us.net>
References: <20190416154138.124734-1-venture@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416154138.124734-1-venture@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 08:41:38AM -0700, Patrick Venture wrote:
> The ir38064 is a voltage regulator from Infineon.
> 
> Signed-off-by: Patrick Venture <venture@google.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index d79fb22bde39..92184ef0db2e 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -92,6 +92,8 @@ properties:
>            - fsl,sgtl5000
>              # G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
>            - gmt,g751
> +            # Infineon IR38064 Voltage Regulator
> +          - infineon,ir38064
>              # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
>            - infineon,slb9635tt
>              # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
