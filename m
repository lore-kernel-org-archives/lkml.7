Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E48DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB3020828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390539AbfIESv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:51:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388700AbfIESvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:51:53 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6E972A09AB
        for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2019 18:51:52 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id 124so2107512wmz.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 11:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+X/R0y41DuJD8stDaaFF/mk4jlVxfRDTjRBOtakznc=;
        b=ovfOlj/Y9rrqv86QUtJMWqeJl0m9/ZpDm8tLrd2bckA40FRqlN+bMlI4uUO6l4vSvR
         xvLjBkawVSa0FkiodjP4zJcix6yQ4a5NPGjHpYLNZAZqm88bQ1ojH8V5nXQypE5WukJ6
         1jy0XV+VQBySeyzpbjGk67GTjhcc65EsqsUyACK6vVO1mG68QJmYao5PUQ3NJQqfrHdE
         vjs/z7a/0OgiXV31A9D6z2JT990BEr0FBp7KjLSD3lYA/AkIIpKlSa06D2CauvCY+5m5
         aeOYW3abKEhY3w4zxwwOcNrKIH6vAKMj7bjRoEQflD3pfKsNZS2LJnl97vaP9P/Bl8CO
         MxNg==
X-Gm-Message-State: APjAAAWQwZ3VHXaQzZEkcqGrQsnci0eyf/53U2KeW+tmLjQPWJJDbIBY
        qBB226ZiDD6lECIFY7+8UlhnDxB00s4S8rlccHXE+rUy42abklkJMeGSIWkaghl5SzA8cnpEkNb
        Gcs348bbSGLG/y0hMtfVSUcEm1l0dpyXGzP6SrCYk
X-Received: by 2002:a05:600c:21d1:: with SMTP id x17mr3763562wmj.123.1567709511264;
        Thu, 05 Sep 2019 11:51:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxxppOJbXRzr0HT1qBIm7hjC+zxuRCss37FvJwDjsHuKSxoe+byuVe16izziNYRTPD8dFxdzcLlPcTR/VI7zzA=
X-Received: by 2002:a05:600c:21d1:: with SMTP id x17mr3763540wmj.123.1567709510985;
 Thu, 05 Sep 2019 11:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
 <11667f69-fbb5-28d2-3c31-7f865f2b93e5@redhat.com>
In-Reply-To: <11667f69-fbb5-28d2-3c31-7f865f2b93e5@redhat.com>
From:   Ray Strode <rstrode@redhat.com>
Date:   Thu, 5 Sep 2019 14:51:14 -0400
Message-ID: <CAKCoTu7ms4ckwDA_-onuJg+famnMzGZE9gGUcqqMz0kCAAECRg@mail.gmail.com>
Subject: Re: Why add the general notification queue and its sources
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        David Lehman <dlehman@redhat.com>, Ian Kent <ikent@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 5, 2019 at 2:37 PM Steven Whitehouse <swhiteho@redhat.com> wrote:
> The original reason for the mount notification mechanism was so that we
> are able to provide information to GUIs and similar filesystem and
> storage management tools, matching the state of the filesystem with the
> state of the underlying devices. This is part of a larger project
> entitled "Project Springfield" to try and provide better management
> tools for storage and filesystems. I've copied David Lehman in, since he
> can provide a wider view on this topic.
So one problem that I've heard discussed before is what happens in a thinp
setup when the disk space is overallocated and gets used up. IIRC, the
volumes just sort of eat themselves?

Getting proper notification of looming catastrophic failure to the
workstation user
before it's too late would be useful, indeed.

I don't know if this new mechanism dhowells has development can help with that,
and/or if solving that problem is part of the Project Springfield
initiative or not. Do you
know off hand?

--Ray
