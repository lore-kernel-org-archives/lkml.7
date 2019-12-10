Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBD6C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727C320663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqTOcUvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfLJKtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:49:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21839 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726574AbfLJKtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575974985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVctwGFkZUQARDKwSMhaffHofk1dC5Yr/3Iil1jZx9g=;
        b=PqTOcUvc4bJzCkHrUeDY1cMin9MvH2+dzrAQEvVV6cGP0Pu1xfScV0XO5iGEk3xy/BBa2a
        blvueo0JE6ZR3u+N8qFwMCsOpbA6FUyinTiDoTWypTGeKNXl5Mvn0pciOrQKm4XmvY414W
        7wgEI+iyyrVlYVRGG3SVW5+EQ/8dKF0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-vgb72TJdMtuTNB1RjDxqqg-1; Tue, 10 Dec 2019 05:49:42 -0500
Received: by mail-wr1-f71.google.com with SMTP id c17so8734851wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 02:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TXqUXLfieW4TVcQp6EMVYOtM+vJyQwpyvlc5ef5/YKE=;
        b=LWRPA4fr9J8n2S/suVFiSxornBYSV8xB+6iCHGekfbCiYbHI5B0l+eaybrxuOL5X+E
         Shl+tbI8nAi9CDixj4UujDC2F2isB71yEW1Ji0SXoW5QEN6gKYUEiarnhEVW6woch/nd
         ZJlcOoKGCFQm8IQzTRpzqEaAMWOTUg3YBvvcekFXyOaatNBZ2u6MKFXuOqyLdsVqg2kb
         KbOYgZhPfonkNEqH92BCl/5lAyA51SRSQTmG5pX2b5sgzBUD0F2OW3Iuy9U6WWcw+KIR
         FfL2zakaqGXAk3yNB7aEWpJexA1rmbmnvuw1aOC51e2rN4aBCEzyzb4CbJtLgh4p2Mz3
         SLkw==
X-Gm-Message-State: APjAAAXgvS0ojDJ7OjsRSHjQPXAcH47MMBYMZeeISfnScix70QvhsnsW
        q9AGgA0zgNg/4aseXftdhmsPMrajBqgLY6VRaBhPMiUVB66/bp9uLao0zeHcpPHIVpqgVYEoodp
        7kqeoV5vbrSKTk0nFXzxbKzoa
X-Received: by 2002:adf:a308:: with SMTP id c8mr943568wrb.240.1575974981379;
        Tue, 10 Dec 2019 02:49:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzWrXqV875WoE1NtxDoSWnidAGuPO2VDjnYqV2h4y2diBP7Q+pt2V1baueET5JHkn8bVgrOpw==
X-Received: by 2002:adf:a308:: with SMTP id c8mr943541wrb.240.1575974981114;
        Tue, 10 Dec 2019 02:49:41 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v3sm2554817wml.47.2019.12.10.02.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 02:49:40 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:49:39 +0100
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH NOTFORMERGE 0/5] Extend remote madvise API to KSM hints
Message-ID: <20191210104939.jauw5hnv3smhtvtr@butterfly.localdomain>
References: <20190616085835.953-1-oleksandr@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20190616085835.953-1-oleksandr@redhat.com>
X-MC-Unique: vgb72TJdMtuTNB1RjDxqqg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Minchan.

On Sun, Jun 16, 2019 at 10:58:30AM +0200, Oleksandr Natalenko wrote:
> This is a set of commits based on our discussion on your submission [1].
>=20
> First 2 implement minor suggestions just for you to not forget to take
> them into account.
>=20
> uio.h inclusion was needed for me to be able to compile your series
> successfully. Also please note I had to enable "Transparent Hugepage
> Support" as well as "Enable idle page tracking" options, otherwise the
> build failed. I guess this can be addressed by you better since the
> errors are introduced with MADV_COLD introduction.
>=20
> Last 2 commits are the actual KSM hints enablement. The first one
> implements additional check for the case where the mmap_sem is taken for
> write, and the second one just allows KSM hints to be used by the remote
> interface.
>=20
> I'm not Cc'ing else anyone except two mailing lists to not distract
> people unnecessarily. If you are fine with this addition, please use it
> for your next iteration of process_madvise(), and then you'll Cc all the
> people needed.
>=20
> Thanks.
>=20
> [1] https://lore.kernel.org/lkml/20190531064313.193437-1-minchan@kernel.o=
rg/
>=20
> Oleksandr Natalenko (5):
>   mm: rename madvise_core to madvise_common
>   mm: revert madvise_inject_error line split
>   mm: include uio.h to madvise.c
>   mm/madvise: employ mmget_still_valid for write lock
>   mm/madvise: allow KSM hints for remote API
>=20
>  mm/madvise.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>=20
> --=20
> 2.22.0
>=20

This is a gentle ping. Are you still planning to submit process_madvise() s=
olution?

--=20
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer

