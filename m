Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CF6ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9B520872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7/naDGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438129AbfJQSDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 14:03:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33400 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730483AbfJQSDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:03:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so2156307pfl.0;
        Thu, 17 Oct 2019 11:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xNzttaqTB9yR0zSx8+SxBzIBKXGNc7WFxOf0/tJ9+l4=;
        b=g7/naDGRERvJkkuXI2LP8O2CE/R3dBBOLDDLXhPuO9PsH8lTKFmDZiWYkDYVhGYNB1
         MQ4bqqZPhr9qtgt0E4azE3RkRUJ0tHvXYBvxLQOXrBqOXtY1dCBxSCMTTs/n2O0CBLlR
         etoyN6cife6+0+oPp4hzrPXhb0i1NckYXfnk0epS9Y+dB41s+7aX9kGws1gx4nb2G8U7
         A5cQWOHIJ1IapHc+2GzGi53pUhEtCBoCDXPag8qSM7jDcp6Gbv9wVOBMyeHzZLB9hfkU
         FZqFxyuPfgPdUzHZpxoH38yGoa96CvdvGTl825MBMT4dG2FmDF8/Z8/w5y5QS/hfIJot
         CGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xNzttaqTB9yR0zSx8+SxBzIBKXGNc7WFxOf0/tJ9+l4=;
        b=o2DIMx7WZQ5Irpobpz86u44BnfZaj1pVO9h5IspprWF2cmpwcwaa8lejKDSTlOHwbm
         NOb2hNrm+sDS/5qKEK20SrbzfAdhkXL77qLybcSDI+R9cpSSUTmqcJzzYWc0JoKie2Nr
         cC4YkeGefsqwsNBtOVSdxWDyhTq/L1wK8Bl2wOCrDtHVqoilvGrdVG5P+oPUXJ4H6egL
         JSa2+QsXClDQZRjUQLE1n38/1qpPvgN0igyREUhts0gQyURmcZf87B0Vy1nIRN9P8+KQ
         GTwTLQb5rzP5H18m8Z4HywosQOSB78sSmUct6ss0XAsVffhJJsUafxVC2eoZvgfWFbVd
         oOlQ==
X-Gm-Message-State: APjAAAX02TPv5OKZfhDIBMQb/9PL1NhmuQvyRc3Bs6BtDg8pWn4v/33B
        5UUal5mjIiu5IixW1SPq4u0=
X-Google-Smtp-Source: APXvYqzRndQOmbANPgO38mUlBFEmFt6xJF4zs3xQD2pIk5bteYU5lsSqeByvFHxsOvF81/5DtZGI8A==
X-Received: by 2002:a63:287:: with SMTP id 129mr5503796pgc.190.1571335420675;
        Thu, 17 Oct 2019 11:03:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y2sm5230476pfe.126.2019.10.17.11.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 11:03:40 -0700 (PDT)
Date:   Thu, 17 Oct 2019 11:03:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/65] 4.14.150-stable review
Message-ID: <20191017180339.GC29239@roeck-us.net>
References: <20191016214756.457746573@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016214756.457746573@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 02:50:14PM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.150 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 18 Oct 2019 09:43:41 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 372 pass: 372 fail: 0

Guenter
