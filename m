Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDACCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094232084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="qQKDibw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438466AbfJYLGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:06:39 -0400
Received: from mout.web.de ([212.227.15.3]:53235 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393483AbfJYLGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572001564;
        bh=vUOD97YDKmM1idl52vAgkHaJpLDtnh+9IX8AJaJynFY=;
        h=X-UI-Sender-Class:Subject:Cc:References:To:From:Date:In-Reply-To;
        b=qQKDibw8gX8BYLFPdPnqsAvblfeMhQD5bK4jCl5TFgVScV5LT9lFQlVY+1UO677Fc
         Nr6vppn9tNdwtdhe86bNWSWz8t/r5WwNs1uXFKCrTX18qtipy1+L02rcPOn8mJsSK7
         fyCsLyHJkfLQKU414PvqHQY7odoW/dK+Bzg/dKjQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.4.210]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lk8fS-1hqHME1Iok-00c8kt; Fri, 25
 Oct 2019 13:06:04 +0200
Subject: Re: [v3] coccicheck: Support search for SmPL scripts within selected
 directory hierarchy
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <201910251738005781441@zte.com.cn>
To:     Zhong Shiqi <zhong.shiqi@zte.com.cn>, cocci@systeme.lip6.fr
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8d81532a-ff38-8e78-79e0-bb8b6b8f9561@web.de>
Date:   Fri, 25 Oct 2019 13:06:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <201910251738005781441@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:VaowjKObMWms629eT8x2R3VEbY8dp4SSRE/6uRK1x0xevnr5yyo
 ijWtr+TWyJjot9T2DEBGIa7FVGEtuTr8RGTaxrhDJ/lMPA/1COf779whlQ3XOPkf/GZLUc9
 Xxq3yilyzMBNhIcXY2pHrFtmsdj6tUp3OIOPWoQx3C5gQ44IUynjpW9VMFsO/GKTKEJUnj4
 4joS1F7/0R9feuDGE+nWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rVj3wfSAF0g=:FqlKcZMthOv5QP1IsC13J8
 Qz8KWGdkk6azwd9GISG8yj5kkYAF0ENEKpxqwCZ+/+6Xhksvk1T5wVNWtuDo3mEA2cfXR9CG8
 j7jhKaQcP8NoOy47x9bcOymzM8M5Gd3CSudfkx87vWIdPVaGdVxaZJgyufS9roqZ3ZvStorST
 Nd08RKqOxnGaGBhH9lpvzv5wyZf5/lOoiUODBC223+Ma3UK/tqRPjw4Ffn8MDJTbXmRxi8VCV
 bqrHfINtG6c6bFFU/fAvcE8CkeYqmWHYl5nCPGOnIJSg/22RSYvCtfbnG1bBznEXZRwKV0gCp
 J0lwbXCUdtKSgsn2k+Wq5z5iPCiJkJV/+t1jaMvQmI5fGG9Qmuunfgy83sQsHN5GV2YT58bwY
 LyJsWJxVcJ5E7K5h1/g+HjlmcT6z4n8jz2vJomW7bBw7sFb1rwtq1QnPATpwrLKv+kgfUs0LI
 9/h5aBoXvmyJNy0zChhUQtlD+kpSb0hIveHzefnzOyvtES4FiLzSrgen+aWY5161MS7+s4vwR
 kP5h0QWUVvyW5WXf9cf9qsebnWGz/jKit/jOzaiC0Bs1rP50zm+g2gG6FpVMzxIB7Nx35lwcr
 kfHjahBkXn16M3I2dy3VROYJGdW4JP1aIvWiu0ezLbyMcE9dJxam/bNw/VXK1ByrXDPWtj8oa
 dWkEk4YGlripdtss59lZ7mjYEwnvgAH313DR96c11ysuPvM+2hqXkZJWVtjdwKPif55ztHJzh
 yztWQYR2KjFAGq+fv6fHh4jIax7beC7PbXcjY8G/XdwF/UsrrBemR6eWhIfBhAxPREGG1nTtG
 8cTt+lEnNwiZ66iS9dsYQ9THczvG7d4yqeWniYEFBTThGjksOYlb7LTzGV4i1ugAGwCandEZ4
 Nqcr1LYEFQ0K+96iHHewjW/XZ9KOathw/9Zr1u2sTt7L4sEHIk1QrPdWqTmpbB5mDNseEWVCm
 RKDLD7LaELH6gkgjUCuh++K32+Tc2UmT130OlbNnjFHDPy5X41CzpSZR5f4AhsoPj47m6s2Tn
 tRzgvcm1L2DbYHRnSP5iMbVdkglStp/YwesKgwjQ8QHEi6SCYj25sy0Cj6EntPZRHSyPPa39Y
 nYvJFF0L5N/TKbvOODeIbOWX8WSoC26mZZYOARrlguXy6+heqCcBbiyty1LX1k//ygwFqa3DX
 WY1fkDxQBvxnq/whljGZONrML8ghdYvujtVBsaLgNKXRwbQGp9ueGgcbeeOHF6aJ7lh01fWoq
 8dSlKkW1qAG5WP+W/FTDJXO+VZG7nbeJqvtn56/MM6cF+0vK2J2cUS4SzOxo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Thanks,i think it  would be better!

Will this clarification trigger any further collateral evolution
for related information sources?

Example:
https://bottest.wiki.kernel.org/coccicheck


By the way:
Would you like to take another look at the preservation of delimiters
(like space characters) in presented messages?

Regards,
Markus
