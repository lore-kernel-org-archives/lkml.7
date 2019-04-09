Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F4EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65292213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="potlje7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfDICLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:11:54 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:39807 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfDICLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:11:50 -0400
Received: by mail-vk1-f194.google.com with SMTP id s80so3511459vke.6;
        Mon, 08 Apr 2019 19:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o50EFn9CaX/ULubRrv169eDGLZ1KBStdLz5wpbfUkiQ=;
        b=potlje7AWOM24pNydX2laAf5SlMdZRpRYSb3SYP3lA+vDqmiTd2+7mUhtadEotjhO0
         umUTO5EAFa9suItj/r1mH7BC1xxOIGC+Au8CtW4be12B7pu731YjbbmQqhMUob9pLMYt
         fzhwG7COQ2mTwM1mvSp52SbRCpUEv3jPk6VyMMI0/Uu7pfmA9C1RGuO1xkxxacalYcUi
         Xg8qstlMs6+dlUe1yOSySoGpnTZ5yBa2LDTiKGAmdLT3vPevPME7I6LHhXInBSs9jtS2
         KQQ59r8cclLePXMgYIrmVM4zq2bBAwxCHtLwQpSkovc17/vVpbyo9+SEGehT7H+vheVf
         EoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o50EFn9CaX/ULubRrv169eDGLZ1KBStdLz5wpbfUkiQ=;
        b=MK1JzHrY46VdDtlglDBObB7srHL0hwPvbcWhZel87pUEOIihq72ub3ZmCZijlNFqkn
         yGmBLcuI58hfK/Ngbml/z0E3dWPg5cKQUvY3WPtz8eEVRWCtKkBwHsxhBT0DKtWqos1z
         dYalTYpFRU1zNgqUqdOTmxFbsV4BAC83BlfW5g9Yr64QhRNQGv1vsUcaVlsHI6i2JzfE
         YYSEgO1RRotm0yVAibItK3fZjyuCwtGfsWGAC3sLkbnRqEe5oGhrnC5eE1mB9kBSCmXF
         mR2MJL8xF11Gu8JaGTWY09IokqFuRDjRMRp8iMdnPNqrDZxx6uMwDJNYNkXQxnCOxGPr
         zhMw==
X-Gm-Message-State: APjAAAU3mDU9EDXAKquWQWeojwgrRATF56+IZdryciLab3eeBFldFYX4
        Ps3B9Zo37xmNKRJOiuXn9976V3Ra/ws+W/TF+l0=
X-Google-Smtp-Source: APXvYqx7rZHMrp2U7l7Mbk3uv/C7kvrDb7h3wnqwyuZtq7dhY5emRWAKt5zsskaASxyraM8POj/HB2OKW5OKJZr5I0Y=
X-Received: by 2002:a1f:bed1:: with SMTP id o200mr18844144vkf.38.1554775909513;
 Mon, 08 Apr 2019 19:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190219074500.16454-1-vichy.kuo@gmail.com> <CAL_Jsq+wUGxeQUMJd0eu52QadvLvkkT=36q9e1Qbru2gEsUGCw@mail.gmail.com>
 <CAOVJa8HUx-8Ok8yMm91UmXpo39KAipt6C1BsfOL1c0Q_kqs1Vg@mail.gmail.com> <CAOVJa8FROiP7e=p_4Bs=QxiwcdqD5ydrrO=6G2GX2TJkQh9U8A@mail.gmail.com>
In-Reply-To: <CAOVJa8FROiP7e=p_4Bs=QxiwcdqD5ydrrO=6G2GX2TJkQh9U8A@mail.gmail.com>
From:   pierre kuo <vichy.kuo@gmail.com>
Date:   Tue, 9 Apr 2019 10:11:38 +0800
Message-ID: <CAOVJa8HmzvpAZBw7QJtMQsxyUGm7hMKaH7V6YZxHcL9E4J0q6w@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: reserved_mem: fix reserve memory leak
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Rob, Marek and Frank:

> > In this patch, we un-reserving memory ONLY if explicit compatible matching fail.
> > That mean driver found something wrong while matching and let OS know.
> > (But reserved-memory without compatible property will not be affected.)
> >
> > So per ur explaination, there would be cases that driver reported
> > matching memory fail,
> > but the memory is still needed by another processor?

Would you mind to give some comment and suggestion for this patch?

Sincerely appreciate ur kind help,
