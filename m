Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFA1C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38142077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVqTmIfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfLDLcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:32:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41392 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfLDLcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:32:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so3514889pfd.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 03:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t1DNzLMJtRK+goiDA70Uvm7c9OsVkgyBu0B8lDewBf0=;
        b=bVqTmIfX+5To8Hzb9tiG2XmeGwX/wUqkaRAOOn9y3KPdfJ7KW4pPLD4KkVv0IemBFG
         6fV/IMQC5x9znOHp25Rzk3hkjmQz0218q3cSSqzwAERRFlYrVYQcFeJtgNN0T/40b7+r
         eEhFvcN15b66DK+zeVvUt4rmAuQL2bXSec1WopyLM4oP9Ss0xhIighqlUK9KHZ53xw8h
         bOyDFhKPpVv0nDEWBWFrSAX2EhpXu8f8B8CjY8XBlb6xQSg0JASCyF0F92PVFLdZfjlI
         WAb5O1vJinSNG/quGFQw+U5vQQlrLLpWAUlZzKsb/o7qTLtGNiQNWrm2ZQnxND1469qs
         l7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=t1DNzLMJtRK+goiDA70Uvm7c9OsVkgyBu0B8lDewBf0=;
        b=oEEMZuttgQLSWVi9Km3akvPUC7i8BsgSD1e8MC06MLtTE3eR1nRbM8il3S3JI2PwM3
         IozldG5aEySP5EEW7J7USsu2Ko5x+ogiDkz6eBlT626fC+LQCHpQCx2gBXhQHCb7N8U+
         i7nlbcL4i7IJWfzME8nbJ8Y4s+uMWGchYmOa88JaoXHyE2A0FJzTE24itIqsdltX5Wyz
         Kh/rBy487xOevgIUq9m5dASUDcrCEQRbG5xp1IfDk4JXL8ydQhMl358gfBOhrUh9+r7t
         hMjmr8VsY0+t/tUp/+nk+vRxopGEla9TwHYuSVCaPZ9ew1K8pycO920NUw+Mt4sfIwgO
         a86A==
X-Gm-Message-State: APjAAAXsHPb5fFtemYd3YRQQxnhMwNVA4rgFJ9B1OL4cdZW44IrgPs5m
        p7DLr4LldSMZ2DuHTEPeTMw=
X-Google-Smtp-Source: APXvYqzq95ioH2qN4ePv+7uUmsmEIMr371avMs3koxwAhMQn9lRexIrHOHUuFHnRoDxdxv6Wdj8+ug==
X-Received: by 2002:aa7:8d44:: with SMTP id s4mr3049884pfe.152.1575459171882;
        Wed, 04 Dec 2019 03:32:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id in19sm6219355pjb.11.2019.12.04.03.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Dec 2019 03:32:50 -0800 (PST)
Date:   Wed, 4 Dec 2019 03:32:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        AceLan Kao <acelan.kao@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v4 1/2] lib: devres: add a helper function for ioremap_uc
Message-ID: <20191204113249.GA2277@roeck-us.net>
References: <20191014153344.8996-1-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014153344.8996-1-ztuowen@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 09:33:43AM -0600, Tuowen Zhao wrote:
> Implement a resource managed strongly uncachable ioremap function.
> 
> Cc: <stable@vger.kernel.org>

Really ?

> Tested-by: AceLan Kao <acelan.kao@canonical.com>
> Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

This patch results in hard build failures when building hexagon images.

lib/devres.c:44:3: error: implicit declaration of function 'ioremap_uc'

Guenter
