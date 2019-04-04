Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B455C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7F920855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgGoi8Mr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfDDK6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:58:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37134 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDDK6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:58:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so1064293pgc.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 03:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+4qAinUJ8qTLO8i1PDvxjEBc94jgEla4gji5wF53jcw=;
        b=hgGoi8MrOlGSWDNBZEw2LcKUFpsEC37TNJsOts+52L/5FPIjy50n8zA7/4fDXyGU4+
         vnJC82fGQW/8USlIN7ZGgjCeZccMbaK09zYs05gNE2oRXhNRPstbgAC89kc9oEXIY619
         luY+2OU5r22ZoPXFY1PYJfeX+G5VEcPpvnip/hqwKOjzETqKccH+DB4QSt5aPkLe15h8
         137evHyVgSnuzyJkvYvg+zShok392e8RTa1mlZ/n/cVGi3r1A+l3XeoMbxoUm4CIHrxj
         Cg1RO9wwcoyskxXYEJeTHohedDo9Ly+Q6SMyBxJ0ja3W0Gd7GBJx5ws3scAH3XzroAt9
         9FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+4qAinUJ8qTLO8i1PDvxjEBc94jgEla4gji5wF53jcw=;
        b=EFBo9gJw7AcFgSHWm6FaZBf8Wo30rv93CLFQdq22vCy44f7/cDE7Y/WTDE8EXEe9gV
         DF0rcySeAO/pO9mnyLZDK862dwTZvBX+/TaqMm/oGDP0YxX7ZfP9C6kSXuAClvmYVLka
         MIlki2ZBeM23q59w9g6zM6hYiMDaDFQRCY0dddEnevSx99yi/KYDFPJr+8eUbada0yX8
         yWYzq3HCvAPy/6PNQUsTl6jtbt2ELkAwKoNYMC7JuPZ1Go25VkRpn1K/H5/YqBF+9lSR
         T3jhY0jjM4pGT2E/hl1AQ/MP+4Y4Fo7ZQUjR/TPuJvgtfl/DgQH8qp9cvjFa1iGsRB0t
         Jnyw==
X-Gm-Message-State: APjAAAVo7ROUKSLh4EzpSNUa+HU8xXJJg/WMduEZ13J+8CIxW2kN9xYH
        ursQItDTQNWPTWTbBBhNLU0rnA==
X-Google-Smtp-Source: APXvYqw7w29ntbO7ckV50g/buwE93HrK55bRarp9BUvAqLRXlVDT6JW2ht3Cp67Ps8eiCWYVM60CJQ==
X-Received: by 2002:a63:744b:: with SMTP id e11mr5087027pgn.327.1554375493439;
        Thu, 04 Apr 2019 03:58:13 -0700 (PDT)
Received: from [10.71.9.192] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id y5sm21753864pgv.15.2019.04.04.03.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 03:58:12 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvmem: imx-ocotp: use
 devm_platform_ioremap_resource() to simplify code
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1554094479-14596-1-git-send-email-Anson.Huang@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c16dff27-dee6-31e8-6fc5-7fdeeff1d0dc@linaro.org>
Date:   Thu, 4 Apr 2019 11:58:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554094479-14596-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/04/2019 05:59, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Applied series to nvmem-next

Thanks,
srini
