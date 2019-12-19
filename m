Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07358C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0F4227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kRJeBsd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfLSKwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:52:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53701 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfLSKwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:52:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id m24so4938613wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 02:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/1iWCzYi3gScJH+ZKu4IAouDVwkUnYO+J1BdKnXhQTg=;
        b=kRJeBsd8VIqqFAlxQLTEATMz0dlQldjkF/yvYns6xcit9rPY2lQWlTSwcM429xZ7S/
         QF/bR2oRu/Il5W4LQgzDYUyrHowxQfpJElyZgWln1Nq+iLDdr+Snhx8vmI1NnPnmUTjD
         pjBEYm7TZJRTlSP2wjwzu7ViRnKBCNpOolpQ0Yvnz57WHmGmoU3vhZy0R5M6WWp2a+h2
         qeyBcRPPLBxGtiswdAg2Fd6/5ofl1LLWXcaIeIx45q9omIwCsRQlpjA5v9INOy3ShcYY
         YZCxlseRTs3p986ZRv0VSTmLmgLrcSUw3LT1/Kayfzvrn78dNAc+p8BSkcZGPVsTgVQP
         OwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/1iWCzYi3gScJH+ZKu4IAouDVwkUnYO+J1BdKnXhQTg=;
        b=hkxEftoP9jiJQKz5lud5evN9JKpxYPFMdmsx9c/1MbsF2SA/iPmPV5ZFz1B/vBWO57
         cH6u5pxPGm1bKzuC/VysHfKAoNBbvNPrUrCz1o2i91mOLK3DHysc/kJmhHxJfK+dOFXB
         d0zMDhvi8zxVyVa338WN+MrrY3kyRvVv+KZHueIo+9ouR/h/waKXmVWtdQuyU9JCcizq
         MCUpfmqzS68vEcfzy16LjuIKvGSppuuhDbHRdFF5Wmmqz0YZMzz7QhqpMaXn7dRhTm8y
         Utlzm4kqO9j+sUgKBRuyqAm5stJlkiUcA0M2abK9qIJPZ5d3UeAHK6NJFEG5WzuOnxJs
         Epeg==
X-Gm-Message-State: APjAAAULWlS3ng+5XZpueXM9PwM76I3ZODF9TZklUBiJo5BL8fE8KlWD
        tMWYgsCFz+PlR7b1kEBVTBtuTg==
X-Google-Smtp-Source: APXvYqzStH+1157P1Cv3/akiouCWbHXle1czPtvxUgDMCyd4SeBRSabTb/W+TZKuJ11C1gGBaJ4A8A==
X-Received: by 2002:a1c:7901:: with SMTP id l1mr9079872wme.67.1576752733307;
        Thu, 19 Dec 2019 02:52:13 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id u16sm5590079wmj.41.2019.12.19.02.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 02:52:12 -0800 (PST)
Subject: Re: [PATCH] nvmem: imx: scu: fix write SIP
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Alice Guo <alice.guo@nxp.com>
References: <1575340217-1402-1-git-send-email-peng.fan@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <feeeacd0-3d0e-08b8-2a43-8527e6840b94@linaro.org>
Date:   Thu, 19 Dec 2019 10:52:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1575340217-1402-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/12/2019 02:32, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> SIP number 0xC200000A is for reading, 0xC200000B is for writing.
> And the following two args for write are word index, data to write.
> 
> Fixes: 885ce72a09d0 ("nvmem: imx: scu: support write")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied Thanks,
srini
