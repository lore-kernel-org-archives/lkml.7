Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D721CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED41A20684
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="p95C1Uon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389800AbfJWHYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:24:36 -0400
Received: from mout.web.de ([212.227.17.12]:38857 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389118AbfJWHYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571815448;
        bh=skmrCU4cvWHof6AkZwFbDtYP1ZNwTFh6o6IDe79PtSU=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=p95C1UonUPcUS39Pk/WHerzB+WDj/RmPhsYA+pVoQN9nMA5g8bqpmGA/rs+gcWoLx
         ryXasS++WsQXXxZ67QhyAFTLDMCwuLa7iEIyLL567YPHf2a5LGN/+jAD6fb7U1L1Zd
         s9L+warx//TfmZ4DkMaessywKC36eD09Qkre5Dv4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.140.249]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPHC8-1iInHM0RAu-004SpJ; Wed, 23
 Oct 2019 09:24:08 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20191023044737.2824-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH] clocksource/drivers: Fix error handling in
 ttc_setup_clocksource
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-arm-kernel@lists.infradead.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2cd566ee-0467-1e06-98dd-aacb3ca42e76@web.de>
Date:   Wed, 23 Oct 2019 09:24:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191023044737.2824-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9gF365o0UcilwO+pK5RggT1crT4SSoxmqNc/+KoSNeEL/AgGuPK
 9bV5/6Pym0AbAidK5f1Q0ukKa1QmBh2RTA60dHhmIoh+xJyN9gtVKtQ2IQ1wcxbVEhJF6zm
 gmSqgMt5sVMxC3SLKXVWQ6SX25DApyWmLR4Vchp4fk3/j1nUXeqMxqn6nepqc+yQwF9nQ9Z
 WfU0c22/r9Zgh6xe3UCdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KH10sGuqIuQ=:4PaQIEJRAGAg0EAOy5bXly
 axni38kGNM7wHEEgp7Em+n8OsvnItmOQ+zkT+Wgmyhn4U/qLGay2+kHGCTFuSQCdN7r8hcWq8
 ZrsVMR3on83PmJ8lLclXi27JqcAxSF6j9uDn24GZIIFI8GXtZHzxU7yApk6KjLQp8t2znUWNg
 6rwMholuJwBLX77Iy5eKZPFwW3C0xcAwP4/6/yj1b2VotivK/p2TTQueLP+6C0eieaFDBEf4J
 3WrjDRzctOF7q+MzGV8Y6z6wLgDY03f26rQqHBxdIXZvNOEktlFVE+yRStSNrcZn7j3g1Dn2M
 1usMZ7BuV7w0xGbu2mHUL5UcZAiHnXUG4o5cKcMcDg/2QSaTh3LX0tDjrSbx50s6968XGhCmx
 NSbxLDCGeTCwVQmXnv2zmVEkhNc8la7XXCoyRefFumXrFtetY9DkAIQgD1YxtyD23n1GYZEq2
 Pgg+mCDdGVY9EOjUjPQGcHzvfwZW3h7Aaq2+ZukeXWC4mTOfDYfwKHNyj5G4iTCQEhhO5bo/e
 IqJBiQAHHXVObU4BQjI3oXZMHnQp+BNaiA6KyTZ5lrQ//wQkCLHo2UQl1DdQtsfxOT0FeicHh
 gE2DQoRRRUr/VhBfZfraSB4t07A82JZda6/cStd+ctiDYYi01nXH+aiPb+42J7Z/CtouczJMq
 X+pX4RwkTIiaB3TE99kVk5YX+JCLwSjibo7oam+UkNM9CNG/yWSrII4C6xo4d6jPh9ZeAZmgU
 +KIY7FwyAbZrL7G/lf+Cmd/4MLsVNChJ2cDOMbU7ID1hVyk7u+l3w3KxDGgGNo/TSeXQfotgG
 jJpZyJJrPpZWimXB11qJ6h7AYaPbpe7KIwzYlc3GlXu1gUlF4ONhg+g5stYb4kjGuwL9toROF
 6zTKiY+KnR7qVvKbMZyPfayAyqSTrTPSGYVY2eT6bixHf79zyiQEl8VpXtnXJES51UiSXdckB
 czrH4OndWri+tmxE/aQXRuWgg8eK9zMnLNSIOH/MKHpCHlLxGtkEAVe9Xnz91O3gWSIjdJ4yB
 LM6yrHqgS3VyxcU0uoIUgu/TWmOXZBfsV4hF8hSyMBwoV8iwekZnhvp7DpsB9YVNnMLQqBcl3
 r9g278CxRiQTqXUnRx0sfPtE8DvKAWcaHvh50eaj9NyVQIi6HA3g8Xa6B4AXRy53lqhxaB93W
 iWPEnNeVYSG9RQIE0dp+NuTJtyMu0bxZPWTIXV+6GdvYgaKSIDI9SOlKv2FXnXORgw1g2LtP1
 zga2v0kz2uyw541cqBlcmYFL0Ev3efvRqwc8q93cjCCglPupXukAXXIzM+7E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the implementation of ttc_setup_clocksource() when
> clk_notifier_register() fails the execution should go to error handling.
> Additionally, to avoid memory leak the allocated memory for ttccs should
> be released, too.

I got other wording preferences. Thus I imagine that such a change
description can still be improved another bit.

How do you think about to omit the word =E2=80=9Cshould=E2=80=9D for descr=
ibing
the previous software situation?


> So, goto error handling to release the memory and return.

Would you like to express the addition of a jump target (according to
the Linux coding style) for the completion of desired exception handling
in a different way?

Regards,
Markus
