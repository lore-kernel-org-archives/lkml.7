Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231EDCA9ED1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 15:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDFE2080F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 15:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI41sgD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfKBPSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 11:18:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38177 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfKBPSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 11:18:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id c13so9005001pfp.5;
        Sat, 02 Nov 2019 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pf5kJVwgXcfe9B9zOMWVoZc4vlsqhIagn6FLoLNF6Po=;
        b=BI41sgD57Ac3b+Gi7Lyki8iyOmCzJCvu7I41CNmSx3UybDNDpuzql2KwYP8uWeBolL
         whzfoNYn6nYgsURJfFbNtz8s+Z0edUflbZqmB4EiY+bWoFXhniMyeCYqvNumgjtYGXL7
         0ENOKmx8tKNPogs1KhLMeV3sKuo4CMJ03GpU/SGaRTJBq5aIUZzjsuNEobDcBqlBJ4q+
         Ti7dxCvFa1isBZMjLa1IZ6BK/JNt1d3/CZZxZMXWQO4w6w/xjqDbI8U8K7Lug4wUcjiA
         jqoaiWTpPYbKCDEn+eS+S8peOK8VwDHV7GGeZ3MgCAFdV9K1BcDOnXZ0xYN+hSaxRsVG
         vOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pf5kJVwgXcfe9B9zOMWVoZc4vlsqhIagn6FLoLNF6Po=;
        b=im3x40zk23NaHiVqwOeX6y2OHyRAhB/goJLUIEvCupSxWnSk/t/G/6zTrdzipY1Atd
         FzuTG1kmie584W5AhSutmYiPUmztdrXvBTekrX2rOYL7eFhOFR+p9abDQUVU5cKMs3YL
         8vxYd/iHHFXdzHPm4sZ4PbmcIc6ozSuUiB3456F9Cc55SZecqjrXZ8vqQf33ukbfzyKI
         W9tJ6PRaTcreaDx8XTABgjX/gG5od8jOtaNUuRQvsJXQxtLB2TYUzaYl7hLvEA6rfnA6
         1BOrScDebDAeRNH1FqI5rBZ8pOygvSb10C/MmAd8m7vAyLIRD4pCNaH6MQCagUmJEPHC
         rVhA==
X-Gm-Message-State: APjAAAWLi2K2LZ4o9YfgBZfcPqB3fRdqrQbMYvFgW350dajGJmo1gm6u
        CkK6pcRnqCEAt/uFQsdk4Ig=
X-Google-Smtp-Source: APXvYqy3MReZbMUoAx7amLghNCcnNvBxw7vDoLCm92p+yy86PO7CwM9Mr5He1JcdcJc/jF5o8BUkBw==
X-Received: by 2002:aa7:8e0a:: with SMTP id c10mr20346790pfr.166.1572707896585;
        Sat, 02 Nov 2019 08:18:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r19sm9583872pgj.43.2019.11.02.08.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Nov 2019 08:18:16 -0700 (PDT)
Date:   Sat, 2 Nov 2019 08:18:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     rentao.bupt@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Subject: Re: [PATCH v2 1/2] hwmon: (pmbus) add driver for BEL PFE1100 and
 PFE3000
Message-ID: <20191102151815.GA21822@roeck-us.net>
References: <20191029182054.32279-1-rentao.bupt@gmail.com>
 <20191029182054.32279-2-rentao.bupt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029182054.32279-2-rentao.bupt@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 11:20:53AM -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Add "bel-pfe" pmbus driver to support hardware monitoring for BEL PFE1100
> and PFE3000 power supplies.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

Applied.

Thanks,
Guenter
