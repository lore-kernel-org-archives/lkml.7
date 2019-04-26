Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3995C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DEC2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfDZOmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:42:52 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52549 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfDZOmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:42:51 -0400
Received: from [192.168.1.110] ([95.117.100.117]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MNKyQ-1h8WmN0YJu-00Oq1v; Fri, 26 Apr 2019 16:42:37 +0200
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20190424081802.GV2654@lahna.fi.intel.com>
 <5a28f22c-22f7-760a-d076-68ff19800d44@siemens.com>
 <20190424084259.GW2654@lahna.fi.intel.com>
 <7e328b7e-f4f0-851a-4152-a9ffd058201c@siemens.com>
 <20190424094506.GA2654@lahna.fi.intel.com>
 <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com>
 <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com>
 <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
 <20190426130615.GT9224@smile.fi.intel.com>
 <bd5453e1-0279-02ab-3304-edc6ebf509dc@siemens.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <bc856e19-470d-7655-5680-a031831ab513@metux.net>
Date:   Fri, 26 Apr 2019 16:42:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <bd5453e1-0279-02ab-3304-edc6ebf509dc@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:57+Vsu3hqF1daSzg7tv9cHLoXy142HWEVeGZ8xaPZEQto4waTOy
 2acyQzFzj3fmavYNlH4dqZqy3CETqZ5B//xzKnuZ+SuKHt0lEHiXgdV13gZ23LD47wd5f7g
 AmUXJFdy+RCm/iqu6er+i+Gz8rc6zZdbXMProKFPsT2hifXbC+77GLnXHwBe8+g33riznih
 3q1FUbX9tS0KRaLll5NKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yBN7E88+4OM=:htSEGp+ToArwoxikrXnyBC
 7pnnFR6MvNepibdBA00sI6cgO/nth4lJpWktM+kbqWrfsDF46C9YZOIF036TXKzG3ZqirVSq/
 tkclYmkZZBr2P7rhrEFDuzAe3Sq/u0Qy1wbPt+zkjxxXmh2LXmqWu46tbV7MdUD0wDCGxTtv4
 7VdYny7mLS2UFIJikMtLyf/4Kzy3peMFpMAc50Z3BOtJH+6Au1SI6xt5mBBqKR7eHrkQlfGUD
 r88ZsuPMeCpcC8kKFvgh2wwp6z2KQNL1rPFJVGQieNocfW1FZUpaTJP96duiop8Tnzaish8Ax
 YwygFeDvLMfDpsfCMACu3NJq92JTFue6e1o5CZL9VT5YwmimP5BqpAkyPN7cSOJALblhw7zqO
 BZtqhNqxI1vJkNtTSueta8+t1xgK55OJnYNdCoIQETetnp8GbYBnll1ydGPkgX97Rxf/iui7J
 XlN7uEBDGN49EeGloy89xh5fyvzEe6tTocAijgZUfjATp1bCl3bWObT98HOnpuScOC6ZJCiXS
 PjSe2nGmfM8eEW57jBf4gqXkE/Y3+nQidl5x0o5KRovqFsoxfORZZtv3KzZTRAFz3oEUuCHlQ
 euEokx4mZ32Jg59idGpIEUy+9MiAqWdnzGAmLW3SQTrnTkPZSzXqjZcDD8sh4pilvnz9Uo+WH
 WC9D4fVjX4s51wWG/XM2ZRIE8I4uTdnSmEiDGAThndpoUN40oWV9hAReLrSVGyNu+ZNiLWgKQ
 yUTbKYc/6R/RkjPwL95eh+lH+GsRLP63Nk2XkFbh/q+mAmB/XZ4n5hpVorg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.19 15:36, Jan Kiszka wrote:

> At the same time, there are no real alternatives - to my> knowledge - for the value it brings (various bindings) to simply
switch> the engine.
Which value exactly does that collection of crude wrappers and broken
attempts to buypass the kernel (driving gpios via /dev/mem *facepalm*)
provide ?

mraa belongs to the category of software, I would never put onto any
production system. (yes, I already had a client who asked me to repair
his mraa-based software. finally, I've replaced mraa w/ a few LoC ...)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
