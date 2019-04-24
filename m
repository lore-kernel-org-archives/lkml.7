Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700A1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E9A2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfDXK7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:59:39 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:51163 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfDXK7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:59:38 -0400
Received: from [192.168.1.115] ([95.114.95.254]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N3sZs-1gbMBU2bM8-00zkri; Wed, 24 Apr 2019 12:59:36 +0200
Subject: Re: [PATCH 3/4] input: keyboard: gpio_keys_polled: use gpio lookup
 table
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
References: <1555444645-15156-1-git-send-email-info@metux.net>
 <1555444645-15156-4-git-send-email-info@metux.net>
 <20190419074811.7rkq3p6t7s56g4fo@penguin>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <9819838f-9e35-c504-61da-f8c3f9b7ac8e@metux.net>
Date:   Wed, 24 Apr 2019 12:59:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190419074811.7rkq3p6t7s56g4fo@penguin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:AEDuO8R1fQE/yb5isu4m2WsZxXxJQ5RzzLQy1341cR0Z05c5VuF
 yEVwzX9aA0+ifBAy0cb1azTO/KPlQY1fQZNJ2C1LDo7wCfi3fOmlp2Zl1UaW5/iK0+vmiTn
 dDy5+vb3SfcOiAZYlg4e5lPyBwLgMoZ+C2+FwiZ1hPpoO4H+GjFs4SIFPtCKZH5q4qLtNhE
 JQ9qY9fzfu+bgCr/38xig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ctEO6TONLF0=:KMIVncDUN0GGnZibhfU/WD
 da+qeggi3C5ItMWKc858Edzv6z1DMl8FirAxYz/WYPLovVq3IEvw9vsQZLN4nP6w4B0SZ9rpI
 Ry30DbNGFLL/HM7T6FJXTOb8hkm7u37TtoQZLA2SoVrS/iZdUwZpyJTXMwwcWgAi5ch7wYgA9
 tXyJkGA4zQeYHnNR26LqckITYmaSCGjzouy5QLYyFzcTgUaMqhdQdsCXVxkmiv9ixtLPhxLHs
 ArI+Y4KAnKiDc3ZzDvdhhtOSIz0z8bTZtoWbQjz/PFGVxukwO/b/sDIx2jf1WfSulaS1eXD84
 4XYt99jvtIPPxRWAcoLxLUiySwlqmwKzoqIXnD6Xr3/n4PlBUlCwvqgmVW4AHpvQC6H4kbJq9
 WUDcR4dQiPhXOdRRDO674w4c6B/NqwvUXal9yN3jdCjtorVp8p/VIq8NiW3cUhQ2U4yVlN7PA
 gJsEQIuHTCKnpyVz2PSOUaHbJNe3hYkwrR8KktT00ZsL6CJZF9ZFKhoyawN0ZTfyWl7DnmQ+O
 jSsG+8wjwFfDsne1GJJgd+gzkhdCRpn64N3k3s5DBEILaee9zeebianc/Qj3dbbQhX2SwMMQh
 4vkR9XS5wQ6aeKTSLYYKQ4ruePsqOQbtUcmEy/TiV34ig7NdI3Ndj20d9uO+KBOO2mS2BNUL4
 w56o2nj/NCXTkKFbhZZFlpfUUQsOvA5yriERkP9sl2mGxxe9tr2J1i6832X2gaS6HUDv5cL7T
 QgPfmCWaK23gLksqre0PSSsd8zZv5q+OwR/1C9mZl+RLbUXUy/fNAWVqm8I=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.19 09:48, Dmitry Torokhov wrote:

> I would prefer if gpiod API could parse static board data/gpio lookup
> tables for child nodes, instead of adding this to gpio-keys. Now that
> Heikki Krogerus work on software nodes has landed I need to resurrect
> my patch to gpiolib.

Of course, a more generic approach would be better.

I did it that way I wasn't that aware that a more generic approach is
in the pipeline, and I needed something usable now.

The patch is already used in the field and seems to work quite well,
but if I'm alway open for better solutions.

I figure that the generic solution will still take some time, so can we
take this one for the next merge window and rework it in the next one ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
