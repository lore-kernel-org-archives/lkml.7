Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E70C07542
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E03217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta44pz2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfE2EFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 00:05:18 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:43896 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfE2EFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 00:05:18 -0400
Received: by mail-io1-f49.google.com with SMTP id k20so609927ios.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 21:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qoCRgKEqb2cNIP9iBbmcP+1MshPj3Nktj6OiPwbarXY=;
        b=Ta44pz2N6vCsDgFB/YzCguDFPvKoN0XrV1PKQ4fEBWZ2ERaHYWnbT/J29GnDrAm3Q7
         AM3uZD1QG2eRlrvcinZcs+1PQMK4LTC9YezWYBUZJjfV0pnyMCfIAYJvDNLAzG9vU3pd
         ZmqqDS3xlEC0dFbnkg8AFgLdi8qp+/J9e/SCpqQZUkMua6FjYoQPGJ/LlWLrApM+j5cW
         nugMzWpzkjSlBmEBIygtEQDay08/Ot0Y4z2MUYdVUgzKbMkj6Lou7ahZJWPwW63K1xFu
         e9KoBVdHojf4Tc2uQhUtLlrd8GVkuDSuvPw5JW6NObfBF1ZsnfMG3LOOx45242BscHQW
         /Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qoCRgKEqb2cNIP9iBbmcP+1MshPj3Nktj6OiPwbarXY=;
        b=ctBVUHNvonWWyWWv0IKJOk6Pval72Ww66lpwdQdtPJzpKHnkEUJ1bkZOa8ifqupgxh
         C1fEUoraLaKmsKzVL9NPCTUXkO5IH9h7rBJer2DIbza5vzd8Z69M4U1+lweFWIYTbxp9
         k47L3ZltEogHsXt4qP58K7qXLdi9r/v7YL7Zj5FdzxqY0gj59gyWVehiz0JJ4zzhs+lR
         qtxd7C6/5mYipCt3AxGmxhnsrNe4HGldn9OWxaq2lTBrj0Uum4c43V1wB0o64lFp7V1x
         6Y075oPKMPjlAmlqKURWf2bow/TJErXCmKGpiEcG0UcKGf1esp5s/+xo/SKofKR5PZNF
         2sUw==
X-Gm-Message-State: APjAAAVmujbwiIeTqyyGmM+vLsAZzQnyN4+saGRV7YdPhZBPUku3Ycmu
        6530Jl5dpy5VR/Is6cVOPqAr2LrAvwXMQD70RE9o9iCs3k32jQ==
X-Google-Smtp-Source: APXvYqzUgiVnU+ecS/L3fcr3coeSpkq06FPF9E/xGA0Vgap0A2MpheGiZZG3Yep4zHc/xlpCpJr4mEN0UD4EDpMfJ4s=
X-Received: by 2002:a5e:c24b:: with SMTP id w11mr1108900iop.111.1559102717163;
 Tue, 28 May 2019 21:05:17 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 29 May 2019 09:05:06 +0500
Message-ID: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
Subject: kernel BUG at mm/swap_state.c:170!
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks.
I am observed kernel panic after update to git tag 5.2-rc2.
This crash happens at memory pressing when swap being used.

Unfortunately in journalctl saved only this:

May 29 08:02:02 localhost.localdomain kernel: page:ffffe90958230000
refcount:1 mapcount:1 mapping:ffff8f3ffeb36949 index:0x625002ab2
May 29 08:02:02 localhost.localdomain kernel: anon
May 29 08:02:02 localhost.localdomain kernel: flags:
0x17fffe00080034(uptodate|lru|active|swapbacked)
May 29 08:02:02 localhost.localdomain kernel: raw: 0017fffe00080034
ffffe90944640888 ffffe90956e208c8 ffff8f3ffeb36949
May 29 08:02:02 localhost.localdomain kernel: raw: 0000000625002ab2
0000000000000000 0000000100000000 ffff8f41aeeff000
May 29 08:02:02 localhost.localdomain kernel: page dumped because:
VM_BUG_ON_PAGE(entry != page)
May 29 08:02:02 localhost.localdomain kernel: page->mem_cgroup:ffff8f41aeeff000
May 29 08:02:02 localhost.localdomain kernel: ------------[ cut here
]------------
May 29 08:02:02 localhost.localdomain kernel: kernel BUG at mm/swap_state.c:170!




--
Best Regards,
Mike Gavrilov.
