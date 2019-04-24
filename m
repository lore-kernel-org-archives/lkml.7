Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87282C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5807021773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HolPvSPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfDXKst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:48:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38259 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfDXKss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:48:48 -0400
Received: by mail-it1-f194.google.com with SMTP id q19so5393349itk.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/RmtPqUFWsBAvuBo3FUv0MSPV82C2xBBc4X67jiyXw=;
        b=HolPvSPEUTfrdjPhSINOjKvLflcaXPi/GzsKlKr+6VUWMIC2XSfh2YtB/7MXyWQoPt
         Y0EYJi9J4oo6Pmqm9VBIiASuhBlh4BHOa7cYbApICwwD0d5L9RJ2rpyQp7B7qevpH1p+
         uT4dayTDutnNSjLmZqWSVxo+XCwopB2r1lNPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/RmtPqUFWsBAvuBo3FUv0MSPV82C2xBBc4X67jiyXw=;
        b=I3BN6Ws4pYiFQj861XX5u7+3BUHVdYDDJHQ1+meG+vS1LeBgfl2jsJhKtqYhaY5QiY
         J/dlc9i6HcFMmaSbQjThdNuH302B09VJggGdhUe/aH3Pc3ZxCnZpYYPKJpxvr9oo6Cof
         gMhLD4yCgJF6Q9B49bL2yDQc3oPy00+MiNYWC0BijdGbx+BNp1RYDix+6gWEQBLtr4VN
         d7F1brCKBrw2ylOXx+zkohT5ut0BbgXkYlCubkhApPemL9kyRJpQXuPwYJrJfTkJYxNm
         zenLP01ulVlmFzC0G/g1riaFIcK8QWw+Z+8/QJSCcUosJzd7Ydrbwv+aqxj1fv4SKtY1
         Sdmg==
X-Gm-Message-State: APjAAAWz05UAULZeXfQSuNlXtaycp7q4agasHkgA2zIz2n9hgu3YUed4
        EACEKTB77MctbIA5TEmDFjZ21nwZC/IPa/NfPzMz2w==
X-Google-Smtp-Source: APXvYqxFWE+Aig7lRZOH3TPXBuf0M35Jzu3BA8swAiEWeCJvTONQvR1PVJHf8+yyYp3fn6wgrBFfhAIRx9u1jYhRVJc=
X-Received: by 2002:a24:1312:: with SMTP id 18mr5458911itz.121.1556102927958;
 Wed, 24 Apr 2019 03:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553680185.git.kirr@nexedi.com> <d74b17b9d33c3dcc7a1f2fa2914fb3c4e7cda127.1553680185.git.kirr@nexedi.com>
In-Reply-To: <d74b17b9d33c3dcc7a1f2fa2914fb3c4e7cda127.1553680185.git.kirr@nexedi.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Apr 2019 12:48:36 +0200
Message-ID: <CAJfpegurLOLoNd9p2avcXPhSvP+ux8V+A=ghBySSpn0pX_Afpg@mail.gmail.com>
Subject: Re: [RESEND4, PATCH 2/2] fuse: require /dev/fuse reads to have enough
 buffer capacity as negotiated
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 11:44 AM Kirill Smelkov <kirr@nexedi.com> wrote:
>
> A FUSE filesystem server queues /dev/fuse sys_read calls to get
> filesystem requests to handle. It does not know in advance what would be
> that request as it can be anything that client issues - LOOKUP, READ,
> WRITE, ... Many requests are short and retrieve data from the
> filesystem. However WRITE and NOTIFY_REPLY write data into filesystem.
>
> Before getting into operation phase, FUSE filesystem server and kernel
> client negotiate what should be the maximum write size the client will
> ever issue. After negotiation the contract in between server/client is
> that the filesystem server then should queue /dev/fuse sys_read calls with
> enough buffer capacity to receive any client request - WRITE in
> particular, while FUSE client should not, in particular, send WRITE
> requests with > negotiated max_write payload. FUSE client in kernel and
> libfuse historically reserve 4K for request header. This way the
> contract is that filesystem server should queue sys_reads with
> 4K+max_write buffer.
>
> If the filesystem server does not follow this contract, what can happen
> is that fuse_dev_do_read will see that request size is > buffer size,
> and then it will return EIO to client who issued the request but won't
> indicate in any way that there is a problem to filesystem server.
> This can be hard to diagnose because for some requests, e.g. for
> NOTIFY_REPLY which mimics WRITE, there is no client thread that is
> waiting for request completion and that EIO goes nowhere, while on
> filesystem server side things look like the kernel is not replying back
> after successful NOTIFY_RETRIEVE request made by the server.
>
> -> We can make the problem easy to diagnose if we indicate via error
> return to filesystem server when it is violating the contract.
> This should not practically cause problems because if a filesystem
> server is using shorter buffer, writes to it were already very likely to
> cause EIO, and if the filesystem is read-only it should be too following
> 8K minimum buffer size (= either FUSE_MIN_READ_BUFFER, see 1d3d752b47,
> or = 4K + min(max_write)=4k cared to be so by process_init_reply).
>
> Please see [1] for context where the problem of stuck filesystem was hit
> for real (because kernel client was incorrectly sending more than
> max_write data with NOTIFY_REPLY; see also previous patch), how the
> situation was traced and for more involving patch that did not make it
> into the tree.
>
> [1] https://marc.info/?l=linux-fsdevel&m=155057023600853&w=2

Applied.

Thanks,
Miklos
