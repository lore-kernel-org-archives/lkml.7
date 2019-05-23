Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352DFC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 23:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4A92177E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 23:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="e+/gloxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388664AbfEWX6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 19:58:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45267 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388232AbfEWX6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 19:58:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id r76so1591328lja.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 16:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=XOaG+GEFquIWc8ZqL+TFm0HU4q3YYIEJg9ZNEaLldJA=;
        b=e+/gloxcunIS64ypJ+CKWxOR6GHBOe89ee8OezcPnTixwXbrsj4kCp/H/qB/aRRzIh
         QByPd96mLzxgV0ur/42UdEdAgLZta9m8/n8uZwMOjeSb+TCAnc5IAjCkYySrExJSMb2d
         5Z95YKknKuZcNyY2ZBYmfV86byhj48xIMZADt3C/Bsyc5/tMvZzKhPLYGPDo19Yqvmjv
         Fud3GSHNHsFt1hu/P7rIEGw5vTXg2484c7fMGi49h6KWxersG0QgNTO1cpjLK/UmrfDl
         qsm3ycA+ZCK/MN4Cc9W533cBQNXDsSoSEJKuP2E1y+UuI6XDwek9p6GetycEEkiOPmfm
         YvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=XOaG+GEFquIWc8ZqL+TFm0HU4q3YYIEJg9ZNEaLldJA=;
        b=ow+atmzn+amflvzLhENbi7Y20yFAEIxr/NAi9572+aPpMc7FbMQHY6c6faLMzdJqP2
         2SoWAONsSUG71Ep+fwPAPeXqQgAMgScEGOKIH1J9NsccXzWfxpQRWb9jSgl2OyS7MZfA
         9Hac9docNZGblBpMiHye3tGUmL58R4bLAXhMyCsg/WoUudiOiPXXrpiMjlrrk+vR3DTm
         Qa6ZqQwBYVqvy0GBJkTPh8W7S51V2r1oy21NPyakbqQ+4VDAAqJPHJRGbGHEbZ9L/IQc
         vRxfvyzA2EeUbbpWzu9oYGFV9mLdyM3Y8Gjv6Y8IOwzkGlSeFa8z5dJpUBUlbOZvUZdg
         0hbA==
X-Gm-Message-State: APjAAAXtescqX8OPbjd359R5MfoDQZuyAz+cdlDP9c67bjYHhD+11csH
        u0oo/vISkS2C3amx+e2X4vtIJyGuJ0afEu42gAG3Ug==
X-Google-Smtp-Source: APXvYqz7QckuaSLcN3Ux3XggQtq3/yHHrcwrhdr4OBzCv7p72vzW4vje4uHz3AT/cEgJbPkLOntoCGlEE9G8OL+e5sI=
X-Received: by 2002:a2e:874b:: with SMTP id q11mr22243701ljj.48.1558655883455;
 Thu, 23 May 2019 16:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <1558647944-13816-1-git-send-email-alan.mikhak@sifive.com>
In-Reply-To: <1558647944-13816-1-git-send-email-alan.mikhak@sifive.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Thu, 23 May 2019 16:57:52 -0700
Message-ID: <CABEDWGyb3zTaiRqt7-mvrS6Dvhu0Fkhjp4nvaJ-vaJrD3n=0_Q@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: endpoint: Set endpoint controller pointer to null
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Bjorn Helgaas

On Thu, May 23, 2019 at 2:46 PM Alan Mikhak <alan.mikhak@sifive.com> wrote:
>
> Set endpoint controller pointer to null in pci_epc_remove_epf()
> to avoid -EBUSY on subsequent call to pci_epc_add_epf().
>
> Requires checking for null endpoint function pointer.
>
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index e4712a0f249c..2091508c1620 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -519,11 +519,12 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
>  {
>         unsigned long flags;
>
> -       if (!epc || IS_ERR(epc))
> +       if (!epc || IS_ERR(epc) || !epf)
>                 return;
>
>         spin_lock_irqsave(&epc->lock, flags);
>         list_del(&epf->list);
> +       epf->epc = NULL;
>         spin_unlock_irqrestore(&epc->lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
> --
> 2.7.4
>
