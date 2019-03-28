Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333B5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05202075C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBSBq9lI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfC1CaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:30:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34611 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfC1CaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:30:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so10895245pgq.1;
        Wed, 27 Mar 2019 19:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pLmlnQQV3axGzNMMxyRd6miDdTXw854xqHJbc6RqKHo=;
        b=PBSBq9lI8QtyybLxSNoNfiXx0NMm8pf+AxsFADe9r9c5AnTSgiE4l+yWEyB8b3Pw5s
         SLoeCXDspCh+FjdVYd6bB7LCN9tCyZwBi9XOKIXTCJ1SMW3PONj9811Z9ZRsKIYxBhYF
         IO1ybfhVnfb+tEbWmLauN5kO2Fd23zZdguc0VMPB6L0vVChRv0V60nmnimNQBO3T3kid
         CR1WumjjPLT4SXHYjwnaIUlVWfZp15ZEQE259a2N4OiMvSo6bFdZbiNaxG5dVi7QQYyl
         634n5Omutie/Vl2/z0keQi36uQ/BvfQiRIQp2STjVP07OGs1gQrwyKd43l/RctT87zv6
         wmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pLmlnQQV3axGzNMMxyRd6miDdTXw854xqHJbc6RqKHo=;
        b=jk31Ae03JPYYHJILqIUG7HbXnxxmyZx0noiWngnoB82PcUH/TBzu+OcvTE2Dol3lUm
         9IcxYRFgEULlldY+OSegJHNj4Do1nuhD3HBmooKqR0t1hpVAsM2ZxxksM/WLlTKXp17o
         8a6HF8k6fJJsH4le/VvfCNmY98cO9srP5mzvWaUL5U241AtdPSk3g/HcL0FGuXIH1KA6
         yBMJv4H1DGLn8KXw6doYcuLKd0nDcM0ICbbif4GZKeHHtIRXn6br341Euq+hb7dJsdVQ
         cIBgqn3WNxGcOnL2VZrZUzpa8cRXz+sZVkKEelIeMhsLinrZ+0MAjotQtImIMDMwMq8F
         CL+Q==
X-Gm-Message-State: APjAAAVJYDMbm0sLlWeHv+ZWY5YVskctLG57d8U9CTDDX8QRFS1+6SHF
        pQkC0WMP+gs4tFRGnIh4FsKrfB2i
X-Google-Smtp-Source: APXvYqw1WgwPUX8EnmqFyZH5Sgg8YSmoVPZevWFdhGVeeuP3d4VHi43gZf7CxHypYdtuv7MUIU+4ZQ==
X-Received: by 2002:a62:121c:: with SMTP id a28mr38056868pfj.58.1553740214048;
        Wed, 27 Mar 2019 19:30:14 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id k72sm64732238pfb.122.2019.03.27.19.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 19:30:13 -0700 (PDT)
Subject: Re: [PATCH net-next v5 13/22] ethtool: provide driver/device
 information in GET_INFO request
To:     Michal Kubecek <mkubecek@suse.cz>, Jiri Pirko <jiri@resnulli.us>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
References: <cover.1553532199.git.mkubecek@suse.cz>
 <b7aea4b2642b2fe6f12cfb843a03154f584f3bf6.1553532199.git.mkubecek@suse.cz>
 <20190327201411.GH14297@nanopsycho> <20190327222554.GV26076@unicorn.suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <6e5fd327-d2ba-1b8d-44ce-fa975c73bffb@gmail.com>
Date:   Wed, 27 Mar 2019 19:30:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327222554.GV26076@unicorn.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2019 3:25 PM, Michal Kubecek wrote:
> On Wed, Mar 27, 2019 at 09:14:11PM +0100, Jiri Pirko wrote:
>> Mon, Mar 25, 2019 at 06:08:33PM CET, mkubecek@suse.cz wrote:
>>> +
>>> +Kernel response contents:
>>> +
>>> +    ETHA_INFO_DEV		(nested)	device identification
>>> +    ETHA_INFO_DRVINFO		(nested)	driver information
>>> +        ETHA_DRVINFO_DRIVER		(string)	driver name
>>> +        ETHA_DRVINFO_FWVERSION		(string)	firmware version
>>> +        ETHA_DRVINFO_BUSINFO		(string)	device bus address
>>> +        ETHA_DRVINFO_EROM_VER		(string)	expansion ROM version
>>
>> These are already very nicely supported in devlink. No need to duplicate
>> here.
> 
> They are supported by devlink as an interface. But devlink itself is
> only supported by few NIC drivers at the moment:
> 
> mike@unicorn:~/work/git/net-next> grep -r devlink_ops drivers/net/

You might want to include net/ in your list too.

> drivers/net/ethernet/mellanox/mlx4/main.c:static const struct devlink_ops mlx4_devlink_ops = {
> drivers/net/ethernet/mellanox/mlx4/main.c:      devlink = devlink_alloc(&mlx4_devlink_ops, sizeof(*priv));
> drivers/net/ethernet/mellanox/mlxsw/core.c:static const struct devlink_ops mlxsw_devlink_ops = {
> drivers/net/ethernet/mellanox/mlxsw/core.c:             devlink = devlink_alloc(&mlxsw_devlink_ops, alloc_size);
> drivers/net/ethernet/mellanox/mlx5/core/main.c:static const struct devlink_ops mlx5_devlink_ops = {
> drivers/net/ethernet/mellanox/mlx5/core/main.c: devlink = devlink_alloc(&mlx5_devlink_ops, sizeof(*dev));
> drivers/net/ethernet/cavium/liquidio/lio_main.c:static const struct devlink_ops liquidio_devlink_ops = {
> drivers/net/ethernet/cavium/liquidio/lio_main.c:        devlink = devlink_alloc(&liquidio_devlink_ops,
> drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c:static const struct devlink_ops bnxt_dl_ops = {
> drivers/net/ethernet/netronome/nfp/nfp_main.c:  devlink = devlink_alloc(&nfp_devlink_ops, sizeof(*pf));
> drivers/net/ethernet/netronome/nfp/nfp_main.h:extern const struct devlink_ops nfp_devlink_ops;
> drivers/net/ethernet/netronome/nfp/nfp_devlink.c:const struct devlink_ops nfp_devlink_ops = {
> drivers/net/netdevsim/devlink.c:static const struct devlink_ops nsim_devlink_ops = {
> drivers/net/netdevsim/devlink.c:        devlink = devlink_alloc(&nsim_devlink_ops, 0);
> 
> That's 6 drivers from 4 vendors (if I don't count netdevsim). And I did
> not check if all of them do actually provide the information shown
> above. On the other hand:
> 
> mike@unicorn:~/work/git/net-next> egrep -r '\.get_drvinfo' drivers/net/ | wc -l
> 240
> 
> Some of these 240 lines assign the same handler but not enough to make
> me optimistic about being able to implement "ethtool -i <dev>" using
> devlink interface in near future (say few months or one year).
> 
> I'm all for implementing new features which are are related to physical
> device (ASIC) rather than network interface only in devlink (at the
> level of kernel-userspace interface). But for features already provided
> by ethtool (userspace utility) I can't help seeing the state of devlink
> support in NIC drivers as a serious blocker.

Can't we just interrogate devlink first if there is a devlink <->
net_device mapping and fallback to ethtool_ops::get_drvinfo if that did
not work? Maybe issue a (rate-limited) warning "use devlink instead".
-- 
Florian
