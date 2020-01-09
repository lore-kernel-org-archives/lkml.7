Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090EBC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF762073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578567182;
	bh=gomddWS0IaU/YKdt2qeOQ0+ifd56t5CsO2E3Tr4tUys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sbiBBQ13/EfISiRWUPevTplwADSfFh+/YVTSoLRqh4dDHuFDsk9q9oG5NTqnB3CuY
	 V+FdApDs15nGrmcfgu6lolzeXddw5s6sxUb0dJEsLn0EcHizNSZss57Q1EqbWF0O1s
	 15NjCVtTBJiq4t2pq1pQ0ODWHS3GA6upsDRQw3Ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbgAIKxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:53:00 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43148 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729609AbgAIKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:52:58 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so6691336ljm.10;
        Thu, 09 Jan 2020 02:52:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FfV01Lii6xRWmFZQZCmMxKJbbWsfZhJQ0W5lt1xJYG4=;
        b=JMREHEpOXmKGAg3ZaahAsAmvA8SIlModrp0/N6RLc9nE72UJiAOaQgj/J4mfoF6VNN
         3PvVNTZCoAD7sRUzGMXv/fd0ptI5C3vWtlnzko2zdEVDXeMwekHq0+sdVyrztuFsk3oP
         sVSJjQ1i3hzQwvQD9kIGqSOPvQW/6+668WfzueM9GbNp3iOu1E3uC0Ru/TPZTgGITXd/
         KKBi5GnZ3u/Z5caCYWqDZaWgrTwnk/VKn1zfsQscPPUUsqjgPROEY3QYs9wQClLnsBuD
         D+F2hcg7IW+nbbrp+9DBYmoJ3T05T4se5PUsFlooBPocZRoChLfahV4/XOeaDzyI8Fn0
         YYUA==
X-Gm-Message-State: APjAAAUk5XPCOGy7iqizNLgMb7vjgiN/C6segQ+1gZpqFZQLk2ZXAC5s
        TQ8u/5F4wcNBio1I2epwzjw=
X-Google-Smtp-Source: APXvYqxDRTxHD6nVLtrkTWGtc/R1PiZw8V9x9Kc68Cxd5tEtGw0IIFmeKSChgotu/cRj8k/4t1nH2A==
X-Received: by 2002:a2e:7818:: with SMTP id t24mr6225318ljc.195.1578567176374;
        Thu, 09 Jan 2020 02:52:56 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id 138sm2931247lfa.76.2020.01.09.02.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:52:55 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ipVR3-0006WK-Ur; Thu, 09 Jan 2020 11:53:05 +0100
Date:   Thu, 9 Jan 2020 11:53:05 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        Rob Herring <robh@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        johan@kernel.org, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Subject: Re: [PATCH v6 1/2] dt-bindings: net: bluetooth: add interrupts
 properties
Message-ID: <20200109105305.GL30908@localhost>
References: <20200109104257.6942-1-glaroque@baylibre.com>
 <20200109104257.6942-2-glaroque@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109104257.6942-2-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 11:42:56AM +0100, Guillaume La Roque wrote:
> add interrupts and interrupt-names as optional properties
> to support host-wakeup by interrupt properties instead of
> host-wakeup-gpios.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> index c44a30dbe43d..d33bbc998687 100644
> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> @@ -37,7 +37,9 @@ Optional properties:
>      - pcm-frame-type: short, long
>      - pcm-sync-mode: slave, master
>      - pcm-clock-mode: slave, master
> -
> + - interrupts: must be one, used to wakeup the host processor if
> +   gpiod_to_irq function not supported
> + - interrupt-names: must be "host-wakeup"

Looks like you forgot to address Rob's comment. If I understood him
correctly you either need to stick with "host-wakeup-gpios" (and fix
your platform) or deprecate it in favour of "interrupts":

	https://lkml.kernel.org/r/20191218203818.GA8009@bogus

Johan
