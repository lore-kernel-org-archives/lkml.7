Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09680C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2629F2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtSHBoNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfDYTgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:36:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39403 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDYTg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:36:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id l18so341566pgj.6;
        Thu, 25 Apr 2019 12:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4XkKzGtDvM9JsvEdnLBMz4u/gBQstxr/n0GMjcp8ev0=;
        b=jtSHBoNO9KSbXie5NK6CTaHZl5mn+JnpPhdXNAtSK3d+hNTar/7e+MNAy1bAEakEF7
         JIO609ryv86T2EiwGp+TDu2QkguNjoPc3XqNjvZraZdnDsRyDBNnlp5BYjloQKNyaC9d
         QFWM8OEka1vB3PVGJb6KqsHRKXxm4kz+KPK0hoZtK4TmYo4TB3Rl1Zx4yOi9DPIZzK1C
         5STaq+Yr6eWfaF0pWFX612Y1UhA45UIblMg1Cm/axZUjL3vLpRQx8gLK//jum5OZiEug
         ipZtRKhGcEIV+/lxSsGkZduRe4gEKTWxRe0J807SA+OiQHvsonZfr609ckXqLNNWuN7l
         SGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4XkKzGtDvM9JsvEdnLBMz4u/gBQstxr/n0GMjcp8ev0=;
        b=ENCz8UAWT3IZutaoAFzpgxJvOKintB2ZFsdx+DvXf5MBqsM7adAb5ZzEmdVE5RqydJ
         vSR9Yy9cUYql+J5PGG0f3QIscOlmNmzu068267PTY8ewuA8ixq1N2Jhx0mw9H92hcuKX
         +wRFkyhXjxal1Ko+XvthWbz5dUy3WdiUfkKFAffUu+SYQXGYbxq4ZfckPrNiSygN5HMT
         4g/CH6Wo5HEuyE2ppL08vPrngDy8Q2sTEtoUhHnWe4kJXiXoyisBBf4BVE1EXgZ0aqoj
         Lldrz3v241efEra59vNCBONpFc7PWvTyx4QZgjVFxcg4EqaVdaCMGB8nRxX9Ze2N3uu5
         nHTg==
X-Gm-Message-State: APjAAAVN15E+GWu8XmqmhRL3eF0XIkE4GUS/It2qLXp88/JSTG/nzqpd
        e3MkOQBAQ2nWzzkPi3swqAEVjeKJ
X-Google-Smtp-Source: APXvYqx8RcgqDaJEYuZJQWWk9mNPyxAqhM7N5/zOOcONq3KUowfN5DIKz1hneecgxoC074oql+c8fg==
X-Received: by 2002:a62:544:: with SMTP id 65mr3455783pff.46.1556220988413;
        Thu, 25 Apr 2019 12:36:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s9sm30730144pfe.183.2019.04.25.12.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:36:27 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:36:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 000/104] 3.18.139-stable review
Message-ID: <20190425193626.GB13462@roeck-us.net>
References: <20190424170839.996641496@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 07:08:17PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.139 release.
> There are 104 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 26 Apr 2019 05:07:26 PM UTC.
> Anything received after that time might be too late.
> 
For v3.18.138-105-g24b000f:

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 230 pass: 230 fail: 0

Guenter
