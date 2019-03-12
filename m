Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CB8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1582D214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fTvN6IOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfCLOBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:01:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38434 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfCLOBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:01:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so2836732wrm.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cCcwharzNZe1nK6/JgQp9uxJKQWrorv8LAay2fzCQY4=;
        b=fTvN6IOLpvlYE+fqMRlyka8rjTBXbn8KaCEVccOGn0LyDbk11GEifH+Q1j5StaEsm9
         vw4jX5MhDCN9BEUAxAbtOjf5ZHIX41slP/3xBp+wRNpbtc0nicobj12U9PRVi03wTKLl
         KGJJ7Pbqt8y8xw8oNpkfYpS3wnI8PcXPOR7qwqPV4/pTGlIemUrwBjLyBKYrOsszmjua
         qDTVasDpfIapL+o/Mg+3H//S3cCTLT6epRTtMIAwrBrGAWspJsxHeUijhpy9rbbbk7YZ
         qjbnXUP7wqbSJaUuu3uBHNAbp3ExNMO0WDdEnnv2WkFpfZWCTZK8bAtayMzpxUeKeUoy
         Rz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cCcwharzNZe1nK6/JgQp9uxJKQWrorv8LAay2fzCQY4=;
        b=GXkA3tOq8qXr3utrmJD9KIExzw+ONovAfLUosPcFnlSixyGIhX496Zitany1yaFk87
         tyAyXAwSoa329pfUoe27VysUW6QZgo2IXRCfs7RAUyoTAB16TmHIrZOCmdzmUUNFZ+L7
         MoJ7GOFZHO6RWaQrcSZFdb16/oyXCXagNM5ULs6b7vZLMctxsC+FGrD8hzd7M2TLTcmj
         GNkXMB0NXpHS8vX/VtfYe5E1Ls1+BNfaz7emKp+0LwSb22aqdxYwUmNtkt7D06S6Da7C
         waEWz0LZYtd1bp+/sa7TheFXt6QIS233IycQOJdeNMe97cQTo7LNJHqD1Rt+dv9fET+v
         WexA==
X-Gm-Message-State: APjAAAXX6aqgfA6iGjGjvpHcp6PVnNHq+TNScdo1r3VPrskagXrkPL7f
        N078RPJWlm1DEsLZRfzlSKu+jmV+Q/I=
X-Google-Smtp-Source: APXvYqxMyhKufBx+ocA8RTxjVzWtJ+4x0jZBTUsj4PvCylWqIdv9nXxU8gXRRdNQzumZBmVdKfdIdg==
X-Received: by 2002:adf:face:: with SMTP id a14mr25902668wrs.320.1552399269328;
        Tue, 12 Mar 2019 07:01:09 -0700 (PDT)
Received: from [10.2.4.163] (aputeaux-684-1-27-140.w90-86.abo.wanadoo.fr. [90.86.252.140])
        by smtp.gmail.com with ESMTPSA id v2sm2665870wme.29.2019.03.12.07.01.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 07:01:08 -0700 (PDT)
Subject: Re: [RFC PATCH 1/2] Add support of imx7ulp to interconnect framework
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181117111905.29091-1-abailon@baylibre.com>
 <20181117111905.29091-2-abailon@baylibre.com>
 <3691c453-b2cb-df6f-d029-e82ac98733c7@linaro.org>
From:   Alexandre Bailon <abailon@baylibre.com>
Message-ID: <e83139fc-c127-5913-f4cd-c1fb8bc9af99@baylibre.com>
Date:   Tue, 12 Mar 2019 15:01:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3691c453-b2cb-df6f-d029-e82ac98733c7@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

Sorry for the late response, I have just seen today that you have 
reviewed my patch.

On 1/21/19 6:41 PM, Georgi Djakov wrote:
> Thank you for working on this! I am expecting the next version.
I'm going to send a new patchset soon.
I have rewritten pretty much everything, to handle some hardware 
limitations, and to be more generic.
Anyways, most of your comments still makes sense for the new patchset so 
I will fix them before to submit it.
> 
> BR,
> Georgi
> 
Best Regards,
Alexandre

