Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDCAC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E479206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTKns+Sd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLSMrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:47:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52728 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfLSMrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:47:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so5305158wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 04:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e2DBwRLOc0+NXX0lm+V606orQs3w/QtiskRtJFmTJpE=;
        b=PTKns+SdLLr4ZaCEfAh3ObI+jGZMo4+JOlU5CQQRWkDFIVSsPWz2iDbfKhjEq6MKIC
         aRbyCQCnk0cTs2UwulNsRgCaiGU5xFbr8ETxhumyOWd8x1/PXMy2lyyiNaGerK3cQHCZ
         QeXBFYNls7O+PoJIrEVsftRBKevjpiYvieUmujy9N2Ktd21t46Qo2yfAICnLpbqmV8sZ
         x7W+JNTruIQEteqTUii7U1vwxk7FLU6CCKbJhIp95hDFhijA9uokDokESBeuNby6NCnH
         QGAbDMuJK9ssD148eRuhFOTXZ4+6o1OxSY+LTgToJGv6UM3vYL+/4R7PHs2e8issXRYK
         N/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e2DBwRLOc0+NXX0lm+V606orQs3w/QtiskRtJFmTJpE=;
        b=Zj3F6FuoVQsjCmP9oFT/r65x3RVjvVpbBNoM+BkiVmEO1q/5udNgrFmiKLvOand3Er
         MAyv2kB/ID2Yw6aBJG8ndrPl6KMbjwLbILe9whYdksFJbHjFNZLkxbwTr+nb/OavAuHq
         JZ4TyvCvRXtWBhjZ6q9TCWojcnPxIwm3Lng4KkogkA8yOSQrcW8ttQxm3M4MfFamrt72
         7SH58zy/qQreOj7lc9TnWV1nO7SCScd06QcdRVW7kaiUl29F1Pz2Ia+psMJICAbD34VC
         zexFJ0D+OnFWdROU963H0x/uhJY5kwGzNJsVgFSHo9HXkJMAPPHUTmqMaKDkYDmGA6EB
         21Xg==
X-Gm-Message-State: APjAAAUNM3uGsiiQJpVD98GDSN1hGGDW1plIFwPeDSQZX357HZFEyc26
        URtx3p8EfvaL5VfWuP59hmM=
X-Google-Smtp-Source: APXvYqwa9Hu0h5qRLAIYGmBsvZFeHDEip3Ga9oDqR6+Q+7HjHlER5nfEI1KMGyTaWk8sZgzSPZaIvw==
X-Received: by 2002:a05:600c:2298:: with SMTP id 24mr10205863wmf.65.1576759669976;
        Thu, 19 Dec 2019 04:47:49 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id c195sm6591110wmd.45.2019.12.19.04.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 04:47:48 -0800 (PST)
Date:   Thu, 19 Dec 2019 13:47:47 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/5] iommu: intel: Use generic_iommu_put_resv_regions()
Message-ID: <20191219124747.GA1440537@ulmo>
References: <20191218134205.1271740-1-thierry.reding@gmail.com>
 <20191218134205.1271740-5-thierry.reding@gmail.com>
 <2b3020a1-221c-f86b-6440-e9ef65f0c12e@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <2b3020a1-221c-f86b-6440-e9ef65f0c12e@linux.intel.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 09:53:22AM +0800, Lu Baolu wrote:
> Please tweak the title to
>=20
> "iommu/vt-d: Use generic_iommu_put_resv_regions()"
>=20
> then,
>=20
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> Best regards,
> baolu

Joerg, do you want me to resend with this change or is it more efficient
if you fix up the subject while applying?

Thierry

> On 12/18/19 9:42 PM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Use the new standard function instead of open-coding it.
> >=20
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >   drivers/iommu/intel-iommu.c | 11 +----------
> >   1 file changed, 1 insertion(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 42966611a192..a6d5b7cf9183 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5744,15 +5744,6 @@ static void intel_iommu_get_resv_regions(struct =
device *device,
> >   	list_add_tail(&reg->list, head);
> >   }
> > -static void intel_iommu_put_resv_regions(struct device *dev,
> > -					 struct list_head *head)
> > -{
> > -	struct iommu_resv_region *entry, *next;
> > -
> > -	list_for_each_entry_safe(entry, next, head, list)
> > -		kfree(entry);
> > -}
> > -
> >   int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device=
 *dev)
> >   {
> >   	struct device_domain_info *info;
> > @@ -5987,7 +5978,7 @@ const struct iommu_ops intel_iommu_ops =3D {
> >   	.add_device		=3D intel_iommu_add_device,
> >   	.remove_device		=3D intel_iommu_remove_device,
> >   	.get_resv_regions	=3D intel_iommu_get_resv_regions,
> > -	.put_resv_regions	=3D intel_iommu_put_resv_regions,
> > +	.put_resv_regions	=3D generic_iommu_put_resv_regions,
> >   	.apply_resv_region	=3D intel_iommu_apply_resv_region,
> >   	.device_group		=3D pci_device_group,
> >   	.dev_has_feat		=3D intel_iommu_dev_has_feat,
> >=20

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl37cW8ACgkQ3SOs138+
s6HwMg//QTaq9qdL6boTSg1EAx8bgcGx/ElOv3yPZusDHrNbEG7C19YElgpyGquj
7x+Amfj9QD/8vIKJg+w2Z7VpKwUgrVyteYw+dOyFzSx5gjqLE7/r5klBFwR32/Uz
pGffIE2X3N6xtCfdzYrFt1ay9wM+cHJA0lvMy7oFX+XEOxc/eAorwm68g+UgkYAm
QigqZ/5cjjlkIkQL2FThNHnwpwd9zAhOMchjlyz+4UZv/4AvQqX0YSilx72T4JP0
3LOCto7pCGTmvv/4/E0bCOzIa+FOMZf56LLqOstqBhIoPeBWGuGNXUerZ5iV22E0
ah5RgWxHM0YwGufRGyHiJ8niUQlIuuIzFsJmjvXbDHdaIM7/tZMGRVRGNcZuINBb
5Addl123iKthkOTBBqNMoZwg9Y30E3mG07wZbH8tkZj91CRJPJ1Ui5uQsEtxlwvS
jwGcb9kVFk3PJO0AuKvDC9VTi40K1MDYW8NLAtTYV4UhLKA5XGuOWawKZWC20Q+X
88ie9W4l5+HhW9hgpSfawGdKAlOeeCzXTVmqzm8o5vaAIZ6qGnaf4peVVZ59YF70
HSty77b43BATtE0oL3ps6hzLgNMNQYSAd8hOnA1cqEwK4+wyCsRgfzx64jxyMOSB
vCaXjNxdpNsgZWqwqw5NVrsV2z3Jn/f11Wvsob4EMM5C3/ZDuVE=
=lKCJ
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
