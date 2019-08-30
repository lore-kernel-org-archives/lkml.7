Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC57C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2E421726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="0tWMSg+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfH3IBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 04:01:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55055 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbfH3IBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:01:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id k2so4841152wmj.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 01:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xDWFOC5KIqBUnS5KsrM2GDBVfGw82n9BymZaCeLwnrQ=;
        b=0tWMSg+ZCEeBjFWM+KTT8++sDU93IOoqfi78OtpLOYzGx5L6DqRT490amuDK/8IY3A
         pi8I3hmd4hfEXFyWXXc3N4/L0XkzY5gsDvefa73RcNYXcXsMLUTEhEGgy7yLYZjSFMtj
         lGd1jqIW2tkpwIbJyBN8vScRO/l1x+lAaxXfOFWu7Su19kQYp8N9T41hgufo8Ev5jz3f
         vlPiW/Xp7sMVtKzdpENlIPKFCL7H5Fu9ISGCBT0OnHOdLDnQiFkAsa1jmW8kKaMtWcDZ
         IUd6oNl9HT9RVQcrSDvg36v1WBdEcB7YKFXRtdQQl8pjSb2rLPhPBMoAXCSol4wZDm5Z
         Foig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xDWFOC5KIqBUnS5KsrM2GDBVfGw82n9BymZaCeLwnrQ=;
        b=eocChD86w/2j5KNnXtJftGmuRIgbL/aDPEvM6iPdSnx3lfdfwt7PkLERMzfr9LPn59
         CAAltaYTDHYRjdlMqPI0UB1ePNQwZ8vJfbmRql5h0CgR9DblL4YdYRAc0V0h8tfnJpGi
         sJ33zF0kAAZFdsUY7zaejIwxUfwuIXniGElAaSl9Q30+UUFWjVGTnujVbdDHjWWMKAC3
         D/KiLOSsYJnMXq+1C+LY9Xrja2ztL8IAFJoddjCsf0h9Ii5QWaC7OL8PGXktxOwSF7d1
         YQ9LwoI7X6JtxsAY9oYe7I38PuDiU2AfcXcHVbPpZjzQcFmmNkZ/f5uio1N/JlydRCDX
         85LQ==
X-Gm-Message-State: APjAAAU9irrLe2YeVSNSjnp6Ipc923sKgaYNiJdTmoVbYaukDb6KUbWY
        e+WEAbfdqvLUQTy0PvwsRMuvIA==
X-Google-Smtp-Source: APXvYqx+aypUiGiA41kuEqSHGWPSBA1IhTUH9hae5gxadfLmM/cYcrrCHWto4Rv6vNFVumxKXZVSpQ==
X-Received: by 2002:a1c:ca02:: with SMTP id a2mr1076784wmg.127.1567152092914;
        Fri, 30 Aug 2019 01:01:32 -0700 (PDT)
Received: from localhost (ip-78-45-163-186.net.upcbroadband.cz. [78.45.163.186])
        by smtp.gmail.com with ESMTPSA id j20sm9610535wre.65.2019.08.30.01.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 01:01:32 -0700 (PDT)
Date:   Fri, 30 Aug 2019 10:01:31 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     David Miller <davem@davemloft.net>
Cc:     idosch@idosch.org, andrew@lunn.ch, horatiu.vultur@microchip.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        allan.nielsen@microchip.com, ivecera@redhat.com,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] net: core: Notify on changes to dev->promiscuity.
Message-ID: <20190830080131.GQ2312@nanopsycho>
References: <20190830063624.GN2312@nanopsycho>
 <20190830.001223.669650763835949848.davem@davemloft.net>
 <20190830072133.GP2312@nanopsycho>
 <20190830.003225.292019185488425085.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830.003225.292019185488425085.davem@davemloft.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Aug 30, 2019 at 09:32:25AM CEST, davem@davemloft.net wrote:
>From: Jiri Pirko <jiri@resnulli.us>
>Date: Fri, 30 Aug 2019 09:21:33 +0200
>
>> Fri, Aug 30, 2019 at 09:12:23AM CEST, davem@davemloft.net wrote:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Date: Fri, 30 Aug 2019 08:36:24 +0200
>>>
>>>> The promiscuity is a way to setup the rx filter. So promics == rx filter
>>>> off. For normal nics, where there is no hw fwd datapath,
>>>> this coincidentally means all received packets go to cpu.
>>>
>>>You cannot convince me that the HW datapath isn't a "rx filter" too, sorry.
>> 
>> If you look at it that way, then we have 2: rx_filter and hw_rx_filter.
>> The point is, those 2 are not one item, that is the point I'm trying to
>> make :/
>
>And you can turn both of them off when I ask for promiscuous mode, that's
>a detail of the device not a semantic issue.

Well, bridge asks for promiscuous mode during enslave -> hw_rx_filter off
When you, want to see all traffic in tcpdump -> rx_filter off

So basically there are 2 flavours of promiscuous mode we have to somehow
distinguish between, so the driver knows what to do.

Nothe that the hw_rx_filter off is not something special to bridge.
There is a usecase for this when no bridge is there, only TC filters for
example.
