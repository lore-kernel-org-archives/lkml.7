Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A217EC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739F6215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YzxSMW/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgAFHFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:05:15 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44429 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgAFHFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:05:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id u71so49861045lje.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 23:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t5yk19yvKtDVRKf82rfjHqiC02zuVOaJ9JjJu9aCc7w=;
        b=YzxSMW/yslL+DsacaMKeKgkaOXrZijHQ6IskmC3pW3RrM0UHz2H1Y6+OiuD/yqK8Ub
         JWx/Z8+HXjPMHvgZFyJGegm4K1gF4kKDW/H7hHlh+Tnd4/giINsN9TQ2MWbo3lGuvrrK
         +cwgSWhuTxfg2o9gd33vV0U6O46O5Xe0Z9CVjk1OBXSaab7imcv9Gvi+GQzGdBOTwZk9
         lBt4EOoOZiIFAdIvD/zNOHoAmU49pcr++OOZUjSfKVxnFtY1CjQQwkFlDzgQWwhk4Ibd
         N+YvEyS3Dl4OxVOYtpvMcSZ5SRtkDWPS4MN8493ORiB3cNBz/QfwraGlpC6mkjeGeuXn
         kxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t5yk19yvKtDVRKf82rfjHqiC02zuVOaJ9JjJu9aCc7w=;
        b=skSHBaQxGa46arYwxnqlhP3Qjlr2mBAkEcz0GydXtoWLbFEHoEergAGxIOhloctgf3
         VNe3dStGs5s5d0wE7o7T/0OFntqGpzHi9opwW3zN3YhvjzPM2fEZ47DEqKJhcW/4H1Ju
         vQu1/wkHvpv5H16DIJz91FLxhjb1Igzeg0FGjGMPQE6QuC/CdJyF9nNxeLwp47vaA3hW
         NzbDE6ITQe+0ZiTugq1vUaEEbkY84n3HSea1yRXaFZX3VMPmEZywe5SBtB6no+EgSNdV
         C/arFq0XyHn/Po8xAhblYuGAZFmU4EYZagdepP66UZmrl9RPnKQ35zk5US4U8DDPsZK3
         nlUA==
X-Gm-Message-State: APjAAAXgulNkKhN0o06AcXzEdkMmWHVGdAC1iupEw3UmOiDnZdCWCaXW
        giDzmrD1j52XjXay0K5uTKnT+4gQ5SOFm0a9Q6Hvjw==
X-Google-Smtp-Source: APXvYqxHu/fTNapq5CnQkXWLWyHBsBS/+4g11L9WZQFQhkz8bg/NqbygIktGRp/mwi+IcUx9wRO96LXf7uWFjHmVQY0=
X-Received: by 2002:a2e:8316:: with SMTP id a22mr8525403ljh.141.1578294310955;
 Sun, 05 Jan 2020 23:05:10 -0800 (PST)
MIME-Version: 1.0
References: <1578291843-27613-1-git-send-email-vikas.gupta@broadcom.com> <1578291843-27613-2-git-send-email-vikas.gupta@broadcom.com>
In-Reply-To: <1578291843-27613-2-git-send-email-vikas.gupta@broadcom.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 6 Jan 2020 12:34:59 +0530
Message-ID: <CAFA6WYPMz=48rfH84aS9eGOQ7OejnLhAZSsZTFR2LXbfvjiCtg@mail.gmail.com>
Subject: Re: [PATCH v1] firmware: tee_bnxt: Reduce shm mem size to 4K
To:     Vikas Gupta <vikas.gupta@broadcom.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Jens

Hi Vikas,

On Mon, 6 Jan 2020 at 11:56, Vikas Gupta <vikas.gupta@broadcom.com> wrote:
>
> Reduce shm memory size as maximum size supported by optee_shm_register
> API is 4K.
>

There isn't any 4K size limitation with optee_shm_register() but
rather its an issue in upstream that is fixed via this patch [1]. Give
it a try and let me know if it works for you.

[1] https://lkml.org/lkml/2019/12/30/189

-Sumit

> Fixes: 246880958ac9 (=E2=80=9Cfirmware: broadcom: add OP-TEE based BNXT f=
/w manager=E2=80=9D)
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> ---
>  drivers/firmware/broadcom/tee_bnxt_fw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/b=
roadcom/tee_bnxt_fw.c
> index 5b7ef89..8f0c61c6 100644
> --- a/drivers/firmware/broadcom/tee_bnxt_fw.c
> +++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
> @@ -12,7 +12,7 @@
>
>  #include <linux/firmware/broadcom/tee_bnxt_fw.h>
>
> -#define MAX_SHM_MEM_SZ SZ_4M
> +#define MAX_SHM_MEM_SZ SZ_4K
>
>  #define MAX_TEE_PARAM_ARRY_MEMB                4
>
> --
> 2.7.4
>
