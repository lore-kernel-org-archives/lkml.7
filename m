Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8543C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC79222E9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJVXOLwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbfDSSPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:15:38 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36990 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfDSSPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:15:38 -0400
Received: by mail-yw1-f67.google.com with SMTP id w66so2154601ywd.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDnN7xYuu1VBUKudqASvz1g5pzbRI3PK9c75wOnApTA=;
        b=pJVXOLwcTV3RzVu+pObedJ4qJe4aSqH4L5NasYqdFiKvUju/IlqJGydPqDSfG4mEgt
         kxSWWyZmkEBlsQMDJ9o2e4/W+/eX7kZMc/PEDRYcRmtxXi4aBv9t+L8xSjUwNN6uaJb2
         a+LClMsVxinVCy+b2wjeoa25rxIbQkXz8g63XRhsysxfXp2SZT+9aJDHrVo/zwSzjc3h
         8GafA6Quf0aOhA7cf5bi+Yg3PpbeUBY5uPExenR8gRPV1pvCHJCQCKTqOvk89nHuCmto
         sBa5yKwwQtkUMxyzNRluyvq3R3HEfYr5vXdU6OwaQAvpA9GwEBqxfY6fITzx2X1eaBZr
         2mVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDnN7xYuu1VBUKudqASvz1g5pzbRI3PK9c75wOnApTA=;
        b=YZQlDaNp/UgVrAQVbmq0rKKnXYU/xiB55A5KDzPJRZOSNoRh2WUb1LMGxDNLu/vhLi
         M3HrJ4sCCzqmVf6+PhMK1wqdp2ye6FkHdxTWNnN7kO5qMJUkjkuoC0zjRTm4oXuhAGBp
         UZvYjfQvIpM2jWVGj6pAb8OdMfAovlOSX44/G6TcUQsJEaZXGiwHebxvmbTdWF3X13XE
         KBoIEiQsOz5Lhw8crwHk792dId0ZRM35p/vmIkVbLszTE3hjdZcCia8L5SglLDlOe4w/
         B1QK/IcW9BkK2DuyB+PbktvMidvJlGI+VExEPEFuTKryysRCO0RrFPsZKoh6OsV+pwkG
         tWPQ==
X-Gm-Message-State: APjAAAUTW9sAtEyrHDuRi9YwG9bL/wUyvUVcVvD+pA36od8duxeyD4Sq
        7pcKSnyKpZvvNa0THprFI9IW1mRyD5IS9s8MODTiVg==
X-Google-Smtp-Source: APXvYqx0NiOYxBuijiFYCW1J/mRblpnrmj7EDisrwNEpLer18ohGoXxAnW8/wjUnx72ZR97hIZeZ5Xt7E/OcPauBD+A=
X-Received: by 2002:a0d:f346:: with SMTP id c67mr3714898ywf.37.1555691283825;
 Fri, 19 Apr 2019 09:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190418180524.23489-1-aryabinin@virtuozzo.com>
 <791f4f23-d931-4ac8-4e60-3ffe46c4ece2@gmail.com> <c2c270d9-29c0-b993-84c5-4c994608f7c8@virtuozzo.com>
 <a80606cf-3076-b01d-0442-ccff3c462276@gmail.com> <6651d0b9-4ddf-ef6d-6f53-e1290b7aeeee@virtuozzo.com>
In-Reply-To: <6651d0b9-4ddf-ef6d-6f53-e1290b7aeeee@virtuozzo.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 19 Apr 2019 09:27:52 -0700
Message-ID: <CANn89iLSnEtCiqQbPkQXLwkvebd_PPCLJsH2tbwp7Py99FS2UA@mail.gmail.com>
Subject: Re: [PATCH 1/4] net/skbuff: don't waste memory reserves
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Willem de Bruijn <willemb@google.com>,
        Florian Westphal <fw@strlen.de>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 9:24 AM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
>
> But why that failed allocation is such a problem?
>
> 1. sk_memalloc_socks() false
> 2. NIC driver tries to allocate pages and fails

The NIC then is unable to receive any frames.

We need to be able to populate the RX ring buffer, before NIC can
actually be started.

Basically you are saying : We need to allocate memory only _after_
frame has been received by the NIC.
I am saying : We need to allocate memory so that the NIC can put a
future frame in it.
