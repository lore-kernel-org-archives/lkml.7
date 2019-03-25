Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DFA20870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbfCYJgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:36:42 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60031 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729608AbfCYJgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:36:42 -0400
Received: from [192.168.1.110] ([77.2.21.215]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mgvan-1gTp8j386X-00hLOO; Mon, 25 Mar 2019 10:36:28 +0100
Subject: Re: [PATCH] pinctrl: intel: Implements gpio free function
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        zhuchangchun <zhuchangchun@cvte.com>, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hendychu@aliyun.com
References: <1553135724-38331-1-git-send-email-zhuchangchun@cvte.com>
 <20190321084420.GG3622@lahna.fi.intel.com>
 <20190321092330.GK9224@smile.fi.intel.com>
 <140c6ec0-7c11-6aa9-8434-f14d77be9a8c@metux.net>
 <20190322190610.GB9224@smile.fi.intel.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <ca34b30a-c989-d6df-8d6a-93ea1746e920@metux.net>
Date:   Mon, 25 Mar 2019 10:36:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190322190610.GB9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pI55jai+C33yCwj9vNPS0Mwkq0i2MP92bDxlak6fsRRHWhQY1vi
 2XquO0rm3OhObaTo5AlUO714EWdV2kUFSvAM3qYk5LGxYI+bDI9J1rbBlQuoGbVFEGQ1i8U
 oX6HgACloe+eaJndDGzZumda9Mq9IeBDsotwkqmJJR7gtIUGerRDZ7AhUzz/D1RHXG+9p9E
 jazS/7EFkDgSJqI+kUwxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4FSUtOlJhJQ=:q4Pzbv3nR5PHK3WWV2iIJG
 4ANZte5lfrDgGjDJdaGO7sbvYHE1+fy6RQut0wuK2mMweQSr8NYH+G2nK4gOF9ebgl2DjJ5wx
 7fCJt/u2FHPCr7ojbrj6Y3uv/hOU0gfvfy0HKIkA/O2WSXwZhVlwpKjYhv76m/chIUTNtTpYg
 K7yYb5NcpFdQ2RyftAHewDBl05TV9dEnBLxfwryGR92HwJKpqQcAX5OKoxMhXP7QJ89DNOY1Y
 7P5C/Ji9bj5pN8qUWqwVBmXGDMb+cL2Gn4LbGywkzOToDKuSYVMx+1Boi487UHx0hRwvwjlWl
 pwAFiV7wT0Bwy/+Hoij0u0rO3M9Na7In1kNbMJIJl7oogwTPMJ9NPpqsa1Ffoxo2NIvN0jTUv
 m42zuzP242fF+wM/6dSjpqUiaLBGwQEGiPfsmEhW6ncQEmB7eayDPAD92KzynAp0xTHX7gCgf
 KBACLW5kD0k/TBN2n7aJEn9xE22RoD/T+vJXd2TM4APnZeREgU8i9RS/L4cmap8wqXyrsl6vB
 5WSe5emSFhV2SR3nhrkgqSfvrsnsPwLiIPb2aUpM1SP0nTA6IgHX8TS/6Zx6SE0tMeGGJadzA
 4NetIEJiKj2FdTG/alylk32MXOTtCio2xWhrUoRoXuQsnhVPzS4kKdJUwzHRxqy5mnuWVRiVM
 dab/NHuo3Bruzr8nlg77+LYnXbtgaMcRnSGcutcW/QM5NWdFnzqrhLfu1oWrhGbO+P9woUoYU
 V61q5kDjH008cCttk+2hyqbb99Ozqs7w17g5IqdHKQ2PW1cCqKwgIk01KVw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.19 20:06, Andy Shevchenko wrote:
> On Fri, Mar 22, 2019 at 07:32:28PM +0100, Enrico Weigelt, metux IT consult wrote:
>> On 21.03.19 10:23, Andy Shevchenko wrote:
>>
>>> ...and on top of that GPIO sysfs interface is deprecated.
>>
>> I don't like the idea of deprecating this. It might not be enough for
>> all usecases, but for a lot of usecases, it's a very easy and simple
>> interfaces.
> 
> So, you probably late for more than year. Linus W. and others discussed that
> a lot and the points of the choice are listed in documentation IIRC.

If "deprecated" means there just won't be any new features, but
everything remains as it is, I can live w/ that. But But having to
rewrite lots of applications in the field for the new interface would
be really bad.

Note that the dev interface is *much* more complex than the sysfs one.
For example, it needs ioctl()s, so this can't be done just w/ a few
lines of shellscript anymore. (which is very common in many embedded
devices)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
