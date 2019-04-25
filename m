Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23E0C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88069206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdnImHrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfDYNuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:50:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36999 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfDYNun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:50:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id v13so7776943ljk.4;
        Thu, 25 Apr 2019 06:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fJwZttXY0+MBk/A/4DHKsrCmeK4k1Co0O4/BbZ7XWKw=;
        b=OdnImHrI69MHpqKM92OrK5LAlCup4WXsnYAeeRue8OELGwkKLMPw31rUnNj0lo9i3+
         a96o35+n8q3sYayrxerb4G3bDQHmub8oL9YnbSsp1ANxoCFgWyBGOGESQ7eqiMUKGttv
         zSXY2dgfI+aZxHJfwgIy1srQhun1mKD0N3FUqFdIgwPI4cvaifuh7ktDRn2dm5iez5R1
         x5FLLVVXGkf/n30jGYpettaD0x4XqWI/n/+qrVolK/Nt+A6ru3uR8fTrERYyX5Sznms0
         L+t0aPe3FV2/dcS1j3S6rsnEbodeDEBYsA9+TBHGOqWjvD8sDVEZIWjH9jkW0OXimFra
         Ye1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fJwZttXY0+MBk/A/4DHKsrCmeK4k1Co0O4/BbZ7XWKw=;
        b=fcrpJF/ptoEIs7iCtM+Ajy05W1Bi+NbqHePHfFTAjT3tDrkaBaRQk15fdpciNSOzan
         NWFzDyu9p8TxCl9645MstMsm1o49VB+U+Mi/f+CGJue24wXkSb5j+/JtetT69PJKP53V
         vZdroJWyq9oy8ZplKD13EnFJGdAt/Qzon4L4lA3aR/sZZ8HMsWd516R51+NQsITviLKS
         iHtj0yNjqEA+iMzoLpbtcUXsx9PPYpyXTOhK0jpuBD1brPVr2ZQLIPEEF+AhGNDq586p
         Trrh5CX/Zo753avGlH39NaumRqG9gL76k40NRWQgguGXisb1SOX6B0JetPIuKXsUiAAd
         1AuA==
X-Gm-Message-State: APjAAAUgiIQOh94x0MBMiGrn/O+40rMyFgxUJerYSiv0X49KDlHM3P7H
        sPfq9er7DTQsFmJetuyol8x7KGek
X-Google-Smtp-Source: APXvYqwGIiWgR3f+nqBRPTti4kKvR6KG+/t2eWfY+LFwHMNhvIGnipv0GmUDu/dZbBDz1PLmIgNAmQ==
X-Received: by 2002:a2e:3207:: with SMTP id y7mr476578ljy.117.1556200241172;
        Thu, 25 Apr 2019 06:50:41 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id o12sm4910393lfl.66.2019.04.25.06.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 06:50:40 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] clk: Tegra124 PLLM fixes
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190411214835.19947-1-digetx@gmail.com>
 <46c12545-0e9e-93bf-2ccc-4577f4eb223e@gmail.com>
 <20190424083625.GQ12975@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d020b512-59be-51bd-39c1-4827e57b020c@gmail.com>
Date:   Thu, 25 Apr 2019 16:50:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424083625.GQ12975@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.04.2019 11:36, Peter De Schrijver пишет:
> On Fri, Apr 19, 2019 at 02:50:10PM +0300, Dmitry Osipenko wrote:
>> 12.04.2019 0:48, Dmitry Osipenko пишет:
>>> Hello, here are two trivial patches that are correcting PLLM on Tegra124.
>>> First fixes system lockup due to a bad hardware configuration, second
>>> removes usage of a non-existent register bit.
>>>
>>> Dmitry Osipenko (2):
>>>   clk: tegra: Fix PLLM programming on Tegra124+ when PMC overrides
>>>     divider
>>>   clk: tegra124: Remove lock-enable bit from PLLM
>>>
>>>  drivers/clk/tegra/clk-pll.c      | 4 ++--
>>>  drivers/clk/tegra/clk-tegra124.c | 3 +--
>>>  2 files changed, 3 insertions(+), 4 deletions(-)
>>>
>>
>> Hello Peter,
>>
>> The patches in this series are trivial and fixing the longstanding bug on Tegra124. Could you please take a look and and ACK the series if it looks good to you?
> 
> Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>                                                              

Thank you, Peter.


Stephen, is yours maintainer-tool able to pick up the "Acked-By" for the whole series or do I need to resend the series with a proper "Acked-by" tag added to every patch? Please let me know.
