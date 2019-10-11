Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4F3C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B88206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bnd5yfCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfJKMdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:33:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45074 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfJKMdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:33:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id r5so11697953wrm.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 05:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kOytMM5gC8Rw7dhUX7I+Kbb6M5MxyF0glkinKL9u21w=;
        b=Bnd5yfCqKUEaKgZOqcY1CN8kvPV2Gr+Q4fywsvrdloeri8uix9ORjvFoTPWg9s38PE
         L6phjBKcq4O5svdzvdGK+0F0IBn4NU4oqEfyvd7vRZD+y1IMPIpxiTsKcMlmtgO7DSYV
         Sy3ij64JmKhmMIPgaaIVVaT3vg5hW8/uIU/4LhATkdavmkvYxYy2pMh4V3Y3aojGsOcs
         g7fcyebHP5q2nEaAMX9ETqiPBaHjiilQd1RVbZkpf2qlQwxyhwK92Tby86JtYJ+hlG/W
         Ylah4FkZGbo9WWpyq2uPxCbkQFm29srzZOiKZ7uxSjkDRZ7J6SY8w8C0jggauuUuTi7y
         vyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kOytMM5gC8Rw7dhUX7I+Kbb6M5MxyF0glkinKL9u21w=;
        b=gFBi23JCVa7UfNEroBEar90ET1tgLFPEF8UIXMa1c2rzhySNEqtaFUR4oL44PfK8CO
         nXxBE7TiGPjy6fTHO/5bHV2btn/0bui81GroC2wLcdWu7u8/2eJIb3J53Fxx6iBs6UMP
         Xus/1CM4z0gOVxMc+saydj7GEcOxejATuVniaMk5GwuWtFilQR0IoX9gB5hoSh6oUEWV
         dRFa57iGhlnmo5ASrM+oD1OaLy1/MzYsOXdQfpagQFUCoW3yIofK/2e7TFYvt6EJp9FW
         Gt7v2Fq5YTflFbWxspMO6Ou0MQk/AM/QQ5FPG/vAC8BTECwRJIXMXZJu6k2VxOiFxNDN
         ZR0Q==
X-Gm-Message-State: APjAAAXlR8zCAfHJUHd63kzfMCFlfNrhE8FSqKYT8FExuP2bUX/fsevf
        jBhbFgY60hz3b5oe+Zot1+J2q0XXz8c=
X-Google-Smtp-Source: APXvYqyzZbUL8OhStZc+HlgbYhvSwM1wqEHLiHP4k90Cva2Yn7aztLK+n5fiCOQHcg5Dxowki5Fcfg==
X-Received: by 2002:adf:fad1:: with SMTP id a17mr13835488wrs.148.1570797177265;
        Fri, 11 Oct 2019 05:32:57 -0700 (PDT)
Received: from apalos.home (ppp-94-65-93-45.home.otenet.gr. [94.65.93.45])
        by smtp.gmail.com with ESMTPSA id r10sm10685311wml.46.2019.10.11.05.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 05:32:56 -0700 (PDT)
Date:   Fri, 11 Oct 2019 15:32:53 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Alexander Lobakin <alobakin@dlink.ru>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Edward Cree <ecree@solarflare.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Eric Dumazet <edumazet@google.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Petr Machata <petrm@mellanox.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: core: use listified Rx for GRO_NORMAL
 in napi_gro_receive()
Message-ID: <20191011123253.GA8693@apalos.home>
References: <20191010144226.4115-1-alobakin@dlink.ru>
 <20191011122329.GA8373@apalos.home>
 <88b9c6742b1169d520376366b683df6c@dlink.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88b9c6742b1169d520376366b683df6c@dlink.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander, 

On Fri, Oct 11, 2019 at 03:27:50PM +0300, Alexander Lobakin wrote:
> Hi Ilias,
> 
> Ilias Apalodimas wrote 11.10.2019 15:23:
> > Hi Alexander,
> > 
> > On Thu, Oct 10, 2019 at 05:42:24PM +0300, Alexander Lobakin wrote:
> > > Hi Dave,
> > > 
> > > This series was written as a continuation to commit 323ebb61e32b
> > > ("net: use listified RX for handling GRO_NORMAL skbs"), and also takes
> > > an advantage of listified Rx for GRO. This time, however, we're
> > > targeting at a way more common and used function, napi_gro_receive().
> > > 
> > > There are about ~100 call sites of this function, including gro_cells
> > > and mac80211, so even wireless systems will benefit from it.
> > > The only driver that cares about the return value is
> > > ethernet/socionext/netsec, and only for updating statistics. I don't
> > > believe that this change can break its functionality, but anyway,
> > > we have plenty of time till next merge window to pay this change
> > > a proper attention.
> > 
> > I don't think this will break anything on the netsec driver. Dropped
> > packets
> > will still be properly accounted for
> > 
> 
> Thank you for clarification. Do I need to mention you under separate
> Acked-by in v2?
> 

Well i only checked for the netsec part. I'll try having a look on the whole
patch and send a proper Acked-by if i get some free time!

> > > 
> > > Besides having this functionality implemented for napi_gro_frags()
> > > users, the main reason is the solid performance boost that has been
> > > shown during tests on 1-core MIPS board (with not yet mainlined
> > > driver):
> > > 
> > > * no batching (5.4-rc2): ~450/450 Mbit/s
> > > * with gro_normal_batch == 8: ~480/480 Mbit/s
> > > * with gro_normal_batch == 16: ~500/500 Mbit/s
> > > 
> > > Applies on top of net-next.
> > > Thanks.
> > > 
> > > Alexander Lobakin (2):
> > >   net: core: use listified Rx for GRO_NORMAL in napi_gro_receive()
> > >   net: core: increase the default size of GRO_NORMAL skb lists to
> > > flush
> > > 
> > >  net/core/dev.c | 51
> > > +++++++++++++++++++++++++-------------------------
> > >  1 file changed, 26 insertions(+), 25 deletions(-)
> > > 
> > > --
> > > 2.23.0
> > > 
> > 
> > Thanks
> > /Ilias
> 
> Regards,
> ᚷ ᛖ ᚢ ᚦ ᚠ ᚱ

Regards
/Ilias
