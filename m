Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF42FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACB4214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eL0UU4Ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfKHNzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:55:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36462 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726650AbfKHNzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573221350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=POOAOo3UbsazSgAaio5sRRSw+QDs6Cpf36t92K3ueEo=;
        b=eL0UU4TsDokwgReUgGz9hcCgLDeuHl3kPrII/tVVG9PrCpA0+CbEF78SK2dKCr//eUylqB
        o50mm+CrI9oXhKD6/xUmum4y4KgqWbsHt3rSIiyJsY7o66AL/ZgrERdEIBD6CsDEw8Ko7s
        vNGHFCm8eu5mSCqyXtlg2muPh62/l+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-PSmf9Gf4McWli0-LE5bWuw-1; Fri, 08 Nov 2019 08:55:46 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DE351005500;
        Fri,  8 Nov 2019 13:55:45 +0000 (UTC)
Received: from [10.36.116.54] (ovpn-116-54.ams2.redhat.com [10.36.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D078A1001938;
        Fri,  8 Nov 2019 13:55:40 +0000 (UTC)
Subject: Re: [PATCH v7 07/11] iommu/vt-d: Add nested translation helper
 function
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-8-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <162b418a-dea3-eabb-1833-a8cd56ab829f@redhat.com>
Date:   Fri, 8 Nov 2019 14:55:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1571946904-86776-8-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: PSmf9Gf4McWli0-LE5bWuw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 10/24/19 9:55 PM, Jacob Pan wrote:
> Nested translation mode is supported in VT-d 3.0 Spec.CH 3.8.
> With PASID granular translation type set to 0x11b, translation
> result from the first level(FL) also subject to a second level(SL)
> page table translation. This mode is used for SVA virtualization,
> where FL performs guest virtual to guest physical translation and
> SL performs guest physical to host physical translation.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>  drivers/iommu/intel-pasid.c | 207 ++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/iommu/intel-pasid.h |  12 +++
>  2 files changed, 219 insertions(+)
>=20
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index ffbd416ed3b8..f846a907cfcf 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -415,6 +415,76 @@ pasid_set_flpm(struct pasid_entry *pe, u64 value)
>  =09pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
>  }
> =20
> +/*
> + * Setup the Extended Memory Type(EMT) field (Bits 91-93)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_emt(struct pasid_entry *pe, u64 value)
> +{
> +=09pasid_set_bits(&pe->val[1], GENMASK_ULL(29, 27), value << 27);
> +}
> +
> +/*
> + * Setup the Page Attribute Table (PAT) field (Bits 96-127)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_pat(struct pasid_entry *pe, u64 value)
> +{
> +=09pasid_set_bits(&pe->val[1], GENMASK_ULL(63, 32), value << 27);
> +}
> +
> +/*
> + * Setup the Cache Disable (CD) field (Bit 89)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_cd(struct pasid_entry *pe)
> +{
> +=09pasid_set_bits(&pe->val[1], 1 << 25, 1);
should be pasid_set_bits(&pe->val[1], 1 << 25, 1 << 25);
and same for below individual bit settings.

a macro could be introduced, taking the offset (up to 511) and the size
and this would automatically select the right pe->val[n] and convert the
offset into a 64b one. I think the readability would be improved versus
the spec.

Not related to this patch but it may be worth to "&" the "bits" value
with the mask to avoid any wrong value to overwrite other fields?

> +}
> +
> +/*
> + * Setup the Extended Memory Type Enable (EMTE) field (Bit 90)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_emte(struct pasid_entry *pe)
> +{
> +=09pasid_set_bits(&pe->val[1], 1 << 26, 1);
> +}
> +
> +/*
> + * Setup the Extended Access Flag Enable (EAFE) field (Bit 135)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_eafe(struct pasid_entry *pe)
> +{
> +=09pasid_set_bits(&pe->val[2], 1 << 7, 1);> +}
> +
> +/*
> + * Setup the Page-level Cache Disable (PCD) field (Bit 95)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_pcd(struct pasid_entry *pe)
> +{
> +=09pasid_set_bits(&pe->val[1], 1 << 31, 1);
> +}
> +
> +/*
> + * Setup the Page-level Write-Through (PWT)) field (Bit 94)
> + * of a scalable mode PASID entry.
> + */
> +static inline void
> +pasid_set_pwt(struct pasid_entry *pe)
> +{
> +=09pasid_set_bits(&pe->val[1], 1 << 30, 1);
> +}
> +
>  static void
>  pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
>  =09=09=09=09    u16 did, int pasid)
> @@ -647,3 +717,140 @@ int intel_pasid_setup_pass_through(struct intel_iom=
mu *iommu,
> =20
>  =09return 0;
>  }
> +
> +static int intel_pasid_setup_bind_data(struct intel_iommu *iommu,
> +=09=09=09=09struct pasid_entry *pte,
> +=09=09=09=09struct iommu_gpasid_bind_data_vtd *pasid_data)
> +{
> +=09/*
> +=09 * Not all guest PASID table entry fields are passed down during bind=
,
> +=09 * here we only set up the ones that are dependent on guest settings.
> +=09 * Execution related bits such as NXE, SMEP are not meaningful to IOM=
MU,
> +=09 * therefore not set. Other fields, such as snoop related, are set ba=
sed
> +=09 * on host needs regardless of  guest settings.
> +=09 */
> +=09if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_SRE) {
> +=09=09if (!ecap_srs(iommu->ecap)) {
> +=09=09=09pr_err("No supervisor request support on %s\n",
> +=09=09=09       iommu->name);
> +=09=09=09return -EINVAL;
> +=09=09}
> +=09=09pasid_set_sre(pte);
> +=09}
> +
> +=09if ((pasid_data->flags & IOMMU_SVA_VTD_GPASID_EAFE) && ecap_eafs(iomm=
u->ecap))
> +=09=09pasid_set_eafe(pte);
> +
> +=09if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EMTE) {
> +=09=09pasid_set_emte(pte);
> +=09=09pasid_set_emt(pte, pasid_data->emt);
> +=09}
> +
> +=09/*
> +=09 * Memory type is only applicable to devices inside processor coheren=
t
> +=09 * domain. PCIe devices are not included. We can skip the rest of the
> +=09 * flags if IOMMU does not support MTS.
> +=09 */
> +=09if (!ecap_mts(iommu->ecap)) {
> +=09=09pr_info("%s does not support memory type bind guest PASID\n",
> +=09=09=09iommu->name);
> +=09=09return 0;
> +=09}
> +
> +=09if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_PCD)
> +=09=09pasid_set_pcd(pte);
> +=09if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_PWT)
> +=09=09pasid_set_pwt(pte);
> +=09if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_CD)
> +=09=09pasid_set_cd(pte);
> +=09pasid_set_pat(pte, pasid_data->pat);
> +
> +=09return 0;
> +
> +}
> +
> +/**
> + * intel_pasid_setup_nested() - Set up PASID entry for nested translatio=
n
> + * which is used for vSVA. The first level page tables are used for
> + * GVA-GPA translation in the guest, second level page tables are used
> + * for GPA to HPA translation.
> + *
> + * @iommu:      Iommu which the device belong to
belongs
> + * @dev:        Device to be set up for translation
> + * @gpgd:       FLPTPTR: First Level Page translation pointer in GPA
> + * @pasid:      PASID to be programmed in the device PASID table
> + * @pasid_data: Additional PASID info from the guest bind request
> + * @domain:     Domain info for setting up second level page tables
> + * @addr_width: Address width of the first level (guest)
> + */
> +int intel_pasid_setup_nested(struct intel_iommu *iommu,
> +=09=09=09struct device *dev, pgd_t *gpgd,
> +=09=09=09int pasid, struct iommu_gpasid_bind_data_vtd *pasid_data,
> +=09=09=09struct dmar_domain *domain,
> +=09=09=09int addr_width)
> +{
> +=09struct pasid_entry *pte;
> +=09struct dma_pte *pgd;
> +=09u64 pgd_val;
> +=09int agaw;
> +=09u16 did;
> +
> +=09if (!ecap_nest(iommu->ecap)) {
> +=09=09pr_err("IOMMU: %s: No nested translation support\n",
> +=09=09       iommu->name);
> +=09=09return -EINVAL;
> +=09}
> +
> +=09pte =3D intel_pasid_get_entry(dev, pasid);
> +=09if (WARN_ON(!pte))
> +=09=09return -EINVAL;
> +
> +=09pasid_clear_entry(pte);
> +
> +=09/* Sanity checking performed by caller to make sure address
> +=09 * width matching in two dimensions:
s/matching/match
> +=09 * 1. CPU vs. IOMMU
> +=09 * 2. Guest vs. Host.
> +=09 */
> +=09switch (addr_width) {
> +=09case 57:
> +=09=09pasid_set_flpm(pte, 1);
> +=09=09break;
> +=09case 48:
> +=09=09pasid_set_flpm(pte, 0);
> +=09=09break;
> +=09default:
> +=09=09dev_err(dev, "Invalid paging mode %d\n", addr_width);
> +=09=09return -EINVAL;
> +=09}
> +
> +=09pasid_set_flptr(pte, (u64)gpgd);
> +
> +=09intel_pasid_setup_bind_data(iommu, pte, pasid_data);
> +
> +=09/* Setup the second level based on the given domain */
> +=09pgd =3D domain->pgd;
> +
> +=09for (agaw =3D domain->agaw; agaw !=3D iommu->agaw; agaw--) {
> +=09=09pgd =3D phys_to_virt(dma_pte_addr(pgd));
> +=09=09if (!dma_pte_present(pgd)) {
> +=09=09=09dev_err(dev, "Invalid domain page table\n");
> +=09=09=09return -EINVAL;
> +=09=09}
> +=09}
> +=09pgd_val =3D virt_to_phys(pgd);
> +=09pasid_set_slptr(pte, pgd_val);
> +=09pasid_set_fault_enable(pte);
> +
> +=09did =3D domain->iommu_did[iommu->seq_id];
> +=09pasid_set_domain_id(pte, did);
> +
> +=09pasid_set_address_width(pte, agaw);
> +=09pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
> +
> +=09pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
> +=09pasid_set_present(pte);
> +=09pasid_flush_caches(iommu, pte, pasid, did);
> +
> +=09return 0;
> +}
> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
> index e413e884e685..09c85db73b77 100644
> --- a/drivers/iommu/intel-pasid.h
> +++ b/drivers/iommu/intel-pasid.h
> @@ -46,6 +46,7 @@
>   * to vmalloc or even module mappings.
>   */
>  #define PASID_FLAG_SUPERVISOR_MODE=09BIT(0)
> +#define PASID_FLAG_NESTED=09=09BIT(1)
> =20
>  struct pasid_dir_entry {
>  =09u64 val;
> @@ -55,6 +56,11 @@ struct pasid_entry {
>  =09u64 val[8];
>  };
> =20
> +#define PASID_ENTRY_PGTT_FL_ONLY=09(1)
> +#define PASID_ENTRY_PGTT_SL_ONLY=09(2)
> +#define PASID_ENTRY_PGTT_NESTED=09=09(3)
> +#define PASID_ENTRY_PGTT_PT=09=09(4)
> +
>  /* The representative of a PASID table */
>  struct pasid_table {
>  =09void=09=09=09*table;=09=09/* pasid table pointer */
> @@ -103,6 +109,12 @@ int intel_pasid_setup_second_level(struct intel_iomm=
u *iommu,
>  int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>  =09=09=09=09   struct dmar_domain *domain,
>  =09=09=09=09   struct device *dev, int pasid);
> +int intel_pasid_setup_nested(struct intel_iommu *iommu,
> +=09=09=09struct device *dev, pgd_t *pgd,
> +=09=09=09int pasid,
> +=09=09=09struct iommu_gpasid_bind_data_vtd *pasid_data,
> +=09=09=09struct dmar_domain *domain,
> +=09=09=09int addr_width);
>  void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
>  =09=09=09=09 struct device *dev, int pasid);
>  int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
>=20
Thanks

Eric

