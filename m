Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA86C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D71F216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 22:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHfwU3zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbfHTWjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 18:39:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36972 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730689AbfHTWjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 18:39:46 -0400
Received: by mail-io1-f68.google.com with SMTP id q22so700535iog.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 15:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MT+ivku//XHW9CQIQxnjOGps60BwXIMdgpVq4LcGGRo=;
        b=vHfwU3zqmy+0qJUig/HZgM51qpUxdBAYAwamUtIQ+OFUVNDNBoWKEiq12IjW0hyxDW
         VD3JP4v2raa071gQz1iVmWqbjttAJ1EmhD56cXwtlEytaa8uksUqp5gCeHV9YlmJkPNw
         8RtQfRTSbZ5CthQWbacG/2bI4OLBKdnfFt0C1wR0Z0PM8xwP7HNWcpWPnQR7iXhdJIEH
         jbHUcg0OfkZ+o3SZb/1pJ1HFk/zvzbOdBTKFOo+vHwZe8YC1YjDvAWEi3LcyVFSFkwgz
         smOeT/rUwr2UKUd9pTj/U0+82ZLCJNvBCmogxY2wIg5b5UwV7f3wn5SvcsHc0doSwVus
         FabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MT+ivku//XHW9CQIQxnjOGps60BwXIMdgpVq4LcGGRo=;
        b=Akn5jd9qolTFQfD8Raou8H+8ZZC8REBut7y4zFlDR0ZZ6S1EX62xKSiGEwzgj+V7jF
         Wq+uh3XkegWWmMKT0pYmSHc+v3hzsJTeLNjznfwcRVZ91xKes/5kItyL8K7tiC/2xdh7
         Nx7ze88Gk6d6te0iZbFLmL9lPrOdwxOF2Yv43j3arylN1FHYxbdaDliLj9J5b4VvzH69
         3Nn/sCeGbSFs+0nEwgRm5dXfFPm4c/u26MBLOezM/SklShqmIsb0z9JfqsKUlsSmqu18
         uF4GO9Zfsv0EHnC02L+2uOYppvdw2dlpDhPyukdN0HvHqbk9ZjBo/sTc1TlKvCZDV/6A
         SbNw==
X-Gm-Message-State: APjAAAXPqk2//1HgqqzacIMzVd3SW03aseLT/Mj9ULv2Vi5HX0IPEkRl
        YulgMg6XqMfIwmXOYu0ZDBe4bKs+JObucvwga142pw==
X-Google-Smtp-Source: APXvYqzTp1KjLOqOkcr9JA80dhLVWKU/MMyi+QIgRT2TB1zTzY9il078ETGnH8HnwJIuJoSljRbgv4+1nanX149FHE4=
X-Received: by 2002:a5d:97d8:: with SMTP id k24mr11314289ios.84.1566340785548;
 Tue, 20 Aug 2019 15:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190821083227.794a0a83@canb.auug.org.au>
In-Reply-To: <20190821083227.794a0a83@canb.auug.org.au>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 20 Aug 2019 15:39:33 -0700
Message-ID: <CACdnJuvCQBX7JaajT5upiY-sNrUfS+pmmSqJF-g_mog96A8h1Q@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the security tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     James Morris <jmorris@namei.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 3:32 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   9d1f8be5cf42 ("bpf: Restrict bpf when kernel lockdown is in confidentiality mode")
>
> is missing a Signed-off-by from its author.

I'm providing this under category (c) of the DCO.
