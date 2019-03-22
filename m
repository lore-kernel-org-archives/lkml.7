Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C6BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993332175B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfCVSgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 14:36:16 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51399 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfCVSgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 14:36:16 -0400
Received: from [192.168.1.110] ([95.115.33.167]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N7zRz-1gufIp0V63-0152d9; Fri, 22 Mar 2019 19:35:44 +0100
Subject: Re: [PATCH] pinctrl: intel: Implements gpio free function
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "zhuchangchun@cvte.com" <zhuchangchun@cvte.com>
Cc:     "andriy.shevchenko" <andriy.shevchenko@linux.intel.com>,
        "linus.walleij" <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        hendychu <hendychu@aliyun.com>
References: <1553135724-38331-1-git-send-email-zhuchangchun@cvte.com>
 <20190321084420.GG3622@lahna.fi.intel.com> <2019032119195575582546@cvte.com>
 <20190321120324.GI3622@lahna.fi.intel.com> <2019032120213955866649@cvte.com>
 <20190321123637.GJ3622@lahna.fi.intel.com> <2019032121342663125658@cvte.com>
 <20190321135642.GK3622@lahna.fi.intel.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <d752cd9b-59f2-4524-e989-92bd0dba6b4f@metux.net>
Date:   Fri, 22 Mar 2019 19:35:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190321135642.GK3622@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:fi2VMJExlxyfTU4iYoocUaUQO9ZpxA0WyS6iOcqeFDrUfgs8mYT
 +zcp6TFjnsRG9vGdXnGmAaPB0X5G8WlhwUBdj3/tiXFyFAiXEp/khyKos1uzxSMIiNy4FtH
 ppvgh+o9+wkj80zfI7cb2lhijfmRO70qdMrkWE6Wp6nXNUhu0ZG27fspz5jgaaNd1HTGtS5
 c2E5rQit3xcZpImaWTiiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nx/XuRv/jpw=:5uZBS+Hl2f9QgqMhNsGnyE
 rG/La14NlTPlzJWYHY3nNs7RBH7dxavU0oxCrarDafQOQvWeVP0cgzaA3KQQ/1scuRpYevmrI
 58yEvgkbBHw+9agyzvXVXE8avuxFRYTOjE2BNb674MwgptfZM2W+G9ZXiiglil/Y4NIJJhzce
 W1y/4tKoc7wCzsxsvrUXg1HwqdccBzU4MQJumtp573XF52W7VepqcibPy7jy2uUpyal4ndUkz
 uHEGh/iAhtMdpRl0Jar8H710ZyvDdxd3qwDlN+Ac73kSTnPcTySK0u1scbwZojmE4KzZnHbmw
 K70uYJsdisfeF38PfWsbf8PR8kkTNottRVvAFZS7hAx+rAfqTyEEj3GtFvkN7erbWqY0ew5l5
 4zMJZNopCV1LFb9K+3OEIVqATynl8AIDODHJgZlkW+nzuY5pEJFwSna9f4g/DPgisLkhOchcT
 22VG2L7aOArOHdBoxJDZToJQvKiMQoTiuhdy1YcPkCWieml2oygOQfWlV7UcV0sTCwrj4mnc2
 yaU847A9mCArtdkrAiQZd6C8WW8JKjllF0TcBpNXpxJIwLVK1ClPIEqlzyq/fM0DkZfLENFx+
 pQTtCJ1+4tyrbHxNCqFNqjo99aODGSkJHFlEy+nuGrsY4WlxDXj7oIUm5gPYVADB8l64vkYsQ
 LYlgWDk40OPIUYl6LWUiFnR5/0PSRDfmXoZ8EeHYnBZTK3vhI9oG7+vy/4d2Yek2atJ7C1v1a
 sImxiOFeJ382uS67QC9DOemV8M0MhNNMYRzyucoNnGR6Th9IZq1C+cZTQ6U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.19 14:56, Mika Westerberg wrote:
> I checked it and you do this:> > +       value |= PADCFG0_GPIORXDIS;> +       value &=
~PADCFG0_GPIOTXDIS;> > which pretty much turns the pin GPIO output
unconditionally. I don't> really think it is good idea. May work in your
case but may cause> problems with others.
Uh, please don't do this. In some cases it could be even dangerous.

In general, I'd question whether such an gpio should be userland-
controlled in the first place. Better write a driver for it, which
also handles the reset properly.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
