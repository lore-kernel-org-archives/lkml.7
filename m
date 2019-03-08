Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E373C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC472085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u17Z+HVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCHMm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:42:56 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36662 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfCHMm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:42:56 -0500
Received: by mail-ot1-f68.google.com with SMTP id v62so17229880otb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 04:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qLnzn2Tse4CfxyiYn6Qj09MwXukENfGfqu3rPuxVE+A=;
        b=u17Z+HVuhJTuMSMKtC8Agkvm17fGdRUkXl1I4jbLPEZxTPbNynlmzbHhfaG3HVzmmS
         p6U3Tc3eR2BrbwULTDLb86WSNV8x5ngwyip4CcxtzyGUjTn67gBVrqY6VJ9xde+MEt8i
         4D5Ie8y8yXbouL9n8xXBBtzIZosISS5aHQqGNKSRY+CDHHxukZb5DPjmTWqz5HzyvbW4
         M1cEKZ/kLwyRF/sjDeKMMJGXog9ponIaLHOb/8ohCIq1xRLbNNUfXOqqjjOw8nD0dbvN
         hwaj2RQdGa396sqVITHYLxDXCQDOvrC+gAnr+Unp/LRz134SrzmGDh4wHzoeKrU19syC
         sSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qLnzn2Tse4CfxyiYn6Qj09MwXukENfGfqu3rPuxVE+A=;
        b=s5Zzpva3js6gfn1nwg8Pf81IsYJvZ6oLF6qyjYGimWym21opA9Rsh7vDJTPw6ebpBt
         23DhOicn/kjz2KUerREsL4+GzrcqpZ7S+XYtLmNU7dFoNjwPjvp2oZcYmyf9oRWcvXur
         tgRUortgZh0GcpptjKlfK0nNPm9BUHUDyMWy8aUAxHfhcNX3BWuX5P+13PbmraqoFj8Y
         Pi24skGsyaD7TjdRUo7ntcIS05Gbfx8vvwB4xqF5/zyIiT48rVg0Af3tTj9JzXoISaTq
         2KHJn79EuDzYr07/XAn1aI2z9Q4HUeF9v6VTnDsYdg+1Bz99fwSnor9dI/6CSfE1rnNo
         f2XQ==
X-Gm-Message-State: APjAAAVcbWLlVZ/Mdyl0JMkvv3fP39+15bcYrGg7xq/X7wa10yBGoAHg
        LDegDP1/DnGTu+ueyHXObLwJNCRno1fe9AaebK69Vg==
X-Google-Smtp-Source: APXvYqyqFOVVhQOXX5Ud9dBsHb+eo1ocBGNcAlb41ZnbFg3MR62SM5aB3kowOksZFz5/+p/uoRVxz1jxHvwUCmkMTm0=
X-Received: by 2002:a05:6830:1543:: with SMTP id l3mr11835790otp.84.1552048974888;
 Fri, 08 Mar 2019 04:42:54 -0800 (PST)
MIME-Version: 1.0
References: <1551973336-23048-1-git-send-email-fabien.dessenne@st.com>
In-Reply-To: <1551973336-23048-1-git-send-email-fabien.dessenne@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 8 Mar 2019 13:42:44 +0100
Message-ID: <CA+M3ks6r_OWvit3OK0yqDDgfnVyyxPoo5aO2n9tRhhoS4=u4XQ@mail.gmail.com>
Subject: Re: [PATCH] hwspinlock: stm32: implement the relax() ops
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 7 mars 2019 =C3=A0 16:42, Fabien Dessenne <fabien.dessenne@st.com> =
a =C3=A9crit :
>
> Implement this optional ops, called by hwspinlock core while spinning on
> a lock, between two successive invocations of trylock().
>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@st.com>

> ---
>  drivers/hwspinlock/stm32_hwspinlock.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/hwspinlock/stm32_hwspinlock.c b/drivers/hwspinlock/s=
tm32_hwspinlock.c
> index 4418392..c8eacf4 100644
> --- a/drivers/hwspinlock/stm32_hwspinlock.c
> +++ b/drivers/hwspinlock/stm32_hwspinlock.c
> @@ -5,6 +5,7 @@
>   */
>
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/hwspinlock.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -42,9 +43,15 @@ static void stm32_hwspinlock_unlock(struct hwspinlock =
*lock)
>         writel(STM32_MUTEX_COREID, lock_addr);
>  }
>
> +static void stm32_hwspinlock_relax(struct hwspinlock *lock)
> +{
> +       ndelay(50);
> +}
> +
>  static const struct hwspinlock_ops stm32_hwspinlock_ops =3D {
>         .trylock        =3D stm32_hwspinlock_trylock,
>         .unlock         =3D stm32_hwspinlock_unlock,
> +       .relax          =3D stm32_hwspinlock_relax,
>  };
>
>  static int stm32_hwspinlock_probe(struct platform_device *pdev)
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
