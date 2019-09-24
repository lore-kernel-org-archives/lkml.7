Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5FBC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 03:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D80021655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 03:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4v6ZISl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408920AbfIXDA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 23:00:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45834 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394621AbfIXDA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 23:00:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id 4so354466pgm.12;
        Mon, 23 Sep 2019 20:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AtJnbuFrZdKCTa7sV9OydssbY5572kq5IYSekbX0Xfc=;
        b=I4v6ZISlXRPLSZgT9fWsxqPFNLvqZYpleOquG0qgAB3ZuRHLY+dgbMhjVA6cvoOSv6
         7GGT0OzgJPuBZ8eDhMlu/agYbmbb/Hcu8YITVVKwL0R4l6BggAj6fZuI3qv/CxIIw1qZ
         PZG6vgwNhMKqQ7xSVgpCUcIwvtPSIKGR6mTBYWtpqvUpoy1svpe0tdD+z9cHAzdc0Yvq
         koPKtitA+ME16oe1K5HH7tISyDyQPflbpP/JMCYkvDPPKvq2NnAyR/8V6zb+6GLqVX/p
         Pxhc6zYoUuP8QK612uh6//DB6ESOKFiWqT3w+Yk8JLYQXFvjIA3bmMEFDovx3quR/XF3
         I1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AtJnbuFrZdKCTa7sV9OydssbY5572kq5IYSekbX0Xfc=;
        b=V/iCjBPFXeXdvC272V30lcNt2XSu8eYrSXxVQj6tVw5IETDD5Dpf1LgnkmekHmRmzN
         WjThLuUYlgrMoywFhBFE0AW7W8IIb3AoX1qDqSavA5RfNdgsWG3Fppebd1m7oylXgddS
         PiZIow1x2m6xXAZacVnaPCstg50F5VhW4AvtbudD+N6nBfRrThDcKmUP4KHkM8UcupMG
         iT8mtU6AiZLcawUU8xNhyXOTJ5HwRUQNr/QSt8gcu6AN809F71Je5VZut2KOIxvc8iSr
         20E++9649DFll30sX4kSa2NBMGEBCFvR9GkMwv2QXua9xM5xBAy90iAhzNfOcLdrbVRU
         w3AA==
X-Gm-Message-State: APjAAAVLGBHK32sFmU13tc0vWimuAfbBqyt2woARrQOyvGHeoxYn5DLw
        7pb8vi5+fRksABsHh65puDg=
X-Google-Smtp-Source: APXvYqxNalgSR3KkEGARfbIZcvkiFJ4bHGPb2YOf/wAGQDtuY6RkWFwFChj7dflch/1BBwFKIK7mOw==
X-Received: by 2002:a63:5356:: with SMTP id t22mr773585pgl.400.1569294055891;
        Mon, 23 Sep 2019 20:00:55 -0700 (PDT)
Received: from [10.230.28.130] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e14sm197603pjt.8.2019.09.23.20.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 20:00:55 -0700 (PDT)
Subject: Re: [PATCH V8 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
To:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1569287538-10854-1-git-send-email-peng.fan@nxp.com>
 <1569287538-10854-2-git-send-email-peng.fan@nxp.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d3a99c0c-dd5f-50e0-ae9f-21ffa1d116d9@gmail.com>
Date:   Mon, 23 Sep 2019 20:00:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1569287538-10854-2-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/2019 6:14 PM, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The ARM SMC/HVC mailbox binding describes a firmware interface to trigger
> actions in software layers running in the EL2 or EL3 exception levels.
> The term "ARM" here relates to the SMC instruction as part of the ARM
> instruction set, not as a standard endorsed by ARM Ltd.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian
