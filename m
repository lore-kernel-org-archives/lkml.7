Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8CAC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 12:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E71D20820
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 12:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="X5Al4uIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfGNMr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 08:47:57 -0400
Received: from mout.web.de ([212.227.17.12]:60511 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbfGNMr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 08:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563108442;
        bh=Bv58aXwasISoukBgAwwIyQdm3DHnY22HSUajDGxRpUE=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=X5Al4uIle2ec6UTEliCb2RHjk1L7MXUIa8nKA7OJApxzBthvWfdBl2tQ2ktVYZM63
         ZYOw2tAW9qDolDVyH3qHYhVvqSbZhY3twptIOUIkyWVC4xEsIxNhQ7Kx7OS+N5hnwd
         pjKqmVwCVfpW5hBQAbj94loVCe1ejBalR+Uc14q8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.159.144]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LpNwf-1iRDWG3tJt-00fEQC; Sun, 14
 Jul 2019 14:47:22 +0200
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Takashi Iwai <tiwai@suse.com>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <1562989575-33785-3-git-send-email-wen.yang99@zte.com.cn>
Subject: Re: [2/2] ASoC: samsung: odroid: fix a double-free issue for cpu_dai
To:     Wen Yang <wen.yang99@zte.com.cn>, alsa-devel@alsa-project.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4545ce50-493c-8faa-fdcd-5aee3ca30792@web.de>
Date:   Sun, 14 Jul 2019 14:47:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1562989575-33785-3-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:ARMVCvM4n0fZixFkmnwA6Q1ueCcqChHYMLocwTvLTJOsT4zwMJv
 ZZnCMfu1tzzrYiauyKZXsAacRmYKQrienBCc8fSAk+ek+GEVJRon6ZzOKulL4F+hs5/WgWn
 IGpm/iS5E1T2oXDEeVpKgGYeuEcd7r4FWdca3cG44QQJthjHf3b8uOtYeddG6S3kNPE11BN
 a3GAoxdoqlR76h4N0fm6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X0JgI81HCiQ=:b1AbNe+rg82E6KQX5t8E79
 5zSJdOfuTQlVmM8AmskRMNiGnlJpg51hawdwWrK5Mcb/+KqAuIMXd194W7On4vkzDWgxChWQ9
 k63b9nSnQow/m/HqAVtwWDTnyTUWBrYyogk/8tNZMgNZ//NTBtAwVzrq2PUlQeUfPrTEPBzCQ
 ae6Y1ATsZWCC+JrhhAA+Ut8++VXTI3natF4PzcRzEKEyJ2SkmO1cagrhpR1EsloXg0x8xaJAM
 vn32F0GavgMGVEMmgCvGaMHvm4Hnjy0nzda7N46OdTKz6o9r1yvvh3H0fbpu8U/RIqjhpyFos
 MEM6M6rztpLUi4CoHoFeHOIssSRB6xcAsTPGBC2u78QjyJC6ZC6yQXLd+7LJWNuLsyk68NDtz
 dR8tF0wnbehTigWQPRwOEMbFWCEUDrZRd1AoCvg5kYH9Xy0zfoxklXChLSiYwHa923oNAIGvz
 +949uvZzuBDGMB9f6NjLR3BM1QnRSeb4hYx1kAQgoRMl97igVnXX0uAIcVv060aoWcGCLejZn
 TcrzN3W67SF5R2iw9ynfzopzE8oA9DhVjAZvAFb8tG+up6zpZUhKVMqWPgyoJ82bbIAJIGEWQ
 QxcRrSPo97ESH7ZhboGtPbjok1yhD8vKhFpecXw2ItkhcZhzMjzUgzo+XtKYzw7NVnGthBCcC
 9+I9zgo1LpiAZbpQx6yNyXX7x8YFXzsaJBb47vZTv7puDZn05ZIxWB5PICWDHIpiS4kDfgaEv
 /Mvmf0/UDUVLB+xoZu6MxMPl4VR4BbxxFIPkwOH+BGwRkTNjOBDelvnzJ50p5BBmHdq53pYsQ
 P/el6xziXo8Ab6qUhPGC7iJXU7zBm2x64svx93///tIy3O+8flX9p3YkkQ60Y+sIenZLjOTXH
 ER3o/otiiyNxo8qmnb/HxEVeJU9DLHWhMEUm4sM9PRds+ocv0Ppvt0FGxe5lU9kVwfHPGjaXC
 ZAENQi/u0vNkEwS+ha1JHZwpVGOrdKoFJH8ih2+wjIv0QvV/E9TROHcfmvv0RZOn8uXby/6H5
 RB6xCrHce52snfMCUmgXaILzPgNyVV1XV9WDtnGr6dZ4RrjhYD2op0XhehWLcYeztajYKxiOp
 BL5iaH3cFCQUndxf5CG71+G09lc4dBI3AaG
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The cpu_dai variable is still being used after the of_node_put() call,

Such an implementation detail is questionable.
https://wiki.sei.cmu.edu/confluence/display/c/MEM30-C.+Do+not+access+freed+memory


> which may result in double-free:

This consequence is also undesirable.
https://cwe.mitre.org/data/definitions/415.html


Now I wonder if two update steps are really appropriate as a fix
instead of using a single update step for the desired correction
in this software module.
Should a commit (including previous ones) usually be correct by itself?

Regards,
Markus
