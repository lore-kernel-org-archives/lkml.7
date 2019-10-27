Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8822ACA9EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501BD214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="AXNA8Zd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfJ0VLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:11:16 -0400
Received: from mout.web.de ([212.227.15.4]:53127 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729850AbfJ0VLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572210613;
        bh=I+TyMJFyvFqu13FItEn2z+FmCa1HDykGuyB+FsP3NSA=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=AXNA8Zd1FklpU89prt3j6occYda8K/cxgzfzuJBcOmGYNzxr7ICgG+WUpSChpovDi
         kvovSq5LmwxqyF9WgpAlAW1E932Un8kMxXR3DsN6GlkOEsjCLmnoctG4x8aaM0ABgE
         SjwZ1FJAjtgTIyDGlBeLGoDRf3603RePSVQRvGug=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.56.174]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LiaAW-1hqsUj2uFQ-00chSu; Sun, 27
 Oct 2019 22:10:13 +0100
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Allison Randal <allison@lohutok.net>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Blechmann <tim@klingt.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20191027192415.32743-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH] ALSA: lx6464es: Fix memory leaks in snd_lx6464es_create
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        alsa-devel@alsa-project.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <626ec93d-02bf-32ee-e4ad-011e2768d8e3@web.de>
Date:   Sun, 27 Oct 2019 22:10:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191027192415.32743-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:Y2TPlp7mNsYdnaAelmOLwK7v2Qr5LPVpwk6ElX515y94nQXfMoH
 VnU3yNCg+GkV/PguqH3q5InJR5SgbeEs1KM8NA68qp9CW1BtyETuH3WFlq4blawqc4IQHK9
 vZZwDqD8dhsFxPJ/gZ8u70qsyOn2wfPbYY7QIkwY5an0buTThJF/su13BN5dMdGoRHWqq1G
 0E7BEfcJFVtR7sA+muisw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aM6jEH9pI8k=:p/0A+9aNhZrcRFn23f3lsW
 Ac4XBCcx7WXC+Y+ucd49XtSzjmN5y88v5Xbxn8PY4xzEA2QNI0X7K5Z497nehKa1GxnBkrj59
 ECDypAtlWbdTuuPbWkoiFnShjOIDheDIlN9IyYVtxqdf/zR404a9C+9bqk5bxdUPoIhjEEYgZ
 90DMi8SKsW71t+yHoQ+jdBjy8wWWsWLgUxGS6ICMhZKHvi/ysGnT7BzBKtjrVyWvpzpKfeVMB
 Zlj0YXolVfXpoMM4PL+ELCzDHEtR/wLYGYJL1dXOM7jMQ11b2WyconZ7HQmw3fiw4Q3kCgiQV
 Cg9TgobXN88OsUU3VujlPikpKOsa/VgACfXA7Iv0FjTW0+ag/Jwi0N2Gx5q0oBZDHEwaKlSeV
 D+xW3Q5eQT65ZWItWecEA8NllKN5MMscwnunJJcnOSYjVnH98SnBb2y4rDLj7qYw4G93lLUIO
 Xw/tbmMHhFr0PDQAIpEhSQdRQqNVeDvWGtsfu2xbKfwcj36gGqi9LnBRBURWEmFeudaPxDo5e
 2HbjecjPg+K8RBeySdC1WrpsD+Ran13uvkwmtSQhLltP2j6aIbErCLu4708gQfDJOb5m5yj2s
 rC6Fs2k1Ebel7msaIvdTeu1NgdKsLexO/JF/d+tee33Jh+xwjZYNDgiNF7hJxMhQl94DEkr16
 Lbmg6A59K8PzCjHJL92376mdycUTwAoc7pVM1oXjhFw5uD3BduLnT7nOttRaygxrMLrndfSMV
 OfUF3OvWyJ9QfeX6zNJntuuA1gVpKT2H7Uv1wqqiYmw/Gqqz17N7DYiZAPvNwuNYsCXVYnU+Z
 nnDsY5/CCjFl7w4SnYvX3XGhbeGB9XH+MZsqek1rMvxTBG4t51t+WDHjtTh2d2VLapRhNIoEn
 cMlM1ROYe3MaBgW+PFnXbjBrUOAPvc1hE6tpCjiIcWrVLHWmxGvM6DLGy6QTtGmoryRgfrFXH
 eBXWp0G5oqGOpvEAiNSACKW0pYa3SqnOTNcxfVFCdepbx3leanVHRuIMExcU/oN85hg8DBoM/
 yUv1pAdC0OVrcNBjInePwmzvSG5QeDusAyjxJlQS9fuTXXRd/D5x+8eY7NDKpcBjSk2zmmtCN
 FcwMP9Wc53Nps6OTK3RnRQpfEDmZQw3sEU5eZcVsu6OBvwat67soDDMGY0N+DICcPElZCTQSO
 n4+K9x9SbBfjc0Q8F7wd0RoC1fGZyVn9QX0BBpmj3B1w4kdjcfGhBpxEoLng5W0oLeRtbnFof
 8Fp3FA5dmmafsjkNnNvmJnD9bcLodLn48Vk05xk5ngk5ij0aB4b7aDTtezgw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the implementation of snd_lx6464es_create() it there are memory leaks
> when error happens. Go to error path if any of these calls fail:

Please improve the wording for such a change description.

Regards,
Markus
