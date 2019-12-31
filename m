Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354CCC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 08:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073FE206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 08:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577780075;
	bh=TV1GXTHPCbAu6Epd2fgEfaaxmBIZlyqdy4Y0H7Axfos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xNJEAlAJFcDUYXSU+9QR/0r7ZfyuGvAf4BUeOIteam2cfrWbWmTUFleNzUt4ychkN
	 thl7pZKUkAwQjHIeQOKoQAEPBZzgN+waidraErUGQ6n3E76qRQGmsCT6GM9wg4Ap9E
	 I3xSfyISn3PBdoGnUw+ObRglhTkvMmCwo4+3haEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfLaIOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 03:14:34 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41948 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfLaIOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 03:14:33 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so34714211eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 00:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BA/6ccf7o5PJh07KawasqXwPysbrUNZi9TDVA0trLq0=;
        b=k506b/hEjujXeZ4raxwZ+kEPIdN3IrdC6dLjv6r4yua3hFOpfZAKaWIjBGeM4prx7L
         AKV+8SFgW3mvBJm8Nc7/bRtE4IPxIltUScbYilx08wGemvcL6/8ekDW9/MozZXNnFKy5
         Mr86zMlNUCgESSh5lWqqnc7gjAO6ymxukLGk9wPP5VTUAkZQXUSJNZB6rjMHAfxxs3ac
         sORu1zHP3lEm3vHURZ2Wvc3NFB69AXTHaBqz1tNJ0KKsOXpEDOpPHva988ADEaogvZPD
         1PbqlnuBXqm1728i4/h+YyrJOCSUiKgLmGPYPawhggNsSKafLs5sWbrIOrlBqiYd+btN
         kntw==
X-Gm-Message-State: APjAAAUGUkYtlMG70x8O4kl6LYiQlv8IxWT8NTcc2sewtKNMEoIz682F
        seRVxXvI8K3h9YMUESmr2Cs=
X-Google-Smtp-Source: APXvYqzKNFFiPREmzreH7+QxwMfA39pRqo7Zxb/2Tp90xaIwQj2J582XTApIImaIRCLvqyMzzOzoAw==
X-Received: by 2002:a17:906:d4a:: with SMTP id r10mr75471357ejh.125.1577780072399;
        Tue, 31 Dec 2019 00:14:32 -0800 (PST)
Received: from pi3 ([194.230.155.138])
        by smtp.googlemail.com with ESMTPSA id v2sm6035132ejj.44.2019.12.31.00.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 00:14:31 -0800 (PST)
Date:   Tue, 31 Dec 2019 09:14:29 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iommu: Enable compile testing for some of drivers
Message-ID: <20191231081429.GB6804@pi3>
References: <20191230172619.17814-3-krzk@kernel.org>
 <201912310916.ScYTgEyR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201912310916.ScYTgEyR%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 09:08:38AM +0800, kbuild test robot wrote:
> Hi Krzysztof,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on iommu/next]
> [also build test ERROR on v5.5-rc4 next-20191219]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Krzysztof-Kozlowski/iommu-omap-Fix-pointer-cast-Wpointer-to-int-cast-warnings-on-64-bit/20191231-022212
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> config: sparc64-allmodconfig (attached as .config)
> compiler: sparc64-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=sparc64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>

Thanks, kbuild!

I sent a fix:
https://lore.kernel.org/linux-arm-kernel/1577779956-7612-1-git-send-email-krzk@kernel.org/

Best regards,
Krzysztof

