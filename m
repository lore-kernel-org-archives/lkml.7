Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ED5C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FC220883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MQWj/05c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfDIOR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:17:27 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:34242 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfDIOR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:17:27 -0400
Received: by mail-pg1-f173.google.com with SMTP id v12so9383520pgq.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 07:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zDTTbSBEk7vKtmENa6CNtzKi9LkUm4mtbZOxvsvK5fs=;
        b=MQWj/05ca3azPxUIgbOJJsG8jiDd0XNtNMUlbUAou0zILsaJ/1bwx1Ylh9IhccrbNV
         6C3G60+VROGTlgw9qpoNynKRAH9sIr/T9ryZOZ0Y5cq0CpPhzDo0brg9t7ALyb5gueCv
         /qEQ+FHVTFfnMneIx59GIneQoYTxZhIcEdGTJCdt7TImVernzaWl0w2o9KSR6HWczNqL
         ZOTtZdRetkMizSGd9XJalZnlJjoPOATpwXfankrS/pnLe71vm2jPamh5YYwNmh9Ii08d
         vN8bQHIFHTGxejLsEAVOBu0PWoELxd9LOXp86+Geyzokzi3dlQGY4OlBRJzwxmgVJpD0
         9OjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zDTTbSBEk7vKtmENa6CNtzKi9LkUm4mtbZOxvsvK5fs=;
        b=W52z1HoWmhYabTE7Y0XTbqafOsdjzOlAT/gfF0CuSg7CSMrZRNrjBAwU0CN0ZwXUVr
         taTaKbWw1+17FmpxYWeZzIAQg/tgWn9qV773QfjK5/7El9rN/0ZUa1CMMq4Reps+4/xZ
         NCYXPhp8zRdwL816WiCnt8zQQaLob/rCsg2612/NZcQqUq0S/rWrK7P4BwS4nfuyAtzt
         OKJc6F7mnPlUCGid7ZeXujdRf+DDPFSxfztJsEwUZ53GXpGmk7SnHYd2ugUYjozwjcSt
         bp90goJQebGgPceVOBNGB+qn3QsUKXDUPcueuDiniu+lIKtsQu+7igZE0C7gtK8O1eBC
         IPUw==
X-Gm-Message-State: APjAAAXOFsmt8Z85NEeWGiGP17gbsRIUHlHws8hKljJwytKvPEIn/ClV
        jnrwKuze4WkiD4QUDkNahsL76w==
X-Google-Smtp-Source: APXvYqy1lRzGLBJ6qphA7AixMkr2Kc1/hwG63N0BYRjGJ0BqHeCg8UY0zo+vsy4MytP/F4Hto2LmrA==
X-Received: by 2002:a62:121c:: with SMTP id a28mr36762940pfj.58.1554819446389;
        Tue, 09 Apr 2019 07:17:26 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s9sm16979879pfe.183.2019.04.09.07.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 07:17:25 -0700 (PDT)
Subject: Re: [EXT] Re: [v7 3/3] ahci: qoriq: add lx2160 platforms support
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
        Andy Tang <andy.tang@nxp.com>,
        Jianchao Wang <jianchao.wang@nxp.com>
References: <20190312015019.30628-1-peng.ma@nxp.com>
 <20190312015019.30628-3-peng.ma@nxp.com>
 <VI1PR04MB44310DDDF2D981F0BC0D7381ED2C0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <5bbd312c-6443-ea23-2b3e-97fd46a98a38@kernel.dk>
 <VI1PR04MB4431213C02A7DC614AB4E693ED2D0@VI1PR04MB4431.eurprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <40cd2a5a-040c-9785-ee17-c5407a3872a7@kernel.dk>
Date:   Tue, 9 Apr 2019 08:17:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB4431213C02A7DC614AB4E693ED2D0@VI1PR04MB4431.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/19 12:44 AM, Peng Ma wrote:
> Hi Axboe,
> 
> Patch link:
> 
> http://patchwork.ozlabs.org/patch/1055028/
> 
> http://patchwork.ozlabs.org/patch/1054189/

Applied, thanks.

-- 
Jens Axboe

