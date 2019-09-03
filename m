Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0402AC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DF321881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnowmga+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfICFWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 01:22:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45841 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfICFWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 01:22:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so2451649pfb.12;
        Mon, 02 Sep 2019 22:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PG4gs15gIZ4A13AM7KKBtxfHSobNNxID1O7jVrr704s=;
        b=Dnowmga+8FytPRC2oXActJjrzdSdzqoiEHPYcxadH83Lyo7BNsdvs7VtAK5N+Y5HTh
         9SwRvLqy23QG9Gf+njtCCn6zJWNccBpObYcunOGxLPu5C2TFX6wWHqrn8BGl810LfPad
         5oe24tdoOsB68DmHjdE0swC/HPEI4bbAIxSCjFBfpRj4yR890BYNIccWZ+qUQ2k/BTfx
         nReAInNBxiVFLgEoakH66wVVImN/uTQf3wPlEqQBkiOqun2dAp2uuNiF2tsDeXakWNaZ
         BsiZbKDprfINyL2+Jf0Lg2a/SODVYKj6vE0zhBZrJv7ZpLY47/D3uPLq7o2w3kZFho7W
         kMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PG4gs15gIZ4A13AM7KKBtxfHSobNNxID1O7jVrr704s=;
        b=cjFXKDSjRwh6abEXkelofoCetvaJxQ9lrBsUjbafV1r4atEHD002VS+7ACKNI+pCHS
         TJ8CjokFWaugwfjdAVIv/FVkZauABYQjQFk+P6YlmbyDOEUXWEdLN+yMidBJ7CqKkLE4
         Qfiz4s0uBkaGmE/1TJGywxDBeAPiDvhgrwXUC72LkUcX70qktjtCgF+lI3VmfHje5B/N
         iJMwB4NnCTgjpS+aEcwUdCKcaFu3VDMYe/C3S0+2sQ76peQGINnlep+/cOenxZEYAQQU
         AE3SBeKwaRyWI87qYx+6hwtS3EJDXTbzNfUmPfPUn2C9tVPviXtH6ya+IHtWij/EAlyO
         ah5w==
X-Gm-Message-State: APjAAAVPB6qvWBhY6m1f+WVNVzim8XOO7b4cJyHD2giBm7r7Ywep8TTj
        fBftOJnJFESIVW2sQExQhneXctVPHyIyA8+p4PLCIJgM
X-Google-Smtp-Source: APXvYqyHperALgm8lL5IUNIg8lI94/bFS4z+MWn1R8zmDLyouND7eyQlZJ7RsDFiVza98N/nXlfou84UJx/41OzfdbU=
X-Received: by 2002:a63:211c:: with SMTP id h28mr28193617pgh.438.1567488152793;
 Mon, 02 Sep 2019 22:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
In-Reply-To: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
From:   Dexuan-Linux Cui <dexuan.linux@gmail.com>
Date:   Mon, 2 Sep 2019 22:22:21 -0700
Message-ID: <CAA42JLZySdadoL5LAhofXZx3T41A9hm=_izyrRs0MHbSbMf3MA@mail.gmail.com>
Subject: Re: "fs/namei.c: keep track of nd->root refcount status" causes boot panic
To:     Qian Cai <cai@lca.pw>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>, v-lide@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 9:22 PM Qian Cai <cai@lca.pw> wrote:
>
> The linux-next commit "fs/namei.c: keep track of nd->root refcount status=
=E2=80=9D [1] causes boot panic on all
> architectures here on today=E2=80=99s linux-next (0902). Reverted it will=
 fix the issue.

I believe I'm seeing the same issue with next-20190902 in a Linux VM
running on Hyper-V (next-20190830 is good).

git-bisect points to the same commit in linux-next:
    e013ec23b823 ("fs/namei.c: keep track of nd->root refcount status")

I can reproduce the issue every time I reboot the system.

Thanks,
Dexuan
