Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B377BC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8618923DF2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy54YSWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfE2QkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 12:40:07 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35645 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfE2QkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 12:40:07 -0400
Received: by mail-vs1-f67.google.com with SMTP id q13so2343282vso.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 09:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Esfl3nvaEBw2uCWEGOwNd1KcpJR7qnstyVJ5GKtC10=;
        b=gy54YSWi28xfcPumIcxdQBpxiv38UYPyQki2rU5FibosdeZ6MlUtt9mGYX3pMzpi1J
         eVhOA5uX5C/8oMK59ewu0GTbMw/NJWIUQ8b/ZIBDbt98ekfp++OMeCkgUOCvHQqDoN8q
         DaT+H9TyYWJTCERqolLABJA2fLCqFKB1pboH6qY+GtugTcyXA1u2hJOOP4KVS5o8T1W0
         Nc3mxPD+goAx+22GUHKIz3rE9eBxPxsWhYqcyXvXu+t7PAS8w0XKOkNJlFUXgc+fItQU
         niid+sGwkxSgn5eDnRpH3eTcty2oJDRMsOtoLpYvHkC93a4vKqdqfiIJhAnbRHUedyz6
         NvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Esfl3nvaEBw2uCWEGOwNd1KcpJR7qnstyVJ5GKtC10=;
        b=iBKflaAMJrZvbYxujYaNGI4gyFLFItrtTPEj9EmxqIzVW2H9xglagRhoBzJS0awq2V
         +1Ae0S+ZRq8M3xyvSGTOwSMprJZkdkfqJkLOtOAOZUln//pMM+PgDPsPOoGXRUxhY95R
         gg1Su+smThxx4AYpCRouFzb82bl2rXxcVtDaIxmpYnSrN8B1SWGZohgn51nGdm9GTmsJ
         rB0NSCQH8tvVtuK8wtJj3Gb0O+gqgFs5LT4onmExNBTHIIRXdp2IQJwf0zklGWYvasMF
         D23d8MEeznnOmvnibTh76hQo1Qx7WlloraKW+cgnN/N6evpWMao0ACOIApn2F1GbtwR7
         qfIg==
X-Gm-Message-State: APjAAAUIxAAqfiOCve5bY1vwlsY0Wha3o9+9ajywRQYNdmBKckfb8OSY
        gW9KS+1HyxkUcKeKnIK1SvuIH2d6V1a/2D8qx6Q=
X-Google-Smtp-Source: APXvYqwhVWfGociEat3pJKeWFTfSJFNJ89kc9w5M4Opt5Pu3UHJ1E0/+S9NVwIgBcTxJaDoqMh03meYLgWch4Id81Lc=
X-Received: by 2002:a67:ea58:: with SMTP id r24mr5616881vso.60.1559148004894;
 Wed, 29 May 2019 09:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <1559133448-31779-1-git-send-email-dianzhangchen0@gmail.com> <20190529162532.GG18589@dhcp22.suse.cz>
In-Reply-To: <20190529162532.GG18589@dhcp22.suse.cz>
From:   Dianzhang Chen <dianzhangchen0@gmail.com>
Date:   Thu, 30 May 2019 00:39:53 +0800
Message-ID: <CAFbcbMDJB0uNjTa9xwT9npmTdqMJ1Hez3CyeOCjjrLF2W0Wprw@mail.gmail.com>
Subject: Re: [PATCH] mm/slab_common.c: fix possible spectre-v1 in kmalloc_slab()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's come from `192+1`.


The more code fragment is:


if (size <= 192) {

    if (!size)

        return ZERO_SIZE_PTR;

    size = array_index_nospec(size, 193);

    index = size_index[size_index_elem(size)];

}


Sine array_index_nospec(index, size) can clamp the index within the
range of [0, size), so in order to make the `size<=192`, need to clamp
the index in the range of [0, 192+1) .

On Thu, May 30, 2019 at 12:25 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 29-05-19 20:37:28, Dianzhang Chen wrote:
> [...]
> > @@ -1056,6 +1057,7 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
> >               if (!size)
> >                       return ZERO_SIZE_PTR;
> >
> > +             size = array_index_nospec(size, 193);
> >               index = size_index[size_index_elem(size)];
>
> What is this 193 magic number?
> --
> Michal Hocko
> SUSE Labs
