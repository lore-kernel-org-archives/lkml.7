Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB192C282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C6321738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkOP1SQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbfDESaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:30:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42864 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731542AbfDESaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:30:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so3504193pgh.9;
        Fri, 05 Apr 2019 11:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=imcdnidaX/LX6lMw/+8EZCPufVujoC1w28brM9agiSg=;
        b=WkOP1SQiP+uVuiEOYICtutkNMwUCiuBAdxGHSeylunLc6EMoFwARKsM+cpd0zfYOkv
         LzGNsFIuj7v+r+90EhN/IId/0bsHHjX2kxOb6LsRAzhWCoSWIhdZy99U5jDiJNhmuYSw
         H+hhqiIpJ1seCTtv4CqJc85fsRyrlCJm4m8+E5QOQ19cct5a9+HCNsPMxeL4IeXJEtG6
         afVUS1hZ7S7QYomfFShWQ8Y2K/5yBB2C5s9i6v1kjjeM38JRfncWB9D2ouQC9EL2bAqV
         Ph+7u0LVGaz0sysqSAmwqDMPuv1+MwrFNELfhj1NGNlFIak6YtAWVBrhI3/FSS33b/rm
         8SKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=imcdnidaX/LX6lMw/+8EZCPufVujoC1w28brM9agiSg=;
        b=EN8TFWtD/OqzO9i5xsqHlVcjXTvvwsVAv3+hvKB4udeF8lX/KsPC7ILzJmEPHqoIs2
         uFpR6kU9woCrotM/CCQQ0D/W9SFlrDEnc3LZHM3/gc04sj1k33sdtGXa2p5XhHFYar5p
         C2niLSMl5iVulV4Opbnv5gY54H8573ojZlUQFACrB3+xAkjVvq6/tc3rteC5AGUKTsx+
         x72F3AMN9hAqnLlUjuzxXlvM2mfyIrEp9/hZM43jN4hG3XbqZcXmM+waYRYB1sIG3L6I
         tRZYUs+wLCVt3tEZ4EJGRC/y10Ceh5h5XIdW+uUB5CfJ4Eh+3Xg5Z6XxvfvyjdXObF/P
         eUog==
X-Gm-Message-State: APjAAAVc/YMN5dK4RGn70DL1lfFCh5/k/SpVETRl073X2X1lW6OVJRTP
        i2jy0tTX/LnV6kAFMhu6D40=
X-Google-Smtp-Source: APXvYqwJySo4Tdq9BJfO3kPvkCvKJiFgvVV0Ztj8/YripIFHkng6/gL4wWXPRCG0uSYxpFj+wJU5MQ==
X-Received: by 2002:a62:474a:: with SMTP id u71mr14085664pfa.87.1554489019988;
        Fri, 05 Apr 2019 11:30:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g2sm31960466pfd.134.2019.04.05.11.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 11:30:19 -0700 (PDT)
Date:   Fri, 5 Apr 2019 11:30:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/91] 4.9.168-stable review
Message-ID: <20190405183018.GB11563@roeck-us.net>
References: <20190404084535.450029272@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 10:46:44AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.168 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Apr  6 08:44:27 UTC 2019.
> Anything received after that time might be too late.
> 

For v4.9.167-91-gba980237d739:

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 316 pass: 316 fail: 0

Guenter
