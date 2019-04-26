Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9479C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84D32053B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myECd9lL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfDZOey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:34:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46368 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfDZOey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:34:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id j11so1807619pff.13;
        Fri, 26 Apr 2019 07:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vutHLEpb1B1k+pI/qvWPJPkN23JkeGxg47wwHuqqG/M=;
        b=myECd9lLETHrtRvqwYau7NEeRhYK36PHtLojbnGLJjaQ+rK5Qgh+H5EzNjEXTl5LLR
         hbvq1t/9rIA0E67R3VDrBCuOuckico6bnRK0ltIthL7u0qhITwcLT61rDwREDQVtN228
         ZCK6ROH865GF7RMOige32IklwzCr0DNzrw33JvvO5aF3Kbsu68kMP3tDVp9mZLevnio/
         GkEpT27GxtgXizPsDZmji30iizeGdDFuS6z88x71Zuxqb+S+jPeFwnTCI3K+08ta+hNy
         VYJfG0S5MFQBw4XsuXvAg3lMWRl2gHkxcIQfMCX98x6cIG6P7nTgwCEL3t4D3vhv6vz3
         RvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vutHLEpb1B1k+pI/qvWPJPkN23JkeGxg47wwHuqqG/M=;
        b=o14/AIKNk0JguEXTTiAeEMjcBw4sPjTd/JtFKGJoAqfcNG8V5HVZA95hQuOUFzF+Ww
         PTezEX2zQOkb26j4YiWKZcTxQ1PpakS67tF7+Qo6l5F+DS1AxM6QjtSqdxzP51mjvswm
         EPP1yuV6OxbbrizZ9ud/RYmPFWVEqjMcL17X/66+WwRwzPxe4Hf4D6y7Cc+b7Z7RYp1X
         m7rh6QlLg7r4SYKlbKyDhC9sIDf657XsUV4jBM+jY2dy5jTDQEAUxzbjGojpHpXgExfX
         /YnfS9DAIMFUz3ZbiHS+JfR2k5Tmd9s+FQHEC4jyfVw4qpfuCBw28pdXFz1wBkLj/qC1
         wkIA==
X-Gm-Message-State: APjAAAUm0STPkbK9vKSysqei7LNgvTzXw7WOerrXmb24/npPkv5EwTRv
        T4f5WAIiYHXYqhmXKcQjWJCRmJQBW4O44ij3THI=
X-Google-Smtp-Source: APXvYqwMcSWAXNwoZ7iqHv0XoObymUGgkhJm3VxS21/XtYw+oSAC/QjAfQlY6kUHSD5+FRtjbPRYc9wbmA+gfe9cy/0=
X-Received: by 2002:a63:8e4b:: with SMTP id k72mr627286pge.428.1556289293130;
 Fri, 26 Apr 2019 07:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <5a547510-2605-bae5-bd58-ab4aff28840d@siemens.com>
In-Reply-To: <5a547510-2605-bae5-bd58-ab4aff28840d@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Apr 2019 17:34:41 +0300
Message-ID: <CAHp75VddTO890=DMa8pQANBGMMaDtCGgVb_cxCHc_Y1hxNTHwg@mail.gmail.com>
Subject: Re: [PATCH] stmmac: pci: Adjust IOT2000 matching
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        David Miller <davem@davemloft.net>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 12:15 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Su Bao Cheng <baocheng.su@siemens.com>
>
> Since there are more IOT2040 variants with identical hardware but
> different asset tags, the asset tag matching should be adjusted to
> support them.
>
> For the board name "SIMATIC IOT2000", currently there are 2 types of
> hardware, IOT2020 and IOT2040. The IOT2020 is identified by its unique
> asset tag. Match on it first. If we then match on the board name only,
> we will catch all IOT2040 variants. In the future there will be no other
> devices with the "SIMATIC IOT2000" DMI board name but different
> hardware.
>
> Signed-off-by: Su Bao Cheng <baocheng.su@siemens.com>
> Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

> +       /*

> +        * There are 2 types of SIMATIC IOT2000: IOT20202 and IOT2040.

20202 ?

> +        * The asset tag "6ES7647-0AA00-0YA2" is only for IOT2020 which
> +        * has only one pci network device while other asset tags are
> +        * for IOT2040 which has two.
> +        */



-- 
With Best Regards,
Andy Shevchenko
