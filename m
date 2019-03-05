Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B483EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B5420684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfCEATC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:19:02 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:50997 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEATC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:19:02 -0500
Received: from [192.168.1.110] ([77.2.115.28]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MJVY8-1gh6Wb3tpg-00JvBg; Tue, 05 Mar 2019 01:18:54 +0100
Subject: Re: [PATCH 2/3] x86: apuv2: fix input dependencies
To:     Arnd Bergmann <arnd@arndb.de>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Linus Walleij <linusw@kernel.org>, Enrico Weigelt <info@metux.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190304201930.1622839-1-arnd@arndb.de>
 <20190304201930.1622839-2-arnd@arndb.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <a94c3c6a-481e-96a5-74e1-8c3299c74129@metux.net>
Date:   Tue, 5 Mar 2019 01:18:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190304201930.1622839-2-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:C7vffW4QSdQDVRshbGd9qoU1jB2/16z0xhzCsXMj1FJFXXD3QnO
 u9oCGFHRCi0L1tLtXi0vYqKUTeWdkjcV8uZyFPob8YeEfMlCh+duNC4d/5tBGDQ4k7RnCoD
 ENXEm5XfYc9eni59bIv2J8Yg466832y84oDtF5km2yrJw6WDDSLH97QWGCPNHHpIH1yd5vJ
 9R77E0qVXuxUmNQ7olQ+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pdRzrBHxIZ4=:r/0/JAkELntYwV5ClbzqEo
 /DrwNHhzkKVGKycNh5lpq7YEGDkPf4wOtg7A28cYEExiF3esLD3ks8KfhvDMu5SQwGm91rXTn
 k1bDhKq74REVGKFRWF6lf82vSrn7CPdpXzBJv1M97weZ7UU9yx9/XucRNfv1qKqAhxD+jn5b8
 HO9LA9ALmJI6bTpPKfFfsSr0TqlTDTXYMW+i32VY8hgQBC7W7BoKetoqe4AFY/hPGH5go09vC
 afhu6NDy9CSN3u15HIvRb/dgnarrCUSE9pNbiWV+1WAeSofffIHDNLmKD7PQambbAV3S/Dgt+
 gT+OKRM4c3NF/0bMKkVEg1+nE69jWVwerHDV2QC9i0QIYyqkjEqlfugAANnwuczvYE8vzDRUK
 9M3U5bH2Jklv11+Z8Mu4QecKDuk5c+MxC1sNPYhHY8DMGyxSSIqgdYEQW5WNzRG//5p5ZBznN
 Xydff5zKN8tUtgJ6BE0tJUhjhIgw+2lOCsTfD/SfH7EcatISkC+6Rm6/Vwr9/Ghp1fM9JzuOu
 LGzj7aNvFu77BViYILUs18rtN51oRaJm3DTHZFA6Egt8okEpeo+UjZANBo/yp5/JouvxCc5Ol
 hLtAcbtRXSFhk5RzDI7Xzi9ibL2b744E1iXOj84Y+lhntPtwod7we3c9fLo1KU7h4BaDiEZ8K
 KZhChwbTkuj45kVlFRrbF2mth0Fc6e6FczrqBNERFQ0e0snPiKKX8KV+DAoLIhqr3yGYZf2GT
 xREl3Z1ibbz4ntPLvk1/cUuSqapqt4JQthJ94g2avo1RZXgl4T9qSe9HdWI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.19 21:19, Arnd Bergmann wrote:

> This could be fixed using either a dependency or a 'select' statement.
> I'm chosen 'depends on' here since it is simpler has a lower risk of
> introducing circular dependencies.

I'd rather prefer using 'select'.

Otherwise the driver won't appear at all if INPUT or INPUT_KEYBOARD
aren't enabled (eg. when you start w/ minimal config - which I do
frequently), and people have a hard time actually finding/enabling it.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
