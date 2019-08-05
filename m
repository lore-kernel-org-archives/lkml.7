Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53633C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FAB214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 18:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfHESSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 14:18:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35866 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfHESSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 14:18:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so830867ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 11:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5iD60MN3ezKI1+xt5FlPDcJaTEoPJLW96DLDKH2MmR0=;
        b=Rs36w3Gtqp/ZeJoZpwoyU04iG+8sE3YYjLggT2XWV1jt/7UrDN0xbGlRvXs+1r5Bm1
         3MFCl7pzuEo3eLdsGySP5EkAafparMYUD3BqvfNAUVgPI3tlBSgyuVrTN4ogmPuLuF6i
         nMOn1fl3+6cpdLBuvtkgRasckvmCXNtCRNuZW1Owvm07qKs2K/8r+IDysJa3vw3AdJ7T
         ZP1Zhcc5ihPZ6ngUOIEN+Sp5B7jGBuHbklZrkDGkd/FlKYpRF56k5r79jaqYaEFW7+/B
         5o6wsGtQPhFvFxCJZn9h7vIVGI5rafZj3EXeXN0qiATw/nGoJ8dKUgPQuXJHPcOpymK7
         gP3Q==
X-Gm-Message-State: APjAAAX01wFeSaWRrKKSFKoAR3eCntb8VXBGq6hOIl8a8ZzjPTMF/h+2
        LgwgrjWJqlh/3v6lsBrQXYBYjwu6J5GK1zT51NwveQ==
X-Google-Smtp-Source: APXvYqzBELw4G2jCqYxgIDkXE9OFhaWwBRVhy7Ub8mvdIqBjWO2i1v3mF9Q01T8rDZyiz+sIt0VO0YHuvz2HFjdenWM=
X-Received: by 2002:a2e:9643:: with SMTP id z3mr80490301ljh.43.1565029095550;
 Mon, 05 Aug 2019 11:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190731183116.4791-1-mcroce@redhat.com> <20190805.105800.1380680189003158228.davem@davemloft.net>
In-Reply-To: <20190805.105800.1380680189003158228.davem@davemloft.net>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Mon, 5 Aug 2019 20:17:39 +0200
Message-ID: <CAGnkfhxRV=2G6Sxf_nZQekeXLsf64QkKqfN-9pN_Mi6Y+=nXRA@mail.gmail.com>
Subject: Re: [PATCH net] mvpp2: fix panic on module removal
To:     David Miller <davem@davemloft.net>
Cc:     netdev <netdev@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@free-electrons.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 7:58 PM David Miller <davem@davemloft.net> wrote:
>
> From: Matteo Croce <mcroce@redhat.com>
> Date: Wed, 31 Jul 2019 20:31:16 +0200
>
> > mvpp2 uses a delayed workqueue to gather traffic statistics.
> > On module removal the workqueue can be destroyed before calling
> > cancel_delayed_work_sync() on its works.
> > Fix it by moving the destroy_workqueue() call after mvpp2_port_remove().
>
> Please post a new version with the flush_workqueue() removed.

Hi,

I thought that it was already merged:

https://lore.kernel.org/netdev/20190801121330.30823-1-mcroce@redhat.com/

Let me know if it's ok already.

Regards,
-- 
Matteo Croce
per aspera ad upstream
