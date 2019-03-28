Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E8DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112E3206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfMVxekm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfC1Dsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:48:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43199 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfC1Dsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 23:48:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so10690281pfd.10;
        Wed, 27 Mar 2019 20:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ccFezFN33u+ZDKzzfcQgVAx+T2jfJJF7pG5VljNcMgI=;
        b=jfMVxekmun88/r6Do7eNP28YredmZDJPaTNASDX28QLU6lJU2u+MhAXxz43kcpvWlt
         JDGV9fCcwzPu7FQ320mD+XBQH0pIlsCOZIY7nxnplHarqCp6Lg2leJb73QLkh7q9xSCI
         stVzmvbFXt+8tUciKet1SH9xqGfL90mMiGGQYiUx60EoTPDrx1xNiPQ+nI8gu8/zGBQj
         +sWKj9YVjHZ9pXO5GAw5oZLTYe2DUhgXRyBQ84VTh2HFjGPVgX8AYx//M6caIsFH/QrJ
         e+Yc/z7Q0sDoRYLbb7dzk4xPrgV39jn3G8N+tEe/T/a17xIAkBhArr9fZrWK9jpMlKMp
         yHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ccFezFN33u+ZDKzzfcQgVAx+T2jfJJF7pG5VljNcMgI=;
        b=s5AafLQb6rgPc+8Q1hc62jtxSi1SGK6pVpNuii2IktPvS8RwcU/U6dZPcXO40EL87h
         WTv+/TSB02o+nOCEvgFm8ihQCPUjKMTbqeVu6WljNAQpCdjYFPqpWADNR21AYHIEemlh
         4JEUBMw/xJBwS+ZwmTCgj0CkvgI+Yz1//6iIdX/XDC8isgWeOtv5wEB+rrSVIrNennnc
         eFUDWB9jVJIZp1UhxYFR09FWyZJWFisJzY9goSv251nyB4v6OMKMNx6qQatgUVMJQy/S
         ppcugb2oe9ZP8OGNfNQX/rn/KMZeGYaUzVGfCY8IvoPnFSsR1hVIraTjLn0JKdDH2zYp
         /8vQ==
X-Gm-Message-State: APjAAAX6djwVDxt1CMsYrsNOvRb22SFnrxLUWTgc/S+lP9Mo//LU3rBf
        B+9iJXcgZ5BoXO4QVCrKdopxZjkG
X-Google-Smtp-Source: APXvYqyYzGaNynt0w6zuPVQGSQqZB/Yi8TJoHMQJyIP7CSbh5Fn/OrmS7pRyivjvti4sXz4BeLILaw==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr14191961pgj.396.1553744917942;
        Wed, 27 Mar 2019 20:48:37 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id h13sm30774675pfn.114.2019.03.27.20.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 20:48:36 -0700 (PDT)
Subject: Re: [PATCH net-next v5 22/22] ethtool: set message level with
 SET_SETTINGS request
To:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
References: <cover.1553532199.git.mkubecek@suse.cz>
 <901fe605465ab8be78026ce2da21c45ea52ca3a3.1553532199.git.mkubecek@suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <8f62bd3b-68bb-e0ed-64aa-c0b8399127f9@gmail.com>
Date:   Wed, 27 Mar 2019 20:48:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <901fe605465ab8be78026ce2da21c45ea52ca3a3.1553532199.git.mkubecek@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2019 10:09 AM, Michal Kubecek wrote:
> Allow setting device message level using ETHA_SETTINGS_DEBUG nested
> attribute.
> 
> Unlike in ioctl interface "message level" is called "message mask" (as it
> is in fact used as a bit mask) and put inside a nested attribute to allow
> future extensions.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
