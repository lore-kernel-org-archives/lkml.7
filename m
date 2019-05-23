Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E25C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B5E2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="on9kVxqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbfEWIwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:52:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42232 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfEWIwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:52:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id l2so5297344wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 01:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j+i/6YHpLYa0VRON5YtxYPlWNbeZJcsk8UufzzybxG8=;
        b=on9kVxqnE4XL9gvdkGUX2lnqH+HDfMFx1fmgPPhEHMLh6fLl/qMVTqq0jyIU4/zk3M
         y7YSJbcxD91+NnS+VGobBAu9oIIllM+Rvh6RrpTXngDXu2RBlSNjIRrjjwsYU4288n4R
         zUmjrS1VsLFV93LbAPHzTV7s0QxGGhiBSoKi6y1LOUJ33YP7h4SuM36zK6MAZqkLr+Ta
         ynjHcXlIGcck8mXnnZZ9Xptdc+uSZeNf6jzyVjTjBW1VPOK9Vz7ioWG3tK9klx/C+QJE
         HzALoy6aCD9QkWLWhOjXICOwGUhtN2g/TQiP+OXFWkX1J/rsMKCeP8EzJnR3scxtjR4R
         Hnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j+i/6YHpLYa0VRON5YtxYPlWNbeZJcsk8UufzzybxG8=;
        b=otKjOI3zSvAUfM1miIsKDP47TNXuioJpNPUghRR8AbutvrACYqsXnROAtIcWWYcYrW
         FHE9dsm4kotvhR/pB49AnZsmThOWIqOdzHONpDqDAIpP0nPKqrYl39d+sZlrd3DyG/Y6
         zny0Y+8NoYNdFUXobUPwHuc67v3HCVastpqqfI2Y5cD833iou5xXyHqIvQPiZJoqqydm
         nLSL8FHeaCoKc/3yianqEOV8WsZh93tvjcFQlMu+k21mRDxhBUejvDCAdQbFkSjw3nGN
         xsF8uCtfo8LPNHDxp+3p114ak+S3I+m5XOcVw1xdMAbCUyqKFg0+MrB7YoqUWowwo1ps
         Jk/Q==
X-Gm-Message-State: APjAAAULFSHCqzMpw/HEu3CFSb6obXAmlTl6SxqL/I0wp5zQsQBdKLSa
        2bLhL6EE2a/gErqCiQJmNvvbaw==
X-Google-Smtp-Source: APXvYqwVf7vgNc882DGvmr22eEnXmPhOY+Dm37Awq0EvbkD2CxA4UYuZbiq2u9/BDdvPo7hxsg3PVA==
X-Received: by 2002:adf:ce89:: with SMTP id r9mr10093854wrn.300.1558601532706;
        Thu, 23 May 2019 01:52:12 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id i25sm10949054wmb.46.2019.05.23.01.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 01:52:12 -0700 (PDT)
Subject: Re: [PATCH] nvmem: Broaden the selection of NVMEM_SNVS_LPGPR
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
References: <20190523001502.20105-1-festevam@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a17e4954-7cc0-2774-3070-6c0554c7cb95@linaro.org>
Date:   Thu, 23 May 2019 09:52:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523001502.20105-1-festevam@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/05/2019 01:15, Fabio Estevam wrote:
> The SNVS LPGR IP block is also found on other i.MX SoCs that
> are not covered by the current SOC_IMX6 || SOC_IMX7D logic.
> 
> One example is the i.MX7ULP.
> 
> To avoid keep expanding the SoC logic selection, make it broader
> by using the more generic ARCH_MXC symbol instead.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>   drivers/nvmem/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied!


Thanks,
srini
