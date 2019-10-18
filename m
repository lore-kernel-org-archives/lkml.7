Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6944FCA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EDA2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rq4Rw84j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442038AbfJRFla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:41:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43103 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389961AbfJRFl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:41:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so3129840pfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p0ZcA5/U4vLBP3fm6ZAT4nlCcb5dQ4JwVYP/+NI5L6w=;
        b=Rq4Rw84jFpBv+yeL1kstTX8oUutO2S4aOm/OKwIv0HgnEm+eEWyDVp+n+8sV/yLTlp
         EKNLZNFpF/6t0n6akdQb6609x3y19LkwO48lMQrq+mLQ1bv3DpCLuS5ohwyegSa08yKf
         CqkF4CgAc0jtuOKIUMudTnVuk8MMCG3MVyIYs/YU61Hbb3zRxI9JgxFWiUWZQVwz1yXa
         eHuGTbH/apzwV1r0LiLS5r9Rz8N51bC1LcbgWN7HuAoMf5BD+d2ktkJ6+tg7EeE22NTL
         e8MhubDpr7usb9CeDrkGO0y+6iqpx2UuYMg/Op6fwXmBI+IStEyRnouVbgCXf0NRZJlD
         rWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p0ZcA5/U4vLBP3fm6ZAT4nlCcb5dQ4JwVYP/+NI5L6w=;
        b=a7BNXfbr5y2rhPFH5h74BZlUMwmrLzNaV4yQSWa3vi1SWW4FPTwdkzEocQluQamUWb
         XCrXeyuC6rx998oyCooXvR933bn9P9sRey+/wCPLNHJM1RCxtGF0AwEs5EO7RVmMvLX1
         YAidbLfU6jP2i9US+4i8ogzRqrMArQeNV0tXbEeir9KVTIaWqQ0KtK8HkaozRBxxNWVu
         eUhvHHUH8IYTDWF+iRPVq4Fd61DR+g0oz1ebqSBsMSur06jY9curv57UyODJYIokdutX
         OwD96XEAjqeqYEzzd66KLKiTAxDizDd4aKAa4Jb8CDKKUVxw1Z0c6LndLAW+W6SC9Ooe
         4I+Q==
X-Gm-Message-State: APjAAAVolVCtZaH04prxbksV+KtH35BMuMqJZ45EhkYUo7Mi0duF+lgW
        cm7wIgwySQTTOgiyyGQ3+Tq/TqyPdfo=
X-Google-Smtp-Source: APXvYqxCBYnbkeb5IZKjGre+6VciDOyz3GYaUWRD7jLEy8anyNUwplve1VOtoA2UYkJzC8Y5d9VTag==
X-Received: by 2002:a17:90a:9406:: with SMTP id r6mr9337135pjo.0.1571377289149;
        Thu, 17 Oct 2019 22:41:29 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id k17sm5036033pgh.30.2019.10.17.22.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:41:28 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:11:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFT][PATCH 1/3] PM: QoS: Introduce frequency QoS
Message-ID: <20191018054126.n7zsqut7z3hzh7bc@vireshk-i7>
References: <2811202.iOFZ6YHztY@kreacher>
 <4551555.oysnf1Sd0E@kreacher>
 <20191017094143.fhmhgltv6ujccxlp@vireshk-i7>
 <CAJZ5v0hDhJrCWnPxbV54yWAB=DKCLz33Sq8J4kXtqH4+mJn2eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hDhJrCWnPxbV54yWAB=DKCLz33Sq8J4kXtqH4+mJn2eQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-10-19, 16:16, Rafael J. Wysocki wrote:
> [Also note that the current code in device PM QoS uses MIN and MAX
> here in the same way. :-)]

Stupid me, enough embarrassment for the day :(

-- 
viresh
