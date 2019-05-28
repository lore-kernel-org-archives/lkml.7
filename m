Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522CDC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D6A20657
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTxm2JN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfE1Pmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:42:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46236 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfE1Pme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:42:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id f37so32360255edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qeekGI+uXQy3jlEv+N7GO97qVs9m18isKX3ghrVsYNg=;
        b=BTxm2JN4TnZY5oEIAoAuBlUzwOpA0fyAfDXZy5d0jtPqAmRgGbeuWhtxJZr0h9LN1E
         s1P2f3XKDDvGy1o+LQWaU65kn5WNVoQqA/I3y1Ca/1152RmednbWHuttXBYLUFkYByvg
         sOFq9xhZCzsG/md6F2JpwpIi4g1panvaJ3JMNnde48voptkpmy4Z8mmwvEUEd+rkPpiH
         1eHhqEWZO9Ah3PY+/Nxjn1SM3XOFdvQCIXS7WZN5EVgk5rq2GKCaberchbEmQzZSDT2i
         ixIqEDqbdeSpo+6lLo+j6SxZUCV42jjvCmzEbOAzc42x1G35yMwVPpE2b6pNAnYfg5qw
         OL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qeekGI+uXQy3jlEv+N7GO97qVs9m18isKX3ghrVsYNg=;
        b=SZPez5HTC5xdjcuK8PqcWfab/b8YSL4Yua0Vj0M3+EqtEb+mK6jUqMj11lJoEPTQ/2
         ohkcPXgpX+MFNGHLW+oBYK95n7bN68cxHTHOG8jakxHgNNgZ37jXrAxEDlAq7mPtzyyU
         rjl2krCidVrQd0vmN2YEpEZzKc8hf+WuvXniybNhpSjiMkz3WVLvThb5ubCXDkvzO1Cn
         yOyIlvX5gCEa4cyNgNTmYaVNm+gnJ9P1UzcSJKPC2bF/lb18vDmcLPZzP0v5cktxsJs2
         U7xn6AS6jo/OQeBnN8JJhiQ6acx864k2xjiuOBoWUTz8glxmHRiytwuHjmzBQeuVF8t0
         Bztw==
X-Gm-Message-State: APjAAAUdqFDaQp3w0EVvLq5LWCoaEn7SWcoIV3V8np+sGZ9voR3cwu0d
        gwFbOh73jUdJO+tKPGY0RJtDnePX6R1VGR+CCnM=
X-Google-Smtp-Source: APXvYqzK5ecXGBnnhHqTBpPNezM4AvVoE3btCq3oudOjiiLkpzhZIdIWfnUH5yuztayDSkpXA7Sl31CoDbjf0TWHoA4=
X-Received: by 2002:a17:906:f48:: with SMTP id h8mr58704847ejj.142.1559058153169;
 Tue, 28 May 2019 08:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190527165413.GA26714@embeddedor>
In-Reply-To: <20190527165413.GA26714@embeddedor>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Tue, 28 May 2019 12:42:21 -0300
Message-ID: <CAB9dFdtT0p+Sg5=qt=Te9FEkASXcH=ZQZRHyN1UQ3nYkDLHMpQ@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix logically dead code in afs_update_cell
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 1:54 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Fix logically dead code in switch statement.
>
> Notice that *ret* is updated with -ENOMEM before the switch statement
> at 395:
>
> 395                 switch (ret) {
> 396                 case -ENODATA:
> 397                 case -EDESTADDRREQ:
> 398                         vllist->status = DNS_LOOKUP_GOT_NOT_FOUND;
> 399                         break;
> 400                 case -EAGAIN:
> 401                 case -ECONNREFUSED:
> 402                         vllist->status = DNS_LOOKUP_GOT_TEMP_FAILURE;
> 403                         break;
> 404                 default:
> 405                         vllist->status = DNS_LOOKUP_GOT_LOCAL_FAILURE;
> 406                         break;
> 407                 }
>
> hence, the code in the switch (except for the default case) makes
> no sense and is logically dead.
>
> Fix this by removing the *ret* assignment at 390:
>
> 390     ret = -ENOMEM;
>
> which is apparently wrong.
>
> Addresses-Coverity-ID: 1445439 ("Logically dead code")
> Fixes: d5c32c89b208 ("afs: Fix cell DNS lookup")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  fs/afs/cell.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/afs/cell.c b/fs/afs/cell.c
> index 9c3b07ba2222..980de60bf060 100644
> --- a/fs/afs/cell.c
> +++ b/fs/afs/cell.c
> @@ -387,7 +387,6 @@ static int afs_update_cell(struct afs_cell *cell)
>                 if (ret == -ENOMEM)
>                         goto out_wake;
>
> -               ret = -ENOMEM;
>                 vllist = afs_alloc_vlserver_list(0);
>                 if (!vllist)
>                         goto out_wake;

Looks like the intention here was to return -ENOMEM when
afs_alloc_vlserver_list fails, which would mean that the fix should
move the assignment within if (!vllist), rather than just removing it.
Although it might be fine to just return the error that came from
afs_dns_query instead, as you do in this patch.

Marc
