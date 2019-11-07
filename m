Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF24C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D16214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfKGWaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:30:13 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43178 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKGWaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:30:13 -0500
Received: by mail-vs1-f66.google.com with SMTP id b16so2437946vso.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 14:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQ0SrO3dITmGH2wZR3g08xc5evdpWQ6iyAkniXzubyc=;
        b=KpTaP1b+dA+LR2zt4VW2VQjPWGyIa/hYbFyJse+YBoGzZ95RpcKIGKomsl1yaoSpUh
         V45B7lk7ArFSs463oIofCvU9lJ6WEjz7mBotO8+J0JNN8g8gE2oJ37Wj3sJXGeKgt063
         zJNhKCuT8VX8BKrH1TH2xkH2IHdBF5ofm2MexYdfJwZGQQffOH1HHyz4gWbg58oCYOdX
         lXQuxuWJQtc3u/ICWhAKxemqtM4BhlbZ6ewhuxA9M0+F6xeFt5nSPncy8POOlqr24FtH
         krL0oelX6l300lnXXS+XuhFAwlB3KVzbbjlFMLG7lH9tt0P7S9o/2SCMpKjVJh1FYc4v
         sQ4g==
X-Gm-Message-State: APjAAAUMHxWYmS3WlfQNqxl7lvDelGChYEJhRBrV4pnV/1WmxT1sMl6d
        zupr5MO/KISZri5Gdy+7A4JMdk/76O7WHyQ0/4c=
X-Google-Smtp-Source: APXvYqx+0YYj1qicJQzcMmSuWAbQhYtQOfKUaHzL7hihlQo4nKnVfbKr51BSFP9Wu+thLR0rcwMoi5j6PGWSsYVAAVY=
X-Received: by 2002:a67:2e90:: with SMTP id u138mr5178874vsu.207.1573165811657;
 Thu, 07 Nov 2019 14:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20191107222047.125496-1-helgaas@kernel.org> <20191107222047.125496-2-helgaas@kernel.org>
In-Reply-To: <20191107222047.125496-2-helgaas@kernel.org>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Thu, 7 Nov 2019 17:30:00 -0500
Message-ID: <CAKb7Uvjj+18cAFW+yBEHWkJLXVTHVMW=zJ-V+uqpzdbcEKsHrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: replace Compliance/Margin magic numbers with
 PCI_EXP_LNKCTL2 definitions
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frederick Lawler <fred@fredlawl.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 5:21 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 29d6e93fd15e..03446be8a7be 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -673,6 +673,8 @@
>  #define  PCI_EXP_LNKCTL2_TLS_8_0GT     0x0003 /* Supported Speed 8GT/s */
>  #define  PCI_EXP_LNKCTL2_TLS_16_0GT    0x0004 /* Supported Speed 16GT/s */
>  #define  PCI_EXP_LNKCTL2_TLS_32_0GT    0x0005 /* Supported Speed 32GT/s */
> +#define  PCI_EXP_LNKCTL2_ENTER_COMP    0x0010 /* Enter Compliance */
> +#define  PCI_EXP_LNKCTL2_TX_MARGIN     0x0380 /* Enter Compliance */

Without commenting on the meat of the patch, this comment should
probably read "Transmit Margin" or something along those lines?

  -ilia
