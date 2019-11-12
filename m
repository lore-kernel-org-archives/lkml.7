Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3461C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9100B204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="aPZJaNpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfKLIwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:52:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35863 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfKLIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:52:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id c22so2015785wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 00:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/4ilrxOZ4QdJ3UAgm96VMI/hVQ/UHpZg4vUaW945RSk=;
        b=aPZJaNpEqDsGZd07oyKR/UqP127LqAjk+WBw7hwfVMN0FoWn8Kz88BWPovdn0p0Hdn
         etVge4dcyyOlncyHRIp/SrzCa9jixeA5xTceibSlk3mTdSH0nZQMqE/TZ+vZ65lu7RE9
         BdWtvuS4aObI1J8/ycZGmCHJxbd9nW3KX7Xu0ZzP8cLosg2EMYs3FApz/KQp2bB0n6hL
         cL7x1GCaxz6Bephfjz7MZG1CIImNYgbbiowJitpiferperrMn/vk3gE8ULGd2hiGCXFN
         CQKL3pU50oO41lZsHvZQvb7tJ351KhVVEFYBOy5Jr/e0KJPJ0WFdYi4bkCyxbTA9+jUg
         FuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/4ilrxOZ4QdJ3UAgm96VMI/hVQ/UHpZg4vUaW945RSk=;
        b=KNtUbAa5FLmL2MtRj02Pt+g9qwV1K32DxAdwZk20iC1KhL5hKY7IeARKe5vhGWcn7p
         tfJmymsqbeX7PX51fpOagjY4aqiuy2nTk5rexeZ9ZWrlM6/73K22y+Ad9ZUN1e4+XxqM
         WDWj6aQYBUnRM32KRxGpYbGFV89xNSY062TzuIqhjrolARdyI0AgPDN/biXOtPbjUkHd
         kCcK/uzSWidDeXLfYONUbvr1lcSuXsTxh03YLDti4ubrl0UKZT87J6QUHVd24eHLefOj
         6dZ24znuAZ+pWowoib1gqOOHi2P5H9biEAxgeb5pvMAtrnUSOdvEtSvIS565MjTLEfey
         MoaQ==
X-Gm-Message-State: APjAAAVeYyL0rMf0ptMqkcGZt/fFC5K37804iB+skzaC2ibwH2xdGh80
        oDn8CkAkLzXdqz7HrYFPxJscHbQu2UY=
X-Google-Smtp-Source: APXvYqxB+LhiAPOVc20S1pf0/sMiK+DUibXaSNSdU9a5OrptV2LYhTLqmvcVDk0wDC06CP5vUIyMdg==
X-Received: by 2002:a1c:3843:: with SMTP id f64mr2652366wma.129.1573548767671;
        Tue, 12 Nov 2019 00:52:47 -0800 (PST)
Received: from ?IPv6:2a01:e35:8b63:dc30:3456:63b2:eba1:f7d5? ([2a01:e35:8b63:dc30:3456:63b2:eba1:f7d5])
        by smtp.gmail.com with ESMTPSA id 72sm264150wrl.73.2019.11.12.00.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 00:52:46 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 1/2] openvswitch: support asymmetric conntrack
To:     Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc:     Pravin B Shelar <pshelar@ovn.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, dev@openvswitch.org,
        linux-kernel@vger.kernel.org
References: <20191108210714.12426-1-aconole@redhat.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <eb0bdc35-7f29-77c7-c013-e88f74772c24@6wind.com>
Date:   Tue, 12 Nov 2019 09:52:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108210714.12426-1-aconole@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 08/11/2019 à 22:07, Aaron Conole a écrit :
> The openvswitch module shares a common conntrack and NAT infrastructure
> exposed via netfilter.  It's possible that a packet needs both SNAT and
> DNAT manipulation, due to e.g. tuple collision.  Netfilter can support
> this because it runs through the NAT table twice - once on ingress and
> again after egress.  The openvswitch module doesn't have such capability.
> 
> Like netfilter hook infrastructure, we should run through NAT twice to
> keep the symmetry.
> 
> Fixes: 05752523e565 ("openvswitch: Interface with NAT.")
> Signed-off-by: Aaron Conole <aconole@redhat.com>
In this case, ovs_ct_find_existing() won't be able to find the conntrack, right?
Inverting the tuple to find the conntrack doesn't work anymore with double NAT.
Am I wrong?


Regards,
Nicolas
