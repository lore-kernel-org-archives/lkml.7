Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827BFC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1D9208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe+056Xc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436719AbfHIPhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:37:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47000 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436647AbfHIPhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:37:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3so8836219pgt.13;
        Fri, 09 Aug 2019 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1gHxcUKWiA5yHFjjpK25ptGbG0LFc8Aiq96C/VWrYuA=;
        b=Pe+056XcOXERtxlJgq8DeLVMn2LDCOiPQ2tl6Qtpx0QYXlPPoad8Wjy8nnKl4Sllj+
         7L0RSB/LANYV/EVvuO42ktjTKRvbxW6f617BRXRn1OTwa0BSyojZ65A/wFJgKGtKuGG4
         ZzUB+XS0vfTROUfzpK9WlKMaDWNwi9nIcNbJbne8vuVSrARauaI8eu6W/HMHc7j3yNcL
         U5GIoiLdF1K6JGvz/FySX4pRRa+5ydok3c6NyByiQlyWgfxCV3aMHX93nPB3Px47DI8m
         EwqCbOtuOGPuxME8i6eUcoApsQILos2aGh5aXuf0YixUAprRxmSY46pWmgHB7m82vyk3
         +Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1gHxcUKWiA5yHFjjpK25ptGbG0LFc8Aiq96C/VWrYuA=;
        b=eAaVSzL8xZtJMhx3ekdXHqPXxov7dssrhX+yvpoUFcjAswr78NNsGE6g/fJmCJw7Yf
         zY6eDrG8791XIYkT+cZxeSKGUVgMERnyRHlqp8lEFgHEkYq69VPNUxf/dfEJ7TEQ7jam
         pOc3e2METqwFa+u+sIsD+GRcdELfRKxAUzPDR9F3fWCL29iLN6crtDvMrtHn+HSiro3K
         RDh7Zu/9cKgv7xV/6B5Ic+BuVqkbjcLpaNmZ9CoELlw3tD2tn4n+lbLjOE/qbKXl1ngh
         JKci2xaYMQ387I2D8+gmB4IDu16mZtCSBKdyELfotBDK+5OWuiQ0e2xVy7qDEDBxEvR2
         DTLw==
X-Gm-Message-State: APjAAAXT7lvDvcUbqh4X1Ua/ME3KUHLHPRq0Ib2gPnqbRdLi9lrzsogf
        V5KFT9QDxbd9nTsI8Edd1J0=
X-Google-Smtp-Source: APXvYqxktsjZzB5P93fI/toqA6EFTHTfHxYk/ZmMNPRfcjr3G/MTcYOhmId3yniXhzPzSOTDJnElrw==
X-Received: by 2002:a62:764d:: with SMTP id r74mr22985926pfc.110.1565365051536;
        Fri, 09 Aug 2019 08:37:31 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n10sm25340056pgv.67.2019.08.09.08.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 08:37:31 -0700 (PDT)
Date:   Fri, 9 Aug 2019 08:37:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.2 00/56] 5.2.8-stable review
Message-ID: <20190809153730.GC3823@roeck-us.net>
References: <20190808190452.867062037@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808190452.867062037@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 09:04:26PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.2.8 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 10 Aug 2019 07:03:19 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 390 pass: 390 fail: 0

Guenter
