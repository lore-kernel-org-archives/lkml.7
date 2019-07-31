Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6981C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFE52067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="oyNYwBY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfGaIXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:23:20 -0400
Received: from mout.web.de ([212.227.17.12]:59977 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfGaIXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564561395;
        bh=xiO1gfTe6z/6PMJZeAKz+knMi62ynkP1/41vXJS9rLQ=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=oyNYwBY+SJbzgVCdqLC/wzwekAPRxzjh9t/zOqIGd45WR6nhNztz9cLQYcH7zamqa
         5lqXYXY9PtDaQkq664VIyWQxiUELesnnYY8jdfWIqV4C7hjSoy92gMHAUqaO3JoXji
         1tlMBWZb9SJGVNoFL69/mBfLPzuZlznnoTMSFYtU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.180.205]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LdVvS-1ibSIC3S5K-00inkh; Wed, 31
 Jul 2019 10:23:14 +0200
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20190730181557.90391-1-swboyd@chromium.org>
Subject: Re: [PATCH v6 00/57] Add error message to platform_get_irq*()
To:     Stephen Boyd <swboyd@chromium.org>,
        kernel-janitors@vger.kernel.org, cocci@systeme.lip6.fr
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4a5c356d-14cc-b7b5-6d7e-f96c8b1c2759@web.de>
Date:   Wed, 31 Jul 2019 10:23:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w00pvW6tAM79iHnS/JKKQdk9lJ+gEb/oV4eS8q+XAMSXt7qBcte
 w17scM0SkeNrfHVr0yG/FYte151UxuU4r+XmstEhuhhuA2smKRcj7rKJ7jS8pk0qDR24L6z
 ByHF0zJ/cLx1p9qmk1AFpz5s7jftzhgfDPWtgdcK/irolgKA2BQVd4h8LNcb+sqBdyYHkkQ
 +q0PLmqCfgyTQC6Fx5ShQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A4rCWsR8Zyg=:E4DLLAKkrU8w7SlPhzsSiB
 xAGuNH3ONzMpzKvDBoQhKP61RV1+RsYzgUxMi9KAFel4ROmwbY63GADTTA1UGFHDcXvhBXprI
 BeDkcUtwZadmzbV2xPc8Y1tQVpYJVAkqly4JUHmO6RBfuQ5X8Po2k3P4I0Ei/tnydGwE4p5tf
 bj2EFJJzbqa5g+t1nXvUjJwUGT08vfKe5EDXN7iVGcBA1Yw9lLixEIet4izkfW1CNbysMroc7
 1F4yaXBYGovVI1GbVISR/dNe6oDzrRe2Fil5MA9Fof20YuSfh9rF3XZAe3i0TumgO3pp1oN0R
 a/1exi6+QNzHvO1usMIfnbQOsIUgJjiic05FWqhY6RKFMCy2VRoU56TAXMix3FhlYk0E1sEib
 fwyARJ0a9nOQZ8oREntfsurQtG+pAMk/Ru5Fmefh4bJh8O5gssXamokBMdiujQQwUmGyyIeB4
 Nl7+6xsk8fOG9EnPWEsg26atrrf3KyM1aK8YhzXva+cPt+7q1LMWrNMVuLpJVig1hVXiUnMBJ
 T50RTMtpzYy+ZG4yriH5eSFqpu4ggDPEHhBPoseGIj5WUE3/bwxhvKcRgzRboPTCWTlB29gUI
 dTx94HnLWpIbDMgJ4V5zsDtCFEGKGv8G5WXJAc10ZFVMUSW83IrZ54mArbWtdVoctXl6Z0ciW
 Zog25sJL6ECYUJhKg4fhRdE3MkMIsf8f2fLeh7at1qf434mH++UcU3SWm1tC+/m8J5XpNdz8Z
 nvypujjSOcI2qHqcny1AeBlFxY807ngTCMi42hOSU5r5wTS+RL/Bl364f3Tf2BcuSjEq5N54z
 eX279c6LAuLm5YEyfgKM8yCiFalRunPPpQghsCwzmA/819IiRp6T5OY81ymkNBGLPUT/Ru8/9
 m/TswxvFHWLGzs5Aft6JqzBqBAG1skim1U0UP3HM6unYf9FrW3HD0d9iNUmfXuDZxH1uLTTH8
 JGBfxrZoTgvQgaBWSWKAZPNixdMzcxdvfgAzzwog51h6EilsU/YNi3tpzzmjFLGmGmtVyernj
 Zm9dkt2p2SH4CLQPG7l1TH6/uKDRqTi3z/e/wtqrs0HbDEHop1MlzeaNM2ooK5MNppsIUXYNz
 FbTgPRZ5AxvTAL+Z5xXnmJQJuU376eWcB/B
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a resend of patch 2/3 from the v5[1] series, but split
> up to be per-subsystem. Please apply patches directly to
> subsystem trees if possible.
>
> [1] https://lkml.kernel.org/r/20190730053845.126834-1-swboyd@chromium.or=
g

Would it have been nicer to fix also the commit descriptions before
such a resend?
How will the the corresponding software development attention evolve furth=
er?

Regards,
Markus
