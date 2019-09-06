Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20206C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED01220842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZHOv+RZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388510AbfIFPMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:12:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40774 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfIFPMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:12:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so3672153pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:to:from:cc:subject:user-agent:date;
        bh=Xb6VwDjoplmWmuetAQCvzqk0SmPHJLjBpgM4hHIYCII=;
        b=ZHOv+RZQ3aLmqgmsd5zyET7umQYE10jQO9DyLmBi7gmXaBD/zsKVo+gYs46PZcAdJX
         TM3rMdk2kGkm9oV51CI9U1unCD6cNDTNdjaApnOAqojhXZp71CwST9cw1aBWzIZauQxK
         RpsP1NITVP9z8h6SB0dNNBxLbHKkMZvZr94+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:to:from:cc:subject
         :user-agent:date;
        bh=Xb6VwDjoplmWmuetAQCvzqk0SmPHJLjBpgM4hHIYCII=;
        b=owMp0yPiNL6W9WEkmu32t+xJFk4C2WdwOqQrgKT0BT6EzQ1mcJAiIUOBsXgO189EFP
         1s9BCbSp1ACWunUotDkDT5saZ+G6wVLQw7pCRVxjTcZwJdzN54z6qj3i73wW7v9lNWYh
         PZ+jmCBkD3pw6uWN6BPsN+o7M6Ff4JV9c0ULkBIToSrCxPhVoIOy6Yz+6r9w8pedi+ea
         BKceDdfuMVTWWKSwEIUuTmlK0P64hPZAOsMFvPKZr/40QufDBWuaV2IEcGw76bT9q3gl
         sNh9ACMkbPUCxLInha4YPPrDwr+69YFWvGquo0rMGklNri9E8rM4kaDCHE76EPw4bp8/
         3aZw==
X-Gm-Message-State: APjAAAWCOMDU7rzGWJep0tCvxYyaLeFNOedd9YHbLCF4JJAHd3BbbKJ8
        NcI7Gi9vfpTOYmdtIf9WiOsqlw==
X-Google-Smtp-Source: APXvYqx5APO82PFexcy027FfVJXJBg/BMStPKFD+PoK1ECUmgX6ZblpH7mM8DpzNko7+Kif7xTbz/Q==
X-Received: by 2002:a63:a302:: with SMTP id s2mr8404939pge.125.1567782768983;
        Fri, 06 Sep 2019 08:12:48 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u5sm5336849pfl.25.2019.09.06.08.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 08:12:48 -0700 (PDT)
Message-ID: <5d727770.1c69fb81.c9062.ce60@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190823063248.13295-2-vivek.gautam@codeaurora.org>
References: <20190823063248.13295-1-vivek.gautam@codeaurora.org> <20190823063248.13295-2-vivek.gautam@codeaurora.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>, agross@kernel.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        robin.murphy@arm.com, will.deacon@arm.com
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v4 1/3] firmware: qcom_scm-64: Add atomic version of qcom_scm_call
User-Agent: alot/0.8.1
Date:   Fri, 06 Sep 2019 08:12:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vivek Gautam (2019-08-22 23:32:46)
> There are scnenarios where drivers are required to make a
> scm call in atomic context, such as in one of the qcom's
> arm-smmu-500 errata [1].
>=20
> [1] ("https://source.codeaurora.org/quic/la/kernel/msm-4.9/
>       tree/drivers/iommu/arm-smmu.c?h=3Dmsm-4.9#n4842")
>=20
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/firmware/qcom_scm-64.c | 136 ++++++++++++++++++++++++++++-------=
------
>  1 file changed, 92 insertions(+), 44 deletions(-)
>=20
> diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-6=
4.c
> index 91d5ad7cf58b..b6dca32c5ac4 100644
> --- a/drivers/firmware/qcom_scm-64.c
> +++ b/drivers/firmware/qcom_scm-64.c
> @@ -62,32 +62,71 @@ static DEFINE_MUTEX(qcom_scm_lock);
>  #define FIRST_EXT_ARG_IDX 3
>  #define N_REGISTER_ARGS (MAX_QCOM_SCM_ARGS - N_EXT_QCOM_SCM_ARGS + 1)
> =20
> -/**
> - * qcom_scm_call() - Invoke a syscall in the secure world
> - * @dev:       device
> - * @svc_id:    service identifier
> - * @cmd_id:    command identifier
> - * @desc:      Descriptor structure containing arguments and return valu=
es
> - *
> - * Sends a command to the SCM and waits for the command to finish proces=
sing.
> - * This should *only* be called in pre-emptible context.
> -*/
> -static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
> -                        const struct qcom_scm_desc *desc,
> -                        struct arm_smccc_res *res)
> +static void __qcom_scm_call_do(const struct qcom_scm_desc *desc,
> +                              struct arm_smccc_res *res, u32 fn_id,
> +                              u64 x5, u32 type)
> +{
> +       u64 cmd;
> +       struct arm_smccc_quirk quirk =3D {.id =3D ARM_SMCCC_QUIRK_QCOM_A6=
};

Nitpick: Put spaces around braces please.

> +
> +       cmd =3D ARM_SMCCC_CALL_VAL(type, qcom_smccc_convention,
> +                                ARM_SMCCC_OWNER_SIP, fn_id);
> +
> +       quirk.state.a6 =3D 0;
> +
> +       do {
> +               arm_smccc_smc_quirk(cmd, desc->arginfo, desc->args[0],
> +                                   desc->args[1], desc->args[2], x5,
> +                                   quirk.state.a6, 0, res, &quirk);
> +
> +               if (res->a0 =3D=3D QCOM_SCM_INTERRUPTED)
> +                       cmd =3D res->a0;
> +
> +       } while (res->a0 =3D=3D QCOM_SCM_INTERRUPTED);
> +}
> +
> +static void qcom_scm_call_do(const struct qcom_scm_desc *desc,
> +                            struct arm_smccc_res *res, u32 fn_id,
> +                            u64 x5, bool atomic)
> +{
> +       int retry_count =3D 0;
> +
> +       if (!atomic) {
> +               do {
> +                       mutex_lock(&qcom_scm_lock);
> +
> +                       __qcom_scm_call_do(desc, res, fn_id, x5,
> +                                          ARM_SMCCC_STD_CALL);
> +
> +                       mutex_unlock(&qcom_scm_lock);
> +
> +                       if (res->a0 =3D=3D QCOM_SCM_V2_EBUSY) {
> +                               if (retry_count++ > QCOM_SCM_EBUSY_MAX_RE=
TRY)
> +                                       break;
> +                               msleep(QCOM_SCM_EBUSY_WAIT_MS);
> +                       }
> +               }  while (res->a0 =3D=3D QCOM_SCM_V2_EBUSY);
> +       } else {
> +               __qcom_scm_call_do(desc, res, fn_id, x5, ARM_SMCCC_FAST_C=
ALL);
> +       }

To save on some indentation maybe you could write it like:

	if (atomic) {
		__qcom_scm_call_do(..)
		return;
	}

	do {
		mutex_lock(..)
		...
	} while (..);

> +}
> +
> +static int ___qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
> +                           const struct qcom_scm_desc *desc,
> +                           struct arm_smccc_res *res, bool atomic)
>  {
>         int arglen =3D desc->arginfo & 0xf;
> -       int retry_count =3D 0, i;
> +       int i;
>         u32 fn_id =3D QCOM_SCM_FNID(svc_id, cmd_id);
> -       u64 cmd, x5 =3D desc->args[FIRST_EXT_ARG_IDX];
> +       u64 x5 =3D desc->args[FIRST_EXT_ARG_IDX];
>         dma_addr_t args_phys =3D 0;
>         void *args_virt =3D NULL;
>         size_t alloc_len;
> -       struct arm_smccc_quirk quirk =3D {.id =3D ARM_SMCCC_QUIRK_QCOM_A6=
};
> +       gfp_t flag =3D atomic ? GFP_ATOMIC : GFP_KERNEL;
> =20
>         if (unlikely(arglen > N_REGISTER_ARGS)) {
>                 alloc_len =3D N_EXT_QCOM_SCM_ARGS * sizeof(u64);
> -               args_virt =3D kzalloc(PAGE_ALIGN(alloc_len), GFP_KERNEL);
> +               args_virt =3D kzalloc(PAGE_ALIGN(alloc_len), flag);
> =20
>                 if (!args_virt)
>                         return -ENOMEM;
> @@ -156,6 +169,41 @@ static int qcom_scm_call(struct device *dev, u32 svc=
_id, u32 cmd_id,
>         return 0;
>  }
> =20
> +/**
> + * qcom_scm_call() - Invoke a syscall in the secure world
> + * @dev:       device
> + * @svc_id:    service identifier
> + * @cmd_id:    command identifier
> + * @desc:      Descriptor structure containing arguments and return valu=
es
> + *
> + * Sends a command to the SCM and waits for the command to finish proces=
sing.
> + * This should *only* be called in pre-emptible context.

Add a might_sleep() then?

> + */
> +static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
> +                        const struct qcom_scm_desc *desc,
> +                        struct arm_smccc_res *res)
> +{
> +       return ___qcom_scm_call(dev, svc_id, cmd_id, desc, res, false);
> +}
> +
> +/**
> + * qcom_scm_call_atomic() - atomic variation of qcom_scm_call()
> + * @dev:       device
> + * @svc_id:    service identifier
> + * @cmd_id:    command identifier
> + * @desc:      Descriptor structure containing arguments and return valu=
es
> + * @res:       Structure containing results from SMC/HVC call
> + *
> + * Sends a command to the SCM and waits for the command to finish proces=
sing.
> + * This should be called in atomic context only.
=20
Maybe add a cant_sleep()?

> + */
> +static int qcom_scm_call_atomic(struct device *dev, u32 svc_id, u32 cmd_=
id,
> +                               const struct qcom_scm_desc *desc,
> +                               struct arm_smccc_res *res)
> +{
> +       return ___qcom_scm_call(dev, svc_id, cmd_id, desc, res, true);
> +}
> +
