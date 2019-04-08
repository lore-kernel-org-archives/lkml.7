Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F44C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2268120880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ms42WX1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDHBhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 21:37:25 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39576 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDHBhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 21:37:24 -0400
Received: by mail-it1-f195.google.com with SMTP id 139so18357961ita.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 18:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m55FDieUwXSVk71d2fSE1OxsfIG20QdAAJNpsap2Ii0=;
        b=ms42WX1SjOmoBQ26WJTGjnIJS6UkYNu7Ywh2HFi+Oenc1OL3+GzCt9lmCeZOB9N7kA
         C33y6MYh1LRhBSHzuynUQIH6rbmxvnurlnDnJqJYO/MDTQ+IWc+c5eWKgZRiPxcVUWDQ
         JtBr56e0/b2JUf2Ci4VeyxlqCp0kxmQkeydxzOJpVuWWgiXRvnQ6EFcUaHjfyUWFvZb+
         +UPxKJPN6C967P/RSWpDgy2F1qsXjZBfyfuNeg2vY2juDKDVSvkHvnoayD5X/UFP9IUT
         WTeGdjoIhhy/NrtBGgWL30vXcawMtcLUEqOiqqWK6pDMT0eQFnrECRrKVicMnD7YVuT1
         iniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m55FDieUwXSVk71d2fSE1OxsfIG20QdAAJNpsap2Ii0=;
        b=nfeRB596yjOz0s7q6O+fA76cqRVBPafr5pqJRyznX5bL/NE0hH0OkIvfr9ESmbprj4
         tDXQ3iy7S3LM00TDIyCZao/qRmrrs2uwZn8yihERa2mPrE3v9nQaLVoz/5Htugstfxil
         K2AlHWdWnnneXiqyQ86NGWT9FhJU5V0z4ILsLisTxcD68HXbu1FZ4cCc4GalRmd/tIYz
         r94fJeu34hcvIQRinlPYZEoxii0o0CqLdqAHKkx1q2KRmMGoTYCxq4lneBr2N3VeLl9g
         iXJ2iOXnewtezYNEeKnAk3wdzUeDbicH8auIbhNNdOqP88ucrIu9xHj7W2nWWHKJaIAM
         coKg==
X-Gm-Message-State: APjAAAXe9Fv2aFG/mfumi8WZd00SKlP1+SfgA5/hBhcoNmaIIsZ4/5H0
        tmScCVvnPHe5DLWCX+EJLF4YlRD1y9xAze0SghQ=
X-Google-Smtp-Source: APXvYqwjSkpJFoN1ghizmvWB8xajraxMmkKwWcPgD9/0BAjtNxkmdv4XTGO6wlgHh521ZAHRpN5cRvVqEcDFzIyUaAk=
X-Received: by 2002:a24:4d85:: with SMTP id l127mr17930524itb.53.1554687443950;
 Sun, 07 Apr 2019 18:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <9138d8e8-5390-0650-9bc3-050b869e978c@infradead.org>
In-Reply-To: <9138d8e8-5390-0650-9bc3-050b869e978c@infradead.org>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 8 Apr 2019 09:37:13 +0800
Message-ID: <CAKGbVbugBGrxfHm3k7WB+FS_O-Bjj9PyKrSDteTy1sra=nd6cw@mail.gmail.com>
Subject: Re: [PATCH -next] MAINTAINERS: mark lima mailing list as moderated
To:     Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        lima@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good for me, patch is:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

Should I apply this patch to drm-misc in this case? Or this patch will be
submitted in other kernel tree and back merged to drm-misc?

Regards,
Qiang

On Mon, Apr 8, 2019 at 3:12 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Note that the lima mailing list is moderated.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Qiang Yu <yuq825@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: lima@lists.freedesktop.org
> ---
>  MAINTAINERS |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- mmotm-2019-0405-1828.orig/MAINTAINERS
> +++ mmotm-2019-0405-1828/MAINTAINERS
> @@ -5226,7 +5226,7 @@ F:        Documentation/devicetree/bindings/dis
>  DRM DRIVERS FOR LIMA
>  M:     Qiang Yu <yuq825@gmail.com>
>  L:     dri-devel@lists.freedesktop.org
> -L:     lima@lists.freedesktop.org
> +L:     lima@lists.freedesktop.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     drivers/gpu/drm/lima/
>  F:     include/uapi/drm/lima_drm.h
>
>
