Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2112C742D2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 10:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F0620838
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 10:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rIbj9rml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfGNK5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 06:57:01 -0400
Received: from mout.web.de ([212.227.17.12]:52143 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbfGNK5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 06:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563101754;
        bh=81eladfMqsM5f/l52YP902lsEMHFBVleNkfZjwRQdIw=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=rIbj9rmlDrS9+4Gt1K0MCcAb8MLhINPENJjsLSq5ow3xBI8Z16GMkw1mdlm8IA6/j
         /aFToe+9pNKmAMvmHFhTxSuhqX3DI8pK09YBJy/J0i3Sdlf0ESMIOm5kbH81Zm9M20
         gDRx75fQ67hLI/dHpkun2JUiVJtUASAZaQOGX4to=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.159.144]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M0Qkb-1icEx50szl-00uXg0; Sun, 14
 Jul 2019 12:55:54 +0200
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
References: <1562989575-33785-2-git-send-email-wen.yang99@zte.com.cn>
Subject: Re: [1/2] ASoC: samsung: odroid: fix an use-after-free issue for
 codec
To:     Wen Yang <wen.yang99@zte.com.cn>, alsa-devel@alsa-project.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6f537916-9dec-606d-ea4b-8d41cc75a55d@web.de>
Date:   Sun, 14 Jul 2019 12:55:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1562989575-33785-2-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:j7Q+ABHMF7uNcALNtrzIqXAhDDMLELYJdE1GISE46wREN9SOZO5
 gy7kW4ofFOXNb20Rp/pKkTpVBSaknQKjPpDb1KaavkYcA6ffk9ftY9KgC0e1ACea1Fix8Gx
 BCbmr00oukrEEsLghzMzNLlN+nmp6OBfZY82kHoLifXkvhF4swOJoMt+Tgc+p7lwIXQ5Z+V
 tcRVw/Szp5N7uHC0FlisA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K/2F3bhXJ5g=:Enqa7X56SseLGf3fDudHmr
 wIOAN4QwMz6DE5RaYK7FnOuAcjM3XR0gYkyyedMBe9Txvn4gpnvctUg5KZ5N9raOqEIgCsMHR
 otLkrw4gi6Yn3+vQCETY1/AEByY9tKjjMdeeHPwGYwj6hiedCcNs2SKAFXN5qODSbbFvL0Uy+
 V5xQ0baVCh117MC95u+V2EYTBgx4jtsQFpxmz26MZyU14O3TUvnUVXzT8Tu3RW3Vovc8qi7AU
 D12e6K9TqgBxCOGgINbAq4ppegjOdRDT5YJsNSV0NhvHLlfd06znjkkQV7Mjv9GLEqfwogD7S
 PpYF7w+WReGal7vVXOHNZHerz9hnjkSZI9mzmR2ClLYaY8KoQAO4b8roxMbzM3S5jnftgkgO9
 zeTpiKZk8k7XuMjsjrd0seO1N4NrI2YdUTvak/onHWOBZMih/TJSZQbPMvAeF3iuLigxDSm7D
 1iIVpFCTcP8kQt/KUw+ap45gUrsFd+LxFk+Z3j909z5S5xy7z2Be2JRyL2LU0c+0lcBuOeUzg
 d7goLTceDi4lop/VGxBHAERkPJh/7b99qdZ9/Vktabq31q/ry1R5MXLAL/DfKzj/hsfK54DGD
 iFVdY4hKHkRtcYN/j91Cmtvyh6WWmEQqEUpKjl7+lgZ3HgPoz8ho4M321iQSrhU6GX8wxC+sX
 MndzcP+qfAK1kcsPm7/WrDcfjIo1kZxg+6zA/OzLZlZbzP/9zhN2UWh7BklbIBiUZ8qe8layv
 as/19N3a7RrKZPbZiiPat3nfdgDd2JXHRQI7bX1wXrX+ESL+Yt9dLteS11tMr6I+QTkIeaNnF
 QJ1hCO9WB51/nPXiZXLLiDV1mcNjeretKPh04eScCkhFCWR7QJmGmDRQbnDaJRzPmM4dTYM4B
 11IHyTkX4XsVwS4vrYHOPT9fpv1ZsHJexW8uF+AItJP1DU8QEFj/X4rB4SpG4B/lAuJhcQeY+
 uzYo6ZsdYZ1YxVM0DWFfPSuprC2aGoPpuboFvCTYetU3FOXDBi4724qmUjaLdzOdmeV14ug5T
 Uk4SOv1pvsGcWrodqq39a6aRHEbDld3mrQdM6h/zy4AaHROscS93I4JFTShG+4s2NvoTPbRYr
 BHENVeOT/MyQtIplGYR4cagnUnX+M0c5l92
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fixes: bc3cf17b575a ("ASoC: samsung: odroid: Add support for secondary CPU DAI")

* Can it be that this commit identification is relevant more for the second update step?

* Was the handling of device node references questionable already before this change?

Regards,
Markus
