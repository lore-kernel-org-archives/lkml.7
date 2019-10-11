Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6E7ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7825B214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="svVx+c/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfJKFLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:11:12 -0400
Received: from mout.web.de ([212.227.15.3]:56023 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfJKFLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570770031;
        bh=bHP1391Tn3hiQf+u74TmLzs4J7Ywj2qN7r225cmc4Yw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=svVx+c/QZso9nJlT2iqhrw9hJkGvLai/RbZHEBJwRtqkF5TRV5m4hHfZVpLkAzVrU
         mudQngS1vHTWGiLQ+9xqFC4/jN8m3lbjGSCaZYzW3skIbeHSU11O7uTHWxwUxBbTag
         Cp7TFeFyVXYEZqywvAmxAWxCb7W86NvCTkQQ1GcE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.164.92]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LyDqv-1hyQAN2tbp-015cZM; Fri, 11
 Oct 2019 07:00:31 +0200
Subject: Re: string.h: Mark 34 functions with __must_check
To:     Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
 <20191009110943.7ff3a08a@gandalf.local.home>
 <CAKwvOdk3OTaAVmbV9Cu+Dzg8zuojjU6ENZfu4cUPaKS2a58d3w@mail.gmail.com>
 <4d890cae9cbbd873096cb1fadb477cf4632ddb9a.camel@perches.com>
 <CAKwvOdntBXd3OPiCV5adcDjXor886-XnsSxcStAjYBJpuEBrqQ@mail.gmail.com>
 <20191010142733.GT2751@twin.jikos.cz>
 <9b331c1184aca8a32b9132d29957cd5e8bef1c1d.camel@perches.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <adc2ab99-1a5b-d381-e96c-6801e18f3735@web.de>
Date:   Fri, 11 Oct 2019 07:00:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <9b331c1184aca8a32b9132d29957cd5e8bef1c1d.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:ZwigmNmZ2KJ2R0OmEJ1Z2yAT5oFulCEJ+yK0n5qf5HMXsNNhHbr
 HD2h6yY8QXqcgLqFEMKaRM+WZYeoSb7GcvEZqRK2Iq0CQef44NKGIpuSh32DDEc4kpScI28
 cFk+gHi49hIKRj2NDt7x41ZgWlPjKkhNGytVZyDII/jJvHvs9WFjp+IzjLnjrAC0cD9NLqk
 //VE1jDI3L1Bipy+PXqvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ekItsbdebGk=:O6L0xmDHb1WRP4AOigTnR2
 5ftCSvBlkaDRr2I/b+GtiLYXowmW/2QA8Pt6R8tJtCuXnjdbhZr+BgExuZN7dPfGFBoyiohMC
 Pjfgm9t/4liL9N/Fk1Vmsmxm829RWP/UiBzExv6rKJqlpSR++mnAV1YD6thzc3Te7F3Yge7nQ
 MfxVJE/pQQu6nJqmABDRoQaiOw3tQlmZjY+Yn1XQwQIQ7kJzSlzwey+ymoPv6vGTNtT7nwo6M
 oGzJLF4ucJFhdIr/htCU4JS2BDd4w/QelmYB8Yp+dnB+qWFHg0T6EWGTRQdvoiXi6eNMESMOQ
 XV4bZvpquKWX1/RKO/DPrC3z3rGi1WzRGk05cvlfdto6aPdFo+HI9X7AqaP/Nux1XWh16+lTr
 N1qavuOOAZ8Vd7+p8qg2YDvGktrpsjktPDTj0y4AZs9HWaCPw9KBjl4FYiKlruMfVtqIvzHcs
 XYBquxKDYP437726VcKzvDEhfjPkag57VGwLjK8B5iig+UP7tP2r+/CUbU72TzHv4/MvD5Hlj
 K6za+bJuEU8berk9BYdVdtmdy39bo+VhNl8fyzVe8jcU3QyBcE81o+riQZ8G9nls1DvKHBcwA
 gLJeLEbkB0BSwyx2wOJYQd2BZnvxeKqLfgbmuQyCcaz0v5GOJhx4hp5i/9m92OydA+WFfanFs
 oa8vAZzHT1YsPXUtW3M8LJvV6aNEcuiPDY9lRD5u0qwVfzvP+x+9/jHO7DK+QHKWbfZFTol9H
 N/DR7E3wr/cdfrF2jjF3tXEHfSIDgUE5lBK1CPsTiLvmCskdFBm8iHlzIpYUmci4ii6NUAC7X
 29j814tNT1QddhMW/3vj3biKDcJwlhKTei5LcLjMYibWdImks3izxsgSr2BvhA9+REdeOMesw
 d/xvRKBHzP2Rxe7crLbh+U+mUq04w0wJcYl4oti3ETqqNQhAuUOvVD62Hf3n43XsfwJCVf8un
 7kRBwYHypxgB+Mkrs1qQeKOEzH5totqxXBZ65bRASQvWyW5GZmsv3jhvCiahDRJ4y51MEUpci
 XKO+B3EnSd7CUzRLxizJsCNwme7xgvdOV2y/FFVJe9TW0K4XCiXeyfduNRYsvruHzKIwmXww2
 mn9anJzAE5yCO9Me33X1u510USMGFuxHHE8keFLibo2DWRMqZylywcIxy+bLq2Y0n2XW0YD/j
 yXwQCYJiP8NbdLZIba5+jj8AfEfbJFfUzTsuGLuP2aoj5rqHONwMGGLkXvmMqeuwMVjrhCbHe
 j05UjcSqQAM3yI+7mFC/v4M+pAm+rg5QBdxzBEil2Z9r2tEkx4h37pi8u55U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +our $PositionalAttribute	= qr{
> +			__must_check|
> +			__printf|

I suggest to put all key words which share the leading underscores
into another alternation for an improved regular expression.

Regards,
Markus
