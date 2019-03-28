Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AAEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733D4206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKIk64c6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfC1Dta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:49:30 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:35021 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfC1Dt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 23:49:29 -0400
Received: by mail-pl1-f181.google.com with SMTP id p19so4311303plo.2;
        Wed, 27 Mar 2019 20:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VEV3aCikXBkNbI3bm2LBz26nyM7vqFFnlwCeArEREkI=;
        b=jKIk64c6RPzm/wFZ+ReGuxw75P7ZlDuJ3QGcUr28CJyVTmC2+tqLpOjWuSMr9mqzHz
         kD+SMueJyBDK7ToPAaC8yXJpUZh7ZmxhCafAbpQpH+ahCAixp/aAPQFFN1EQlqoqCCvu
         JkLTayXl0psiC2wS9Ow+Oopo4jxg7AeSuReGY+sN9foPw9LDbmgCi6HJZw/2hZAXathE
         8+4bBk6/kuXVMFARbxZW82MQIErqNvXZoGi8rIWUuTNHbiegIv3u/F4fY6YAGmiu/poQ
         1X3qWU2c4JzKWIzPRQz6x25jK4c47CyKhLCRfnXp2xfN0VtJRww05ZnuZTo639mkC5kU
         UE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VEV3aCikXBkNbI3bm2LBz26nyM7vqFFnlwCeArEREkI=;
        b=fekYPEbgSs6WKfqJ/t1IYVnChSmhw5xT7bgIaqW/KvepvbTCPIUBI3Y7f4bl3Idr3I
         f+LozdWkkq0DtQcxr8WIkRTRGQd9lxeY7BTexiZT4ToNs8wasK0tyqj7tbn8Mey5RVV1
         hwyCNZdmYgvkFOo9Q861Df91dfXbW5tZfneJ6zgKI24Xry5jizNeXOnY8YDSApAy3Kka
         /lKtdY4A3rx+o/27ZFCrjEKfZlNGHY8Jb04QH+m2s8Zmwh+ETva3tT9U0fg2+WzrH+qq
         J4dXEue0hWiy9256JrtcsI77G/Zjj6s2DH6T6V/dHpRU93NSGBqpxEP3fJbBjgGUn5yI
         FD6g==
X-Gm-Message-State: APjAAAVchYvVh3WNxIBJBUjvvDaOdKmAGejmM08jkAArKkqkoDV81Jmv
        enqIesSyEf0ZfU9auGRvR89EfkU7
X-Google-Smtp-Source: APXvYqwWWwFbk6JLIuH4D1z0IbQI/sMxp7KM72abGEAiLJMw0TM/v7RTbhk3RYTet8xHStwxVbo2pQ==
X-Received: by 2002:a17:902:8d8b:: with SMTP id v11mr41359651plo.241.1553744968817;
        Wed, 27 Mar 2019 20:49:28 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id k17sm29579492pfk.166.2019.03.27.20.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 20:49:27 -0700 (PDT)
Subject: Re: [PATCH net-next v5 20/22] ethtool: set WoL settings with
 SET_SETTINGS request
To:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
References: <cover.1553532199.git.mkubecek@suse.cz>
 <19b3da19441d0c8884c2cd07cb31acf83de89163.1553532199.git.mkubecek@suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <a45ede76-730b-e9e4-3f6b-e69760bff1f9@gmail.com>
Date:   Wed, 27 Mar 2019 20:49:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <19b3da19441d0c8884c2cd07cb31acf83de89163.1553532199.git.mkubecek@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2019 10:08 AM, Michal Kubecek wrote:
> Allow enabling and disabling wake on LAN modes using SET_SETTINGS
> request.
> 
> ETHA_SETTINGS_WOL nested attribute is used to set or modify enabled WoL
> modes and SecureOn(tm) password.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
