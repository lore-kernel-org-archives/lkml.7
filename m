Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F920C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0893C2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfCVSco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 14:32:44 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:58553 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCVScn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 14:32:43 -0400
Received: from [192.168.1.110] ([95.115.33.167]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MEC8L-1hEnUz09CP-00AGYT; Fri, 22 Mar 2019 19:32:32 +0100
Subject: Re: [PATCH] pinctrl: intel: Implements gpio free function
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     zhuchangchun <zhuchangchun@cvte.com>, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hendychu@aliyun.com
References: <1553135724-38331-1-git-send-email-zhuchangchun@cvte.com>
 <20190321084420.GG3622@lahna.fi.intel.com>
 <20190321092330.GK9224@smile.fi.intel.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <140c6ec0-7c11-6aa9-8434-f14d77be9a8c@metux.net>
Date:   Fri, 22 Mar 2019 19:32:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190321092330.GK9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VF5D8LSwT7qB3qNgsSR64hd9nxmDKtHkgyi3t4YO0Jme71qkFDP
 Og+mjfIilGwSZ1jlTmrfAEwvBbZZPWWIJfeQBzfWQmLi8QZoBv+kgEIE0iE4mY2ue1hpvqu
 tTg/3mcbh32ZivpNl0NGJQX+Wn/gdauGSpTaDwyhP3PqvXWjY/qTVeYP+z1cWyrxoX7xmES
 N7U0FXoAu98dqjX/nyjuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+y/Jh+KowbY=:cwI1S2Zl8x+EhuGcg27ttQ
 rgoRlHoriDVA9+w1ddGrJbhFUuCnuEFcDNk3GPWkHhdOGZjjjn0B+V7E0aCg85PGHzPmPZez7
 k8hpSRWO7fkWIvIQFtks58pGD/H7OrPF6J0PNtJOMy0kx846qZECoOg7JCQ1DLs3h5Fgla4ZQ
 I6Fgf6gFIt3dXPdbk/SVxmf5qiMNJ46iE6/3Ln6HnRq39qLuOEmVZqxEWuDWaKp2emawh3zr+
 C65vlO2CY4ifJRWznIgrj3Ir3QY9mfZh41UwoiGfGBymNEnNHvLWqURFPBU79LywSTsPTgpFg
 6tlXmW9oewhOr8Gw4ldmk+WvtIaYTLT/aUEmA7N8G32VjTgi0oK0TnW+j5Zm83dAPIxTGIA5v
 0oxoCXoW3QOkxp5lR8roskwmfMdacTFkHlvWKlN9m2jRKQaGYEKeLVvhCuZD52Dn10N5EWZI/
 tC3p28y7fr/LA0foFQWnsP2qpyOxS0QrclZLLy0bXciu5oFyaOcDDkkYxkLifeSFesV0nDFP5
 qH6KTeOi9Brc7g24Scool4RYI/SXCrkv4vmk1JdkoEcZdr7LUPpADNhY6ZoxQNWaMFAYocUzX
 pZo79dniHoBBTERZPsQEpySzGAglUPbS97EKuEjEwXOIcrBJ9NOB4HbumBh12xLjHs+0e98OH
 9jH8KOVv9o0dyAHk7GV49qD5uyjXHOxDeAduu3o8Ft7JB+buzoaVPO3zmO8azsGvBErFn0lyu
 XzEHt3xv4JF7/5lCYpG+L3dB1jgzifuB/gVjSurHnSvGm/PK1LTWbjsSwfo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.19 10:23, Andy Shevchenko wrote:

> ...and on top of that GPIO sysfs interface is deprecated.

I don't like the idea of deprecating this. It might not be enough for
all usecases, but for a lot of usecases, it's a very easy and simple
interfaces.

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
