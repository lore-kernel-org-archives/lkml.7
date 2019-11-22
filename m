Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D1CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641402067D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aocSHzwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfKVSJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:09:41 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41408 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfKVSJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:09:41 -0500
Received: by mail-oi1-f196.google.com with SMTP id e9so7278066oif.8;
        Fri, 22 Nov 2019 10:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LzPGe9jNoFe06HsvZcJh28F5+rCWRe7dlKz7ip1T8jM=;
        b=aocSHzwQyqD0J1tEblob40O5AI2fghfC/QQIzWQUKEW1DCUeY0H1su3oHYU8XF+LBa
         m851LWRqjMKDlQF0lX7GVJnXty5WbLhxj9CPxbEigzW8Y/2zYFGIRNigJ4bq1BIwl5aa
         uIoTApjUraYIgaEtuyXBrqjoT94+gqHAj8cKIRCfOWOJNv1nqHv+X0daAFdCOXouHsyT
         teu+063Byr52i97MnLImFGLhmZTK/Bt2LprB/Pjgq9dvLRldrS13PX+BY6vtIjodBiOF
         kNcJ/YQ1w3q2aa3BIkOaqmXRiYHVH19TH5nWrEyXqkmwYarxiIRO6NRadc8QJBG4g/s/
         +kIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LzPGe9jNoFe06HsvZcJh28F5+rCWRe7dlKz7ip1T8jM=;
        b=FrJkda23T6pM/jF8C8wNMlyEmUrllv74iQqGEbQ3cr+Jit0zM+XnpIQfPWfxM4RH1+
         yPJl15MpgXSNaQ03ZxbIICDFZdB3Ejpx0O5XPflLgGqgaG1nNGtW/mEff9UM8d0VRPgs
         C4sQ8UHAL/JyXdfmLEhrkb17GvgqqiPnw0Ko9+ssfjC34Gq1fcpqvxxzGCVCGy0EWoI2
         8h1IjM4CcjfpcM4o9tdBxDrJe+h2ORrCYlsKYbEV3WaeMRXkGbX3tWTyzG0DS0uvbWo1
         lg1xZl1W/jAsT5LGa+sFyNDkcjraO32oUYgV+Cif10Y21xNRcT2OJEhodPMkQpREf8sL
         D6/Q==
X-Gm-Message-State: APjAAAUcxkVeqQV1YD9WDcsWsoWc3vFT9PFlhY9iiggSU8io6mvba18T
        lf/+3MpIi1slVGK8z25yHaFL3w0n
X-Google-Smtp-Source: APXvYqyCyqE8PONQTIi7O0k94MtnqcIAM2ZCphgst7ZRhRg9xTaEGo4DblFfCysVbt8OySM/oCkiyg==
X-Received: by 2002:a05:6808:995:: with SMTP id a21mr12631144oic.108.1574446179966;
        Fri, 22 Nov 2019 10:09:39 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e19sm2387811otj.51.2019.11.22.10.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Nov 2019 10:09:39 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:09:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/159] 4.4.203-stable review
Message-ID: <20191122180937.GA13514@roeck-us.net>
References: <20191122100704.194776704@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 11:26:31AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.203 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 24 Nov 2019 09:59:19 +0000.
> Anything received after that time might be too late.
> 

For v4.4.202-159-gdbaac4c54573:

Build results:
	total: 170 pass: 168 fail: 2
Failed builds:
	arm:allmodconfig
	arm:omap2plus_defconfig
Qemu test results:
	total: 325 pass: 307 fail: 18
Failed tests:
	<many arm tests>

------------
Error log:
Error: arch/arm/boot/dts/omap5-board-common.dtsi:636.1-6 Label or path dwc3 not found
FATAL ERROR: Syntax error parsing input tree

Guenter
