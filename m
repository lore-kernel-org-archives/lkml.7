Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19496CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB32D21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huwfFp12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390565AbfJWIta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:49:30 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34975 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390343AbfJWIt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:49:29 -0400
Received: by mail-oi1-f193.google.com with SMTP id x3so16715346oig.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 01:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADV4dloY4QrpGFTvy/OoeHNXpjGf72Q0UAxYSc8ChkI=;
        b=huwfFp12qyI2jHm5EkRIvVBfBZqxMGd9x3nLq47NHMuoNKyPqUUlPqebVk2hNWcmoB
         khsxVS+6M6Mwbin2NE2ARQLmtl2uUthxZN6Q0ty4ygeOYJOmRfBZsicWfsp0FZeh0PR0
         0YM25+A7HZueY+CL67+tKQ4O0O+iPzCz3YCSV7s5SXkpIa1N/74v/bSlQ8OVkxDLFOtZ
         t1WUqnauORxl1IlJycJtJDRyJNJFWU0w6tlcmL3a7O2EPySayNDeSJq2uSSuC3gJq3vQ
         lmjitHFVXJtM3d77FbqsRR5hW3PKY6hdPWimAJgEkDU4svHHe24YtTnR4XqvCMWsWMxz
         tapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADV4dloY4QrpGFTvy/OoeHNXpjGf72Q0UAxYSc8ChkI=;
        b=e1+QM1hWfeKObrDwnTvOFAIRi6STjL9TCBaWVNZdweY8S7u18nU6aYTf1d25KdINsZ
         0pV/TCtJTf8DQEMNJ7DP4CLuUVBickvWXKM+BpRh41ztGkj+wQbF4km14/ukmtxzOrPu
         XRUGCfeqvDwjfjPPvkUOBvr/DKkM1qjDpOemfUJG/TIcpnoFQ6AcdsAi9tfSmjbVLroY
         iUNsCRB30H5rrT7OkvKJ25gzC4fDGTHBQfmnt4ldFfvAvMfgBScU9U47UTho7VbZOyhT
         TlOz05/HDwuYP5TL/slou46qly5Re4EdLEBek2OIrxf8WnyzIU2lHdPCsBUZp/C36mPU
         4BlA==
X-Gm-Message-State: APjAAAU8uDaEL40S4U00UBOD38sjeB8Vey8YBqidEgqGXXp91uNiqBnM
        r/GVm+KkgOfiHCQgUU5m16NnDVIhCgbur7fF7Tx34A==
X-Google-Smtp-Source: APXvYqzqfl89y1pbwQVoS8A11ClrnUFaZyaqUTogCmeTUjY5/jx96G9aTd3cpQSBIBLrLvTVV6/LLgDn+8AwgABdV6M=
X-Received: by 2002:aca:1a18:: with SMTP id a24mr6615198oia.145.1571820568027;
 Wed, 23 Oct 2019 01:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191023063103.44941-1-maowenan@huawei.com> <CA+Px+wX7-tn-rXeKqnPtp74tU5cLxhJwF6XZ_jeQX-tnAfvO5g@mail.gmail.com>
 <1d948ec1-69e4-735f-c369-80d2b28e0eaa@huawei.com>
In-Reply-To: <1d948ec1-69e4-735f-c369-80d2b28e0eaa@huawei.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Wed, 23 Oct 2019 16:49:16 +0800
Message-ID: <CA+Px+wXgXkmVYboPcrhOWkAwRB2ygLDLi+TN9xw2awUZKMhCJA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: Check SND_SOC_CROS_EC_CODEC dependency
To:     maowenan <maowenan@huawei.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?U2h1bmxpIFdhbmcgKOeOi+mhuuWIqSk=?= 
        <shunli.wang@mediatek.com>, yuehaibing@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tglx@linutronix.de, KaiChieh Chuang <kaichieh.chuang@mediatek.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 4:38 PM maowenan <maowenan@huawei.com> wrote:
> I receive below message after I post, do you know why?
> '''
> Your mail to 'Alsa-devel' with the subject
>
>     [PATCH] ASoC: mediatek: Check SND_SOC_CROS_EC_CODEC dependency
>
> Is being held until the list moderator can review it for approval.
>
> The reason it is being held:
>
>     Post by non-member to a members-only list

I don't exactly know.  But I got similar messages when I first time
sent mail to the alsa-devel.

Have you subscribed to alsa-devel mailing list?  I guess it is fine to
wait maintainers to proceed your patch.
