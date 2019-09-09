Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B748C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2381A2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jmPhYdOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404031AbfIILOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:14:15 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:37459 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbfIILOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:14:15 -0400
Received: by mail-wm1-f53.google.com with SMTP id r195so14191260wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 04:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x4n6x9/qmmEjTTfyMxaFAIZOc+x6zgwe1HZT5rXoAW0=;
        b=jmPhYdOL/Zxi9Qz5vYmk68b3cSiHJfLO4h07ekQYZ7UefcH13kMNa5NCQkZPcz7IFj
         RBtOSND7FhodJf5EobnGmQoh7BqHBn/EgfMQT0opwbHi8hREbqRm5gbdgX5HgxZyEWaW
         iImLvv0wzHsaEBx8hGfHFvRJ4wJYdF9eI8ZXVOMs9CPsFsmVoyO0sHbf5Vnm+azs3hxG
         rqz65N9wmXtJ5OOqSgQsPtid3ubHRszYpq+uKARW+hMVU2KwPCMC64cXQvDrtA2OHbui
         R/SFce0PYrqsbbQ2Z89hDYwru4jtBwvgn/KWC33/afLcVMISX+IhggznBQs9Gs/GhLsL
         x5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x4n6x9/qmmEjTTfyMxaFAIZOc+x6zgwe1HZT5rXoAW0=;
        b=VivfR7HJm68+BXVUGRvDavADAAPktErHPoLcFvDO+o21gxPdqIw43VizIjrFVPRmxV
         /oenJQ1UvZcKnzyTaSxSikPLaDNMO8tCNgBTv6g/3Wp8WQGUK6d/t7AuR3qEEk/254VC
         HOCWiV6i8lABKVK2UoPiUx1aZrf+YW5HKH4GCDVGHdKg6lsFOpMsSD6qO2xbtsIq+e5l
         hp0vqbEMKSREv6XqvXJPDt+BYH+9YiufImCMWPmd6PkG26PFveTsZOCg9O0P3Ul8TGi8
         MQgUWn6MnuxSLJdJyg1FX11DBkH3KETeqgcxVnE+NkJVYPvRTSJRwsXRSi5VQMHxVDkX
         VzPw==
X-Gm-Message-State: APjAAAUNNHCDyYk7NnOGWZS6SqcqceRLLDWdYxzKbdBk61ZBaeedzG9D
        D61i0oskakIkcLwudEXJou+Bmw==
X-Google-Smtp-Source: APXvYqxZj8SqxMjLqHToVcM395HkhShweXt497/dFSmolXMFHfS1yWHepdCWoK4iNZVD8EKvctaAHg==
X-Received: by 2002:a1c:4485:: with SMTP id r127mr17430162wma.59.1568027653085;
        Mon, 09 Sep 2019 04:14:13 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a15sm8198707wmj.25.2019.09.09.04.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 04:14:12 -0700 (PDT)
Date:   Mon, 9 Sep 2019 12:14:10 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        tomi.valkeinen@ti.com, jjhiblot@ti.com
Subject: Re: Status of led-backlight driver
Message-ID: <20190909111410.dwqvg6b4lgxymn2o@holly.lan>
References: <20190907100726.GA12763@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907100726.GA12763@amd>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 12:07:27PM +0200, Pavel Machek wrote:
> Hi!
> 
> I don't see the LED-backlight driver in -next. Could it be pushed? It
> is one of last pieces to get working backlight on Motorola Droid 4...

Sorry, I dropped the ball on this and was therefore rather late
reviewing this patchset.

Assuming I have read the code correctly I think there are some
problems with the max_brightness handling in the backlight code.


Daniel.


