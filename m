Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E6BC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AED3207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JylfxDZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfLIUFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:05:34 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46923 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIUFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:05:33 -0500
Received: by mail-io1-f65.google.com with SMTP id t26so4749824ioi.13;
        Mon, 09 Dec 2019 12:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kIY713aoSEHD/x3u5PlTEokoVSLdWYfrdpPXZFMSPxQ=;
        b=JylfxDZU9Jre6L6QN+kjA1Ig3xs+nah2MG1fWPLyf69hWYqujAozYEURQLLaP5elD9
         LEfUbDdK9AVoMMsn0B/HVbWlVLjXga51iRODPYk9+cXpUjT87fV4ij0TAXpd83is5lCq
         5LyHSOW9MByPohc5Z3nnuUdziogfqN0nRiLs0m8e13je/aVQh27c9/tv5Q4lnaNuzq2O
         6EfAR0hvrxRCxOLxJ1J40RJOeQ9CszPKBwC5ImOond9Yx8dtOz73cACH4SaamM0M6gxq
         1zr54sALDFW4NtZHOUBDc13ebOFZt6Q+UlmZAhcV9yA6csQ5M/YjeNnocwYCUQFaxGJ1
         OPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kIY713aoSEHD/x3u5PlTEokoVSLdWYfrdpPXZFMSPxQ=;
        b=Rublg/EuhgG0pX5OwdbE8WBMg8lkIlGrlGCYxnJrAvsrNsq0QskVcYhCSQZJ4uDhOc
         n8Pg//wmW64bevOtFJo6epWBGi02hDWy35IJelKv/5o65v9vbVvdVBiWJBxm1sDnJI9a
         zehWPdKBWveCtdAirLan94jwXIKmp6/EWhcl2HLbRn/8KHyJjSJEfRFFVIRJ/cznRMeE
         sU5CyYiSoRb4YlFyoZAtDfTVd+6ersXLDA/wwRK5i6WwJ2f0FYtfDQuN/lRQLxTkACnO
         HEWkb/f186Crk0vjLKWCcWry1qWmZr8DAbPn8LWCUdD3VjRVyzCntzWmn25sJfVYdRcw
         uR9A==
X-Gm-Message-State: APjAAAWhaNJiLQS9tM7ABcrYsz4COLF6ebpOTdp4zJLkYm+thmHPB75M
        +U6XyQne+1dWwq58ZCl9yUiZStBXnO8M55sm+ME=
X-Google-Smtp-Source: APXvYqy8pV0t678lSy5tpzAGPPl7NNyMK/SS0pTYQJIEbUPGHR1AKNsHvrADh5xk5NJJEC9jlPzpKY+6g+PtFvDt/w0=
X-Received: by 2002:a02:950d:: with SMTP id y13mr22133594jah.139.1575921932855;
 Mon, 09 Dec 2019 12:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20191208105328.15335-1-lukas.bulwahn@gmail.com> <1606305704.12702713.1575886917867.JavaMail.zimbra@inria.fr>
In-Reply-To: <1606305704.12702713.1575886917867.JavaMail.zimbra@inria.fr>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 9 Dec 2019 20:05:23 +0100
Message-ID: <CAKXUXMzd1OBdoOToPpuv6fh=eW+mNUPHcFdUjARxx+qBGMw=Bg@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Replace deprecated PTR_RET
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sinclair Yeh <syeh@vmware.com>,
        linux-graphics-maintainer@vmware.com,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 11:21 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > De: "Lukas Bulwahn" <lukas.bulwahn@gmail.com>
> > =C3=80: "Thomas Hellstrom" <thellstrom@vmware.com>, dri-devel@lists.fre=
edesktop.org
> > Cc: "David Airlie" <airlied@linux.ie>, "Daniel Vetter" <daniel@ffwll.ch=
>, "Sinclair Yeh" <syeh@vmware.com>,
> > linux-graphics-maintainer@vmware.com, kernel-janitors@vger.kernel.org, =
linux-kernel@vger.kernel.org, "Lukas Bulwahn"
> > <lukas.bulwahn@gmail.com>
> > Envoy=C3=A9: Dimanche 8 D=C3=A9cembre 2019 18:53:28
> > Objet: [PATCH] drm/vmwgfx: Replace deprecated PTR_RET
>
> > Commit 508108ea2747 ("drm/vmwgfx: Don't refcount command-buffer managed
> > resource lookups during command buffer validation") slips in use of
> > deprecated PTR_RET. Use PTR_ERR_OR_ZERO instead.
> >
> > As the PTR_ERR_OR_ZERO is a bit longer than PTR_RET, we introduce
> > local variable ret for proper indentation and line-length limits.
>
> Is 0 actually possible?  I have the impression that it is not, but perhap=
s I missed something.
>

I did not sanity-check if 0 is possible before patch submission, just
cleaning the syntatic stuff here to prepare final removal of the
deprecated PTR_RET.
But as far as I see:

vmw_cmd_dx_clear_rendertarget_view
-> vmw_view_id_val_add
-> vmw_view_lookup
-> vmw_cmdbuf_res_lookup

which would then return a proper pointer/a non PTR_ERR value and
hence, it would be possible that PTR_ERR_OR_ZERO returns 0. It all
looks pretty sane.

Lukas
