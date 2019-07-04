Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BDFC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001FF21850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tf6GWRf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfGDNdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 09:33:19 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38836 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfGDNdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:33:19 -0400
Received: by mail-vs1-f67.google.com with SMTP id k9so1956464vso.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQVVIWl//6cOx7PlPgCwTmODIiDI0iixaOn3E5xX89k=;
        b=tf6GWRf+C/ZB5a/aNf2dgNIGQoefiebM+pWSkWYd6g5+42Vw8BY/Hflfy5rgyEqBIY
         AkjG1Lt06tXP0NTdnFXu5ozD0KVkkrgkobAiW0vi8cmliCBscS6yh3+rxtN0U4p6uJ1z
         aVGTXdw3d22F94J0hDEqd2hbwmDI8dNRta+U40O/xSj2f4N45oZNN1B7UxmNU3DCVt1L
         ifcQG3k+n8CZpalpAnKd4AWSexGUm5ZQI7LujqCoWgxTB1SArwstn8/mpG9coVpqX89g
         hgEkx/ETJi9fEYCLRKBtXjcBZbCUhY4ioUU7UcJQHHhhKqifAkrjSzFIjCDZ77D4IX4B
         Tfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQVVIWl//6cOx7PlPgCwTmODIiDI0iixaOn3E5xX89k=;
        b=f/z4GiRehr82cIICjNP5ZY7Xx28wHE1DH19Kcp607v4F27TbS6gO+LJH7vVurGtz/5
         q68S327kQZY/nA6nc/RXpH+ieOdTR1ucuNnb9mVxJ4JMgvXccxg+Jd742Hd2gFU762h8
         QxIa5j8iVed3HJj8uo/xZurZ7wBQSJWAEvKO+pykyWhCcN9j5sLPJlREusHLevFHjiyu
         9oa9fZ22HErX79edSl7OMP69Sztfb34Q5n1JObwVdO85iTlf1wBaBmcpzxHbL5L29+25
         q/iidBncAyrj8OX0GNHu+UyD0YVz4BTtzZhR5k4Q5EADXXJPiD2mYObdiD7nb4CDGRYz
         lL7A==
X-Gm-Message-State: APjAAAUsEnWCWnTQb+2VpWYQgqeu1w7nGSslMewtwfj7i1Qm3KryJRQB
        3Kv6d6jzBFQnIVQQJeP30mSFj6HQpVLvkPgfATg=
X-Google-Smtp-Source: APXvYqzNxMrL7Y1CtJokOFwqwShcUzdoU0/yTDHqrQLqguDdVULNGiPTFyjwU9y4H4PtuVAxlBXZEwnPTTITZkfD8P4=
X-Received: by 2002:a67:eb87:: with SMTP id e7mr22016486vso.118.1562247198710;
 Thu, 04 Jul 2019 06:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190702141903.1131-1-kraxel@redhat.com> <20190702141903.1131-12-kraxel@redhat.com>
In-Reply-To: <20190702141903.1131-12-kraxel@redhat.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Thu, 4 Jul 2019 14:33:26 +0100
Message-ID: <CACvgo53tSNa9=3LvmEdZvSp8g4oQF=cuue4UyTMjBtSKsfR0Ew@mail.gmail.com>
Subject: Re: [PATCH v6 11/18] drm/virtio: switch from ttm to gem shmem helpers
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

On Tue, 2 Jul 2019 at 15:19, Gerd Hoffmann <kraxel@redhat.com> wrote:
>         .gem_prime_import_sg_table = virtgpu_gem_prime_import_sg_table,

I think that you can drop this entry-point. AFAICT it's only purpose
is to return an error - something already handled by core DRM when the
function pointer is NULL.
It's not strictly related to this series, so feel free to keep is a
separate standalone patch.

-Emil
