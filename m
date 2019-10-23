Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B571CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DDA2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="P7m4Rk84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390242AbfJWIUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:20:37 -0400
Received: from mout.web.de ([217.72.192.78]:48157 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390020AbfJWIUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571818815;
        bh=1urHB5QX4TImKjSn5rNYrLD++7pMPjelkawIGF5kTrI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=P7m4Rk844Uc8RcUThTIJqzdEdQEhgIICRE0EfqVGVkTuuSX8V8JQXZUfxyY3p9kcL
         ROsDFDPPCjNkH5jXpaV3Y5cje3HfIf4kDTtP7X6W+zd7C1s/9wBv3oEN6Crew5cy37
         En2fow/TAANI39gm+4bINRr7wjkzW93JrdwmH8IE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.140.249]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lp71s-1hkqNe3ZXY-00exfy; Wed, 23
 Oct 2019 10:20:15 +0200
Subject: Re: [PATCH] clocksource/drivers: Fix error handling in
 ttc_setup_clocksource
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <2a6cdb63-397b-280a-7379-740e8f43ddf6@xilinx.com>
 <20191023044737.2824-1-navid.emamdoost@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5913e1b8-b292-de06-e47f-d5f982db2b10@web.de>
Date:   Wed, 23 Oct 2019 10:20:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191023044737.2824-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jB/9/sNWnRg7fAXxmE9K1RoIPmjkhyq0QzhkP43nkMA5Emp6kAI
 KocIVANYQavqi6O1Pqrs6DlclG3w22AH2CGQHTH6kl8hS1y5P3cF/EDSN9RD7iocRZx5uT3
 MSbJG6WcTueYh9Y1BkKN87I6K0uuUX1kqbSP/5gIFOmhmOnPt15Qi1aqfGbiIDhNtOUc1Vv
 TI1NYqhu/qNIGN9iAaCtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4xhHCnPgOyM=:bo0DmfHB14HK/aUTgUa63Q
 V5onzlyvu8gTGD4xAvOCeLTcObbW+Crc2xi2jJdl75OnGdTadOjZ98pDHq7fDwby6lV6xuRAy
 xEEEN7yWtUpnUeZFflvY/1Xamsif/8OKBy76S9ss244QYrbXs7M97KWvCEGPnFXpWmBThdr0V
 i8sMx6Te8T8kqpuABhwd3luLsiFppSXAks8san4bDLKQiJZHwsgn5Vd2/ibtQhgMBe6cHBpVL
 yvzKl0Et9zx+xHz8yqgcz7czoceaiKS57lig0d+1Py3/91IpXoj+2QAhiexYxHTZ3QhY8kOLE
 HsNyAepIyMzU+6LkcobA7uPMrTuVFZZEQsB5DWS6bv/mYa4F6X8qEKeeCkJDKW1PkYn7HPG4t
 69T3f85K1leQx0yclbyepiGsKPwP3nXxSn1yJ/HjS/CuCbpavPPh6x9tETpkAuW0+7CTbeyZY
 juIlKMMswwIEd3943HPWaaKS66zntUT6JmfVYEErYd5ySVo/AlQuQypuvu090E0DZLXdrBnDd
 OMlJAhBQf+iEtJScg6WTYhWpqjr61enNFCMB6MzcsPwe4cwsDpHCMc4sDWmAWF1sbwl0X105L
 s/hKgxzgSPU5jhXvgBGLNOERbkuGhrrKy6DM+xia9FYBntk60f9RkTP9/dch6FesWijwCREWt
 zSiP4XOVOHdFVdZxOqpSS/1+2zBfqjiOfSwdw8AefQ3ZjG2gRjPmIzyiQMOzH1bMmG6jFZmQw
 vbs2N+BvQ93JBH6umBQ+6xsRYsGWsnNA0pzxqyMRCdtb4jpFKPg0csRomyqqSFZs+LOtKar3E
 qYh2OPfVdKh4MCE1XSupP9c7ENVVnLDAhqKfR8TeKKVh5OkNnUUpxIZaR48goQNSoKdHD3lH5
 h7YbTk+V3iD+kfKuWXyON3hR6tjriM7ZFLbv69+d4USrrUIe7GvxHlLvHvpoJLJf2Ecmhdccu
 m1uJDRypUTv7ZBnvc5QlzrzaCxqK8YhGxbFCVPLYEmdjtGoRFsUZb67eAH5+XYVhpYVB5s1k3
 cWCu0mXHY11cwQti9PLK47bUPCgTRR5fFRocQYZhsDpPRZP8tShEilmtz1AtwePDYZmtoztv8
 q5aTXykTnOXsV4jn9sQFjv+JsMIEpYxYJWK6Xce935rSHigPIgcsAO5uvzWtDETI/0jjPiZWt
 vFEiYpKjGmaOYWOsnBlhHL3dHLP3d7aKYomdtp0VW+giRBP1t7zIT13F/vZU8BUVP2nwp1XAm
 d9bEjaSMkA12/snhZn4nWIzwaNYAPSUffBh3PUeU3kCAPUOYXxk1xsdelDdg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fixes: e932900a3279 ("arm: zynq: Use standard timer binding")

How do you think about to add the tag =E2=80=9CReported-by=E2=80=9D for Mi=
chal Simek?
https://lore.kernel.org/linux-arm-kernel/2a6cdb63-397b-280a-7379-740e8f43d=
df6@xilinx.com/
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D3b7c59a1950c75f2c0152e5a9c=
d77675b09233d6#n584

Regards,
Markus
