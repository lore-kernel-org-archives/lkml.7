Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912BCC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D6E206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NiF3piWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfGBOof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:44:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42594 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfGBOoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:44:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id x144so11580887lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 07:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WjQyJp2iY5fGQc+V5V9CzoNmpSilM+nwtjmuAYauCEg=;
        b=NiF3piWStntZFsAy372v0MM1GMImhKld5gDip0Lu1PLdyy6+Ltl6+a2jJU5tTmYId9
         8jZ85ljZHm/Bpx3imlNI+faosGx7aI2iRRrJiM5V+sj0CV6CX1wIYNmXGiEY981UNrxO
         hf8yWMUWJOFuRXFWZ+dmcoS5Gk704pP5LQwI3JsKuHQrZ7x3sfjvw597qSs8xEaES7oM
         hpqzKPmzVUxa0Z7jiwBzpTrtulmisvOdcmKjTaOkdj0lrwULUL/oMw4WWU5HNrxnq/O8
         QVwG8w9rbhVvPmzIPIiOmh5pw20NMIIUgjXgIlRIinWcl9CqWcCz6+i7ZHYeqoCmWlpa
         5c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=WjQyJp2iY5fGQc+V5V9CzoNmpSilM+nwtjmuAYauCEg=;
        b=XcuhdXoYCuJC39THMVpn/4A9aBZlTIi+72hs/HcXxlAW42+hSTOpik6d+leTXcQ8yW
         4hDFncEVyYUro+c3F+zBoWR4txFxaqZStUPT2v5mOsJzzVs2KgFGOJoeCDJlc90+4gRG
         XYWD+fGALd3cw1D5VHakRoUFOZ6WITOMj2IH0LAFs3LbiYfRLz0qdbXe2xIfh4lIaiVo
         t5KNPTivPQbbu5dX38b8RfysnhWCyIaTelX631VuIOWIAYLP/unXYW+LAtIOcLkidaxi
         0S9HeREUDQOKauc15jDigQ3pX8/6XdN9AoOAJ0RFmcbplfcLKXvItpwpKZWkwndknwLE
         8/Mg==
X-Gm-Message-State: APjAAAUY8XyM/LAuj9UNh+KhbqMkzNUhB88B3vUoK1uPqJ8n+WxIZwxw
        IXS5P9hSWEEVuFBx8qZV65cocg==
X-Google-Smtp-Source: APXvYqwfPQEhJ9ZqyNl1gitN8PCg095jCz3ViGeh+JQ6PhSKFerq2czllQDDaVCc7B0WKAcPGCi1og==
X-Received: by 2002:ac2:51a3:: with SMTP id f3mr13273142lfk.125.1562078670487;
        Tue, 02 Jul 2019 07:44:30 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 11sm3821577ljc.66.2019.07.02.07.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 07:44:30 -0700 (PDT)
Date:   Tue, 2 Jul 2019 17:44:27 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        grygorii.strashko@ti.com, jakub.kicinski@netronome.com,
        daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] net: core: page_pool: add user refcnt and reintroduce
 page_pool_destroy
Message-ID: <20190702144426.GD4510@khorivan>
Mail-Followup-To: Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        grygorii.strashko@ti.com, jakub.kicinski@netronome.com,
        daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
References: <20190702153902.0e42b0b2@carbon>
 <156207778364.29180.5111562317930943530.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <156207778364.29180.5111562317930943530.stgit@firesoul>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 04:31:39PM +0200, Jesper Dangaard Brouer wrote:
>From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>
>Jesper recently removed page_pool_destroy() (from driver invocation) and
>moved shutdown and free of page_pool into xdp_rxq_info_unreg(), in-order to
>handle in-flight packets/pages. This created an asymmetry in drivers
>create/destroy pairs.
>
>This patch add page_pool user refcnt and reintroduce page_pool_destroy.
>This serves two purposes, (1) simplify drivers error handling as driver now
>drivers always calls page_pool_destroy() and don't need to track if
>xdp_rxq_info_reg_mem_model() was unsuccessful. (2) allow special cases
>where a single RX-queue (with a single page_pool) provides packets for two
>net_device'es, and thus needs to register the same page_pool twice with two
>xdp_rxq_info structures.

As I tend to use xdp level patch there is no more reason to mention (2) case
here. XDP patch serves it better and can prevent not only obj deletion but also
pool flush, so, this one patch I could better leave only for (1) case.

-- 
Regards,
Ivan Khoronzhuk
