Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34018C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0137320883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="susZ3Yig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfDHPUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:20:34 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:38960 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfDHPUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:20:34 -0400
Received: by mail-pl1-f177.google.com with SMTP id a96so2838288pla.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 08:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DrgzDz62/Hvjgq90U976Otc7CQE2vUfOkPbPxuDWPgY=;
        b=susZ3YigOV1xGTm6Fmbf41gaZzz/TkZ/ZqUwjhQ98+vhmjinwmfC5RiyWqYa/xFO1E
         Mvqi3sYRZe8PJSEkl0S3eaBXyZMHc/Qe8fwC1YVPiEMH2tV6YNBxaFnFfM7eMzZGTsRz
         5vw/IxmXwAmq/QDMw/L7MVnRl+e8MYiQOebbJ8YOgWq6KfUKKfJjC8jEZWCtIdoArtoV
         w9f0A5DuTz1iIybCxvSfy4gsa0YtGhkaD+qGGgcrft3rEK3YqJlyk8BOpiAV5YzUYNhc
         mRFcZqFGiibgq+/fixV4wyOxb7pAkOqN9EHiAO5PjG4mRUqr0dJCiT3jP5zblRpjWC1X
         2Hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DrgzDz62/Hvjgq90U976Otc7CQE2vUfOkPbPxuDWPgY=;
        b=lo5qG/akRh4VYS6u/ziHSMtR+e8EIF61FwPdon5tJovO6RWDmaruXib9rOol7/pkQK
         YSSr/Gdt2V9DEXAHEJqHBD//chabVT/W2AG8YSz+7cjnZEyzrzfPJhR2mDSEzcm6Nq6b
         Z6I2iKEDbrdEdGJe5pcxuxRMLBPpfOsDq0jiql9kL2L9tvjfIcfuAwjBhgW1THuhaLWT
         uJiz/jTE9F99m0kBnJPdkk73ByJj0gKrKOMrS8mbAKd3B0Z13OpkryYEr5VGdfnyIMVP
         2s3oZWe0qChl9fqDn3+UzyBRkJmadRzcCo+DonINNSdu3GnUxXMtZjF+ouTGu5bD6hcA
         oU3A==
X-Gm-Message-State: APjAAAXCcI3j48mP2FS0nBmwQ2vlVv112hY2kkhlMNArbjyRrKYaX/Nu
        xOwll8+WTiUuX0dO1tPD8TCxlQ==
X-Google-Smtp-Source: APXvYqxMYeyBjIE6PHusjrgLO/cduxbVZR05t+v/NU84urJKBdEvQmmdGpe1i+mW+B15ZVkEZ86xUw==
X-Received: by 2002:a17:902:2927:: with SMTP id g36mr31185663plb.57.1554736833192;
        Mon, 08 Apr 2019 08:20:33 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m7sm44234028pgg.62.2019.04.08.08.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:20:32 -0700 (PDT)
Subject: Re: [v7 3/3] ahci: qoriq: add lx2160 platforms support
To:     Peng Ma <peng.ma@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andy Tang <andy.tang@nxp.com>
References: <20190312015019.30628-1-peng.ma@nxp.com>
 <20190312015019.30628-3-peng.ma@nxp.com>
 <VI1PR04MB44310DDDF2D981F0BC0D7381ED2C0@VI1PR04MB4431.eurprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5bbd312c-6443-ea23-2b3e-97fd46a98a38@kernel.dk>
Date:   Mon, 8 Apr 2019 09:20:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB44310DDDF2D981F0BC0D7381ED2C0@VI1PR04MB4431.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 4:06 AM, Peng Ma wrote:
> Hi axboe,
> 
> If you have no comments on these paths, please merge.
> Thank you very much.
> Patch link:
> http://patchwork.ozlabs.org/patch/1055028/
> http://patchwork.ozlabs.org/patch/1054189/

Can you resend, it's not clear which is which here, and what parts
of the series goes where.

-- 
Jens Axboe

