Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59502C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0BF24650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KEeUqQTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfLSKwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:52:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38597 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLSKwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:52:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so5513049wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 02:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZXDdUchGqcGrK25/fVfAQ7zC2o3YZYG/aF++t6v9I1o=;
        b=KEeUqQTWTWspOZferDBKxJRiolK3KQa6C3ksapi9JX/FVu21dZ7XD8X5TJVpp/w9A1
         22HyzJLAY49JncZXmY6QMzGvxiyeUsGDrquAiPYLUy2dcLmaI+LbkgG0DmZsQ93c54Oc
         EmRuD9uAXvFn/+wbycCp0IHXKeSVmIh6hstFYADSGlJlyFd0DpXtb7P0IDGFrCZf1HlU
         yMnGbIwB0HND4fdQbeNho6qdPER/kVyFafbemsVb1Rm0w7Mbu9Kud7ZygC9ViclMhpm5
         XCS34S3AR3yjEzp93cSvgQopEKtG78XV9LLTzYA/Kjba3Sd3to47bXP+pZ1ejTPHNa0m
         yaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZXDdUchGqcGrK25/fVfAQ7zC2o3YZYG/aF++t6v9I1o=;
        b=CEFj+dXc1PqfO7jHEt7hNQr0BovZZDXwUqRZD3/rlbb3PIHg3b3Q0uvYgSH+yG1Er/
         nzJjNp17BICttt/FY/NGM8dpn8N5gngSc2/tgeIdiLbvPyXsKSdSIkmTrvR6hPnKtInc
         RXokwNNQnCbz12wWKcSTPCu/qTIhyHNQYDUbo9Z1s6yzPtGJ6kwk36JCkucx8nj59VeA
         LwaNYi9gO3dqPxRxnP5zEwYx9yzXV6Uc7Rqf3aXIdS7HLXWzPDBqB6Er3SI2grCxQDVw
         PCPuZ9L5fgL7rYMMPRPPzx/3rOHy90LAa4qhSuHTfJ1lcUbXcsXozfnlCJ+75KsDPWFG
         vr5Q==
X-Gm-Message-State: APjAAAX3JglGIIr/pl+Pqc1vuYiuDtJ0J6ZDUhMQXZJsRjHXHIJJ6qdL
        0XeqvQ79cVvgoEIYmwXei9Nao0X5F3Y=
X-Google-Smtp-Source: APXvYqx/n2fEHAE3TWeuYbC9ZW46dZ6bG8quYLjNLscGuEq4UrWNQvBDKkDiHTmT+TprLK72WtL+EQ==
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr8514280wrn.214.1576752753718;
        Thu, 19 Dec 2019 02:52:33 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id k4sm5889509wmk.26.2019.12.19.02.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 02:52:32 -0800 (PST)
Subject: Re: [PATCH] nvmem: imx: scu: correct the fuse word index
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
        Andy Duan <fugang.duan@nxp.com>
References: <1575438591-12409-1-git-send-email-peng.fan@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1815fe19-4d0c-fbcd-7f44-010b010c00f7@linaro.org>
Date:   Thu, 19 Dec 2019 10:52:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1575438591-12409-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2019 05:52, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8 fuse word row index represented as one 4-bytes word.
> Exp:
> - MAC0 address layout in fuse:
> offset 708: MAC[3] MAC[2] MAC[1] MAC[0]
> offset 709: XX     xx     MAC[5] MAC[4]
> 
> The original code takes row index * 4 as the offset, this
> not exactly match i.MX8 fuse map documentation.
> 
> So update code the reflect the truth.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/nvmem/imx-ocotp-scu.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
Applied Thanks,
srini
