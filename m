Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0F9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A2720854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWmWx/5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfJOM10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 08:27:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37361 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfJOM10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:27:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so23616726wro.4;
        Tue, 15 Oct 2019 05:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4hTyTKATeOIbqPECdaIMFPIQ+kkXZ7Yjh6SF4N/1fVc=;
        b=bWmWx/5qo5LjCAVvXpAcg12upTfg8qcewvMIkjsTgspO1O+RBmF3NNaQkxFanLyhQN
         37vw/QnXljPI5T3DpwYnPDTakxyW7FY4G4Dv7Y2nTgfN3cpSKSmJg8UldhGJni0mVyEB
         7iGG7P1W2SqP23aUC/7/fPu0W04fhEUU1+NvqgEKGPT8Jbu5lDSif/JQhPrMBWkPZyye
         3oMqw729npEpyO6rV7AxhC07kMrqr5+vE/wZrYHFwGHVCD652byqMv1YF8MPzQvEtDSy
         BXnICE6ww3/U8GFKTMBbtknMK6XDbVws7joW2Igh5fib1FTe1LsvXNLGsANeOnMhxYG1
         ztQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4hTyTKATeOIbqPECdaIMFPIQ+kkXZ7Yjh6SF4N/1fVc=;
        b=JDqadmQjlkLnNR5fRRGhU7QlTL2Xxj0HkDDZftSiVpYiiuOC8h/NeSaLGeQ40JUnLi
         gsT1QmY7CzqP1tkxVHDHmWNEDlZm3rO8xid5bP0RCezuKBgJdpGV++K6vlNB/vmKinXe
         Iv5WEivvnRVvxMx43dGvI9AEr5C5cwWvVikYItVBrExlFOskVfzLItmaUsUZ4aV1XT1p
         KTZEHQ/vzlpxqnqgq6Qb5x6tKVKapmqFtiK0iAA0FJePRJ9bEx0qVR5936A36ckL/wr+
         Sb1pk+UlAbc2JaZNUpXusSDU/tLGXC78wRDhqu+9iveAEKGK47laKiPmCpZaZfZFfTeC
         1/TA==
X-Gm-Message-State: APjAAAVsvfggxtxr+dMafJIFJivkiR5OcuMN6CWnd+qkRPL1DvP6oBvI
        3dKS9YaNQmeqkkjueSCGaxw=
X-Google-Smtp-Source: APXvYqy6m/69vs3V1OEi86NEzfYQktvtypdOIpBrVFzKBI1sjIlc1ijrURisQ4GAvkwHCaIFkqNmGQ==
X-Received: by 2002:adf:f98b:: with SMTP id f11mr20156814wrr.350.1571142442781;
        Tue, 15 Oct 2019 05:27:22 -0700 (PDT)
Received: from AlexGordeev-DPT-VI0092 ([213.86.25.46])
        by smtp.gmail.com with ESMTPSA id n15sm19424015wrw.47.2019.10.15.05.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 05:27:22 -0700 (PDT)
Date:   Tue, 15 Oct 2019 14:27:20 +0200
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, Michael Chen <micchen@altera.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: avalon: Intel Avalon-MM DMA Interface
 for PCIe
Message-ID: <20191015122720.GA20768@AlexGordeev-DPT-VI0092>
References: <cover.1570558807.git.a.gordeev.box@gmail.com>
 <3ed3c016b7fbe69e36023e7ee09c53acac8a064c.1570558807.git.a.gordeev.box@gmail.com>
 <20191009121441.GM25098@kadam>
 <20191009145811.GA3823@AlexGordeev-DPT-VI0092>
 <20191009185323.GG13286@kadam>
 <20191010085144.GA14197@AlexGordeev-DPT-VI0092>
 <20191010113034.GN13286@kadam>
 <20191015112449.GA28852@AlexGordeev-DPT-VI0092>
 <20191015114108.GF4774@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015114108.GF4774@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 02:41:08PM +0300, Dan Carpenter wrote:
> > > > > > > > +	spin_lock(lock);
> > 
> > [*]
> 
> [ snip ]
> 
> > I struggle to realize how the spinlock I use (see [*] above) does not
> > protect the reader.
> 
> Argh....  I'm really sorry.  I completely didn't see the spinlock.  :P

Np ;) May be in the next version it will be more visible.
I done it the way you asked ( even though I do not like it :D ):

	spin_lock(&chan->vchan.lock);

> I am embarrassed.  Wow...
> 
> regards,
> dan carpenter
> 
