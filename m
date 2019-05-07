Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6EBC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA97920C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfEGJXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:23:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53644 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfEGJXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:23:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id 198so1623040wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 02:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GWMFFy2F73uQioGzc/atPqbskzKfI+KjLLT2AD39XqM=;
        b=OX5vvZ87LB8cDTHYamz6ligqfmQhsZ90tAaUfhW/IEsC6KHMHK+E9vGdNRRy6BOkyX
         6+cj0giqIw4AHdBAi8vmxMODUJn8lXbsDTJIH/fbvp54BZTW7/eJVi8hBs2V2a+/dRgz
         P4AZcCq8siWWa1i1ZdA0WHsf86YolUA/v7aAUzexizy/0jj+PSLWAog22NrW0arYjkmv
         kq83vOOTR/Ni78BW71QcFHgrj8o/uLFJZcXwHiHC/ena89R4f6NGoe5b5mOJdN3cflqT
         2U9wPrMk67OSqdM6fU70ReShJTHFD+EqYPj2V2+Im6rhBoBLG/ppiYktnrAuaSEMarHA
         MqZQ==
X-Gm-Message-State: APjAAAX4xe4fon1ydvgy6fwbyXBTZVA7zrRrnWyfAg9qAqUutqE9g6eS
        zIXPXC8DmtyXqyPCtlnGg35JsA==
X-Google-Smtp-Source: APXvYqznSrFaB6uyOHVbt0B0t1ukse7n+r+sBjTzNFN1gJDrpzuanPf8ms1kehTEDJTT1MzX9RHvpg==
X-Received: by 2002:a1c:4c09:: with SMTP id z9mr19795673wmf.87.1557220987708;
        Tue, 07 May 2019 02:23:07 -0700 (PDT)
Received: from linux.home (2a01cb05850ddf00045dd60e6368f84b.ipv6.abo.wanadoo.fr. [2a01:cb05:850d:df00:45d:d60e:6368:f84b])
        by smtp.gmail.com with ESMTPSA id s3sm26161021wre.97.2019.05.07.02.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 02:23:07 -0700 (PDT)
Date:   Tue, 7 May 2019 11:23:05 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, g.nault@alphalink.fr, jian.w.wen@oracle.com,
        edumazet@google.com, kafai@fb.com, xiyou.wangcong@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] l2tp: Fix possible NULL pointer dereference
Message-ID: <20190507092304.GA12570@linux.home>
References: <20190506144404.25220-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506144404.25220-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 10:44:04PM +0800, YueHaibing wrote:
> If alloc_workqueue fails in l2tp_init, l2tp_net_ops
> is unregistered on failure path. Then l2tp_exit_net
> is called which will flush NULL workqueue, this patch
> add a NULL check to fix it.
> 
Thanks!

Acked-by: Guillaume Nault <gnault@redhat.com>
