Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D385C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A93D21783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKTvE4/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390267AbfGRMoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 08:44:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53418 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfGRMoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:44:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so25455260wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 05:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WS8vnU3ecan2i1/OO2Y6tvR1DOXqFiFRTJBV+WH4b/w=;
        b=bKTvE4/D/KmSbeF6nrjTCwRz8hhg3QS8GznTxNG/CLtsGsLYHz0dGnheWET4t0ieMf
         EqkwC2yqIr2Sdpjg00rJCVcis9lPCPoqwkCPrEAsPbPwg0oYh5By4Ety6Ht/5BQnwtjA
         OLgCOVzZkWXQ3iRFGvXzDroyw0W1eQwhlU+TDbQcEU2SidQk/coEwR4MXoesOYQb7v23
         X2+bq4ULoDhsOcJ3qoVHn4C4WTCnIvBltBw7s9MhVGzqbCMasPk4HaTfS5j8/vvMxFNR
         xfMWQokZSRr4JnvLavp4BL1WCopvjvep+JRalJUVfs1083oCHqluHzzXLm3R0INnBRME
         sD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WS8vnU3ecan2i1/OO2Y6tvR1DOXqFiFRTJBV+WH4b/w=;
        b=X57R+/hXk2vmSHxrhCEeFQ/QeJrIWCDAVgvTFmPMwaGGNMZHFCu/Z7wnWlnTj7J/hH
         Xd0lffKoUWNug+P+4FB6uDGTKLHQrchrZRqjUPxRgxfUIjjryIiOAUPhly92xNPxWMYn
         xpSfC0EhL7kDiT9sD2R/Qym3cCukt1lS83mKfiw6uXO3YMACglHMTlHDYh5Do/5tjTWb
         83kCu5i4YGzqto42aOGya5rBJeHuqAL2nmIVR1eAAtu7BeTsxAOyaMLP8mZUP4+2gQFl
         nK1rsQq/JxlJ0Emo7BwxEujYRq6cxMXI4iB4Dr+trEHy63H4R4eYJaJ0Odc/+McS7tdU
         yakw==
X-Gm-Message-State: APjAAAWjfgoX305PsQb+K2qqFlmwYnndxcR6TNsUC0xfwJ6Md2zrTF+5
        MAqqowwQ7y8XPKjOiwAOYMOl+LE2I8YVQ0QLQ/cK
X-Google-Smtp-Source: APXvYqxAlp9/0Oc6DGKMN4Zg6dm2vP1/Vu/RQWya+BHffL8c1J2ZebGwZ3HAa6YCI2fmFRbiPV1HJpRImMPRjEXm94Q=
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr43460959wmk.88.1563453845217;
 Thu, 18 Jul 2019 05:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190718020745.8867-1-fred@fredlawl.com> <20190718020745.8867-10-fred@fredlawl.com>
In-Reply-To: <20190718020745.8867-10-fred@fredlawl.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 18 Jul 2019 07:43:53 -0500
Message-ID: <CAErSpo6BmWDxi3Vckm03=fZHEUosTgkMUjqCvYRA186jv8XbFw@mail.gmail.com>
Subject: Re: [PATCH] skd: Prefer pcie_capability_read_word()
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     Jens Axboe <axboe@kernel.dk>, bvanassche@acm.org,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 9:09 PM Frederick Lawler <fred@fredlawl.com> wrote:
>
> Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")
> added accessors for the PCI Express Capability so that drivers didn't
> need to be aware of differences between v1 and v2 of the PCI
> Express Capability.
>
> Replace pci_read_config_word() and pci_write_config_word() calls with
> pcie_capability_read_word() and pcie_capability_write_word().
>
> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
> ---
>  drivers/block/skd_main.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
> index 7d3ad6c22ee5..996c38d03fc4 100644
> --- a/drivers/block/skd_main.c
> +++ b/drivers/block/skd_main.c
> @@ -3137,18 +3137,14 @@ MODULE_DEVICE_TABLE(pci, skd_pci_tbl);
>
>  static char *skd_pci_info(struct skd_device *skdev, char *str)
>  {
> -       int pcie_reg;
> -
>         strcpy(str, "PCIe (");
> -       pcie_reg = pci_find_capability(skdev->pdev, PCI_CAP_ID_EXP);
>
> -       if (pcie_reg) {
> +       if (pci_is_pcie(skdev->pdev)) {
>
>                 char lwstr[6];
>                 uint16_t pcie_lstat, lspeed, lwidth;
>
> -               pcie_reg += 0x12;
> -               pci_read_config_word(skdev->pdev, pcie_reg, &pcie_lstat);
> +               pcie_capability_read_word(skdev->pdev, 0x12, &pcie_lstat);
>                 lspeed = pcie_lstat & (0xF);
>                 lwidth = (pcie_lstat & 0x3F0) >> 4;

This should use PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_CLS, PCI_EXP_LNKSTA_NLW, etc.

Would probably make sense to do that in a separate patch so this patch
matches the other conversions to pcie_capability_read_word().
