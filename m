Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45646C7618A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 06:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F73120868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 06:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Ncd0SFc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfGOGln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 02:41:43 -0400
Received: from mout.web.de ([212.227.17.12]:33443 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfGOGln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 02:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563172835;
        bh=5N7eSzP8Tge+KuNT1ByNfjpaRy8jABPbJMW1CVN3BO8=;
        h=X-UI-Sender-Class:Subject:Cc:References:From:To:Date:In-Reply-To;
        b=Ncd0SFc0uWIbKgSGcepmFx9gSLxV67/NWF8o6nXu8OOftEE6HgOWmfxLiW74gdcwF
         Daxk31Leg38oDqDMH9nEhbhxcVfWa9Y/GoGdRElFGcjYRRq7cCftMOGnFPSZxUyKiG
         wP5DCdNgyC5ePRJRzGob0ssqFW4pcsUCqr0T6FoI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.73.93]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxweO-1iYQbf1L2i-015GKT; Mon, 15
 Jul 2019 08:40:35 +0200
Subject: Re: [2/2] ASoC: samsung: odroid: fix a double-free issue for cpu_dai
Cc:     linux-kernel@vger.kernel.org,
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
References: <201907150949139435825@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Wen Yang <wen.yang99@zte.com.cn>, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org
Message-ID: <23d82d8b-d600-b28f-9444-65afe04a781a@web.de>
Date:   Mon, 15 Jul 2019 08:40:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201907150949139435825@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kdpL+1mGs2vHWKv1DMqvrBT4iGiLJvJV0KoE2AFL1EQCrSCthr7
 rP3myNrH+dj+I8cRJzcPIRLqHH8t51HF+9ygtIa4JrmNqxjILFHaDKCo+ahs5UlTTbucmMN
 leZovJkMtme1ZIP8GXDc1TsUCHm4xqMQkp3K3ztGxpKCbwyBTXlIm7y+7cCRbXq5K+QIBY3
 I3cKROv4WSV7c895ZLlFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hbv3PXxoCN0=:Zez5eONvyPtHFryPLpU1vt
 lG370vbqGn7UYA3mLpiiPVthFRZuvVeyEbmNwJAKzJ+nq5jV+JTrvC56jYEnds5TXGZr2bnDr
 RrmrpoMT9s0Kom041c2rBrKW3viXTfPeIu7NTZ0W9wwaMmm0XnWwW4sGSL5GS91dC07p3+fqb
 Ur+DvP2FEwkHAMuk8AO71nE2oQz5SAJzgJkIf/WIPuBrE8iEvir2fPP0EEgezSf+ACg7IfkVI
 BrdNZP7o0V4WY6JB8NHU4UzH10j2bvf6pp3X63WdsSXh/28MbF8kaxBWZfmPZbLbHGoybOOqu
 SU7uy/Zl2QrX0c8+t12CEDuo/lL/2cKsSoPVwPErKm5+Y90xRFH1N8JrfbV+EZbLU9k8W0PnY
 zcHyOdl2fjZloJI3Uv05xQXcZR9kSWuHIwWpiaxTgXSLySxMzV+qR4YPbHkvaMJlhO2JZNpH5
 n0LP/Kw4u0KYxMzTY7TqYuJrSSF5/1tgEeELfkGpwiZ6a73r9+TJVm6n8v97niuI0DDpL1i6D
 aw5W/TKXD13qVDyIOfqoJmuhHy0TarLUp1FVg7cGqlCj2wbCm+4s3bWKa1JUzJnTBrOrJL7tL
 0JowQF3itcCUDEdcNnUy8aa/A02yk2pFUYa8Jw0pgirjR9I5einV5UWo3jhqb+2fTjBZXhgKz
 je3fmITlZxGbUlFwgn0oCatROXssUn1VgS74HGasoShBMOBjulLQLgBjufsdpXb3RztbSP6VU
 72b7vzTRIeYgUmAeQD80RhScu93gxe5vYpMtKQSftTzCezjQYb7rA/rrDENSWYdUJ2T3uajJ4
 VGGp/e+lu2vvdOI5WHD1vNUYbwBSNE//8B1NFRmY71wJY1JLxGDI4wOyJx9Le34/3cIWmTQ46
 E29J9KaIBbeuPE6UD/nXi2WfGfb6paqIfEBi1I6U93Uh1N2TwZG3mbVscIqH+lGv4LS6xR4kX
 Z4Fx6t+FYpIAuc5sQ706wICVn2CyloZK3FFvq59/xcY7xyImiE+d5eKrcVI+xf3jqxlX4LbQ3
 B1CCQgsbT9Dzo8YUaNEF74eBx41dHGDeJEcH0owMaGDM5BOJYycEMTSGEN8ogMsjw6UhbvQyP
 SojfNPJ7glue5ScFlkeOEOIIVLWICJOVgUL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> These two updates fix two different bugs.

I can follow this view to some degree.


> and the other is the double-free issue

This programming error affects also the use of data structures which becam=
e invalid.
https://cwe.mitre.org/data/definitions/415.html#oc_415_Notes


> So we sent two patches to fix them separately.

You would like to fix something according to two variables (of the data ty=
pe =E2=80=9Cdevice_node *=E2=80=9D)
in the same function implementation.
Please combine these corrections in an update step under a topic like
=E2=80=9CASoC: samsung: odroid: Fix handling of device node references in =
odroid_audio_probe()=E2=80=9D.
(The previous update step would contain still a known programming mistake =
otherwise,
wouldn't it?)

Regards,
Markus
