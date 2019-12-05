Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64463C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3813821835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575567748;
	bh=mGbUhnKqUDvUyqSud77x9iCr0BtQN5/XTAykCMrnbro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rbMfXY63vKPCLZOC/yk01v0cMjVNsRwqwJbjL+motrXiDLEurxiBg/IXerkJOE50M
	 uaZnJvN6DKOS6l2jq74ybaFvrvm/gerQOPf7MlhSu1NEyKjLVue3uNdLxUy7Mn6eCU
	 8bw5fg4Ed2HpRkOIRnMSamPnOGM7S2JP8t68QqwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbfLERm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:42:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43583 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbfLERm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:42:26 -0500
Received: by mail-lf1-f68.google.com with SMTP id 9so3119395lfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 09:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbUJTjP9F3GwOz1HFUh2s3Qmcb6CiYFw+YJqleMOHnU=;
        b=At+uWZuKrLZ9S7SyRUatFCEd1Mv2OAsl5w3v+FMN3slvSqWktBXK4CWewfKJV7jSv0
         jpx4YsZEPIQAb72cz8O870cYWisRieSJNwsV8ZKkMw0312Czo8jJrbF9lgpKcnqShANR
         4t99ocyvjH84jbC8Y0/H3HnaS1ee2Sr9m+fHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbUJTjP9F3GwOz1HFUh2s3Qmcb6CiYFw+YJqleMOHnU=;
        b=BgKcRPYKK8ByDZT3Ph4Fgfy8azt6Wh8HpOXvhW+TdNxSg8hK1W09g9OPZFhgCFR0tp
         n+J+wqb6RZJXcum88ZEw/D/SVj2QW4BCE56bQPFE5EqOBDEuC6eFvL4vb1RewqFq0p4e
         i4qa9cZfau+Wa0iVjombfru2m9Mq3CE2MxdkhQY7N3Lw9t+TOmBt5rgmGVlZG1Y0DUQa
         4ZkZ9/n0CMMv1/AOVvXLhckegs3iPbj+If4cpQYMw6ZV42epzPaGJpDsWizDNLqvOv12
         LUruKBJqna60nd6bOf/2DtjqDStsgLaR/DdRA9MFx9oZxzINCnPtdMNpMEncETnFHcVZ
         oeJg==
X-Gm-Message-State: APjAAAV46npNMYXapAoG6auuD89DaGuKB/m/mQILyeQU2mY4KUHY9p45
        rIRCssh0aqli9GuBqW3i0anz+1gC+tM=
X-Google-Smtp-Source: APXvYqzUQgx0qBBoU4xA5MYH9S0BIGAlwHokc3ignzP+YKjNS02Qi+se6qeQ8eOWDlDMnqdHjmGxtw==
X-Received: by 2002:a19:c84:: with SMTP id 126mr5917386lfm.5.1575567743590;
        Thu, 05 Dec 2019 09:42:23 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 144sm5421932lfi.67.2019.12.05.09.42.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 09:42:22 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id y5so3136976lfy.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 09:42:22 -0800 (PST)
X-Received: by 2002:ac2:4946:: with SMTP id o6mr5923371lfi.170.1575567742310;
 Thu, 05 Dec 2019 09:42:22 -0800 (PST)
MIME-Version: 1.0
References: <157556649610.20869.8537079649495343567.stgit@warthog.procyon.org.uk>
 <157556650320.20869.10314267987837887098.stgit@warthog.procyon.org.uk>
In-Reply-To: <157556650320.20869.10314267987837887098.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 09:42:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgBLUeMUwfWGfqeihz4K=QhXxEgskOo6aUfTmLa=XMvzQ@mail.gmail.com>
Message-ID: <CAHk-=wgBLUeMUwfWGfqeihz4K=QhXxEgskOo6aUfTmLa=XMvzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pipe: Remove assertion from pipe_poll()
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 9:21 AM David Howells <dhowells@redhat.com> wrote:
>
> An assertion check was added to pipe_poll() to make sure that the ring
> occupancy isn't seen to overflow the ring size.  However, since no locks
> are held when the three values are read, it is possible for F_SETPIPE_SZ to
> intervene and muck up the calculation, thereby causing the oops.
>
> Fix this by simply removing the assertion and accepting that the
> calculation might be approximate.

This is not what the patch actually does.

The patch you sent only adds the wakeup when the pipe size changes.

Please re-generate both patches and re-send.

              Linus
