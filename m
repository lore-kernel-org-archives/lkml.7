Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1714AC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1B120880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dxarpl8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbfDHKVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:21:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40991 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfDHKVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:21:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so7357935pfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W13ir/3O4kQtJcvEFgEzE8M84aMPh80E8shkyCcmrhQ=;
        b=Dxarpl8cgx29GxFDAS7SxpwcLQbKg2Dvp5vG4HrT/fFafnmk60oLfcKJOEIE5EVkNw
         /pYz772fK4UHJtey7FtWuEgzsLLfqIP+Irmx52pk/+kw7d+W+OyH8m/3jpvGzqgXbzhI
         9KMvgZxEuWvOYhX3NbfbE+SN1GNW+Y39VW7hOTf5SQ6NGp8XhZxDlswvaWQGeVXP4e+0
         ufpcz4JA3T6jwsJIhi0eEs1cC1yXYBygYfAgYnAcLOY6RMVdusUPyCp0xGuOVLUhCL4c
         2LVqOXosi5ArfN9fBFpD/8BxyxrbmQ7jNJVloqTXaQFBC1SRlhJLu0vAo1OUq/pdQIZo
         Sy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W13ir/3O4kQtJcvEFgEzE8M84aMPh80E8shkyCcmrhQ=;
        b=GviG0h1fJDxVpsD02mD5IACcw5YVGKqSNijiukB7+pgeltrhL479eifLneWZqFUyLB
         576KU0DlZHTikQv5SR90RlMn5ZN5q2ARVIkAcqYxixNAxwftE7ZEBSjas3A1witZZKkz
         d6CuzbMQ7xbD2+0W/g5mUGUaaAQ3N/IxlhbWUTsAhORmhL6uloOW9+rABvtzKdfc4zcT
         RowO5MPmFuy5PeitRaBd8oWqbwT8CuHnMyAS0QHMg2b2hj4DpdycNXH5LO43DyjZxsGV
         Mo4rPCs56jG9eb3yEiOIEc/ZfvQJWJ553C40dZCriLkprdjJkpXhzUCXgiB4xSX60kLP
         wNvw==
X-Gm-Message-State: APjAAAVjQxG/ccIIFu/mh63PMR+Fx8iEN3sq5m88tHCMZDEbxPAkQzaF
        IxkpPL0CTd0W2odzjTbjC6j1nA==
X-Google-Smtp-Source: APXvYqwxFhnB9dPeuD10c50fkcf9nVu79YtQWcFipFxNi82iB6EkKf96TBdBleIVJDB3DsmI2uEh3A==
X-Received: by 2002:a62:5582:: with SMTP id j124mr29254633pfb.53.1554718896145;
        Mon, 08 Apr 2019 03:21:36 -0700 (PDT)
Received: from localhost ([122.172.162.162])
        by smtp.gmail.com with ESMTPSA id l192sm14128086pge.42.2019.04.08.03.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 03:21:34 -0700 (PDT)
Date:   Mon, 8 Apr 2019 15:51:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/7] cpufreq: ap806: fix possible object reference leak
Message-ID: <20190408102132.jeuulxxwkyvbppdp@vireshk-i7>
References: <1554082674-2049-1-git-send-email-wen.yang99@zte.com.cn>
 <1554082674-2049-2-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554082674-2049-2-git-send-email-wen.yang99@zte.com.cn>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-04-19, 09:37, Wen Yang wrote:
> The call to of_find_compatible_node returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./drivers/cpufreq/armada-8k-cpufreq.c:187:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 130, but without a corresponding object release within this function.
> ./drivers/cpufreq/armada-8k-cpufreq.c:191:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 130, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/cpufreq/armada-8k-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)

I haven't received the cover-letter and patch 4/7 (because the tags in that
commit were incorrect). I have applied all the 7 patches to my cpufreq tree
though.

Thanks.

-- 
viresh
