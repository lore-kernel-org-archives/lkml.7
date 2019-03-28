Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFD9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382962146F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXgTpaaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfC1CRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:17:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39765 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1CRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:17:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3so7153709pga.6;
        Wed, 27 Mar 2019 19:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n7ZPy+nfr7LsIdBcP4vxC3YGgaxtIQPIfYYaw1em+hU=;
        b=QXgTpaaMoJrlaxdjTmOXIvH2CKyd5a2RmG+FNMWjvdzJB3vOpafXpQ1PAAYowtzZEX
         So9LpAf+ybxg1HymouDdqbmUfb5ay5e7qGCxj9y0PQrzH1L8Zx3A8TfUKXFvEpF0SQwg
         YvMooLsJ0nm8p6HsRce5r5w33o9K1LUMGZAKDC1upUq37gZFEEKjKS+bz0a7pxmHKJeo
         9M/7pKctELsbdPcwEjmTA2t3AkHGrYJvvfdWtiVJCCq2T7MuUDBBluBQaRFu0ZWs1WfN
         9pC18A5EEmmPLj+TS1SmSiWuoMDpm0REcq2ZRKycmAgcqA8G3h/k+qGmnU28wqGBifAM
         DA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n7ZPy+nfr7LsIdBcP4vxC3YGgaxtIQPIfYYaw1em+hU=;
        b=ER6yniw3ZYgrGM/VdqIT2JlxaUJH0Da9WlgJgyw2bEhTVXH+E30pIb20SZFIqpk/Gs
         FzTWge8czOGGRKAfCLFS/96/wzb58utKi2eezQxBI4/X0aL/2KEvC4XtIBfbNGh3QzMb
         d/EDZSdepfloYrZbuaE8E8FhzX7i1OqDIYKKsfLgRbNFV5KVWY14bQsh0oca/kIlJlih
         wPj8VLEim0/WuYkSPIOFiWe2DqW0SQ1E//ryQe9sFUXk+NlWa3VV0zCV2We15whRthsa
         gAZz7UlIVyfef7slPj6s08T0QH5uC1C0CoRC06G184HeG1IyOUCIpDP1xybEQ6EQzeHA
         T0PQ==
X-Gm-Message-State: APjAAAXLc2bJrAS6dC43Kq2H8iCxBO7xJa018Gxx5qANjJ0iQrEEGsg6
        t/v5Wa5iEe5s/7+VxzBGyob+pRpW
X-Google-Smtp-Source: APXvYqx+iFhxEyqnmOXjc/GrqxICLpXqseQto4txbPX8OJygLkOcK2nxJkTEkwvrK5EnOb4BOJvSZA==
X-Received: by 2002:a63:bd42:: with SMTP id d2mr21160629pgp.319.1553739435684;
        Wed, 27 Mar 2019 19:17:15 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id i31sm42322786pgi.36.2019.03.27.19.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 19:17:14 -0700 (PDT)
Subject: Re: [PATCH net-next v5 11/22] ethtool: move string arrays into common
 file
To:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
References: <cover.1553532199.git.mkubecek@suse.cz>
 <0a1c4ac67996792b422532fdf3b0f1d6c8a2b6cc.1553532199.git.mkubecek@suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <c476e6bf-de05-5fb3-f9fe-f5c1eb7ba207@gmail.com>
Date:   Wed, 27 Mar 2019 19:17:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0a1c4ac67996792b422532fdf3b0f1d6c8a2b6cc.1553532199.git.mkubecek@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2019 10:08 AM, Michal Kubecek wrote:
> Introduce file net/ethtool/common.c for code shared by ioctl and netlink
> ethtool interface. Move name tables of features, RSS hash functions,
> tunables and PHY tunables into this file.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
