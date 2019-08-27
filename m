Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957EEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663B32184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4V7AIOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfH0Gec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 02:34:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43412 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfH0Gec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 02:34:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id q27so4618235lfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 23:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=woMVWkO9N6OT+1wNpvLDhrI+4gOoEkBxINhlAwTjVgY=;
        b=G4V7AIOrXki/MR83mgS7/vhnAxuOkNK7tsBKMt1NW6cCkgqpM4R8d9xC4iwkAMKiWd
         LupUWwErlZt4gN+zA6J9pxAHDpS3bwnR7tKZOB/PQ7sp3tCSFEhOyHe67Jx7qy4C7h2f
         KRB9EN4z3eor2gPcv53aQ8W+11PixefFeSDA+rQ1JLxOEFFsN1pTeEU8Ybt0O1V6ETiu
         hpXBKpaaxe8Xpz/qkqnJPUHmyQzxPxMGU73lDiNGFSjmZxGkCjuxkR3wPsmtOMK3uEeC
         fKSSJUzLjax8k+oCvFNuPq5EUWubGEAIjUs89Nv4DgYyI5h+P1dKGZXyXWhLE8KTVMpX
         efGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=woMVWkO9N6OT+1wNpvLDhrI+4gOoEkBxINhlAwTjVgY=;
        b=WwUpxhiFPTAAp3CYo9zmrqwBvJPza0kyyhwkbbibAXCM+wl/9VaqZxVNUORo6DtzOV
         RK5S1gihSZe4S8joCBW8FMbgitGoyVAN02HCmWS1E6Olnziso4Bsy8fwaD+5bohf9FFS
         Us7yP3fLIBvKgzdIpuQKJMEUbNsSoOzhBI4aXGZwZ5XRGE4p2KUl8DxkQ3ASONJuTJ8R
         YhmFJY98sXVvyC8nQfrpwS1IOxCs93df6CBY5fSxX57UTS+yCmivBBNKRUiDzt0+H3Yq
         H92VzfNOxTp7Lp4Bvlp/R6AFZBAmV52VRwKHXj7MQVMc2PaA/vCjUUr0tjhq/TLGsbsm
         Xt7A==
X-Gm-Message-State: APjAAAWruVhvzMGzbzHDmzaj80hqE4/9ozFFTmJAcDSS+GmlZu36GaeU
        dq+wGUwpCPdiiwba6Zq9BxoqXz5SylsJ3/sgFqnRFA==
X-Google-Smtp-Source: APXvYqwtKMfXhng/fHj5e3j0vDEcN/gvDNAvxUrvbkGaP71Rckkcpm2TGpsDunvFIDoF+3rhd497aAMEnFMQ3svRqjQ=
X-Received: by 2002:a19:750b:: with SMTP id y11mr12265790lfe.99.1566887670119;
 Mon, 26 Aug 2019 23:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtN2tjHZtjtc8isdsD5hF76teeh2-pngUp+uj3WYdj7jA@mail.gmail.com>
 <20190826104127.GA14729@haruka> <1264279239.8133737.1566817520787.JavaMail.zimbra@redhat.com>
 <CA+G9fYsHpNKFHr=ZukVvj+uMJDyHj2Xwb9bCfzPQyYzMjZ0rCw@mail.gmail.com>
 <203971593.8175020.1566830285708.JavaMail.zimbra@redhat.com>
 <fcd20866bb836d45b1e384dd68080c671bcde938.camel@hammerspace.com> <2039173876.8300255.1566861172742.JavaMail.zimbra@redhat.com>
In-Reply-To: <2039173876.8300255.1566861172742.JavaMail.zimbra@redhat.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 27 Aug 2019 12:04:17 +0530
Message-ID: <CA+G9fYvKbU5St+D=awgQS--SSO-_AteEpfMJ69COq-eOTHa2NA@mail.gmail.com>
Subject: Re: Linux-next-20190823: x86_64/i386: prot_hsymlinks.c:325: Failed to
 run cmd: useradd hsym
To:     Jan Stancek <jstancek@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        the hoang0709 <the_hoang0709@yahoo.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ltp@lists.linux.it, open list <linux-kernel@vger.kernel.org>,
        chrubis <chrubis@suse.cz>,
        alexey kodanev <alexey.kodanev@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 at 04:42, Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
> > On Mon, 2019-08-26 at 10:38 -0400, Jan Stancek wrote:
>
> No change with that patch,

Same for me.

> but following one fixes it for me:

Works for me.
Thanks for the fix patch.

>
> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index 20b3717cd7ca..56cefa0ab804 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c
> @@ -590,7 +590,7 @@ static void nfs_pgio_rpcsetup(struct nfs_pgio_header *hdr,
>         }
>
>         hdr->res.fattr   = &hdr->fattr;
> -       hdr->res.count   = 0;
> +       hdr->res.count   = count;
>         hdr->res.eof     = 0;
>         hdr->res.verf    = &hdr->verf;
>         nfs_fattr_init(&hdr->fattr);
>
> which is functionally revert of "NFS: Fix initialisation of I/O result struct in nfs_pgio_rpcsetup".
>
> This hunk caught my eye, could res.eof == 0 explain those I/O errors?
>                 /* Emulate the eof flag, which isn't normally needed in NFSv2
>                  * as it is guaranteed to always return the file attributes
>                  */
>                 if (hdr->args.offset + hdr->res.count >= hdr->res.fattr->size)
>                         hdr->res.eof = 1;


- Naresh
