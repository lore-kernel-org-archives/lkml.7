Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D752CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D4B217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EiSExjjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfDEHqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:46:51 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39327 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfDEHqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:46:51 -0400
Received: by mail-yw1-f66.google.com with SMTP id z9so1982317ywd.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 00:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+gd4faDAtq/OW4Rmwo1J0jG1l1BL+UhKsEyr7fipbk=;
        b=EiSExjjd1MCNvFUIdMch5YBNiGWeYUo37xiNXJUS9i7HzMucN+OiMBek89bsavX7ql
         Lyx5nLzQJTU1VLDGBs/DY2LASExSwEQUfyvwPqWfwSAQz4kuZN9p9geI7LXjE/o7+D64
         rIC/cEP04sX689IE5TPwIsYlwc3VVRZ7BxKoX8qJSEoucjhwxSAFIt23JJFJHpcjEe05
         zqeZ1pZrmJrZ64xZ0MePsxJ4JX4HRVHEynQBzjV29GVPfRPM2pl78R/jNvVcN9kmMRku
         qmVWA5HFVGfwyoJtRezdilRyL9PYtxsKBsvHE8xMHuzE5vBGN+VWIXmKIYRqBlLoQzB/
         7iKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+gd4faDAtq/OW4Rmwo1J0jG1l1BL+UhKsEyr7fipbk=;
        b=TlUgy9ILVsAxmfLtC9tygQgdX7KTylmgjuyFNF6dzftaTIpUfokXDjS8Sh6z5eezAM
         MtvQ6zF+k9BBUv+55VQ0ZBHn5evCFhS1JwMFOr67wOThY/UXuUt8gWAtJp50DVJ0H6WO
         WiSdFvieB99OXzFwFJj7lil7kkMjfIlGfh+m3y0dwdICjtbn4mU+5K+rVX7mgg3iR6Bn
         lTBWpyiVcGwSUXc+aOfXHVDjA8z6gs5JLlyDUPeohJa7JvgUQwmuOUch8m0hKsnPr927
         xxt5ZNli4z/WTW2MTANTGlDSDPUib7/y2uVUEaQmMDUpZ62fBuvg3P/sZuh5pexD8578
         zPrw==
X-Gm-Message-State: APjAAAU9LvqzsL5pavLFoHV8c7jNMfLFPhXHyLYR/A6VclmArOwwT7Wx
        pVU+//FJgEfrafQB7jOURgeTV4v23e6r6jj3nhCasGDerJ9BQw==
X-Google-Smtp-Source: APXvYqz3VqqgU/EjWNlgQQ6kMGe+m1gjI6z81wC8M8WvnsrIILFHrfEGQDwnN+S2ylPwC3NMwGfymTPl9w+KnNzLJB0=
X-Received: by 2002:a81:9249:: with SMTP id j70mr8883187ywg.371.1554450410273;
 Fri, 05 Apr 2019 00:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190404144603.27682-1-colin.king@canonical.com>
In-Reply-To: <20190404144603.27682-1-colin.king@canonical.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 5 Apr 2019 00:46:39 -0700
Message-ID: <CANn89iLsp+Nii7Y-ppBnLbinR7e=vVJ6QsMjBVLjcAKs9zQaRA@mail.gmail.com>
Subject: Re: [PATCH] tcp: remove redundant check on tskb
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 7:46 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The non-null check on tskb is always false because it is in an else
> path of a check on tskb and hence tskb is null in this code block.
> This is check is therefore redundant and can be removed as well
> as the label coalesc.
>...

> Addresses-Coverity: ("Logically dead code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

SGTM, thanks.

Signed-off-by: Eric Dumazet <edumazet@google.com>
