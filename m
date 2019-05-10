Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38F6C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AF721479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+ZIn2zU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfEJQq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:46:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45612 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbfEJQqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:46:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so3265034pgi.12;
        Fri, 10 May 2019 09:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2AGOmiDwayrK2Za4B1eEP+agTXn2R+Lt+JLsatUIQRQ=;
        b=m+ZIn2zUaHX2MzWv1vnowmyMiFHdH3xZowTvfWXYMcI8G70Azi+pOFPLR7+V78Byy2
         uhF3oYNxzE2sDgsU7BrhKT9LvamrNOke4tYdahPjE7R/DawhYR8oKfWU90Iiiycthqu0
         lN2vhYs9IElW+MCaCo+H37PXAvyQqTKD7q9cw2iRiI5FzcGE2brhj3zRObfp7P+c9O96
         qK0NOjhKSj3L/W7dk779p981Z4jTEidgCzAFGlySBPyaOSw/MSeotI6DwEiUETxWHGOd
         jumRxPUpYIfPHM//2BXPYibSSeOBtrsFqyeyCE1T3Rq0szxHOzS2hivx9XixZcfEQmqH
         ZZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2AGOmiDwayrK2Za4B1eEP+agTXn2R+Lt+JLsatUIQRQ=;
        b=Ci6g1d/fumAzIVJZcAFuvrOaB/CyOlxFvPvK/d9WLMhWXGeV+ZoBo5PN49VFgans7k
         gYb30xqukqDlNSEdBQ8/jySujSvRq9cyckw69gmuYAjH6zxfTdYgJHo8FVlqZwl2ZkJc
         gshN0llRT14e8PHsmRto3JRhOivPCrjhmutbuI5u+S7BMv/jU9VLcuGPpU7ym/Zix08r
         qUDqzdpkfelKoEckBlQVhtc99iAEkaM07NY8/gmNUoxOCcK4nxPO26jXcrZrKb9A+nKZ
         Y7CsYFiemOmlc7f1EeSpgmy0Znur/Vetrwz9kmeqqW1ALUqgSyWZRZ2pw6byHzLvfxAw
         4NuA==
X-Gm-Message-State: APjAAAWwSqOCsECqtZd/4dCPnSGDQElWwkGYEBudkdpS5hf85lMX0Qow
        p9YkmlETxb4OKcEryCc8N7k=
X-Google-Smtp-Source: APXvYqwZLmDD1T3k8WCyDcpxzK5H/iahqF2ClRTp723zvoRlx6arS5+wOyKxvy8vK53uR2UhwhfmnA==
X-Received: by 2002:a65:608a:: with SMTP id t10mr14879618pgu.155.1557506784788;
        Fri, 10 May 2019 09:46:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m21sm18114518pff.146.2019.05.10.09.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 09:46:24 -0700 (PDT)
Date:   Fri, 10 May 2019 09:46:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.1 00/30] 5.1.1-stable review
Message-ID: <20190510164623.GB21034@roeck-us.net>
References: <20190509181250.417203112@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509181250.417203112@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 08:42:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.1.1 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 11 May 2019 06:11:35 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 349 pass: 349 fail: 0

Guenter
