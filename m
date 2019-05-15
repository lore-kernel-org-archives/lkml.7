Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6504C04AB7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821CC20873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL4UagPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfEOAyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:54:32 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37103 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfEOAyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:54:32 -0400
Received: by mail-oi1-f196.google.com with SMTP id f4so566707oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 17:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o3pBh+WZzfqafN5dlWW0Wq5LSopVGwQt/9grztsVP8Q=;
        b=bL4UagPLt/A/WHre/vmyevp4cdF/uZaIIauthXb/RSLU9boFflblpd0Igw0mDxecZ7
         OKh0jTET33oGC4lJ4iDWw1ztFq7aNdwe/1f2N6NepkwT23N1kXq4x/yBp6LThhqxTnNd
         mxH+VqHVcEDljU0cFZ4HSirp7abOy0L0gfHCzOPtfoTw4PEYpJG4QugwQdXnCAvMQ/tM
         FjN/LZUhJzwirenb+ZJ9NvSBV/+ZmBa7XbRdyvPpqgArPUPBxygDZu4abMWUDvvl4hML
         YVNJbFJ8d/r/0AnWOdikBf3g1MQIdSqPrH1HGUFbN3AVEt+mN9e91ZFm4dmYw4Wjs0jh
         IZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o3pBh+WZzfqafN5dlWW0Wq5LSopVGwQt/9grztsVP8Q=;
        b=K6WtQncb8/OgjBb8SlJOrrq5uLLVK720Sv0JwBoFBfB7YUyPyVNDeB9EJdge3DbMTh
         mWLKuTbhcyJ2SiMc8yuM6zEoG3p2g5jU8dBy4f/1xhg0IMvCXMnAdjj1QNIcHUIh+0At
         aTPLW8yU8kdeOv1wLTxV+pRfzJO/dx+eYWGwpff7yS2X8EorFwetHrAWO3ojvh1Qsong
         pezastb5HM/rCf3Wv94pBGCymU1IWjZcHpfzEuUta5YnNHuQD1nNBE4S0BaOtCasO8Z7
         4e2APYtNi/0qfGGukd4u2P7dmLXe1FjQJlkvNfAQhYVZsVfXsAWiuVQ9pEUcMOaj2FWb
         GkSg==
X-Gm-Message-State: APjAAAXFFRIgXoOddjtrQWNO+QqWByYQeq4N7aZeRQCxvVgfiYTUuZR9
        k/G323PovUxqcCjhoCBEOoyVBvImcSiucwEm3A8=
X-Google-Smtp-Source: APXvYqzLzjVzAuF91k9Rvra27CP94F8xT9tqGHftDUVQde0+Qqr/bBS2NaHTqcycqFttq3MebFh7YnEg8yJb4h/sK8E=
X-Received: by 2002:aca:f007:: with SMTP id o7mr4859752oih.59.1557881671192;
 Tue, 14 May 2019 17:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190514131654.25463-1-oleksandr@redhat.com> <20190514131654.25463-5-oleksandr@redhat.com>
In-Reply-To: <20190514131654.25463-5-oleksandr@redhat.com>
From:   Timofey Titovets <nefelim4ag@gmail.com>
Date:   Wed, 15 May 2019 03:53:55 +0300
Message-ID: <CAGqmi77gESF0h8ZduHm8TTPKRqQLGFdCP15TAW5skDwZnL85YA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/4] mm/ksm: add force merging/unmerging documentation
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM for whole series

Reviewed-by: Timofey Titovets <nefelim4ag@gmail.com>

=D0=B2=D1=82, 14 =D0=BC=D0=B0=D1=8F 2019 =D0=B3. =D0=B2 16:17, Oleksandr Na=
talenko <oleksandr@redhat.com>:
>
> Document respective sysfs knob.
>
> Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> ---
>  Documentation/admin-guide/mm/ksm.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-g=
uide/mm/ksm.rst
> index 9303786632d1..4302b92910ec 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -78,6 +78,17 @@ KSM daemon sysfs interface
>  The KSM daemon is controlled by sysfs files in ``/sys/kernel/mm/ksm/``,
>  readable by all but writable only by root:
>
> +force_madvise
> +        write-only control to force merging/unmerging for specific
> +        task.
> +
> +        To mark the VMAs as mergeable, use:
> +        ``echo PID > /sys/kernel/mm/ksm/force_madvise``
> +
> +        To unmerge all the VMAs, use:
> +        ``echo -PID > /sys/kernel/mm/ksm/force_madvise``
> +        (note the prepending "minus")
> +
In patch 3/4 you have special case with PID 0,
may be that also must be documented here?

>  pages_to_scan
>          how many pages to scan before ksmd goes to sleep
>          e.g. ``echo 100 > /sys/kernel/mm/ksm/pages_to_scan``.
> --
> 2.21.0
>


--
Have a nice day,
Timofey.
