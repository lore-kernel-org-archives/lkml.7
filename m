Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C369FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9182221734
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwJ0FvOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfDDMY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:24:27 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42233 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfDDMYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:24:25 -0400
Received: by mail-yb1-f193.google.com with SMTP id x84so903937ybg.9;
        Thu, 04 Apr 2019 05:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s3qpVVmxyOtu+1LyTKJENQDRUtah03qnRLReICoWpfQ=;
        b=iwJ0FvOau3sebooPyMR1N0zFk8DyjSwl07Pmxc7tFDOK55SV6DHo0rVvw9oyGU9tvn
         UldxEh3pekjqPCn9VK+2pZ5RaS+4uaDwzFDge9JQjC6E/D/wsZVt04mvcGYy3tX6x601
         LDfKzMqL8WRl/1sZVRZIbaAFsTstfxTsm6au3x+0NV5gAJN16V5hzNtrzfDtGiGiwrpY
         qSAmho7NXbqi8f6VBjgImWlILbAeAsHitmAVdFqUvgInnLyLxaN+z7aCZlc2QE/t14ZK
         4dMQmPzsEg8DvcHJRaJZlf3TVavi9qf6peVHo5TWdQmK9lDH81cFs2/3qZiTwK5F1vhf
         6DAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s3qpVVmxyOtu+1LyTKJENQDRUtah03qnRLReICoWpfQ=;
        b=jRGsIIcAH4jdFVNEwL7mUGLULMrHPpaZ4IjuBvpnocNFY3zNn4XghhtqIL/btfQdSQ
         YM6IRnfYhdzhjTUCnCmY5Y9/6AJXDSHtxe75ttzBGnQ46akk7NLZicbVzK5KsAYk753t
         DnwtR1O6dA/KZbcaUma/ucSlfrQFZG8AHLF96jOugDDuPCMVNSwpDpQn5ECpd3fjwghR
         Cngx7YbspgUnYc2NrQf5oQIvB8ROmOm8O8n+x1xlPEdTcxbSjqeT7LtAFOSeoPO1byFz
         NNo8wcAFGG1toFGI0j8Q9aNl7xbZf3JKKVkiHnO5EM7gfiqmsr0Iij8p1TE7e8L0FHin
         4AbA==
X-Gm-Message-State: APjAAAVWe2SKK1LSHQsa02iL3ig8DY17daxKRY7Yb+AJG2hIVxKbHtKG
        rkvb4CfJm8lw/Jzv75PYdG/rm7uWlh+yc749t/E=
X-Google-Smtp-Source: APXvYqwVPLJw8skjFVbPuYbFHg9pjK+SqOtxY0F7i8WzFyFtEKZWKj4ESFWV4/IfwlTN1+UZLSG8ZAYZ9qlIIHHEWys=
X-Received: by 2002:a25:7492:: with SMTP id p140mr5159188ybc.394.1554380663980;
 Thu, 04 Apr 2019 05:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190404081620.zx5rt2j2rjvdcglt@yubo-2> <af74fc26-2790-d83b-5320-bd4581e00585@gmail.com>
In-Reply-To: <af74fc26-2790-d83b-5320-bd4581e00585@gmail.com>
From:   Bo YU <tsu.yubo@gmail.com>
Date:   Thu, 4 Apr 2019 20:24:13 +0800
Message-ID: <CAKq8=3LNN1-KQ_33tRa8niQWT8YjD_0F_1qgzwPi35asaTQbBg@mail.gmail.com>
Subject: Re: [PATCH] bpf:sample: fix field 'lock' has incomplete type in hbm.h
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, songliubraving@fb.com,
        Netdev <netdev@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        open list <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 4:30 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 04/04/2019 01:16 AM, Bo YU wrote:
> > When compiling sample/bpf:
> >
> > samples/bpf/hbm.h:12:23: error: field =E2=80=98lock=E2=80=99 has incomp=
lete type
> >  struct bpf_spin_lock lock;
> >
> > Fixes: 187d0738ff35(bpf: Sample HBM BPF program to limit egress bw)
> > Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> > ---
>
> This patch makes absolutely no sense.
>
> Please carefully read samples/bpf/README.rst
Ok, got it.
Thanks,
>
>
