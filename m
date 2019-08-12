Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E477C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD0420684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvH5lrvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfHLU4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:56:09 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33830 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfHLU4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:56:07 -0400
Received: by mail-ot1-f68.google.com with SMTP id n5so164330710otk.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 13:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yEhYtlqx3isPppAlKvPH5QInxYeigAvCLguvPFMHc8U=;
        b=GvH5lrvIAAKcYun7yRC8SDdua3RI8viU0eBaf+6otOFBpCpzupg3pkPDPUEy/1xrXQ
         OPqAc6S9iobVBwK5a/Afj+iPegbRa257wSViB6S2zob3GV+yqTaTUsRudTC6kOE/dP2d
         rUAqbFjYxnpJHQ+HL/c//eTP1JQ8jj/+sZ8dLP1nGltc0R54UGZNetLNCQFvNYGvAgf6
         QHdoH35fdNjFsTRPNUBHzAz5Wni8BNL0469msCrLu5GMx2oACcBLf2uNZwV/rlxujwWL
         rQcOOp1gZC/2dYVqK2HspIzHHbarzQf1+k1VcCnoWLDbNO7Im/4ofxUWqlENdr6CIVpU
         CXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEhYtlqx3isPppAlKvPH5QInxYeigAvCLguvPFMHc8U=;
        b=B4As0mJdZeZi2uk+nj/lVRwd0AyzXOSdXjKg/k7lEa/if50YdTKDOj2+UtYSxzsN0p
         Y8ZHq39g+jUKHOsfeAoGoGAxx8bTVjgSmsw7nZRQ1hpyXUDEE3GMvZbluzap0v9Ehi97
         xiCNAZkfqehmm9kDND+EQBTrtGFw+NoP1y5V73KgnJG5c8N7eHjift0ClbMN+O87I14p
         ZN1Y5WM6rOS6NQLQKdnjnyUHceq+JaRIbdGfnUwbOMQBBa/DDzhG53sPRIloLfYj1FA7
         jOZCcVWvZBIA53LKO0jTODS9MYze558MW4fkOaIsQN8p8JWY0/I1/AhJa1ipBLHXQoGF
         9cyA==
X-Gm-Message-State: APjAAAUx6xx6Qjz1WlZm1TDdfDLWnsn+Er2hGXlYOhVMkcpxbHpguTs9
        ACqYhzYr5crsGIF5b7FEetFl3D4cKy6sKXH8CgEkuw==
X-Google-Smtp-Source: APXvYqxwVUDUJKPykTlJoJIAe7teD9eBcVqKjT6eveMf2e+O5c92wWdS07aWZ62aimqSth0qIbY0i9WcKyYJFxWO15s=
X-Received: by 2002:a02:cb51:: with SMTP id k17mr4219145jap.4.1565643366183;
 Mon, 12 Aug 2019 13:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190808005255.106299-1-egranata@chromium.org> <20190810081540.GA30426@infradead.org>
In-Reply-To: <20190810081540.GA30426@infradead.org>
From:   Enrico Granata <egranata@google.com>
Date:   Mon, 12 Aug 2019 13:55:55 -0700
Message-ID: <CAPR809tiAhWqrNz0E5KrFtn-QrMTKv7vQtYq=_mrOH0VWfi0Eg@mail.gmail.com>
Subject: Re: [PATCH] vhost: do not reference a file that does not exist
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Enrico Granata <egranata@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fair enough, yeah.

I think what I found confusing was that the file had a precise
(directly actionable in a file browser, if you will) path. If it was
just listed as a filename, or a project name, it might have been more
obvious that one shouldn't expect to find it within the kernel tree
and just go look it up in your favorite search engine.

The right incantation to get your hands on that file is a web search,
not a local file navigation, and to my perception a full and seemingly
valid path pointed in the direction of doing the wrong thing.

It's not a huge deal, obviously, and it may be that I was the only one
confused by that. If so, feel free to disregard the patch.

Thanks,
- Enrico

Thanks,
- Enrico


On Sat, Aug 10, 2019 at 1:15 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Aug 07, 2019 at 05:52:55PM -0700, egranata@chromium.org wrote:
> > From: Enrico Granata <egranata@google.com>
> >
> > lguest was removed from the mainline kernel in late 2017.
> >
> > Signed-off-by: Enrico Granata <egranata@google.com>
>
> But this particular file even has an override in the script looking
> for dead references, which together with the content of the overal
> contents makes me thing the dangling reference is somewhat intentional.
