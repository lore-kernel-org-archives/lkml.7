Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69376C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3899021473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akc9wpaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfDHMcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:32:47 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:38918 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfDHMcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:32:47 -0400
Received: by mail-io1-f45.google.com with SMTP id e13so10825908ioq.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 05:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XUyD7HgaLKvNpQbVoCvM1sZNHi87l9aU3qc5naKdNME=;
        b=akc9wpaObjt/S9YkJvVVhBOw4ipfpjv2Dc76h8/2ou6T/bi5q4mVDMj3amXC+zPDXx
         qN5xZ3mHANHFgYuIM+7RdCGLosbDZQe0wdC583LPpvX21xnHsrcGTanaz3V855nVthln
         u0mZeyLSgJvVb2Hd2UbU92MIq6Ce2UBgnfdPXcQY0s5V2bgQCJOpOZLT43i0V3kKibsO
         F0p5+V9ync89g9sIiNfnF9hnOZBMNyNd4su3kSi8s23nYAOhz3u2y8//J5H4JqQFMKQS
         lTveURPSQt9COIVUszZ0nlNLBGT6DizBDEOrWZeg8xMBN8eedJS8qYMzwLRHX5TT8CfF
         QWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUyD7HgaLKvNpQbVoCvM1sZNHi87l9aU3qc5naKdNME=;
        b=NfVcWcRjxDZXDCsSfVZLBW7R478PKzVNafS6m+L3HSPwkvve5QH9xY/wO4FMS+ysmH
         m91miNXhoYUuYvMFZ85SZZdOu3m0YACqtnCmcqueQQbRM2pbX6wIQQ9Vuc8W2/iKSjqq
         3rmqyaLpGogaWRp7p/n9+TQFBD8wmRZdBCZqcnDrS5Dp/4GSBlLRX3CC3ko4JR0K8QU+
         CiFd1h4G+W0Ds60kKgKd892pH7oLXDzgquklfll/0rWYlI4mkR8X4qZWthGJxXl262ms
         78QTn91ke+McVaAITjM1Bu36qoHqJWSUEct7tdvaL+sGuI+DLWS1b6CtjkFaNdftrAto
         Cxzg==
X-Gm-Message-State: APjAAAXJcrQUtBaL4+akJznJ/O6xmWtiXskL6bNk5dZD9KAmXl8QJBS1
        sJl6m99s2cixHRXveT7Lgh+bcjKigt0uCW4TmuIfyxJt
X-Google-Smtp-Source: APXvYqzaKn2qZOnGlIkiHbs4w4oLyJ2Cv7OJtQH49VDLMpSQRdzO+5UgvljIoFcZm02jL/+pJx0NTuQb2vjgXV4oQU4=
X-Received: by 2002:a6b:8d87:: with SMTP id p129mr10388114iod.10.1554726766481;
 Mon, 08 Apr 2019 05:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <9138d8e8-5390-0650-9bc3-050b869e978c@infradead.org>
In-Reply-To: <9138d8e8-5390-0650-9bc3-050b869e978c@infradead.org>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 8 Apr 2019 20:32:35 +0800
Message-ID: <CAKGbVbsiwTv8hV7W+unG_kuAApQm__=OxU4EnWzQNA7brZZMgA@mail.gmail.com>
Subject: Re: [PATCH -next] MAINTAINERS: mark lima mailing list as moderated
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        lima@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch has been applied to drm-misc-next branch.

Thanks,
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
