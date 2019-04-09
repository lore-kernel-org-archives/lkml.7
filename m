Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CA8C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E216821473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D2J9uaHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDIALC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 20:11:02 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42209 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfDIALC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 20:11:02 -0400
Received: by mail-vs1-f68.google.com with SMTP id f15so8728015vsk.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 17:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=toy7Kf029iuEJYDO7d0IZxVbjz0T4H5yuRELwShhKD4=;
        b=D2J9uaHS93/MWRzReT1LG4j5SX4ShmqbpagH00CZkJTN81+iDP4NEnoKvPK4ra8k8R
         W33rqc+t8V4sFbIkVcHuQjKdNOvLOcy20UtvQkFOF9zLw3SVJgRURPIeXKvSPA6rv2eq
         KdKLKMWj82LddnIUNyX58mXTBdOLiR6c1NOj3RS6wW7PSohmxbBZXO4WESF6UbRmrQiL
         tPVHi9wM7PMRiDSJHUcKaYt+Rh7xrlwBE2WSvfLRGUdUOxAcPfIrPC6kahpZk38hVvr4
         BInduzPZ7/1lgLZfSq9n6bE3YbY1itb2MCQmxOR7wAO+HnDb7/TisBoivtFzZpi6x+Cb
         pYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=toy7Kf029iuEJYDO7d0IZxVbjz0T4H5yuRELwShhKD4=;
        b=Y1tbZl+HGeJhJtSEIn4YAQ79tu0Y/DCqkptAsC5bCb0pV844MMQPHs3skZTkZFXEko
         3nRqtoQbJjTKDS/RN6/LCqkwx3ZGoadXGg1MRFc5BhNThqXE01oGYEH1E0ztj86BpI54
         6q+31Gt25uPbDsa82wTVyVTPf/vrjodGrMbB5CSHEwX1F3oFlKiyxTFB/mjugWa1GSpV
         TKOPw4MBJDVYVfKNPb8BQwW34i47ML/Bk97vrdxwYM0u1kaKIIBX/OMImqyeTpWkrt5+
         PzcocBOcaEKBG18AcdKnZsZfBxrDbhB4uVpJwH4Q05uWwsUqYodYKclwNS5PMiRgOiKK
         ZJxw==
X-Gm-Message-State: APjAAAVtIN978S1VHoTRFmwXM6uc4FwRts8NPIlccRAanDosLiqs3K1o
        hl9p4TgoWhoEEbJ8I9qwQ9tj5EDXyQpyNsRw3DjNgQ==
X-Google-Smtp-Source: APXvYqweuaNBjkaNFqEcdKIwDyBFcn27hix457CnVV+ZSixr4ulsVIoGv7NSK93sbJywlWFjnZQuwBz2FSqQCQldWAY=
X-Received: by 2002:a67:76c7:: with SMTP id r190mr19251348vsc.196.1554768661260;
 Mon, 08 Apr 2019 17:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190110220245.GA20942@embeddedor>
In-Reply-To: <20190110220245.GA20942@embeddedor>
From:   Kees Cook <keescook@google.com>
Date:   Mon, 8 Apr 2019 17:10:49 -0700
Message-ID: <CAGXu5j+WYMbVaAWETjjg6BbVGNYaJt_8cKcFkiL7XUwbQEZGAA@mail.gmail.com>
Subject: Re: [PATCH] afs: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 2:02 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Notice that in many cases I placed a /* Fall through */ comment
> at the bottom of the case, which what GCC is expecting to find.
>
> In other cases I had to tweak a bit the format of the comments.
>
> This patch suppresses ALL missing-break-in-switch false positives
> in fs/afs
>
> Addresses-Coverity-ID: 115042 ("Missing break in switch")
> Addresses-Coverity-ID: 115043 ("Missing break in switch")
> Addresses-Coverity-ID: 115045 ("Missing break in switch")
> Addresses-Coverity-ID: 1357430 ("Missing break in switch")
> Addresses-Coverity-ID: 115047 ("Missing break in switch")
> Addresses-Coverity-ID: 115050 ("Missing break in switch")
> Addresses-Coverity-ID: 115051 ("Missing break in switch")
> Addresses-Coverity-ID: 1467806 ("Missing break in switch")
> Addresses-Coverity-ID: 1467807 ("Missing break in switch")
> Addresses-Coverity-ID: 1467811 ("Missing break in switch")
> Addresses-Coverity-ID: 115041 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

These look good to me. Gets us another step to finishing this. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
