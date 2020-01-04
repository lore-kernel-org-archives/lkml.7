Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39562C33C99
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054D724653
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578172304;
	bh=KAzTx1HoWyH1hLxbp7zwKilyS2Wgf6R1NOwfHPWv/8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b39kVU+OqSc0yYC3OMxm8kLgggwEeQU/JV8yx/ImLZFehTvO6/RqUBP/cBMGch+n8
	 0MZy9BYz1nexL1zeYLgAOqnOKTHiPgAHoaG8Ptg1ODMBvHQ5ydFReHnTeQVcFj0irM
	 dbG5PO59hsiYqh9t65tFBUsP6XJ5rMBKNu+eC678=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgADVLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:11:43 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38117 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgADVLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:11:43 -0500
Received: by mail-io1-f66.google.com with SMTP id v3so44765725ioj.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 13:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2DHefjLQc6S51MdSwDdwJfZErHx2CFrIYRVhl6DWIYE=;
        b=TzyowqOlG7VCQIVyUrQFM8f5B+i0Q68gL94Z5lOWiO0CuaC2gYoB2GNcJ54SGndD7g
         CxIs2HVwCdgZgf8mc33/EjfE32HbuNg6rZC+2bGVnCxdu6lVDHeuI9oiu/BC5InHhOuc
         3DWhjMRIWhRpSxtkg7iv6fX0HKtRQJtWiGjp5SCZFkJHsYIJoNhjnSFReRoGUtEySg5L
         /KLU30YQPa7hJ5TRIn4eMS/bPYCMG68+wa1s81HdJG8LRvyY9LIU+IZ+Z6jutOXmEn/H
         PLif6rXTSpDPfjvwzZcW7PHc6u+ew11IjcY4l9PK9pwpYsceZq2M7WRNdnCS21uLe6ef
         yMfg==
X-Gm-Message-State: APjAAAVE0Dgc3LfjUepZM1APztrb5x8qtkXn7heZWvIK1uAjuwpXB7+F
        NYN2eY8iTBvlpu+qY7GQPQEolTg=
X-Google-Smtp-Source: APXvYqwg9/2MTSBUVwJ7Zum7vBCI4sCJbeorl1Jmu+RpgUUqyBJYwafuCP2KyfGUqs7b1RkBoNQ+XQ==
X-Received: by 2002:a5e:9814:: with SMTP id s20mr57979896ioj.96.1578172301896;
        Sat, 04 Jan 2020 13:11:41 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id r7sm16007172ioo.7.2020.01.04.13.11.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:11:41 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219b7
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 14:11:40 -0700
Date:   Sat, 4 Jan 2020 14:11:40 -0700
From:   Rob Herring <robh@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] dt: bindings: lm3692x: Add
 ti,brightness-mapping-exponential property
Message-ID: <20200104211140.GA20909@bogus>
References: <cover.1578134779.git.agx@sigxcpu.org>
 <7df957d4f7902a5d2a30695ab2a5de19eb7772d3.1578134779.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7df957d4f7902a5d2a30695ab2a5de19eb7772d3.1578134779.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Jan 2020 11:54:19 +0100, =?UTF-8?q?Guido=20G=C3=BCnther?= wrote:
> This allows to select exponential brightness mode instead of the default
> linear mode.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  Documentation/devicetree/bindings/leds/leds-lm3692x.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
