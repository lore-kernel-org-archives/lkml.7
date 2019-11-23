Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F4AC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 02:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FD52070E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 02:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bQyo9ejq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKWCTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 21:19:19 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:41128 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfKWCTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 21:19:19 -0500
Received: by mail-il1-f194.google.com with SMTP id q15so8952196ils.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 18:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=SPBEDeCT3kwOdphyRQBZzPbq5J/p0MlFQsHze9zwisQ=;
        b=bQyo9ejqUVo3SvgNMyxvNK9k9+90qSUxDJ5A12wqws1rIj8SJo6Aa92G7Gjse8Nril
         zZARKjLCc2Zsgz783dnfDIeTXUGTLiQETm2X98yOAW0jdfPADM4XHNmDMNze0jH2TrYZ
         HBZEbJDX9allKnVDZsLPsy8Eoa/Up8HvbKiTJd+eNq0EjX1duDFptRF2II28hwqSc6W/
         Ly15u1HnKj1gsh0c6hVtDH5fdkXcoGRgLx+QMiZW0dnVtPokUJTjMPZvcQpczAIVRquq
         jYcYI3K7+/S1XODMR20cc8T6aKC3mscP4oMRK8l3UgA8SgsllRDczqiRkUyk9+26jHt+
         r4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=SPBEDeCT3kwOdphyRQBZzPbq5J/p0MlFQsHze9zwisQ=;
        b=Pagt6+5O8GA183PCmTJLoIrJ+U6T8YB0Cdr8USWLfrr6cWg/5+WYL7e/8hwN4c81vw
         XCCmWNLFGkPbX8ERbrsNMGoOe6wvjxXoSM+SuNT1kuY4wASlQd2tPrg3QuvKm24DSvYL
         XTC5X6CJ3mTOokm313/GV/wKbSSk8VPZim4UVcopRC5XGGo4dnvOZ+1DTWQoAlYcSJQM
         gv1yAywvELhYQ7NXBylXqaBR9PALkt9iGw47QGf6R37ioKU3twxbiC868OFhW0CiaXgP
         4YGWQbXWvJRnbfLuAtOc66p/UIQPsi9UDT/JfjSd8XCTeOSsJlrofBOu6QRbAEg1PZ42
         e12g==
X-Gm-Message-State: APjAAAWpDnOWzOM+zAvcUcU7FU48AHG34va82LD1Yn3Inge5AtLNnE/7
        8v03u6ED2xyuLtnD3T4tbCw44Q==
X-Google-Smtp-Source: APXvYqz+zuCG6ZEnbxgw59YpE+zZ0csSZbj+iHT/o5FT7FRW5zsTsYuareLuZIMohCPWGZ9YVAEuaQ==
X-Received: by 2002:a92:864f:: with SMTP id g76mr18274844ild.37.1574475556992;
        Fri, 22 Nov 2019 18:19:16 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id h15sm3497335ilh.85.2019.11.22.18.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 18:19:16 -0800 (PST)
Date:   Fri, 22 Nov 2019 18:19:14 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: RISC-V nommu support v6
In-Reply-To: <20191031155222.GA7270@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1911221817010.14532@viisi.sifive.com>
References: <20191028121043.22934-1-hch@lst.de> <alpine.DEB.2.21.9999.1910301311240.6452@viisi.sifive.com> <20191031155222.GA7270@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2019, Christoph Hellwig wrote:

> On Wed, Oct 30, 2019 at 01:21:21PM -0700, Paul Walmsley wrote:
> > I tried building this series from your git branch mentioned above, and 
> > booted it with a buildroot userspace built from your custom buildroot 
> > tree.  Am seeing some segmentation faults from userspace (below). 
> > 
> > Am still planning to merge your patches.
> > 
> > But I'm wondering whether you are seeing these segmentation faults also? 
> > Or is it something that might be specific to my test setup?
> 
> I just built a fresh image using make -j4 with that report and it works
> perfectly fine with my tree.

Another colleague just gave this a quick test, following your instructions 
as I did.  He encountered the same segmentation faulting issue.  Might be 
worth taking a look at this once v5.5-rc1 is released.  Could be a 
userspace issue, though.


- Paul
