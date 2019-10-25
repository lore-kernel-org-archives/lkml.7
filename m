Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFA6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845E320684
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6JKuvB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394367AbfJYOXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:23:03 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36143 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392999AbfJYOXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:23:03 -0400
Received: by mail-il1-f196.google.com with SMTP id s75so2009519ilc.3;
        Fri, 25 Oct 2019 07:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ePhtzU5NI6z2BX2GKzTIAEd2EINs+iRTKDQWAsMttns=;
        b=V6JKuvB8C9r57btbIHWT9QPSij4Qf9wRAL966ReKuoUJJQsIL7YcP62zdSPHfNJdhS
         BRJYHY6s2yx/0uMtNUNPftQ2Q3WVS64fUCSIW0D2K7ljqduyMiKms6uxLENAtGvOVesG
         m1R74DhamLyH8vrS28kWW0hlDZnj/6+3o9G9AJi82IYKOoMAhfWr8g8ZYp2IziO6l5Ps
         ejzCcVf1U3a/YY1w6ZZDCTQeBkHzQVh8oWAtLn9KNUur1v01Jo/c/OfI8eOOqDbhoCM2
         SSOxSRZqdbrV69DMcKz4zCQ4LRW4iXiT/dHttQCMW7zOxHbQc8r76055f/GaCCK7903t
         SNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ePhtzU5NI6z2BX2GKzTIAEd2EINs+iRTKDQWAsMttns=;
        b=obtC0t7w2c+PPtd4kf8SytFD3NWiy3HVsVYB6iOx6penPGjg2UCEGoPy2+G2qDbEiW
         +AE7pbHDqx0PHJTkUj8a+qMD76TTzsCRAi3qat5Bg7VlSrgvY0hLy5b7RN5loQc5o71c
         vuA/+XU2dSVm1F4smidCGzutIyjhao2U9zeKBIV7Dx8vAcK2J7+MEdVv02kW1ger2D8L
         hmblUOZlHXTV0XKZo52g8VvatkrBTqBELA3Ld3256UGfmnfPkVNp4AOODL07jVzyAGsA
         DRLxoS2YluLLHNowEyiQAaiVlIsxQa8x64mF/Ch9POB47aH27HMUb5QeAes6z3NpE+zj
         idDA==
X-Gm-Message-State: APjAAAXLf5tQ2DsxpR6rckcKrOP2yBoSUCiZF+pQWY4kLlpAGZbs9dPS
        xeFe9ep2QWm/CKYI/D/7Qd9ltZxE
X-Google-Smtp-Source: APXvYqwd5FaJDyLRZxvSrDF+ugbwgjF6WU/G/6DS2v6aOS1/J+mH1PSz7Wdg6gxoi7G+N9WlwBonpQ==
X-Received: by 2002:a92:9a54:: with SMTP id t81mr4282508ili.147.1572013381778;
        Fri, 25 Oct 2019 07:23:01 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:b19c:9c8b:8bde:d55c? ([2601:282:800:fd80:b19c:9c8b:8bde:d55c])
        by smtp.googlemail.com with ESMTPSA id j21sm297593ioj.86.2019.10.25.07.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 07:23:00 -0700 (PDT)
Subject: Re: [PATCH AUTOSEL 4.9 19/20] ipv6: Handle race in addrconf_dad_work
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Rajendra Dendukuri <rajendra.dendukuri@broadcom.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
References: <20191025135801.25739-1-sashal@kernel.org>
 <20191025135801.25739-19-sashal@kernel.org>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <f3c4a11c-b5b5-455a-6c88-83b8cc56623d@gmail.com>
Date:   Fri, 25 Oct 2019 08:22:59 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191025135801.25739-19-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/19 7:57 AM, Sasha Levin wrote:
> From: David Ahern <dsahern@gmail.com>
> 
> [ Upstream commit a3ce2a21bb8969ae27917281244fa91bf5f286d7 ]
> 

that patch was reverted in favor of a different solution. It should NOT
be backported to any releases.

