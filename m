Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B14C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFD92087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="RA8rRbG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfD2Gel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:34:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40692 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfD2Gek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:34:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id y49so5017094qta.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 23:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gl+VBxLR+GvLaPXntiUPaJTzvL30rd0oZ2WHgSedNcs=;
        b=RA8rRbG1034BWX7o4E1XRqbi+lga2VA0KM2tC+lbBBCvRzXpsOoOTXoak2ktUYXx3i
         mPlKfQGZyS1PpLgmgUT+NYxD5C9YkdzxxxC9o3fBSKPUEGLdn2VnEOnihBW9AfKADl2B
         3b3a+2m0IvZScTZRhHwa+0u5jjTOxViRNk6+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gl+VBxLR+GvLaPXntiUPaJTzvL30rd0oZ2WHgSedNcs=;
        b=DDWHmqjw1Q49x28J7B8eSaaY7PrMzP4fc6wToaP5vC0SvNZeto8Rw59xxHSXceTZOM
         UMe9tnt3lFpXwjLkg3/8dAA0tkr8jcOJByETG4MdRB5hwfmIPXcdMGJoeyL+fop57u/w
         s2/SyPru3oA02+HW1A+0ysOSi/rffwJHqlMA6sEITl8i9KZeOWhN9EgoWPKDeXMIFDtb
         6tIdG+pRZRmqkCNi7+RGoLYpYIokGD4J+lykijYPsqsnZViW0ee3qG8ceaK17R6oX0f/
         xifYh1rjqeHWiSiSoezVi3KPnA/draCO/uKYOw1Ay7RrSn5AJMevPRJia8/S4k5E9RmI
         uYjA==
X-Gm-Message-State: APjAAAV5oH9YaHOfJMK4vsKQRL3ZspvkdmOcTI4E+JgvsxuIdW7WCfKb
        inZfTxI5B+PVgkKnIJEa+4wwN/z71WwKqrdsBRM=
X-Google-Smtp-Source: APXvYqytTy2fdLvUmYedjHrz9dNMdoWzxnrks4lCz9FIJWSQW1pppC/60NhYFajTRR6X45EF3TyuzhcRlVv5SRz/TIA=
X-Received: by 2002:a0c:948e:: with SMTP id j14mr17487089qvj.245.1556519679861;
 Sun, 28 Apr 2019 23:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190426165655.218228-1-venture@google.com>
In-Reply-To: <20190426165655.218228-1-venture@google.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 29 Apr 2019 06:34:28 +0000
Message-ID: <CACPK8XcbSZCpR5tjAXTSuvhfTyeQ_dJTTDOqZVVP=VWCxkaV6g@mail.gmail.com>
Subject: Re: [PATCH] misc: aspeed-p2a-ctrl: fix mixed declarations
To:     Patrick Venture <venture@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm <arm@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 at 16:57, Patrick Venture <venture@google.com> wrote:
>
> Fix up mixed declarations and code in aspeed_p2a_mmap.
>
> Tested: Verified the build had the error and that this patch resolved it
> and there were no other warnings or build errors associated with
> compilation of this driver.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Patrick Venture <venture@google.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/misc/aspeed-p2a-ctrl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/aspeed-p2a-ctrl.c b/drivers/misc/aspeed-p2a-ctrl.c
> index 9736821972ef..b60fbeaffcbd 100644
> --- a/drivers/misc/aspeed-p2a-ctrl.c
> +++ b/drivers/misc/aspeed-p2a-ctrl.c
> @@ -100,6 +100,7 @@ static void aspeed_p2a_disable_bridge(struct aspeed_p2a_ctrl *p2a_ctrl)
>  static int aspeed_p2a_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>         unsigned long vsize;
> +       pgprot_t prot;
>         struct aspeed_p2a_user *priv = file->private_data;
>         struct aspeed_p2a_ctrl *ctrl = priv->parent;
>
> @@ -107,7 +108,7 @@ static int aspeed_p2a_mmap(struct file *file, struct vm_area_struct *vma)
>                 return -EINVAL;
>
>         vsize = vma->vm_end - vma->vm_start;
> -       pgprot_t prot = vma->vm_page_prot;
> +       prot = vma->vm_page_prot;
>
>         if (vma->vm_pgoff + vsize > ctrl->mem_base + ctrl->mem_size)
>                 return -EINVAL;
> --
> 2.21.0.593.g511ec345e18-goog
>
