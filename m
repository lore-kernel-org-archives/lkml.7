Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900ABC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE6221850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pW28AYFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfGDMtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:49:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37351 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfGDMtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:49:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so6041342wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 05:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pJR9Nbd+EOvZUGtVQfqXOkJPh6MJRl4K59V5gxu19nc=;
        b=pW28AYFsfz6lnQajSXfkgm0Hxur+z4zyo2+Mn98yniclwqQG8ecE+mzYQficvwPFQX
         CwaUtZA2yFftv6MUGI+P39gNRBhdcckVT6Z0SvAtY1DX2pnwSaoHEly7RoIVzrucF8G6
         QkNbFnvmuH8BK7WWkIuBgCbD3BytI6VZUw6ERP+uTPion1cNRcbhgGFAWdYp0RPt4EtJ
         M6uwQDJR9jYJanmQM8MXRDn0xqlApbLdnoCFWaJYCctFnhciK/AIsqBU+gRA1PhQpR1C
         M+emjXF3OofspwDRs4fsa/6DEY898+4AgcxTrYHV6MOPqtDDritljBieEejXK1CY6+2f
         kIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pJR9Nbd+EOvZUGtVQfqXOkJPh6MJRl4K59V5gxu19nc=;
        b=piT3A/oF30w2Orr63Qh2/Z4v0uZxh1n4EYQaIh0u+1Gvcj+V1v0BHYwu9qnH94+TeT
         w7p1B4E1JOl6XRFpUGTM6OQRLhLOPg0NKB6rRw72KmWJqPYhwNnG3R7eZ9ENzJkxkt8p
         HuWjF3QXIG8M7QJ4JdGml43WDdqPy36igvFtiJK2Ap/GN4hBw5kd1RCEBoSyMh71aGEz
         juNRDroqW/YKJ7lpnT9BIilTtllaaGYydDxKpWvOW9++jr/jH7vWPymYfTqEkVDUy9aR
         tKkE61xYENUZw+OWgHjPh7085Yi5Q8ew3WRC1qc6b5mmWJy9k21qrzgBHy7IOkv3tUg6
         QMYw==
X-Gm-Message-State: APjAAAXhVSeNj/PUG5o6PTUY9baQJROToXC5Pf4TXLtxUvcWSHJ0SvZv
        OaOTlSlS0lh28CQrmdlHadlZgg==
X-Google-Smtp-Source: APXvYqxkaYPEcpkgDFk9Q6mfIv5r2R6ZColj0lHQ9LOI2sMRzVJDlcVu4dSz0xDEM7lLB6xOpEFGdQ==
X-Received: by 2002:a1c:18d:: with SMTP id 135mr12614483wmb.171.1562244584926;
        Thu, 04 Jul 2019 05:49:44 -0700 (PDT)
Received: from apalos (athedsl-428434.home.otenet.gr. [79.131.225.144])
        by smtp.gmail.com with ESMTPSA id s11sm2387689wrr.59.2019.07.04.05.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 05:49:44 -0700 (PDT)
Date:   Thu, 4 Jul 2019 15:49:41 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next 3/3] net: stmmac: Introducing support for Page
 Pool
Message-ID: <20190704124941.GA9617@apalos>
References: <cover.1562149883.git.joabreu@synopsys.com>
 <1b254bb7fc6044c5e6e2fdd9e00088d1d13a808b.1562149883.git.joabreu@synopsys.com>
 <20190704120018.4523a119@carbon>
 <20190704103057.GA29734@apalos>
 <CAK8P3a3GC6f-xHG7MqZRLhY66Ui4HQVi=4WXR703wqfMNY6A5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3GC6f-xHG7MqZRLhY66Ui4HQVi=4WXR703wqfMNY6A5A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 02:14:28PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 4, 2019 at 12:31 PM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> > > On Wed,  3 Jul 2019 12:37:50 +0200
> > > Jose Abreu <Jose.Abreu@synopsys.com> wrote:
> 
> > 1. page pool allocs packet. The API doesn't sync but i *think* you don't have to
> > explicitly since the CPU won't touch that buffer until the NAPI handler kicks
> > in. On the napi handler you need to dma_sync_single_for_cpu() and process the
> > packet.
> 
> > So bvottom line i *think* we can skip the dma_sync_single_for_device() on the
> > initial allocation *only*. If am terribly wrong please let me know :)
> 
> I think you have to do a sync_single_for_device /somewhere/ before the
> buffer is given to the device. On a non-cache-coherent machine with
> a write-back cache, there may be dirty cache lines that get written back
> after the device DMA's data into it (e.g. from a previous memset
> from before the buffer got freed), so you absolutely need to flush any
> dirty cache lines on it first.
Ok my bad here i forgot to add "when coherency is there", since the driver
i had in mind runs on such a device (i think this is configurable though so i'll
add the sync explicitly to make sure we won't break any configurations).

In general you are right, thanks for the explanation!
> You may also need to invalidate the cache lines in the following
> sync_single_for_cpu() to eliminate clean cache lines with stale data
> that got there when speculatively reading between the cache-invalidate
> and the DMA.
> 
>        Arnd


Thanks!
/Ilias
