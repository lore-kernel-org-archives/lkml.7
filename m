Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1337C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8312B218BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/VaJFb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfHSKPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:15:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39691 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfHSKPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:15:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so907306pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 03:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dvoZuXsWbX7lGOYq0TI7+TMlH9iF9uBzei6TSIkQpEo=;
        b=i/VaJFb6t3Te0/Ydwxw+vNiDeOkdb+MJcn7TXNKivhdWghXmslO+y9j87467I23K5B
         UEIdHIp5NmCbO2tD0ms4O0rHfC9npZUxAQBJwWN2F1wOvMf78WZozaAhabZwXV8s6gme
         kr0uF3g+rOBACFQwNusHDXx0rDj3zT0uXJuO2ELFMqR9kumQa8+cEsOTnGOXV53mYZ/7
         eJ2P7RVuUV0As1NWdtd6aa9IAu0zjMd8v1DnOmTKmilI2vqiIRgtnAvAf6f2rEF+Owvk
         fvCVxPV5Pf7NZim8ShF9cnEGA62qMbfwPvm4GU1U06dDRlFPtwj++Y8rxmEMd5Gr6Np0
         hCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dvoZuXsWbX7lGOYq0TI7+TMlH9iF9uBzei6TSIkQpEo=;
        b=qQ6azGBm7GPqv1AU9etSmtI9BESYXxGwI7MgB5e5izShdIn9UpBYaHi5kcu+QHjluG
         yeoLBX6qiffXw1eLKO3Zj2DvwBhjmO+TZonXx5RP8q7mMKY1CjfTvtSVN5bO0rOBYQYi
         tokyW+01yF6JQ9Y2vPcuz/H9oNH9d/p1zHkrVgpqnna27fTuIdUR0KL6qVUaGiBfqyaE
         A9wb7BRkZbt8lGmYpM5gBLi0vXbjd6fAzhV5uwLWP6ZELFmL4kCn/Zs8+8q42Qn+pb56
         VMwuFaHuf54abvxddoFe/uI/9FyQEmjjMmLIMxUDrTPDd/Cex5q0XhL8HGwyM3Tgvrb9
         9h7w==
X-Gm-Message-State: APjAAAVz3EYVp0KUp6HA7giNMruFq/me7C27PsmYGPX8Yce+atLJphAS
        abXRwHwsRnbVFvVe4ElZPqlVODGrhP7yCuE62jimQpdp
X-Google-Smtp-Source: APXvYqx5xUj0PgOqdNxe923ijztvKJq0n7kqXgvHNZUnz4s7+1GMnujrSsYL9Fe2veAZjTKScqieSNogP1xZzEeGNWE=
X-Received: by 2002:aa7:8488:: with SMTP id u8mr23776800pfn.229.1566209739353;
 Mon, 19 Aug 2019 03:15:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:b296:0:0:0:0 with HTTP; Mon, 19 Aug 2019 03:15:38
 -0700 (PDT)
In-Reply-To: <20190807182316.28013-1-atish.patra@wdc.com>
References: <20190807182316.28013-1-atish.patra@wdc.com>
From:   Jacob Lifshay <programmerjake@gmail.com>
Date:   Mon, 19 Aug 2019 03:15:38 -0700
Message-ID: <CAC2bXD5JiEmYFQnJK9qr2=PLiXzHw2Ece_g+iMc_B_YAW7e0Eg@mail.gmail.com>
Subject: Re: [v5 PATCH] RISC-V: Fix unsupported isa string info.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Johan Hovold <johan@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19, Atish Patra <atish.patra@wdc.com> wrote:
>  		}
>  	}
> +	if (isa[0] != '\0') {
> +		/* Add remainging isa strings */

That should be spelled "remaining"

> +		for (e = isa; *e != '\0'; ++e) {
> +#if !defined(CONFIG_VIRTUALIZATION)
> +			if (e[0] != 'h')
> +#endif
> +				seq_write(f, e, 1);
> +		}
> +	}
>  	seq_puts(f, "\n");

Jacob Lifshay
