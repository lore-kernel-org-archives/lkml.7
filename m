Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9109BC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DE5204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbfFYKz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:55:28 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:35782 "EHLO
        15.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfFYKz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:55:27 -0400
X-Greylist: delayed 8391 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 06:55:26 EDT
Received: from player158.ha.ovh.net (unknown [10.108.35.13])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 9356624018A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 10:26:15 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
        (Authenticated sender: clg@kaod.org)
        by player158.ha.ovh.net (Postfix) with ESMTPSA id 6000D71B0092;
        Tue, 25 Jun 2019 08:26:05 +0000 (UTC)
Subject: Re: [PATCH 1/4] powerpc/powernv: remove the unused pnv_pci_set_p2p
 function
To:     Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190625081512.16704-1-hch@lst.de>
 <20190625081512.16704-2-hch@lst.de>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <113fb518-0f5a-8ced-8391-abe48869a0cb@kaod.org>
Date:   Tue, 25 Jun 2019 10:26:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190625081512.16704-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15755561823041391383
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeggddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

On 25/06/2019 10:15, Christoph Hellwig wrote:
> This function has never been used anywhere in the kernel tree since it
> was added to the tree.  We also now have proper PCIe P2P APIs in the core
> kernel, and any new P2P support should be using those.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/include/asm/opal.h            |  7 --
>  arch/powerpc/include/asm/pnv-pci.h         |  2 -
>  arch/powerpc/platforms/powernv/opal-call.c |  1 -
>  arch/powerpc/platforms/powernv/pci.c       | 74 ----------------------
>  arch/powerpc/platforms/powernv/pci.h       |  5 --
>  5 files changed, 89 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 4cc37e708bc7..7b0bc104a89c 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -280,13 +280,6 @@ int64_t opal_xive_allocate_irq(uint32_t chip_id);
>  int64_t opal_xive_free_irq(uint32_t girq);
>  int64_t opal_xive_sync(uint32_t type, uint32_t id);
>  int64_t opal_xive_dump(uint32_t type, uint32_t id);
> -int64_t opal_xive_get_queue_state(uint64_t vp, uint32_t prio,
> -				  __be32 *out_qtoggle,
> -				  __be32 *out_qindex);
> -int64_t opal_xive_set_queue_state(uint64_t vp, uint32_t prio,
> -				  uint32_t qtoggle,
> -				  uint32_t qindex);
> -int64_t opal_xive_get_vp_state(uint64_t vp, __be64 *out_w01);


This hunk seems unrelated.

These OPAL calls are new. They are used by the XIVE KVM device 
to get/set the interrupt controller state of a guest. 


>  int64_t opal_pci_set_p2p(uint64_t phb_init, uint64_t phb_target,
>  			uint64_t desc, uint16_t pe_number);

I suppose this is the one ^ you wanted to remove.

Cheers,

C. 



>  
> diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
> index 630eb8b1b7ed..9fcb0bc462c6 100644
> --- a/arch/powerpc/include/asm/pnv-pci.h
> +++ b/arch/powerpc/include/asm/pnv-pci.h
> @@ -26,8 +26,6 @@ extern int pnv_pci_get_presence_state(uint64_t id, uint8_t *state);
>  extern int pnv_pci_get_power_state(uint64_t id, uint8_t *state);
>  extern int pnv_pci_set_power_state(uint64_t id, uint8_t state,
>  				   struct opal_msg *msg);
> -extern int pnv_pci_set_p2p(struct pci_dev *initiator, struct pci_dev *target,
> -			   u64 desc);
>  
>  extern int pnv_pci_enable_tunnel(struct pci_dev *dev, uint64_t *asnind);
>  extern int pnv_pci_disable_tunnel(struct pci_dev *dev);
> diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
> index 36c8fa3647a2..29ca523c1c79 100644
> --- a/arch/powerpc/platforms/powernv/opal-call.c
> +++ b/arch/powerpc/platforms/powernv/opal-call.c
> @@ -273,7 +273,6 @@ OPAL_CALL(opal_npu_map_lpar,			OPAL_NPU_MAP_LPAR);
>  OPAL_CALL(opal_imc_counters_init,		OPAL_IMC_COUNTERS_INIT);
>  OPAL_CALL(opal_imc_counters_start,		OPAL_IMC_COUNTERS_START);
>  OPAL_CALL(opal_imc_counters_stop,		OPAL_IMC_COUNTERS_STOP);
> -OPAL_CALL(opal_pci_set_p2p,			OPAL_PCI_SET_P2P);
>  OPAL_CALL(opal_get_powercap,			OPAL_GET_POWERCAP);
>  OPAL_CALL(opal_set_powercap,			OPAL_SET_POWERCAP);
>  OPAL_CALL(opal_get_power_shift_ratio,		OPAL_GET_POWER_SHIFT_RATIO);
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index ef9448a907c6..8d28f2932c3b 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -38,7 +38,6 @@
>  #include "powernv.h"
>  #include "pci.h"
>  
> -static DEFINE_MUTEX(p2p_mutex);
>  static DEFINE_MUTEX(tunnel_mutex);
>  
>  int pnv_pci_get_slot_id(struct device_node *np, uint64_t *id)
> @@ -861,79 +860,6 @@ void pnv_pci_dma_bus_setup(struct pci_bus *bus)
>  	}
>  }
>  
> -int pnv_pci_set_p2p(struct pci_dev *initiator, struct pci_dev *target, u64 desc)
> -{
> -	struct pci_controller *hose;
> -	struct pnv_phb *phb_init, *phb_target;
> -	struct pnv_ioda_pe *pe_init;
> -	int rc;
> -
> -	if (!opal_check_token(OPAL_PCI_SET_P2P))
> -		return -ENXIO;
> -
> -	hose = pci_bus_to_host(initiator->bus);
> -	phb_init = hose->private_data;
> -
> -	hose = pci_bus_to_host(target->bus);
> -	phb_target = hose->private_data;
> -
> -	pe_init = pnv_ioda_get_pe(initiator);
> -	if (!pe_init)
> -		return -ENODEV;
> -
> -	/*
> -	 * Configuring the initiator's PHB requires to adjust its
> -	 * TVE#1 setting. Since the same device can be an initiator
> -	 * several times for different target devices, we need to keep
> -	 * a reference count to know when we can restore the default
> -	 * bypass setting on its TVE#1 when disabling. Opal is not
> -	 * tracking PE states, so we add a reference count on the PE
> -	 * in linux.
> -	 *
> -	 * For the target, the configuration is per PHB, so we keep a
> -	 * target reference count on the PHB.
> -	 */
> -	mutex_lock(&p2p_mutex);
> -
> -	if (desc & OPAL_PCI_P2P_ENABLE) {
> -		/* always go to opal to validate the configuration */
> -		rc = opal_pci_set_p2p(phb_init->opal_id, phb_target->opal_id,
> -				      desc, pe_init->pe_number);
> -
> -		if (rc != OPAL_SUCCESS) {
> -			rc = -EIO;
> -			goto out;
> -		}
> -
> -		pe_init->p2p_initiator_count++;
> -		phb_target->p2p_target_count++;
> -	} else {
> -		if (!pe_init->p2p_initiator_count ||
> -			!phb_target->p2p_target_count) {
> -			rc = -EINVAL;
> -			goto out;
> -		}
> -
> -		if (--pe_init->p2p_initiator_count == 0)
> -			pnv_pci_ioda2_set_bypass(pe_init, true);
> -
> -		if (--phb_target->p2p_target_count == 0) {
> -			rc = opal_pci_set_p2p(phb_init->opal_id,
> -					      phb_target->opal_id, desc,
> -					      pe_init->pe_number);
> -			if (rc != OPAL_SUCCESS) {
> -				rc = -EIO;
> -				goto out;
> -			}
> -		}
> -	}
> -	rc = 0;
> -out:
> -	mutex_unlock(&p2p_mutex);
> -	return rc;
> -}
> -EXPORT_SYMBOL_GPL(pnv_pci_set_p2p);
> -
>  struct device_node *pnv_pci_get_phb_node(struct pci_dev *dev)
>  {
>  	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index be26ab3d99e0..4f11c077af62 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -79,9 +79,6 @@ struct pnv_ioda_pe {
>  	struct pnv_ioda_pe	*master;
>  	struct list_head	slaves;
>  
> -	/* PCI peer-to-peer*/
> -	int			p2p_initiator_count;
> -
>  	/* Link in list of PE#s */
>  	struct list_head	list;
>  };
> @@ -172,8 +169,6 @@ struct pnv_phb {
>  	/* PHB and hub diagnostics */
>  	unsigned int		diag_data_size;
>  	u8			*diag_data;
> -
> -	int p2p_target_count;
>  };
>  
>  extern struct pci_ops pnv_pci_ops;
> 

