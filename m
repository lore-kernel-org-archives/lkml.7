Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D039BC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 15:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAEC20838
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 15:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfGMPfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 11:35:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:47048 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfGMPfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 11:35:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so11327848qtn.13;
        Sat, 13 Jul 2019 08:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/SFjgyvYpOtxlwc4ojENp06eD74+gSpEUYF2scggOfQ=;
        b=BJKSuFuGQ1P4mDDRmhGmwHJszPzDGjdPANVTjmuVU6GxOJtwxtIviN6APNfDEqPVgu
         z6gtwIiJE4fXvYcRTqx9slPn2jk7d++MudklG/RxjKSIMExLK6oB+mCp+3cBYtr/wwRT
         wmr+IImr/NXnW95JFjhq8d98P75qO+JWkWNxlGlbzoBoUccte1EbimmVXofhZSqAMvF9
         yxYOxAy1ASMEZybaj/wpjr5WWVI8vhxktrw30nhTrF5l+7eX846Oi9Pc2FerayHMmVlO
         iNtZSY39U8Y3ytryY2ayFYDkFChTcsU+MeFOKeJsf4wtfRX8D2+9JZrvEBcpYtjfbRRm
         FRZw==
X-Gm-Message-State: APjAAAW+hJjsnUpu3pKueFjGex6frdJHFsfG6CDPFDntHdiaz0VexBnJ
        Ml6UnN5AGLoCnRV9IrqosJrbJs3TkpiHio/iykmfLw/g
X-Google-Smtp-Source: APXvYqyNL8VCWHu8hXjLdxyE0zt8XE/YBBnFh1YunfEwAEzy31sAhDj5qQ+vzJ5+HLnT5CPEKwJW9Rqccob0hz144sM=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr10880166qtd.18.1563032146072;
 Sat, 13 Jul 2019 08:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190712090700.317887-1-arnd@arndb.de> <20190712.153632.1007215196498198399.davem@davemloft.net>
 <82ccdd83d2a18912bb8cf75585e751c0bd39a215.camel@perches.com>
In-Reply-To: <82ccdd83d2a18912bb8cf75585e751c0bd39a215.camel@perches.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 13 Jul 2019 17:35:29 +0200
Message-ID: <CAK8P3a1eGXyZdXrkyhkXzvHt38J1wOzywU-+uxqnAYOnRVJtcA@mail.gmail.com>
Subject: Re: [PATCH] [net-next] cxgb4: reduce kernel stack usage in cudbg_collect_mem_region()
To:     Joe Perches <joe@perches.com>
Cc:     David Miller <davem@davemloft.net>, vishal@chelsio.com,
        rahul.lakkireddy@chelsio.com, ganeshgr@chelsio.com,
        Alexios Zavras <alexios.zavras@intel.com>, arjun@chelsio.com,
        surendra@chelsio.com, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 2:14 AM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-07-12 at 15:36 -0700, David Miller wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > Date: Fri, 12 Jul 2019 11:06:33 +0200
> >
> > > The cudbg_collect_mem_region() and cudbg_read_fw_mem() both use several
> > > hundred kilobytes of kernel stack space.
>
> Several hundred 'kilo' bytes?
> I hope not.

Right, my mistake.

       Arnd
