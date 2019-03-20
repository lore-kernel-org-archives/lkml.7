Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE01C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D787218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S1O9kHKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfCTUvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:51:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42652 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfCTUvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:51:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so2640747pgh.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g+r58zUzKkd46kafe10Zzb0WJpKDqL0ZbHfu9A1I5ZY=;
        b=S1O9kHKDYCN8MuWYYqnMF2Gyx2u8YJdgu1KvTS6/h6lW9URvU9/naiUw1uY5dNTgyq
         uwSMu3+huDMeITkU/wwPJfHV37EYgiH+1mR5v72LeVAo8iz0bfz/5XY6kpW+5HZWKWB1
         sxE6PjV9WsaObdluAUF7AmD6hkqkgQYIp4t1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g+r58zUzKkd46kafe10Zzb0WJpKDqL0ZbHfu9A1I5ZY=;
        b=GqbrJiOv8xk+cGZ6+zfOAw81ECpGQE3HUxC2j5CDfm677N+1rfYb4hmHedwN+5ZI2l
         tq0Ia9la8yj+hsRxw5/jdXX6gB4Cl1u4zxOeX9TZwTpKgZ8rrFdywQNhLbpF0/P22+/+
         5eItKhpXjGwBgq+mzM40uQVP9PFnws6zk1V2lck7LsVcEIwXBxDfbdrmqXfdTwOT/SGV
         Hw1R1UhhiVsC1wOwii979G93dKQBzefQMVcRoosQiH8rhx8SDaNyjSi6+b0ncfHL/sbi
         Ts0QtvZcxIiUtWzRzKhwcCGyKJIEPuKdLjUeHumft66Pg4sHI7H5r9gyjhpujlIc0vbX
         /hiw==
X-Gm-Message-State: APjAAAVD/tRwjwjF1p98b5/GJ/8a5KpqW+ifDgb57jN36wbTtypmKjT7
        llqd5BvK8OgHR9q/d0ubNpoDPg==
X-Google-Smtp-Source: APXvYqyXFt21Z0luGHpGxXvyHZqtzLqvwvN2RbqQuE7jMoudhSy9+GNB9w2/OxluMWf7A7zsf6fLFQ==
X-Received: by 2002:a17:902:7b93:: with SMTP id w19mr9940719pll.141.1553115103140;
        Wed, 20 Mar 2019 13:51:43 -0700 (PDT)
Received: from [10.136.4.147] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id o76sm9372018pfa.156.2019.03.20.13.51.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:51:42 -0700 (PDT)
Subject: Re: [PATCH net-next 0/2] net: phy: Move Omega PHY entry to Cygnus PHY
 driver
To:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>, hkallweit1@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        murali.policharla@broadcom.com
References: <20190320195313.15658-1-f.fainelli@gmail.com>
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
Message-ID: <b4882cd3-c6c7-6af8-2204-6627434b03cf@broadcom.com>
Date:   Wed, 20 Mar 2019 13:51:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190320195313.15658-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Florian.


For the patch series,

Acked-by: Arun Parameswaran <arun.parameswaran@broadcom.com>


On 2019-03-20 12:53 p.m., Florian Fainelli wrote:
> Hi,
> 
> In order to pave the way for adding some specific Omega PHY features
> that may not be desirable on other products covered by the bcm7xxx PHY
> driver, split the Omega PHY entry into the Cygnus PHY driver such that
> the PHY drivers are reflective of product lines/business units
> maintaining them within Broadcom.
> 
> No functional changes intended.
> 
> Florian Fainelli (2):
>   net: phy: Prepare for moving Omega out of bcm7xxx
>   net: phy: Move Omega PHY entry to Cygnus PHY driver
> 
>  drivers/net/phy/Kconfig       |   5 +-
>  drivers/net/phy/bcm-cygnus.c  | 147 +++++++++++++++++++++++++++++++++-
>  drivers/net/phy/bcm-phy-lib.c |  52 ++++++++++++
>  drivers/net/phy/bcm-phy-lib.h |  20 +++++
>  drivers/net/phy/bcm7xxx.c     |  76 +-----------------
>  5 files changed, 225 insertions(+), 75 deletions(-)
> 
