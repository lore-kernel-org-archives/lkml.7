Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D091C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D304204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iReIt/iS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfDPPym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:54:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34162 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfDPPyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:54:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so10629789pfd.1;
        Tue, 16 Apr 2019 08:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X+kQOpGQoB0mHY+DaeDL24lqqbk2b3IZaG62Ox3ZM4U=;
        b=iReIt/iSYCUQM7iP3b8le9JrXulcx1Ip+Dovv9g1K2+dLiuezPUGHaC+W6m4DZFla5
         uAlJmcsGHBRxg+jpf19gera/lz2kAc7Ts5r2+LzCsTjt/5ZiX5fnQnQybJpv7p7jFzU2
         rIznU4RxqQMvr/fPJ5aonF/K9pRexVRoQlGUzCoTZm6A5nvI7fByHJSCnqmsthG9n5/4
         n2l40ETK3BLsQzb6U+9el+DTMjrWr6LmxoMDqvyty0DAr2U2B3o+EIYAVPPGTiwz1B7L
         kkwGz+r63pKu3tr7/BmJstZTY7cgQM9ybAkPNHCiFh5wuDAmzP0W/mMXHR+QU7d1XLpm
         xz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=X+kQOpGQoB0mHY+DaeDL24lqqbk2b3IZaG62Ox3ZM4U=;
        b=UqmAbKcwUg0lt6P1SWR2g/FX0WnpJdZZ5AgFTeD+TPDQNz1jQBJcZjqehd5chMCdQW
         fH/jaXuPwtrEQ3uCEINW/GqVi5oT4BrE3BMNV95x697DC5JXDo+GqO7vwLczw6FgFKuw
         qOH8LYHLIjCRtGOaFQcfkL2XZ7esc1ZAzda0v9mX4325egHavQ0SN+c4MM5uCbyLbe/8
         ZMKQSD1YcYzWea6WM6MFGY79nsDCFGm9BEnzGkWF88alRGDeVTDYY/Oqg3KYg9jx8ShN
         Hxj/Vb9ToubNEK1ZYAi+/XTpvhLUsjNOd8vMBR/2dXT4iZKQ93xH8aUFHzp8bj2+TFr2
         n4Lw==
X-Gm-Message-State: APjAAAWgU93Z5AyXegvKvaxixEQMGvtQwUm7F2GnJfNPv23/pZyXv5Z0
        s4SdC1MpxNwoYcrt21F8aKo=
X-Google-Smtp-Source: APXvYqyhgMXHNoDdGqrIQaDWxNvdrFfJ7Db48ijWu3Ts6moK69mo+008a9MAEMItzt0Dj0AAWL0ndA==
X-Received: by 2002:a65:6410:: with SMTP id a16mr64133469pgv.315.1555430080695;
        Tue, 16 Apr 2019 08:54:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w3sm101593169pfn.179.2019.04.16.08.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 08:54:39 -0700 (PDT)
Date:   Tue, 16 Apr 2019 08:54:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Patrick Venture <venture@google.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, trivial@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: Add isl68137 as a trivial device
Message-ID: <20190416155439.GB8871@roeck-us.net>
References: <20190416154147.125602-1-venture@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416154147.125602-1-venture@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 08:41:47AM -0700, Patrick Venture wrote:
> The isl68137 is a digital output 7-phrase configurable PWM controller
> with an AVSBus interface from Intersil.
> 
> Signed-off-by: Patrick Venture <venture@google.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 92184ef0db2e..747fd3f689dc 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -104,6 +104,8 @@ properties:
>            - isil,isl29028
>              # Intersil ISL29030 Ambient Light and Proximity Sensor
>            - isil,isl29030
> +            # Intersil ISL68137 Digital Output Configurable PWM Controller
> +          - isil,isl68137
>              # 5 Bit Programmable, Pulse-Width Modulator
>            - maxim,ds1050
>              # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
