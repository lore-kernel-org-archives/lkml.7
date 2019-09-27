Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33FBC388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B6620872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jib1Vio9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfI0N6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:58:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40321 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfI0N6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:58:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id l3so2855586wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=gII68bP4dZ9iYMhUx7xHDSWnoKBKHppjR8OxdRxuXBw=;
        b=jib1Vio9p2uFXLtUzi6lfZKzVGWkziSLDW2+TRSJFGk6PgvdnLiOEh2A4ORdDfaL/6
         3uLg4fyINURnKSKJATlRUCzv07Rs/SJISz5rR4j4akSghw4SPPBtkiWOwIJpajnSVcOe
         WHWuUrGtYlk3nahK60v2BFXzYfA+3KFiaIkruKQVCQcTIZImNru0PuBFCBa4DJyDiGKa
         j3C1qJdA3ZniSFVahofA1sTCU65ji40vYu/fNYmhnq/b6VbO3ChdzOBrzGJcgLwz01MP
         /+bgNfXwtE+4D6EGE8iVLI9zTgAaSoW/bkxNCuYB2Djz3f+WpwX+Ury8d+/SsQQ7Zw0S
         2swQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=gII68bP4dZ9iYMhUx7xHDSWnoKBKHppjR8OxdRxuXBw=;
        b=XAfhBc80s4dpWzVzy3PpcgcVwrjkxCJscnqpB5ClOSNFgsT0LW/2nPqKe2CcsfGfbw
         DYez9g7SzpfHPMTHENVvAT+3mpRJXq46S5dUdcxGGd852m6JIzh8WIzTafUXDM0Y+4Ky
         mv8YTUnRfRt/H8ATgY+WKwPncck81zP3cP//3xEaxoqmEBihWJzez82+hp53V+fO5EM/
         +yZSLDrWskCfo9uu65i1lPZp6J1PmyVChfkiz6dURZEhHGFi4eHLw+hZ/NuzhIHkLZUB
         lWzEjp1954I3Q4AFx8j4IHHOEKzz4dYKgga4VUBGQWuuHYWEHMVe1JE4u4Kz6145OdiF
         EFzg==
X-Gm-Message-State: APjAAAWNuvJpkpjEAOfpqcquje9CUnlrEgQaDlhxovcdzlDZWG6xqDoS
        4fguAceUc1a3KJbfr3t80voLhYFToJM=
X-Google-Smtp-Source: APXvYqwuSdVoFqaJkOuDyzzg3VoL6LNVdgNCAOB7KF6CRtWFJZG1jZiUaDvFOdDugpzHJK1GuGAddg==
X-Received: by 2002:adf:dc01:: with SMTP id t1mr3093951wri.222.1569592719413;
        Fri, 27 Sep 2019 06:58:39 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b7sm2920872wrj.28.2019.09.27.06.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 06:58:38 -0700 (PDT)
References: <20190924153356.24103-1-jbrunet@baylibre.com> <20190924153356.24103-7-jbrunet@baylibre.com> <b328b0c7-9449-172d-a1ed-7449023ff516@baylibre.com> <1cd21d60-5ded-2f70-3c99-02b70f996870@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] clk: meson: axg-audio: provide clk top signal name
In-reply-to: <1cd21d60-5ded-2f70-3c99-02b70f996870@baylibre.com>
Date:   Fri, 27 Sep 2019 15:58:37 +0200
Message-ID: <1jh84x2642.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 27 Sep 2019 at 11:37, Neil Armstrong <narmstrong@baylibre.com> wrote:

> On 27/09/2019 11:14, Neil Armstrong wrote:
>> On 24/09/2019 17:33, Jerome Brunet wrote:
>>

[...]

>> AUD_CLKID_TOP seems to be missing here
>
> Oh, yes it was exposed, do you need to it to be exposed since it's
> dummy for G12A ?

It is a bypass clock on g12a and axg yes, but on the sm1.
It is the leaf of a block on sm1, for all I know it could be used
outside the clock controller.

Of course, I could wait this until there is an actual need for it if that is
what you mean ?

>
> Neil
>
>> 
>> 
>>>  /* include the CLKIDs which are part of the DT bindings */
>>>  #include <dt-bindings/clock/axg-audio-clkc.h>
>>>  
>>> -#define NR_CLKS	163
>>> +#define NR_CLKS	164
>>>  
>>>  #endif /*__AXG_AUDIO_CLKC_H */
>>>
>> 

