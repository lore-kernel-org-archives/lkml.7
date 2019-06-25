Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D513C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C3520656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH7jR3TD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbfFYOkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:40:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36922 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730689AbfFYOkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:40:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id 131so16533350ljf.4;
        Tue, 25 Jun 2019 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q0m3ZCcvvlamTMjrKbKQpPCjAq0COFaxIHyMR99gkW4=;
        b=UH7jR3TDn/mUxso6TpcyTOtnuNk/kSdJZKteGrbYjSjp1oiEvdriH+931yXLyjy1P/
         PfJU3kpY4MIkqm+n36A2osZQXizmmeYDQLbHsBA2b6LxpZGeBFe1sxmtrBonQwkYEE85
         6a/iLuKv2fs9ncZFjrlli7ni4FOW2LPVk7T7dvI7HstK0w69OHQxGp1CdUd5nQOUOKq3
         3vUX4SBh4JeldgoBofMvNlgBg588xFsMd/GlhH+0uT+2GGzvBxtdW4UPpCtBtI9QYtxB
         JRlNrnTmzY7XiVUNSIR5qGOLmKV3z5h9JWNxH3kP8T4CmDLvFwSlbwECLY7tWy9MtcDA
         kxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q0m3ZCcvvlamTMjrKbKQpPCjAq0COFaxIHyMR99gkW4=;
        b=PT0aUZr5zhjItdUwJfmV5H85exu2eZqvQ5rhCQomE18rqYxl+eZ1DCo+e4APLZugkS
         +tTjv17j+PBlVpGwH+bKb6Wcs9LSFH/DzhsiHcXFVAGCjFC4yFM7x9G0Ruu0BQdEsLwu
         DGUKCisNZbVoJE1vuK3Y1ofyC6UZtbutU3ibQvgTzQ+CwV1RAz248SmQORRVyxhxCoVB
         CxnaNbbKLEIMJpDN43BNjUg4nZDBamlOHapTQVhaTcw4xQcK4n762M2ZFcV46euuAj8n
         y6qyno0R2mo1cYsrsL8qo2bgzLH8LlGYuGG1KC072y0j8eQAdoEeODylcpXdaWsdf5gZ
         CWfg==
X-Gm-Message-State: APjAAAWnuV/SgdeTuf521o3x0VbuNMk+SfWyMRYtWg2N0VRvZ5TStubd
        KKsESVw7YFNGf9slv4JfQkzFWvC8
X-Google-Smtp-Source: APXvYqwwGogsn+0F5BzrzfyS8cU7M9D0Jg0oyoWVeDuvdXH78LpECLVu/4t74BUaXxcL4PdcgQSqtg==
X-Received: by 2002:a2e:9a87:: with SMTP id p7mr36337953lji.133.1561473604136;
        Tue, 25 Jun 2019 07:40:04 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id 25sm2273267ljv.40.2019.06.25.07.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:40:03 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] regulator: core: Expose some of core functions
 needed by couplers
To:     Mark Brown <broonie@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190623210835.26281-1-digetx@gmail.com>
 <20190623210835.26281-3-digetx@gmail.com>
 <20190625111946.GP5316@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a0626c9d-c68b-9043-8b2f-870f594938b8@gmail.com>
Date:   Tue, 25 Jun 2019 17:40:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625111946.GP5316@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.06.2019 14:19, Mark Brown пишет:
> On Mon, Jun 24, 2019 at 12:08:32AM +0300, Dmitry Osipenko wrote:
>> Expose some of internal functions that are required for implementation of
>> customized regulator couplers.
> 
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-couple-api
> 
> for you to fetch changes up to d22b85a1b97d12a4940ef9d778f6122546736f78:
> 
>   regulator: core: Expose some of core functions needed by couplers (2019-06-25 12:15:35 +0100)
> 
> ----------------------------------------------------------------
> regulator: Coupling API
> 
> This series introduces a way of specifying a customized regulators coupler
> which is necessary for cases like a non-trivial DVFS implementation.
> 
> ----------------------------------------------------------------
> Dmitry Osipenko (2):
>       regulator: core: Introduce API for regulators coupling customization
>       regulator: core: Expose some of core functions needed by couplers
> 
>  drivers/regulator/core.c          | 194 ++++++++++++++++++++++++++++----------
>  drivers/regulator/of_regulator.c  |  63 +++++++++----
>  include/linux/regulator/coupler.h |  97 +++++++++++++++++++
>  include/linux/regulator/driver.h  |   6 +-
>  include/linux/regulator/machine.h |   2 +-
>  5 files changed, 287 insertions(+), 75 deletions(-)
>  create mode 100644 include/linux/regulator/coupler.h
> 

Thank you very much! Very nice to see some more progress!
