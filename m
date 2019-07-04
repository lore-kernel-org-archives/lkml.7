Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF39C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FC621882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/WRwefk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfGDJxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:53:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46194 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfGDJxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:53:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so5519943ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 02:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BqBU8eROEpFAO1ocJziz04qM/Zuhm289mbEgEJT6YY8=;
        b=J/WRwefkB5fpBBCdNhDqnbGOm5pEkwQKNqGOuVjEbxWcbY1VIEAPkwEt41zK+zAM6Q
         ZJw9VnhlVc8m/WNlt/nkuVm8/4lJGRAQ7xwIZbvDwxmkDxq6zo6UMrYRECrYvwOsBREs
         TNi5OMDaokL/x789RToYNUt0Qz3HctF66Za+6QqRPzlbia03h5Lgs6JVALYwmcMdGXzc
         mLrkM4AQf//f/qlkMInXnRfbLtwTQW7hU2bYhDf4HAvC/2dkiVZDJVJSECYGk/9ofHLj
         xhT8SBZgjNaYnypN9ZY6Vd/ye6z8KnEFdW7LP6fATtmpQSZj8DdId3GEBYNHZTkzyE/n
         uJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=BqBU8eROEpFAO1ocJziz04qM/Zuhm289mbEgEJT6YY8=;
        b=CZvjFgsURcRQTPxRjafEeaKtLnnUbp6i+NcVnJBL0y8erT6Nxys4zYNT3O/frgl0O0
         sHlp0Ysm31Dj9kyfsiJ4C7InxiCxMO021nwJjqpZ8Q4gJi0DQNiWGhWdR2MlTm+c2Egu
         XpAIGbiE+WhCsLnlHICSXTdG6PZng3WhBn1SZAsBR2ypXb+yaOpdIcbnpsDJIO9GtCPM
         Ijyi0EL4Vrdjc7nv3WdMaYy0s/ZxgP13jfH1QzZwOffJjzsNNbk9JT3JtDRmSKpRXHF8
         pgeiUZLvFK3oodvkJ3nzO7ggnhO2nGtB/5rA+AZfo3iQSX91CIEk6gXPni4040pPOyKA
         xMHQ==
X-Gm-Message-State: APjAAAVa/OfOwJEYKsBIMhbtbM9m8WpY/IXHHIXs9AaA97a8Tnne7vK4
        u92Huq+dHGCGgLaAJSu+PaiGNQ==
X-Google-Smtp-Source: APXvYqw6wJVVcyLMuTZ4JGOF1cmfDRTD+Y4fa4WctmJ1WjU1aBHv7LlBsDBi0dNiAffOwBZUlFjNRg==
X-Received: by 2002:a2e:6e0c:: with SMTP id j12mr24002852ljc.123.1562233988708;
        Thu, 04 Jul 2019 02:53:08 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id o11sm799392lfl.15.2019.07.04.02.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jul 2019 02:53:08 -0700 (PDT)
Date:   Thu, 4 Jul 2019 12:53:06 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net,
        ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        netdev@vger.kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com, john.fastabend@gmail.com
Subject: Re: [PATCH v6 net-next 5/5] net: ethernet: ti: cpsw: add XDP support
Message-ID: <20190704095305.GC19839@khorivan>
Mail-Followup-To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net,
        ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        netdev@vger.kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com, john.fastabend@gmail.com
References: <20190703101903.8411-1-ivan.khoronzhuk@linaro.org>
 <20190703101903.8411-6-ivan.khoronzhuk@linaro.org>
 <20190704111939.5d845071@carbon>
 <20190704093902.GA26927@apalos>
 <20190704094329.GA19839@khorivan>
 <20190704094938.GA27382@apalos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190704094938.GA27382@apalos>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 12:49:38PM +0300, Ilias Apalodimas wrote:
>On Thu, Jul 04, 2019 at 12:43:30PM +0300, Ivan Khoronzhuk wrote:
>> On Thu, Jul 04, 2019 at 12:39:02PM +0300, Ilias Apalodimas wrote:
>> >On Thu, Jul 04, 2019 at 11:19:39AM +0200, Jesper Dangaard Brouer wrote:
>> >>On Wed,  3 Jul 2019 13:19:03 +0300
>> >>Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> wrote:
>> >>
>> >>> Add XDP support based on rx page_pool allocator, one frame per page.
>> >>> Page pool allocator is used with assumption that only one rx_handler
>> >>> is running simultaneously. DMA map/unmap is reused from page pool
>> >>> despite there is no need to map whole page.
>> >>>
>> >>> Due to specific of cpsw, the same TX/RX handler can be used by 2
>> >>> network devices, so special fields in buffer are added to identify
>> >>> an interface the frame is destined to. Thus XDP works for both
>> >>> interfaces, that allows to test xdp redirect between two interfaces
>> >>> easily. Aslo, each rx queue have own page pools, but common for both
>> >>> netdevs.
>> >>>
>> >>> XDP prog is common for all channels till appropriate changes are added
>> >>> in XDP infrastructure. Also, once page_pool recycling becomes part of
>> >>> skb netstack some simplifications can be added, like removing
>> >>> page_pool_release_page() before skb receive.
>> >>>
>> >>> In order to keep rx_dev while redirect, that can be somehow used in
>> >>> future, do flush in rx_handler, that allows to keep rx dev the same
>> >>> while reidrect. It allows to conform with tracing rx_dev pointed
>> >>> by Jesper.
>> >>
>> >>So, you simply call xdp_do_flush_map() after each xdp_do_redirect().
>> >>It will kill RX-bulk and performance, but I guess it will work.
>> >>
>> >>I guess, we can optimized it later, by e.g. in function calling
>> >>cpsw_run_xdp() have a variable that detect if net_device changed
>> >>(priv->ndev) and then call xdp_do_flush_map() when needed.
>> >I tried something similar on the netsec driver on my initial development.
>> >On the 1gbit speed NICs i saw no difference between flushing per packet vs
>> >flushing on the end of the NAPI handler.
>> >The latter is obviously better but since the performance impact is negligible on
>> >this particular NIC, i don't think this should be a blocker.
>> >Please add a clear comment on this and why you do that on this driver,
>> >so people won't go ahead and copy/paste this approach
>> Sry, but I did this already, is it not enouph?
>The flush *must* happen there to avoid messing the following layers. The comment
>says something like 'just to be sure'. It's not something that might break, it's
>something that *will* break the code and i don't think that's clear with the
>current comment.
>
>So i'd prefer something like
>'We must flush here, per packet, instead of doing it in bulk at the end of
>the napi handler.The RX devices on this particular hardware is sharing a
>common queue, so the incoming device might change per packet'
Sounds good, will replace on it.

-- 
Regards,
Ivan Khoronzhuk
