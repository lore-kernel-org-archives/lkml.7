Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497DAC432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAD5207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="QBNbnv6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407672AbfIWWLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:11:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44138 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393454AbfIWWLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 18:11:34 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so37360551iog.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 15:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uqy59dGY4blvVGjglQKtbrenXU/K+5if5eYupyey+8k=;
        b=QBNbnv6LfU1vYUfG9fxGzxN8bkeZ+r7GkCsBwDfBzz/srW76LvSDMic4448RCNqNfz
         iwQwMLffsPuE37qEbWHO1eHL8fuCN9qvLY6yc/yazJeSW/yG1i/PMnmBtf7hTZkNKNrb
         qTdLgazsFHjNcDk4DN894LR4UzSlziTZdEgickRQJQ1a0GdeuZ121aMLazP/2DmFa1LD
         ALJ9mOA+fraK9O74bJRu/FmesFz2rfcEGWqgYSVMi4yOKKj+9DAmJVEikPJVdOs/CiLS
         LyVQ9UneHqOIYpj06lMMoqtarLolTqY27NYt3Y6AHByaYdDCThj/r+jh4gY3s6G4ldfb
         h2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uqy59dGY4blvVGjglQKtbrenXU/K+5if5eYupyey+8k=;
        b=MEvHKFi8r6BIejZJftHvywAGExYuDHwLVSxdUQZeZbqbHySZcd5GCtVxkfv5rS1ie1
         m3dPn7oIwfv9sBCjfdaEKIoN9CbcocKSoyCvNoJaZjv5mn6ah5ClH953Vx9x8floc4jK
         fDwTh6oDBAFrN04jwYz+atjRr/vM7Updaa1Y9QN01Wxdkha79jMyQf/UC0S0IzAge9T0
         ADsDZVcBb/6o6gguzfHFIIXQhuiNmdgLLMDwto+0M+4L+4pMNMwIhsiGPeQhaaR1ar26
         CIEm6NKL9f99ITb9fVkxwgVjrQLb3+bvXIkoc75Vs7XnA9YlyseOM/N1qbH8t8cs9PI9
         b8cQ==
X-Gm-Message-State: APjAAAX2cIbEm4nQ5nhrfTT7FHuICNd00CFMM7vv6DSJqC6/9CZ5LPdN
        FGxgvvy0atEZYvs1yhxFt2mP+qYkoifyXhVy/psPQg==
X-Google-Smtp-Source: APXvYqx/0kwqTbrzgZPosJDDB6xWJh7UZJ2MOHzRx9J0fsTEPUqbE+lhUSEHxL1fYdz1iEGUI7hsMKFShx7QdnO4zrY=
X-Received: by 2002:a5d:89cb:: with SMTP id a11mr1789115iot.159.1569276693582;
 Mon, 23 Sep 2019 15:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <1568567293-26894-1-git-send-email-Sanju.Mehta@amd.com>
In-Reply-To: <1568567293-26894-1-git-send-email-Sanju.Mehta@amd.com>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Mon, 23 Sep 2019 15:11:22 -0700
Message-ID: <CAPoiz9w5eFaw42SmMBoyNEACJ10QNdTL=jiduS8UbowrgwcdHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ntb_hw_amd: Add memory window support for new AMD hardware
To:     "Mehta, Sanju" <Sanju.Mehta@amd.com>
Cc:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 10:08 AM Mehta, Sanju <Sanju.Mehta@amd.com> wrote:
>
> From: Sanjay R Mehta <sanju.mehta@amd.com>
>
> The AMD new hardware uses BAR23 and BAR45 as memory windows
> as compared to previos where BAR1, BAR23 and BAR45 is used
> for memory windows.
>
> This patch add support for both AMD hardwares.

I pulled both of these patches into the ntb branch.  I am aiming for a
5.4 pull request this Wednesday.  So, please test if possible.

Thanks,
Jon

>
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c | 23 ++++++++++++++++++-----
>  drivers/ntb/hw/amd/ntb_hw_amd.h |  7 ++++++-
>  2 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index e9286cf..156c2a1 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -78,7 +78,7 @@ static int ndev_mw_to_bar(struct amd_ntb_dev *ndev, int idx)
>         if (idx < 0 || idx > ndev->mw_count)
>                 return -EINVAL;
>
> -       return 1 << idx;
> +       return ndev->dev_data->mw_idx << idx;
>  }
>
>  static int amd_ntb_mw_count(struct ntb_dev *ntb, int pidx)
> @@ -909,7 +909,7 @@ static int amd_init_ntb(struct amd_ntb_dev *ndev)
>  {
>         void __iomem *mmio = ndev->self_mmio;
>
> -       ndev->mw_count = AMD_MW_CNT;
> +       ndev->mw_count = ndev->dev_data->mw_count;
>         ndev->spad_count = AMD_SPADS_CNT;
>         ndev->db_count = AMD_DB_CNT;
>
> @@ -1069,6 +1069,8 @@ static int amd_ntb_pci_probe(struct pci_dev *pdev,
>                 goto err_ndev;
>         }
>
> +       ndev->dev_data = (struct ntb_dev_data *)id->driver_data;
> +
>         ndev_init_struct(ndev, pdev);
>
>         rc = amd_ntb_init_pci(ndev, pdev);
> @@ -1123,10 +1125,21 @@ static const struct file_operations amd_ntb_debugfs_info = {
>         .read = ndev_debugfs_read,
>  };
>
> +static const struct ntb_dev_data dev_data[] = {
> +       { /* for device 145b */
> +               .mw_count = 3,
> +               .mw_idx = 1,
> +       },
> +       { /* for device 148b */
> +               .mw_count = 2,
> +               .mw_idx = 2,
> +       },
> +};
> +
>  static const struct pci_device_id amd_ntb_pci_tbl[] = {
> -       {PCI_VDEVICE(AMD, 0x145b)},
> -       {PCI_VDEVICE(AMD, 0x148b)},
> -       {0}
> +       { PCI_VDEVICE(AMD, 0x145b), (kernel_ulong_t)&dev_data[0] },
> +       { PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
> +       { 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, amd_ntb_pci_tbl);
>
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
> index 3aac994..139a307 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.h
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
> @@ -92,7 +92,6 @@ static inline void _write64(u64 val, void __iomem *mmio)
>
>  enum {
>         /* AMD NTB Capability */
> -       AMD_MW_CNT              = 3,
>         AMD_DB_CNT              = 16,
>         AMD_MSIX_VECTOR_CNT     = 24,
>         AMD_SPADS_CNT           = 16,
> @@ -169,6 +168,11 @@ enum {
>         AMD_PEER_OFFSET         = 0x400,
>  };
>
> +struct ntb_dev_data {
> +       const unsigned char mw_count;
> +       const unsigned int mw_idx;
> +};
> +
>  struct amd_ntb_dev;
>
>  struct amd_ntb_vec {
> @@ -184,6 +188,7 @@ struct amd_ntb_dev {
>         u32 cntl_sta;
>         u32 peer_sta;
>
> +       struct ntb_dev_data *dev_data;
>         unsigned char mw_count;
>         unsigned char spad_count;
>         unsigned char db_count;
> --
> 2.7.4
>
