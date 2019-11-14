Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F068C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BC82068F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="YUThzm3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfKNAQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:16:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35146 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfKNAQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:16:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id q22so2467017pgk.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fC5YIN5NtZi/DXcKOnXzYS9mKERKZFP+XZ7Rx2pmg4o=;
        b=YUThzm3hWkO+B3k6fmOD9jjOo22nIUdns6Nk74aoOjhQGWKp8wCMXp81efO21+PIHv
         61haGe1mJkGBs/aEIJni/10z8i9W0DuN45uIdFEXNEotqthFlNUjXdK9zLQBBN5M7Tmr
         Z0O+CmPg1wg9Pulrjk6ThTJyN0zr3/GNZIrKK6OCdO6loYg+X+Cm4im1X1Gu8LNmDiwn
         A2XUoje+m/KmT68GxiFyquVHJyFS7e8edM2B3qpKsrRyWcVQznJzAEsymUTdVoXvSYm5
         kluK8yO6qQHhdLiabAfo5cDczDWYOFGhhNSqrCEjFGo6I7oQmxeYoTTXRWWZU545C0tR
         ccwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fC5YIN5NtZi/DXcKOnXzYS9mKERKZFP+XZ7Rx2pmg4o=;
        b=M0MwBUvugpcPLinLbQmwWV9flmEHhEjj34LPoaloto/mzSjnHuZ6k8YI1Q6A85ALYd
         q/ADO0DRXRAIwc3SKjlyo5t1tORuQCkrrz+OgmEmhWTn1jxUoTAem+bDcc/fWbc57Hao
         4QAhu63t0NU9UVWs+0hHng7lSVsFRMHbmds+manJHfIF1cKMVmhY1In+CVmQuNOnHbX3
         D/asowfJmaPfz7F8XcckjgEw33DhY/CJ4lRIZ9+EqlAJuTXxxk/Rb/Ud2DdnsxWj5gEe
         YyT4+QEaDLJvFG+m094AUzLiQGaBHBqcfAF8WNPCH8j0OadphGrq9Sx3QznFAf1Z8l3C
         1A4Q==
X-Gm-Message-State: APjAAAVcaNG6y0IDzKMoJVOeP5q/sxEw7ERSG0mNQk2yuwBn4LeYFuRr
        xDwR7pzx943OSmrsog+xnHfeB4amc+oyRA==
X-Google-Smtp-Source: APXvYqxNviRurndtGovBnwGXDIHYmz4ZT6TjBRz225KDObJ42eWctFiGh5td4z/a5LiJCy3brTIu/g==
X-Received: by 2002:a63:ff46:: with SMTP id s6mr6839305pgk.337.1573690599971;
        Wed, 13 Nov 2019 16:16:39 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id j4sm3984530pfh.187.2019.11.13.16.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 16:16:39 -0800 (PST)
Subject: Re: [PATCH v2] firmware_class: make firmware caching configurable
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Tim Murray <timmurray@google.com>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
References: <20191113210124.59909-1-salyzyn@android.com>
 <20191113225429.118495-1-salyzyn@android.com>
 <20191113231602.GB11244@42.do-not-panic.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <33f2baa2-944a-2bfc-1c50-0e437bf11959@android.com>
Date:   Wed, 13 Nov 2019 16:16:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113231602.GB11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/19 3:16 PM, Luis Chamberlain wrote:
> On Wed, Nov 13, 2019 at 02:54:26PM -0800, Mark Salyzyn wrote:
>> +config FW_CACHE
>> +	bool "Enable firmware caching during suspend"
>> +	depends on PM_SLEEP
>> +	default y if PM_SLEEP
> I think the default y would suffice given you have depends on PM_SLEEP,
> however this also works. So, again:
>
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
>
>    Luis

Worried about setting FW_CACHE w/o PM_SLEEP, this enforces it.

--Mark

