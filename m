Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9FFC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47A82173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrDiNZ9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390382AbfGRM7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 08:59:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42459 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390336AbfGRM7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:59:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so13597075wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xzSmfnXRcQ0lncJ4oY1al5Tz1krJ5LsMFDXPD4J+9Yg=;
        b=vrDiNZ9Rnx+Zqc1cpL3YQZDzoErYg0d+VFDXepCbcF5cGqaeFx3c5BM0tQ4QkrU+Dy
         eFw7529GaRzASlFP2QTx4bc+pWcBPFWDu83jKCCl5zrzGxW6xXSB6aB78CJM2XP/7g6G
         m4Qj9Xmmtms+/YX1I6yLI3HSgIxoQjQo6HVkQ3S2L3MccYLA3RNRhq2hYgbFhvO2XjbT
         RhPHTJqDlRmTuE2cHcHNErAT2w67a168Rqb9Dhq/MDemJRn86AupD5qAmlvHcKGLjcTX
         M/bfxIMC6vKZw+ZYxrx2/4R+pffU7qa4XIVMpKXPSyIY44DjzV9bD3Ie/idMEctL5wDk
         JkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzSmfnXRcQ0lncJ4oY1al5Tz1krJ5LsMFDXPD4J+9Yg=;
        b=dfShGhYaOrO1eWzLs8WFw1WftRPna2j8TaLMNCcHt9hUgb+GnYkzFIwm2ltGZncKVP
         eOqNIQ3oQljJ0uLan8uL8RPR+BxLIMEHKmUULILufT/SXQtbTIxKfqrXqzaSlai34wMm
         ygR0IBs1IukMSOgp2vx9Z36B8QRBzMBKK+EVuw7dOXkoOjYKa2PtClLo7PPH1MVyqisN
         EF40n/0O8r+fW95d4HJlr5dRSTluMoopHCL9NfPlVXDqxig7sap6qWpdDuzGW5sZR5Nw
         +YfWlYTcqfU5i8mW51IhbIdAsnEiaL84C50mLWffwLOc9RK6wckaID1/vE3zJHvUCVVl
         v3JA==
X-Gm-Message-State: APjAAAVKgRNBLEV1ASddeZtO+TCs3FjXvjIE5qiaffoiZdoCV05jG/90
        lMlefS54C20bBItfg6wI3yaR+xrYQygz83OfLFjr
X-Google-Smtp-Source: APXvYqx+UA6wGMTsSYyKydsHPsreGPcADwb0A3zKt9W4oWZfUbYMFYDh4XnvSlOSEREuZ5JLmfQ4N7152jaQCWuJoHM=
X-Received: by 2002:adf:a344:: with SMTP id d4mr49759564wrb.237.1563454745883;
 Thu, 18 Jul 2019 05:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190718020745.8867-1-fred@fredlawl.com> <20190718020745.8867-2-fred@fredlawl.com>
In-Reply-To: <20190718020745.8867-2-fred@fredlawl.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 18 Jul 2019 07:58:52 -0500
Message-ID: <CAErSpo5S=VyyV6Euzf7qhO0zukU_mnXqJgEhy9fwR0AYf4LTpA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Prefer pcie_capability_read_word()
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     David Airlie <airlied@linux.ie>, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 9:08 PM Frederick Lawler <fred@fredlawl.com> wrote:
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

> -                               pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
> +                               pcie_capability_read_word(adev->pdev,
> +                                                         PCI_EXP_LNKCTL2,
> +                                                         &tmp16);
>                                 tmp16 &= ~((1 << 4) | (7 << 9));
>                                 tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 9)));

Same comments as for radeon.  Looks like a lot of similar code between
radeon and amdgpu.
