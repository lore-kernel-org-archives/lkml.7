Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B103BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEB22087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552343191;
	bh=LbfdkPZG+MsyY5eaWj30/YXSWStVRPcEnMyHmAZpsLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ynXnSNmSXEZmLxVhR0zqd0Dmax6T0LYviblaOMac9iuSQcZZoxTc4KyCuHwnD/wmt
	 XA2LOw2GY5uLxkOqh1pv3+dSC9TGem96czq3uit0I4zGqEgDoFDzB26JVch0JKRpHv
	 gFR4SPlQXpr0b+lY+OAdJgbDcBilA68O8mWiyzyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfCKW03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:26:29 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33424 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfCKW02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:26:28 -0400
Received: by mail-oi1-f193.google.com with SMTP id z14so489959oid.0;
        Mon, 11 Mar 2019 15:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aBZLUd4hpubjdvlFEYkQ1ouWUmfNmrO8MxfGM+7n9TY=;
        b=cGqumrwwrxKPX2RRydn/5VutQ/UzrXf8VOXkkZoKKMQOcS9YxnUHtg1G8zNFvzsxQm
         LjxVtDaIf2F8ujbX7ymv68iqsrqCFZFVDYI8cBSSFyQXVJ4ht9X/CG/aMFfzp3IMoaqp
         EfaltRXYo7BT7/SgB9L6+Czi8U0GuOT0IS8leosjij4BAHV0VqWVaS06JokYCrHOWWh1
         V8hqNoQTRYun47tnPvE7QJ6fPiIWqnzGUNWfziDj5baLRyIn31B+9FgDv+4fTRgUwolW
         lbeqAOIFcI+W5kVAnZ6ZbsFrdxnVsIIl8OSMSDDXb2CFKKkLfhMJA17kqnhNDoREz/Gd
         bgPg==
X-Gm-Message-State: APjAAAUEjMIshk/TFIcpKs1FvY1SWfTMbQ1KzIiek54+iIZEt04nC/iF
        cizESMdOXk4w1x4OtrzCUQ==
X-Google-Smtp-Source: APXvYqyX2GBVUSSNMy2pVVKB/YdvrRPb+Yq/Arevpw4iUb7kKWFV+jRCwUTv8N2jILMIpx1ncxUcBw==
X-Received: by 2002:aca:360a:: with SMTP id d10mr357468oia.68.1552343187680;
        Mon, 11 Mar 2019 15:26:27 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d11sm2739097otp.18.2019.03.11.15.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 15:26:27 -0700 (PDT)
Date:   Mon, 11 Mar 2019 17:26:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Patrick Havelange <patrick.havelange@essensium.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/4] dt-bindings: iio/temperature: Add doc for
 thermocouple-type
Message-ID: <20190311222626.GA26688@bogus>
References: <20190307103409.24174-1-patrick.havelange@essensium.com>
 <20190307103409.24174-2-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307103409.24174-2-patrick.havelange@essensium.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 11:34:07AM +0100, Patrick Havelange wrote:
> This explains the new generic property "thermocouple-type" that
> can be used with temperature sensors.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> ---
> Changes v6
>  - Add this file
> ---
>  .../bindings/iio/temperature/temperature-bindings.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt b/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt
> new file mode 100644
> index 000000000000..69a6441d8083
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt
> @@ -0,0 +1,11 @@
> +If the temperature sensor device can be configured to use some specific
> +thermocouple type, you can use the defined types provided in the file
> +"include/dt-bindings/iio/temperature/thermocouple.h".

You can include patch 1 in this patch.

> +
> +Optional property:

Optional or not is really up to the specific device.

> +thermocouple-type:	The type of the thermocouple used by the device.

What's the type? "A single cell" presumably.

> +
> +For example:

As this is example is incomplete, I'd drop this.

> +	device {
> +		thermocouple-type = <THERMOCOUPLE_TYPE_K> ;
> +	};
> -- 
> 2.19.1
> 
