Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD81C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6D42064B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwVLkyUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfFUBrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:47:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42058 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUBrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:47:19 -0400
Received: by mail-io1-f68.google.com with SMTP id u19so202675ior.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9yrO084oxG4dfNiDRfSabLfvEkBQAcPHS7taeQ/jeGI=;
        b=YwVLkyUOFNcOL0L8d9UZznf+xeeBIZ3g7ZUlrHDcDXBqLeWn0K9Nh1qZw9MCgGaBqb
         bsZDq3fFnLiUXnPvImtfor3a/phBY9+2zH+Do1BBqFhffuGg56NP49qLr/2sqGmf4RoD
         dBPVR54f6mQoB6gvXOLPeez5jvChN+nQ+jpNmWMt+CFi5AMLJhrJuktKhq3OI26jj6DA
         GrvQT8G1lfOsQWFP47xVxQLMf3WpyB4aq7PWUKYCOwYSjf13bJjzA0lXyuF7XawLdCyO
         7WDd+DM8NXTV1ediGy1tO6AcrJnwj7GMoiz5G4IZu2FIiAPzcKTPqdpqyD0E407nmjBU
         ZlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yrO084oxG4dfNiDRfSabLfvEkBQAcPHS7taeQ/jeGI=;
        b=Us3xO+nGWTWBWto8YEa5yzjb72tLojUOxFJzOlS7/+dExxaSsn2rgtKIybeoEovP/F
         dw+n8a9rCAE+yG3n31RBvqCR5wgnYQYrpa2dGobDbipji341perJjUU7l2C4EmO9htXy
         tPE3M3BljNha4VS/iJwck7nTGRDQhLMmdNfssI2tH6QtMxiohfmAZNaYSRc3SiOizNDZ
         hPNlmE6NpC/7r/2LTZIjVOPajN3NitJq/ML6ZK6YMrYMLSLrI2Du4Eq6/64dk+wmPiQx
         NmAhC0EQba28osgeF/ZNIg5K3s0+MrrJaphjMNPJNISvZ6QFBQhoS0ySS84L2n8cmnqs
         4hRg==
X-Gm-Message-State: APjAAAWk1NcZAmH8T9EKtsd7SBYrPaZmwdQ5T3p+NRm23IhHg6AW9IJI
        9B4Y0zarLjVs9YldTRubNfxl3lAYI0LdV/EbrFxkxQ==
X-Google-Smtp-Source: APXvYqxR8Ec8V67QRIv0YSxrqeF2qZ0ENo0zWc+r/BTUyQHPOeP071K+gI3WACD+zZ/Y6TZ2ZUXUkDwEBHuqzlrfHGY=
X-Received: by 2002:a5d:8497:: with SMTP id t23mr6017508iom.298.1561081638030;
 Thu, 20 Jun 2019 18:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190523074924.19659-1-hch@lst.de> <20190523074924.19659-3-hch@lst.de>
In-Reply-To: <20190523074924.19659-3-hch@lst.de>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Fri, 21 Jun 2019 11:47:07 +1000
Message-ID: <CAOSf1CFu_T=7weW0eagzjTc8474ntVx1uCKdQh8sX85bfaPxCQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] powerpc/powernv: remove the unused tunneling exports
To:     Christoph Hellwig <hch@lst.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 5:51 PM Christoph Hellwig <hch@lst.de> wrote:
>
> These have been unused ever since they've been added to the kernel.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/include/asm/pnv-pci.h        |  4 --
>  arch/powerpc/platforms/powernv/pci-ioda.c |  4 +-
>  arch/powerpc/platforms/powernv/pci.c      | 71 -----------------------
>  arch/powerpc/platforms/powernv/pci.h      |  1 -
>  4 files changed, 3 insertions(+), 77 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
> index 9fcb0bc462c6..1ab4b0111abc 100644
> --- a/arch/powerpc/include/asm/pnv-pci.h
> +++ b/arch/powerpc/include/asm/pnv-pci.h
> @@ -27,12 +27,8 @@ extern int pnv_pci_get_power_state(uint64_t id, uint8_t *state);
>  extern int pnv_pci_set_power_state(uint64_t id, uint8_t state,
>                                    struct opal_msg *msg);
>
> -extern int pnv_pci_enable_tunnel(struct pci_dev *dev, uint64_t *asnind);
> -extern int pnv_pci_disable_tunnel(struct pci_dev *dev);
>  extern int pnv_pci_set_tunnel_bar(struct pci_dev *dev, uint64_t addr,
>                                   int enable);
> -extern int pnv_pci_get_as_notify_info(struct task_struct *task, u32 *lpid,
> -                                     u32 *pid, u32 *tid);

IIRC as-notify was for CAPI which has an in-tree driver (cxl). Fred or
Andrew (+cc), what's going on with this? Will it ever see the light of
day?

>  int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
>  int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
>                            unsigned int virq);
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 126602b4e399..6b0caa2d0425 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -54,6 +54,8 @@
>  static const char * const pnv_phb_names[] = { "IODA1", "IODA2", "NPU_NVLINK",
>                                               "NPU_OCAPI" };
>
> +static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
> +
>  void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
>                             const char *fmt, ...)
>  {
> @@ -2360,7 +2362,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
>         return 0;
>  }
>
> -void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
> +static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
>  {
>         uint16_t window_id = (pe->pe_number << 1 ) + 1;
>         int64_t rc;
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index 8d28f2932c3b..fc69f5611020 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -868,54 +868,6 @@ struct device_node *pnv_pci_get_phb_node(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pnv_pci_get_phb_node);
>
> -int pnv_pci_enable_tunnel(struct pci_dev *dev, u64 *asnind)
> -{
> -       struct device_node *np;
> -       const __be32 *prop;
> -       struct pnv_ioda_pe *pe;
> -       uint16_t window_id;
> -       int rc;
> -
> -       if (!radix_enabled())
> -               return -ENXIO;
> -
> -       if (!(np = pnv_pci_get_phb_node(dev)))
> -               return -ENXIO;
> -
> -       prop = of_get_property(np, "ibm,phb-indications", NULL);
> -       of_node_put(np);
> -
> -       if (!prop || !prop[1])
> -               return -ENXIO;
> -
> -       *asnind = (u64)be32_to_cpu(prop[1]);
> -       pe = pnv_ioda_get_pe(dev);
> -       if (!pe)
> -               return -ENODEV;
> -
> -       /* Increase real window size to accept as_notify messages. */
> -       window_id = (pe->pe_number << 1 ) + 1;
> -       rc = opal_pci_map_pe_dma_window_real(pe->phb->opal_id, pe->pe_number,
> -                                            window_id, pe->tce_bypass_base,
> -                                            (uint64_t)1 << 48);
> -       return opal_error_code(rc);
> -}
> -EXPORT_SYMBOL_GPL(pnv_pci_enable_tunnel);
> -
> -int pnv_pci_disable_tunnel(struct pci_dev *dev)
> -{
> -       struct pnv_ioda_pe *pe;
> -
> -       pe = pnv_ioda_get_pe(dev);
> -       if (!pe)
> -               return -ENODEV;
> -
> -       /* Restore default real window size. */
> -       pnv_pci_ioda2_set_bypass(pe, true);
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(pnv_pci_disable_tunnel);
> -
>  int pnv_pci_set_tunnel_bar(struct pci_dev *dev, u64 addr, int enable)
>  {
>         __be64 val;
> @@ -970,29 +922,6 @@ int pnv_pci_set_tunnel_bar(struct pci_dev *dev, u64 addr, int enable)
>  }
>  EXPORT_SYMBOL_GPL(pnv_pci_set_tunnel_bar);
>
> -#ifdef CONFIG_PPC64    /* for thread.tidr */
> -int pnv_pci_get_as_notify_info(struct task_struct *task, u32 *lpid, u32 *pid,
> -                              u32 *tid)
> -{
> -       struct mm_struct *mm = NULL;
> -
> -       if (task == NULL)
> -               return -EINVAL;
> -
> -       mm = get_task_mm(task);
> -       if (mm == NULL)
> -               return -EINVAL;
> -
> -       *pid = mm->context.id;
> -       mmput(mm);
> -
> -       *tid = task->thread.tidr;
> -       *lpid = mfspr(SPRN_LPID);
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(pnv_pci_get_as_notify_info);
> -#endif
> -
>  void pnv_pci_shutdown(void)
>  {
>         struct pci_controller *hose;
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 4f11c077af62..469c24463247 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -195,7 +195,6 @@ extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
>  extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
>  extern struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev);
>  extern void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq);
> -extern void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
>  extern unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
>                 __u64 window_size, __u32 levels);
>  extern int pnv_eeh_post_init(void);
> --
> 2.20.1
>
