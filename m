Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DFBCA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E484C20820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Lb5Q+5tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504407AbfJRGbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:31:22 -0400
Received: from mout.web.de ([212.227.15.14]:34497 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405849AbfJRGbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571380252;
        bh=p8mhWn/YrYMqYy6+4X9EL8V29BdU0woCBpW40cTEzHc=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=Lb5Q+5trUEQiuWSsc/FD3D9sXuiFEeEb78TkYvj3JWHEy5pAFFjgIHKZcIqVXM0wk
         EcpqmD5neoB+BG5TOb3P/aGhP0/v5VpeyYyRl7TtV41LCFGQJdamMrvd3+/+svjq5/
         t8zorEpweN5dJac+qFY5vBk2AAhHVgphNpJAutEM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.164.145]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MFtOY-1iIcEU19XS-00Ev3n; Fri, 18
 Oct 2019 08:30:52 +0200
To:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: iommu/exynos: Checking a device_link_add() call in
 exynos_iommu_add_device()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
Message-ID: <dfb07352-877b-0ed2-ea1b-5a4885cd740b@web.de>
Date:   Fri, 18 Oct 2019 08:30:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kz6Sq8uCDyYL9Ez0E32lMUJbvmecMdngPvik0NC9fOSKpwaCu/Z
 GHf7SqhybjsaEj4DjUJFvmknmkm6W7gVZB02ooERL9yygzF8OGdThEnp/Tfda20nwV0Kq5m
 4T/2U4ZTr8anhB+aj/oENyYdMcgEiW0AjOkE5k/igAWfO3w8P7mmUtW69U6LazhByxsh8NF
 IDYpGue7A/AIaWdOop6ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/3R1qhRFeWU=:lHE+wQICeMtc/QR2/JeDzr
 wJ8B0ISWyhsJrhy0bPfPrZ1+HCThx66JP5iXaqEl1IdF2VdvzMWIzYQBMGDwmVEFt1cVtd3Fh
 S8YMOyIHMA+VyjPAbCxK8vPPQjcmbK6pNW243Ga9N1wq96Bph71bzJZd7J4p/Z5CFXK+TfOs6
 V5cLO5pcp0Nortn3FyJGWrBSglMsVcoo6SiVcM/mXU1PnLA4i1X/9ynCdw+QDnXx/bYZxafYK
 5UjfyUsqtAfETx6M9j+x1TRoRwhPf5vtBdCCFajDwwc3X89zwl8LWDYKELVKQDZg7SyUy9eH2
 7kN1z69z1Qyxb9y54Wt2wW2G0PfAYjl/9zLqnNpQtReDIKvcertk13Ehv5gvgynNh2i9yvl3X
 kl9u966zgb9hP1M8QlQM8nT0dGVKPQIpkzhhcId10fJv2vdTdRKIxAeIKB8dGBTN7guaTtJi3
 fM0Yz3Rj9VFw2GxJ/Z4yopb4++ayk7S83sAEJDCvNQy/luSKP86lgrwWAkG2NP5uMjm1qYbV0
 pbh72TJhxj06ab+sxBf7hd4VxgFwg0AmgUf4OmbZV5Rw3Fg3smYHEtK9qsMFJIspWOJPbaKyH
 Hz817z3pW8zCogar/N+P+7/iwZ3t998byiJdkhR+UfyYYsf3xyMw5hukqMjW2JShzKo8I0Abj
 oU16da5E1e3yKhn97HLdwfYAUN8C4dbtHsWAOyounOSij6ajZKqN1TgjAAcxwK153BbyLA94C
 VkSZKitvfnymbcgWuXoXj6ukf8S7id7CoMoO0fDW8aAqckttEQ/FcbXXl2WTrDD2crr2PJ0jQ
 s8GH5fQM1c2mleTkJdc055US7X0taZ1RSZdCwfild9iohfouwCaVzcf3Xb5IE2qmrxNf2OJZE
 jfjOvRTvud6xtY50800RngNfQhBDwJtgvyGNlvbqscZ5TUpottmeyu5dUY2UbA1qFCh/6M/pi
 EqETrzXxGga9ZJax6aGbOcFKg1Bvz/xpVuw81cKvAwy11aCW/3y9HHYqBK4RWfMACSXZhRo+k
 vDnVGs5oyw2Pub3RsG498qpK6gOiM+zRx6kWgAZIh3WWq9f8k3r7ZwlCbaRpHE2LTOOzQpTVR
 nQkBvmGXBWZgqBouBbhD3djNv8A5ZB28l9t6iP1w/2MP6rPy4aQJ0f7Met9hUzSybGGQPuZNJ
 s9vOieRWSsH1xrY4ArIYRbENyRR1z+BhxLLHhEJBfibYt7SLPJCD9mA4YwgLrWTpx/Z0nxIae
 Te10wqPTNMAWVq1UOCjMwlkcShmhumWhujAEgRavTQJ7PVEZc+qv7tZhEvkw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried another script for the semantic patch language out.
This source code analysis approach points out that the implementation
of the function =E2=80=9Cexynos_iommu_add_device=E2=80=9D contains still
an unchecked call of the function =E2=80=9Cdevice_link_add=E2=80=9D.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/iommu/exynos-iommu.c?id=3D0e2adab6cf285c41e825b6c74a3aa61324d1132c#n=
1253
https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/iommu/exynos-iomm=
u.c#L1253

How do you think about to improve it?

* Which error code would you like to return for a failed
  device link addition at this place?

* Will it be needed to delete any links as exception handling?

Regards,
Markus
