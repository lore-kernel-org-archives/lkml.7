Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5B9C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A649214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="u33Z/Pwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfDHPIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:08:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43319 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfDHPIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:08:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id u15so12304478otq.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=veq/eP11WMmbDZ0kmCDZHYcOSV6UdVblrwR8OkjSNS8=;
        b=u33Z/PwmObw3LQvFXvuHfrzogiLKBN8Hrx8IKUNBS/fU+w3zAYRK9FVd9oLt7bnTic
         GiOrSOhUoEItOlPU2mOdAkDVJzigSiSIVoBU+UrLA1eEZ+SCk8KwjAQ0Sl5oNq2aDXah
         R8Y4qrp+qMtUSNdVbQcxud3krDerVGV3agwe1u0fxMF1Uzw0aYz+lbo8ImPwN7KbnW8m
         1kJbrvELHzHbxgWx0PvuB2oYC2EMU0IJW5avLnAqwfMZC4cL4UXy3HyxaG5NrN4PP4Iz
         6chvgv+s7M+S4jObUNl9DnZRKgbxv9BhEaLHH57Q0SVJ6ltKpcdT7UwxqbzkTR78nGdu
         GgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=veq/eP11WMmbDZ0kmCDZHYcOSV6UdVblrwR8OkjSNS8=;
        b=qzTPdkv4NobbmHpM+qKHbgnk96ZbnJXM5dZN0p4xJwYQ1VXY0crWW2u4ZqSRoNXgB2
         crbIO8fBmSYm7aidECyXqvZpTUs1orsiX1jMUkI+OCJURpvEwdIzFO9vmx82UNCiaINW
         FQB+F0v8LYRLJyrQ5R+Xu5NCx5jYpmaf8k224Xco9o5DNw6X4WjViFni8mawBt2Oshov
         AoHYfTM+7tYjAharkI2jsk/akAc8pMPWLCj71NtsqPkVtTpOAKJEftJMivB1S80VKz5N
         +z0idD/2h8QCq57APq507oY+JnzzVe3VDDjiWvyEQ9HBVJGPCNdcjkUauZxb4PQ4ByuA
         e11A==
X-Gm-Message-State: APjAAAVFsREt2JRP9Koh2urK1vtSeT2xp/RXF4LIXDRVCiyFBJSCaA03
        C6NwZrsrNLyQP19frl1qGH3e35+4W0A/OUhgiiBNSkyk
X-Google-Smtp-Source: APXvYqySxW+8aLri/rfgRiqJ5QjHTkkxGclErNaf15TSyfkd09pTwVRxiSfkTqOrkTpVwAhuiNN25f3Is+clG6biWYY=
X-Received: by 2002:a9d:5c86:: with SMTP id a6mr19265394oti.118.1554736114859;
 Mon, 08 Apr 2019 08:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190408155257.7b82b64f@canb.auug.org.au>
In-Reply-To: <20190408155257.7b82b64f@canb.auug.org.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 8 Apr 2019 08:08:23 -0700
Message-ID: <CAPcyv4g0WsHf460jJZHyS6k=YvUU4WVfXZq3cJc5b_NUVoHqQg@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the nvdimm-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li RongQing <lirongqing@baidu.com>,
        Liang ZhiCheng <liangzhicheng@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 10:53 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Dan,
>
> In commit
>
>   7c33bd4e3e97 ("libnvdimm/pmem: fix a possible OOB access when read and write pmem")
>
> Fixes tag
>
>   Fixes: 98cc093cba1e "(block, THP: make block_device_operations.rw_page support THP)"
>
> has these problem(s):
>
>   - Subject does not match target commit subject
>     Just use
>         git log -1 --format='Fixes: %h ("%s")'

Thanks for the heads up Stephen, will get this fixed.
