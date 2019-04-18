Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF00EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1A720643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I91MKNLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390757AbfDRSav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:30:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36508 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390149AbfDRSat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:30:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id u17so2360714lfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 11:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BDrH2xghiWsDzu64JGgq5KXMa51VeOg5C+1Bge4S8qU=;
        b=I91MKNLLyTOdb9kCQ6nrk/7QWGjWrF/5oH3P8fLqYdS4dRUjU17U5ZhPv6yrlinCeE
         up4eQrrfAgh/gXlQaKcgLFhMjbnAJ8SNJ+tfCQ4pQwwF3vd1MmNKVizotb/GUtVGuZ89
         yUFErUEIBKFwWRqhG+9U0rK+GYtzkyBJY0FHrayTeHmdXgX+PcMHZOD/xKNKzjpB/kwQ
         XZSNIuuAL7XM5w7LVjfGHevB3YrZoHkzYCK0WYX0TSqsoGHSTi0G1NHMnpps9lUvGto9
         6ZlGzRjsu80nPeCrdqVFxiKdGlsM2N/XAAtSrev4tvifctc47cC3z8vwT615isud8PNj
         hGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=BDrH2xghiWsDzu64JGgq5KXMa51VeOg5C+1Bge4S8qU=;
        b=BO4oWdE/0KfL/QSejQEd1fqkMfH1tAIEIRyNEFedluJl6vZJ+p/+EEErDBUr7Yf/N7
         tfRZerO+47uG0VN/96t5wvsCDY15a2b2DpXhFYw70DEgS73lmqyohI3Fr+riPaWWzKOO
         wUaiudvK7cgHiH6V/+LpQPk4WD+xhG4WyMcxe0BZGrElvqx8NRFjGIXfwAdZEClSQdub
         zSK3Fbw1BV4moJj7qV4PG76r3lqUTL2dIyUOhbHzLsaRjR9KhQVIK8oEaoxMf8C3srPc
         wlNHEpwct6p6KjKTciWFA3qNMuY4DE7vX872fKrI6dsEEP+opHllo96KlC+Igazj2uXD
         Lz9g==
X-Gm-Message-State: APjAAAWOjpgySXWgCgJ+co5+m8Vq/h7V3vFqyXJ8G3du0TW3o3D77gRF
        UEll1VhFWcJn8aaoO7yZV+SX5Q==
X-Google-Smtp-Source: APXvYqwIcovas9Ysm1mVpyjhfx8EgOQTC1rEopmvlMcL+8QtpMl1zkxq2zScpsO8sYHGpdUeejC5rA==
X-Received: by 2002:a19:3845:: with SMTP id d5mr18719428lfj.77.1555612247557;
        Thu, 18 Apr 2019 11:30:47 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id n23sm603574lfh.86.2019.04.18.11.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 11:30:46 -0700 (PDT)
Date:   Thu, 18 Apr 2019 21:30:44 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     grygorii.strashko@ti.com, linux-omap@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        ilias.apalodimas@linaro.org, hawk@kernel.org,
        xdp-newbies@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        aniel@iogearbox.net, John Fastabend <john.fastabend@gmail.com>
Subject: Re: [RFC PATCH 3/3] net: ethernet: ti: cpsw: add XDP support
Message-ID: <20190418183043.GD27879@khorivan>
Mail-Followup-To: Jakub Kicinski <jakub.kicinski@netronome.com>,
        grygorii.strashko@ti.com, linux-omap@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        ilias.apalodimas@linaro.org, hawk@kernel.org,
        xdp-newbies@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        aniel@iogearbox.net, John Fastabend <john.fastabend@gmail.com>
References: <20190417174942.11811-1-ivan.khoronzhuk@linaro.org>
 <20190417174942.11811-4-ivan.khoronzhuk@linaro.org>
 <CAJpBn1y0odvL97-kP5yzKC+tN=fx178nxigfBfDwXhRhPRvDuQ@mail.gmail.com>
 <20190418094008.GB27879@khorivan>
 <20190418104111.559a0e74@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190418104111.559a0e74@cakuba.netronome.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 10:41:11AM -0700, Jakub Kicinski wrote:
>On Thu, 18 Apr 2019 12:40:10 +0300, Ivan Khoronzhuk wrote:
>> >work?  The stack's TX ring has a lock, and can be used from any CPU,
>> >while XDP TX rings are per-PCU, no?
>> Yes and no.
>> am572 has more queues then CPU num, How I can choose tx queue not based on CPU
>> num? It's always shared and has to have lock, and cpdma is done in this way.
>
>Oh, I see, you already have another lock.
>
>> Here another thing bothering me, I send it to queue 0 always, instead of
>> taking cpu num. Not sure about this, but I expect to have some tx queue
>> not bind to cpu and didn't find a way it can be changed dynamically in
>> redirect.
>
>Not sure I understand :)

I mean, is there a capability to choose tx queue while XDP_REDIRECT or XDP_TX.

From what I've seen it's taken by:
qidx = smp_processor_id();

What if I need to send classified traffic to hw queue 4 for instance...

-- 
Regards,
Ivan Khoronzhuk
