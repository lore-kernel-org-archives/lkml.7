Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926BBC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566972077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ISAq0t3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfDXNTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:19:24 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:39341 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbfDXNTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:19:23 -0400
Received: by mail-it1-f177.google.com with SMTP id e13so6092389itk.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+9wtzOHTKfWwDFfAxyXSFblT57McAjnf3BBwlBkbcmk=;
        b=ISAq0t3otNaY9rmihmNmYwm6lU3FIlCt0FIlpUpiIJsNKCvpsYUZ0LRiEqWsbI9wBl
         Rf8iWUDOR1ZAMbHbd0f9qLR7/SOR8VfaskD5UlFhOklyUSgVEJpkpAj7qRwEiydNUbO2
         K5XpbA3gZ2b8zg0pMP3ft3ArQQfb5oRO9IP8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+9wtzOHTKfWwDFfAxyXSFblT57McAjnf3BBwlBkbcmk=;
        b=Vknlw50fA9mdZrare7zzNSt81P/D/RVI9qji0F7e7E/0jH5ILewgVosbwgtX+qJnvS
         i0f3WOZYB6LG4hywT/wEv5+wIhfvVZzc9pqeix0TQqBCPl0+LWHTmpoDKPSbAzIhbb4p
         d7VuLF5T2ePKuud8GGXV1SHYL1O4qcQW7GtnQXue8K/KEmu4G1EaoKrJ8yYPBrnckvrV
         dc97/VVnl9IINt+QNsZQufrioRj1uLD5Loud3qVk13+PjxvF1jvtH1pWtwgafkNNtbmz
         rVbdnijB1uXTY2letHwKkApMxExBzJZuGOqOTxSD92/ebT6xPe6hAPK4yVVi+I/3JJCo
         ISow==
X-Gm-Message-State: APjAAAVtdwtFGn8Kwzcf9xHUQwVN3T+TPahrqxyBF2KS932R+Q8r2zVc
        Rq3bvkzcHdMaay+pqi7YOPDwPJoMuPeUqt7crKhZew==
X-Google-Smtp-Source: APXvYqyiD2KC7oQVYjMqP0FCpqgItbxd5QDgSy7sdqZ7xz83K4NkLsINvasjM6Nbdnv2021L/kM7wlOZB+jkVt9gfk8=
X-Received: by 2002:a02:ca13:: with SMTP id i19mr768954jak.77.1556111962827;
 Wed, 24 Apr 2019 06:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553680185.git.kirr@nexedi.com> <12f7d0d98555ee0d174d04bb47644f65c07f035a.1553680185.git.kirr@nexedi.com>
 <CAJfpegv0NvcsD9gh3aN+ngzsLqbNWUc73ZPN1qHox_14eN9Pqg@mail.gmail.com>
 <20190424115620.GA2723@deco.navytux.spb.ru> <CAJfpegsiWuykUsfg=sO8sKo5h86U65q10=e=wYKXTQEHW8DFkw@mail.gmail.com>
 <20190424123107.GA32024@deco.navytux.spb.ru>
In-Reply-To: <20190424123107.GA32024@deco.navytux.spb.ru>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Apr 2019 15:19:11 +0200
Message-ID: <CAJfpegupwNbVPenZdMX8F2Z3vKSJdfAsXuiF4YA+nbnj2Kp=sw@mail.gmail.com>
Subject: Re: [RESEND4, PATCH 1/2] fuse: retrieve: cap requested size to
 negotiated max_write
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 2:31 PM Kirill Smelkov <kirr@nexedi.com> wrote:

> Thanks. Does it mean that the patch is ok? Do I need to rework
> something?

Pushed to #for-next with all the rest.  Made some changes to the
patches, so please verify.

> I see. Probably it is not "quoted-printable" as
>
>         Content-Type: text/plain; charset=3Dutf-8
>         Content-Transfer-Encoding: 8bit

Well, google converts it to quoted-printable then:

Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: quoted-printable

> suggests and it is maybe due to UTF-8 characters (I used "=C2=B7" several
> times in patch description).

Please refrain from gratuitous use of non-ascii.   That middle-dot is
written as "*" in C (fixed the patch description).

Thanks,
Miklos
