Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D20CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3638821479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jd5drsSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfJ1VUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:20:40 -0400
Received: from mout.web.de ([212.227.17.11]:52529 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729265AbfJ1VUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572297628;
        bh=poxB/p5zs/9n07uoBnW2zlk5izmjFo4sTfzHC0tbfpE=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=jd5drsSekp35cF+bbRI/lf/CPfqIKmXrn+qaFVkZUczB+rgo1imHxJHUarffVCPsr
         aGVOr/p4wKe2p/ylvdy1DRXEoCXG+dJwEbFUNO7t1i0FY5D3SbaNU3YyOoVpsRLF9T
         LUxOfUDCnoHVxWR4ffP/3k6w+5gDmGNhvYKT/Ens=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.155.234]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MZDKy-1ihpFX3myS-00L09k; Mon, 28
 Oct 2019 22:20:28 +0100
To:     linux-tegra@vger.kernel.org, JC Kuo <jckuo@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Thierry Reding <treding@nvidia.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: phy: tegra: xusb: Complete exception handling in five probe functions
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
Message-ID: <fe6868a4-01f5-2832-9081-7643be0ab4a1@web.de>
Date:   Mon, 28 Oct 2019 22:20:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:S14+J9lKlHu42+pPg/HC0yE9/6IapDQzOcIDWN8D67/1jfWkINK
 LEsmnRt5D9OBjYyZKXJBaVVRXqZBGLGWpfJs30HLXFRIwJe4v5n6oDrtMiUG3L82PXPG0aS
 H2tm+fMonuZU29vARXkN4DiiVi1lgJfImNe4xQIbihs6Kypl3eE8rha75mtclLGTMPdaSXP
 QsqFi425Oqfd88fZrcPgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IlZ/wnhgbXo=:pPC2Qf58DvaZErslc/Zsn2
 IwVBWlwcyO+lbaIOAZjEwni+Yx4kHU0Pbz9XKckUgoKokCNESN9mzf/5fmlw9VGU94CZgzKRY
 WNWpZz1Ruygpy6inWHlRYZHLjAvilb/ElZuHd2kEkJ8lcg7AWfJCUKsxyZs/SgOZ1vPaxAF9e
 +F+uh82k4nAMvWu7JDRVp/EZc80ueGarXq+Xed5IWIVBkKy7FCNHGmZFaYZiQ/df8MeMyBrXk
 1N4Uiztq76SMPrZpksMijrOo2wFU1OlRIs/KwB1N2hGS7ASzKBgscTPVY1b2BMiy8z0/7fTUX
 aviEloHnmLXZLSO5its5adWQ4whfMsDZodQApJ2PKwoYepRp6GoPWePYWb2fLyVH13wUdx5Du
 9sh7oZJV7FjAOCFQca/+o0rjbLzC65etx5i1xc/CewAqlSYsxjRVGGEg+WfM5Pfb4fxGOgPvX
 T98laYh83Y+tLCu8zI60oMAX7NXevnQy9qdYq2nc8Np/09m7wYAOgjYo55YVkQs2s/tHJMFkS
 lC1fWUs6mJ6tEiJJRH8hADYmxmJXdh8+PWh03FWYbtemlMC7XU8boMHyrFh9wVjfogHOnAiAa
 CLpTEMTbrEqLiRrKPKqZEI2NXmDh1JYyQpLc5x7XBHXfGbMK5P77Vn40va9gboxYNGCshljgY
 SfJoav7F6tY9rEpwYzOSrBoOvKlGDoLsjFkAZkMmbG1s1oKYwsPV+0ox9B9WjVbs3w6BALMmN
 uEoxhUd2qn/ZY9olfR2MLGKI78tT+voBErpyzCvfWxfF3MX1V8zdzdWXs1s++93/x8cyy94oO
 0Tgx1XmefMqj/cs6QRLLsoFKcxFPSjz4nYWguDlq6vDiEd1Tmag3UPIxcFcpgSy1HjWtHxhnR
 LN7wGcyf5YzwUyxbtg2qLEBclvD+WvUYDo56FOrK9X4zqqOx5H66imUEuWOQVk5FnwYsRzqIt
 4ADoD9Uci4Fw+svQRTvDSvMOd1yByW0TcTsvnsTaJVmDJLlfML98mhrnGh4a0lwoDPGxpMLx5
 VC0OduHbrD3/r22bG5z5dikyxmb4xsUcdu5YEKaY0VKpGgb4/jwbnAy2BXErLKlYK67buo+GH
 hChMUhtnPkyMODZgXEYJbWSfH2Sa6/Bk82xe9NaaxI0pEboNN2D25NUJdB2FICAmNYuB3d8JV
 r81DCaba/kSdi63IYLOkeBRnDCOfrduqbBJ+LWTSRfxS1BPH9FKDLwUxpl2Gie/a5ixRR11ms
 XnX1Av/28iEPhKlOLJByqCdEskAPvu/dRnFt3c5dx97m6baDRx41pOPcUG4o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have taken another look also at the implementations of five probe functions.
I have got the impression then that the exception handling is incomplete so far
at these source code places.
https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/phy/tegra/xusb-tegra124.c#L608
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/tegra/xusb-tegra124.c?id=8005803a2ca0af49f36f6e9329b5ecda3df27347#n608

How do you think about to move kfree() calls to other jump targets
according to the Linux coding style?

Regards,
Markus
