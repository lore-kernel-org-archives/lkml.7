Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C360DC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B95E21897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swc147Yi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfH3LOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 07:14:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36030 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfH3LOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:14:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id p13so7081480wmh.1;
        Fri, 30 Aug 2019 04:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hSYAq4sNLBANo6XopvpmS+ZLIgrnfGchaR+MSg6zRQk=;
        b=swc147YiD1hTkQMVs3j8eSZPwJ75gmdJL7WJvQRhwzGH8P3pqKp0h3fW3Xw/r6aNJJ
         wrOjTwXI26OzyPOTK1VKn1ZFIUIHGUVdxhb0U2TVD8EAsCfD7NZxri2mEgZOEEqRRAAI
         +ZM86IJvvd8JX8uubdjCHzgKGobcPZS+LUWVyRuPdhI/KvXtNVdz6+La/B1ajV1FjHv5
         EsNHEZtlMIjbWhOBh5rE+GerGL8u2fUhKv0gQiZgQXXAjNG3XCngA5DFBw9A4o9rrFlU
         /d/Eq4chNIYY3F9qBlhsOteSqvYNmXQ7UP0J+kbnJGJ5bER/Yulc7yFn7n9wC5jXcKoN
         kQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hSYAq4sNLBANo6XopvpmS+ZLIgrnfGchaR+MSg6zRQk=;
        b=ipPbF7LnKDguHI8SgXKdYW0Sqq5pZMk2T7xw1TTQuXO1c1S4rYvs3ZLzHVKNr+zyMi
         vH1xNZGZTMOLLh//IrqBRTYQwrv1DXlna+MvVmnUGXYI1QChv91Um0km836ISgxHtKwa
         Lbf1UR0BPlPEcKPipMRqNL3YtSUwhhJ5TJubzKZjWZ9ehdLNMFMJDAfxjdSme7o3OQoj
         wkhPzRoC0R6LHg/IyDXTs1r9WZ7DPJtCW2mXUGZvlSBHZFYJjn129BQQvFivXmPvkWot
         dGOs4ho8R8fiWQPHJ+jD79IMxqJj5kbliwZHt7L8kbDB7qCZ/FiZyR/NxjYgAuzP96tt
         HWQA==
X-Gm-Message-State: APjAAAXq46Wlo3EOgeVMzE0M/i0QER9oZ9iRtqy63hZd3Pb5VHiUfeUR
        DfUcehePlV37LDUUyKZYIVg=
X-Google-Smtp-Source: APXvYqzf1BOs1k9qqYOdUV8xiUSs3dlXRV9oMWXV0IcM1uJiVGKLXERr7a9JXq6CtrMFQs1FCaAnlg==
X-Received: by 2002:a05:600c:231a:: with SMTP id 26mr16734766wmo.136.1567163689074;
        Fri, 30 Aug 2019 04:14:49 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id t14sm6222778wrs.58.2019.08.30.04.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 04:14:47 -0700 (PDT)
Date:   Fri, 30 Aug 2019 13:14:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com, yhsu@nvidia.com,
        snikam@nvidia.com, praithatha@nvidia.com, talho@nvidia.com,
        avanbrunt@nvidia.com, thomasz@nvidia.com, olof@lixom.net,
        jtukkinen@nvidia.com, mperttunen@nvidia.com
Subject: Re: [PATCH 3/7] iommu/arm-smmu: Add tlb_sync implementation hook
Message-ID: <20190830111446.GC23902@ulmo>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
 <1567118827-26358-4-git-send-email-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <1567118827-26358-4-git-send-email-vdumpa@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2019 at 03:47:03PM -0700, Krishna Reddy wrote:
> tlb_sync hook allows nvidia smmu handle tlb sync
> across multiple SMMUs as necessary.
>=20
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  drivers/iommu/arm-smmu-nvidia.c | 32 ++++++++++++++++++++++++++++++++
>  drivers/iommu/arm-smmu.c        |  8 +++++---
>  drivers/iommu/arm-smmu.h        |  4 ++++
>  3 files changed, 41 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvi=
dia.c
> index d93ceda..a429b2c 100644
> --- a/drivers/iommu/arm-smmu-nvidia.c
> +++ b/drivers/iommu/arm-smmu-nvidia.c
> @@ -56,11 +56,43 @@ static void nsmmu_write_reg64(struct arm_smmu_device =
*smmu,
>  		writeq_relaxed(val, nsmmu_page(smmu, i, page) + offset);
>  }
> =20
> +static void nsmmu_tlb_sync_wait(struct arm_smmu_device *smmu, int page,
> +				int sync, int status, int inst)
> +{
> +	u32 reg;
> +	unsigned int spin_cnt, delay;
> +
> +	for (delay =3D 1; delay < TLB_LOOP_TIMEOUT; delay *=3D 2) {
> +		for (spin_cnt =3D TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
> +			reg =3D readl_relaxed(
> +			      nsmmu_page(smmu, inst, page) + status);
> +			if (!(reg & sTLBGSTATUS_GSACTIVE))
> +				return;
> +			cpu_relax();
> +		}
> +		udelay(delay);
> +	}
> +	dev_err_ratelimited(smmu->dev,
> +			    "TLB sync timed out -- SMMU may be deadlocked\n");
> +}
> +
> +static void nsmmu_tlb_sync(struct arm_smmu_device *smmu, int page,
> +			   int sync, int status)
> +{
> +	int i;
> +
> +	arm_smmu_writel(smmu, page, sync, 0);
> +
> +	for (i =3D 0; i < to_nsmmu(smmu)->num_inst; i++)
> +		nsmmu_tlb_sync_wait(smmu, page, sync, status, i);
> +}
> +
>  static const struct arm_smmu_impl nsmmu_impl =3D {
>  	.read_reg =3D nsmmu_read_reg,
>  	.write_reg =3D nsmmu_write_reg,
>  	.read_reg64 =3D nsmmu_read_reg64,
>  	.write_reg64 =3D nsmmu_write_reg64,
> +	.tlb_sync =3D nsmmu_tlb_sync,
>  };
> =20
>  struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *sm=
mu)
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 46e1641..f5454e71 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -52,9 +52,6 @@
>   */
>  #define QCOM_DUMMY_VAL -1
> =20
> -#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
> -#define TLB_SPIN_COUNT			10
> -
>  #define MSI_IOVA_BASE			0x8000000
>  #define MSI_IOVA_LENGTH			0x100000
> =20
> @@ -244,6 +241,11 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_devi=
ce *smmu, int page,
>  	unsigned int spin_cnt, delay;
>  	u32 reg;
> =20
> +	if (smmu->impl->tlb_sync) {
> +		smmu->impl->tlb_sync(smmu, page, sync, status);
> +		return;
> +	}
> +

Wouldn't it work if you replaced all calls of __arm_smmu_tlb_sync() by
smmu->impl->tlb_sync() and assign __arm_smmu_tlb_sync() as default for
devices that don't need to override it? That makes this patch slightly
larger, but it saves us one level of indirection.

> +
>  	arm_smmu_writel(smmu, page, sync, QCOM_DUMMY_VAL);
>  	for (delay =3D 1; delay < TLB_LOOP_TIMEOUT; delay *=3D 2) {
>  		for (spin_cnt =3D TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index 9645bf1..d3217f1 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -207,6 +207,8 @@ enum arm_smmu_cbar_type {
>  /* Maximum number of context banks per SMMU */
>  #define ARM_SMMU_MAX_CBS		128
> =20
> +#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
> +#define TLB_SPIN_COUNT			10
> =20
>  /* Shared driver definitions */
>  enum arm_smmu_arch_version {
> @@ -336,6 +338,8 @@ struct arm_smmu_impl {
>  	int (*cfg_probe)(struct arm_smmu_device *smmu);
>  	int (*reset)(struct arm_smmu_device *smmu);
>  	int (*init_context)(struct arm_smmu_domain *smmu_domain);
> +	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
> +			 int status);

Can't page, sync and status all be unsigned?

Thierry

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1pBSYACgkQ3SOs138+
s6GamhAAm9NP9HwE2om5HwmvNF1hvSJvdYGIs8Hb+6SK7HaysBo/UItRO7PatkiM
I3Dy8/4A8G8usJbwN7+MgFMqLU+aaEA+4iqHdAm8e/4OSZhzjiLu5/hhKAlUgCUn
booaUKUu9PdhunwyuWoS3Baz3pCTjJgGEr4BdtT/DpikFZXLzouG5r+n7bp85B8a
M3n7J3nd/1eWpPUGohLnK74ZE/rtX9p6/s9U6aJE8dwoyIulMGVlW+iV42fEfVCS
FREDgmrVme/6QjpvsHZYNtkUNcwI0DvoTsJrCUnp7m5NCpXkXTZY9YkwcYOAeeAZ
sLQ464W8Fh+s8m0ZyEmOx6TnDClrFzOyyT/CxMB+B0P7Ro/1xvDVEt/UBdsVj6cY
NIw15iqmh6y9OYxQr5xFiHm5VjOnTuKUESkUKTp5TDgoP9aAYNxJM+sOgK++3k2Q
Tw38fWKoLd3Ar6EuvnGbmVXSpqWVmfNxTS8BRUfeLtadXdrMitKO+Qlz5ZTI3GW7
A5RFA+n8dgTNQaOKgm+s1e6lm4EIvb9ifKrDziuHTW1Zvc3JBQUO8zuuctaR6IAl
mS4wyFCLdVWFQiVUM05HxdjxWGu5Dd2ZKStGAkkMt2epWtDV6Hg/WP22D0F+iYHN
4x3H7TF6Qu9D/ZkLt7wt5KjA4v6irlhrb8ZFF/rCTTRAijtUKtg=
=lYk9
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
