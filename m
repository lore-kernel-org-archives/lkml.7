Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03B0C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 10:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8134520838
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 10:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="GwyrUOjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfGNKHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 06:07:54 -0400
Received: from mout.web.de ([212.227.17.12]:37795 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfGNKHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 06:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563098842;
        bh=bXndHdPJ3jM5bQ1RKItkawRtER4ZAQycYeZkZqs1DWU=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=GwyrUOjtKxDTEfETGu4dHU4shEjLuNo1rZ1+tUgG/E9M1qX/NbNKUAH3bbfWhexla
         ZkWwPEnDFYV4rmwSDbobiJVrZmxSINVL6R9ZWmt4QEBVuws4KNDGvIL0mTpgs5JDCH
         Q/GzFz9CSb6tSA2I4WJtAh2cI3tmpmmMz7zKVm0Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.159.144]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCZtW-1hdDUe20Pa-009QHP; Sun, 14
 Jul 2019 12:07:22 +0200
To:     Wen Yang <wen.yang99@zte.com.cn>, alsa-devel@alsa-project.org
Cc:     Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Takashi Iwai <tiwai@suse.com>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <1562989575-33785-1-git-send-email-wen.yang99@zte.com.cn>
Subject: Re: [PATCH 0/2] ASoC: samsung: odroid: fix err handling of
 odroid_audio_probe
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <fbd5666c-f681-4f09-eb5c-35c47d60d857@web.de>
Date:   Sun, 14 Jul 2019 12:07:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1562989575-33785-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5n2Rwt1HpiQQYgHOGVufp3KJuiq5qGuGoupTkQDnbXt19t2izfJ
 ilRmwUUcgkLWbfVu4ouAvUF32ozP2T6/oBQuHXU9fk+8RQyaUewsc6a8RoxqE3QpHhNSfm8
 mkqhB4uf+uxb7h156qHKrw+O77+FPZS75eIBXqDvnvjtwrMB+ejVsvVO1JGrRUkap570zJX
 YQfVccfd+SLMs5MFKV6pQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QYTy0z+JYvM=:BnN4HfEsEybItVrKYvv/sj
 FvANxBXjzi1stt549giywAIO/EGUKxLMTfttfpd3ASiVjUvhVatsLoFkpqhNyQUJ/Vg38DT1A
 Tis1JQ7gDZGnaw1k0p1ioU1pdPdH7OgJnyrMWjWvV1/NmYlmVzWuMZj0t1wU5GFU4MNTSAnP8
 u8oD15wwvw+vWr6lATzdKrCihKk1VlPexUxEZ9sYZhdNaF8sbCPPLsfzDpvmADe7k91iuwgG/
 nNlUv3BGHc+ri+uR9xgZJtZ+GleH8QJrhHN8XPJxy4Tw9dACRBX74OdRtpwenlDkd8G765wCn
 gv4jri6CHDf9+L60xfmfd6V+ug1SSJJDQt3EQFS3qtTraNkV9irJ/jiieCVASEbH1F87HFK+W
 5gk8xYKjFCQh57LeGromQ5Uuvs6H17Ykdg0urM4O3mrj5IGPF/Qpbbmf/87iYXnTCfX5REQKv
 acSyiWOndT3qysK+z+QZjuZEw+kV7gaPjuRTGeHxg/+064DMzWgPrtVfC8/D8pYqzpV+Frhq7
 yt2DEVXZVWTqaiuJV+zZ3aq3hT6ryqT+uGuOBNJJrKkoMt6s+ypuQlH7gQvsjRYPCpT3N56Q0
 PJ8Yh8wnAOWJiHcVOOaXLx6r5uqKB3elNGxRUeh1vxjmC+RKDemVT9L3EiJKu+HZl7XmxW+rS
 lO6YT1HDhkIzZ96yvAlvv9lGm8LzIg+bpl/xPwUWTVZft42MAAIj9dznnpj9aVc95T0E5v51D
 GqY6qiXNYzL2rEtn1fDZPeObF8hM+3yf5jB78hETv2Maou/JOVfnf1PtnyoUGTpDAxaXOjvQn
 pY/PYvFYEK/1WAeZxDcyWNbnU9sImk5Yhg1AMIBaomoM9qRcv4ITQSVI27oVL1kfTFDUYT+0c
 APJEgkJJPHXz1BT7/nuOMpuFa/RmMCdcipXeM3fi3dXTPATD8dbou9nt6+f+81rK/SQdhK64m
 VGN4J4QZFgaanDfdosOtf1ZtHmWeRKx4QibnJbqWKyQpBvhHnRS/GCrV/A5DAnD2EYvxu8Ts5
 Nj29bvmrt01G5LkLcABR2wGxC9YZJVLdMiVnyjF9uPAB5Mh7ZPk84GsiJ/O4dR3zMZxJFa2FW
 FEaPtwFIVcxDyha4wsufCwiWKJFGXTm2o9e
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would a subject like =E2=80=9CASoC: samsung: odroid: Fix handling of devic=
e node references
in odroid_audio_probe=E2=80=9D be more appropriate (instead of using the a=
bbreviation =E2=80=9Cerr=E2=80=9D)?


> We developed a coccinelle SmPL to detect =E2=80=A6

* I would find a slightly different wording better.

* How do you think about to convert this information into software attribu=
tions
  for the update steps?

Regards,
Markus
