Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7468C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7362053B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cP8y8jz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbfGPKuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 06:50:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46461 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733164AbfGPKuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 06:50:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so20365427wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 03:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nGHdZHwOOO/T2384pEiYCjK9U0acA1Up7ymoQnE8Urk=;
        b=cP8y8jz99Gz9nRhMHIWp3tnPvoaGR2aHUluujRGjc/UHmoPzvlHWZZkT9YcFmAFqi1
         EssQrq1YHwRLYzCr/tsZ0plLTWbcsQTYmpb3zrTWqQ2pvpknCWsDme74+qRvh6zNosvL
         JGAfQEePL0/yPaeoQcFQFIEk0uH4KlZBIxtBFYJ26oU/Z+0malorsCIFbN4AEU+J0DF3
         9nnNUjifgD8e++maw7yPtAf7PhlB3fnx8hRyZRkseNTr42TO4stZDXoO8IjZMbva8g2C
         cv0Wlw4CvZ++FZewUVs7r4OTdNQiwK/VP8CQop8Ydut99FTWoH4kIBlrfU4K5otNRFQN
         NXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nGHdZHwOOO/T2384pEiYCjK9U0acA1Up7ymoQnE8Urk=;
        b=h3vS5Jz++v+VWt0UzkxImuQtSL0U+/OLz1ooXKAnxiIbo6tDEDJc290Vozc8Cio4xl
         VBou+WOSjyouipGSmriNbGSBDnaVO7Ku4BD+u3/emDgjt/h3/yX+ZlvQjVh8TrUUIP+J
         cYBp2Qm4N1w1Z/3Rr3sP7w2ZpD5CWTXo8S+CLJeQOvGlljDzWWM418s6okAKJnXKMlVH
         w5U3r2j6UqDyj5Y49A5zArugf92uQeLOoNmlQkiG1a8veYjpPxgVbiapCn3ftsfnDVzg
         EvCPNX2f6/pKsYvifLq0mbIchsOBPL1nA12zXtKnTH2F4EPSFt1IMSLhL+hWpxWl5suv
         inJg==
X-Gm-Message-State: APjAAAWFvzlowE7aMHZcScUx4OhVfAY5cP8+7q4kg1so+OsGS5iMT+i7
        wUTaX98aa+RjfFd/FNp7xsoq9g==
X-Google-Smtp-Source: APXvYqx1ya2YP0LeutZVoNpvYo9pNFMWGWEbyjTVlgN08/JSNnQvVJ1GmsmxFf21LN1R3KUhPwUP8w==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr34484243wrn.257.1563274235060;
        Tue, 16 Jul 2019 03:50:35 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id g19sm35841133wrb.52.2019.07.16.03.50.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 03:50:34 -0700 (PDT)
Date:   Tue, 16 Jul 2019 11:50:32 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, dmurphy@ti.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] leds: Add control of the voltage/current
 regulator to the LED core
Message-ID: <20190716105032.thpcttko5do3u56n@holly.lan>
References: <20190715155657.22976-1-jjhiblot@ti.com>
 <20190715155657.22976-3-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715155657.22976-3-jjhiblot@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 05:56:57PM +0200, Jean-Jacques Hiblot wrote:
> A LED is usually powered by a voltage/current regulator. Let the LED core

This is almost certainly nitpicking but since there's enough other
review comments that you will have to respin anyway ;-)

Is an LED really "usually powered by a voltage/current regulator"? Some
LEDs have a software controlled power supply but I'm not sure it is
the usual case.

Likewise its a little confusing to be talking about LEDs with an
external current regulator since, although that is possible, it is also
one the main features provided by LED driver chips.


Daniel.
