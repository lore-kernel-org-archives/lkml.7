Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA2FC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFFB213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553011485;
	bh=58aO4WASlwepUd9usUNRB4/GTJqqmkWnqpcy7gLsJfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Jvo+YPTJtB5uzBmTqMhPFB3XMFUi89TcEIvoV1cC51DYzuG9cX7h3xb/VC20/7lL5
	 nO2r3t9oixo68kSaFpMigth7ZogK6upV00ChhsXZgd23zhhFawf04aEqux/qajqv9D
	 qmCSCZYrUldcCUkfhtAupHjuQY+ja6pdgOnmg3G4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfCSQEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfCSQEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:04:44 -0400
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93F602085A;
        Tue, 19 Mar 2019 16:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553011483;
        bh=58aO4WASlwepUd9usUNRB4/GTJqqmkWnqpcy7gLsJfE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fqeLhSixIV0EiTIrw/Sui6Kv+E8Bk2kUqHODentmu++/3+tosLQVEHraROmGJvIXN
         /NZNX/AMTFozhjiON7fl77Eq15zceYp789ifKccqHbOr5fE86DYvzsi0iQlDoDMGUJ
         4BqSXnWOhJIWVYJm4Ub0UmsQIZ8VzcM/B3q2NW3s=
Received: by mail-vk1-f175.google.com with SMTP id j195so4739256vkj.9;
        Tue, 19 Mar 2019 09:04:43 -0700 (PDT)
X-Gm-Message-State: APjAAAVYNup9SiR3BRJMIQAn/ce7QJ2LeCV/11nnCb/2M3nfJbzQtsdP
        /fm/T7oAx7cnKtm27XreCakKWUjcoCuyEj/vm+Y=
X-Google-Smtp-Source: APXvYqyARE8zU7V0s6M8u8my7OKeq0SbfqYNdwr/GvxA9tCaYO0KuZyDDp4r1khqIHM3Um2m9Qao6nP65nGDmgOOrxw=
X-Received: by 2002:a1f:37cd:: with SMTP id e196mr1657204vka.36.1553011038250;
 Tue, 19 Mar 2019 08:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <53be40fc-6ec4-c714-a64e-f69c96f7058f@redhat.com>
 <0ffd0eea-ca64-0128-2835-a9856b224e07@sandeen.net> <20190319153005.GA1146@42.do-not-panic.com>
In-Reply-To: <20190319153005.GA1146@42.do-not-panic.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Tue, 19 Mar 2019 09:57:06 -0600
X-Gmail-Original-Message-ID: <CAB=NE6Xt3vkCqpODo1j8hnWLgig8Ot6d3F3OS6AysZ52mHyFsw@mail.gmail.com>
Message-ID: <CAB=NE6Xt3vkCqpODo1j8hnWLgig8Ot6d3F3OS6AysZ52mHyFsw@mail.gmail.com>
Subject: Re: [PATCH] sysctl: Fix proc_do_large_bitmap for large input buffers
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 9:30 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> can you send
> me your respective lib/test_sysctl.c changes? I don't see that they had
> been sent.

Never mind, I see it now, will roll all this in.

 Luis
