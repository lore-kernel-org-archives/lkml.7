Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87331C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1742085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw/peMiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfFZUXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:23:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33245 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZUXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:23:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so15994pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1sFRYli76Oa9Fpzatk5dKJj5bbhDS+hpfpOSa39CM/g=;
        b=Uw/peMiDEBTcscGvhEOaR8eZH/EpoXIst/MpQF5Zjbawytad/jS6Me0x1z4eMD1peF
         YElaFb9RYpjZgzleYOqgYfk+JTk5Tbp1vt9MH44Za+PVUbm0iaU2m5b32J4zlUgNP9Ox
         7I6JSYwfeuMn/P3zxEdbtNrf4AmWOZtib6mhwd9qGPaGQ8Qc1ZAAbFGm083lO5yReKO9
         KxH0blycJFDAveYnxoGY83lr4Ej1qBwpFGSxA+aCzPzjMJE0k7EfLuXcfpDNCg9MKtkn
         s5JoMo83/Thv4RE4c14l6FGnDG6JLk6lpq3HbSog9Qm44y4Omi6WalBMDu1C3icmw+v2
         GMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1sFRYli76Oa9Fpzatk5dKJj5bbhDS+hpfpOSa39CM/g=;
        b=VgDcSRJP0ldPVF879BIUgTeRN79IIGiwlJaNqCPCLyvbx1MC09mtTcXlRBtFIK56AN
         BxAvyYfRdLfEezZMcP0HPJRjTpQJcvvV9oAFbFWdmtw9R0xsUG7+GgKNq/rhj0+qZn4Q
         JFFmNhXX+deDQrBIjLmlyRl2MOEzDVoDhdtU+KV+pszVUxy9tJV1ql2xySR/UM7eNyki
         +o5jcbCFVExCKr9J6LMEq1pWytRJritMayOBIAjDuMJGyqyuXJHqW7bup6HcHXXu38Rv
         HjHuAvhxc3T0tbHufCFFGQ7i0tUyyzZw3Vq+QHjZjIwdjYO6fchxtcFqQ/YbijhRZm0f
         XD5w==
X-Gm-Message-State: APjAAAVk5lVeYJ8Fst/nL4fXy5CtjY0cjEixaRCrDGh3mptkkYhJ8H4/
        KQsgyBmVvHXEcUthC0I9B6Q=
X-Google-Smtp-Source: APXvYqwrOkJyA1bmUCcxC73Xdrb6sRHtJ3fe2VIjQ16DdeXFTHSVgSP92v7hi1aV0eBBAVVN5kNmYw==
X-Received: by 2002:a17:90a:3401:: with SMTP id o1mr1143077pjb.7.1561580594906;
        Wed, 26 Jun 2019 13:23:14 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id 1sm99647pfe.102.2019.06.26.13.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 13:23:14 -0700 (PDT)
Date:   Thu, 27 Jun 2019 05:23:11 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        keith.busch@intel.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH -next] nvme-pci: Make nvme_dev_pm_ops static
Message-ID: <20190626202311.GB4934@minwooim-desktop>
References: <20190626020902.38240-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190626020902.38240-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-26 10:09:02, YueHaibing wrote:
> Fix sparse warning:
> 
> drivers/nvme/host/pci.c:2926:25: warning:
>  symbol 'nvme_dev_pm_ops' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 1893520..f500133 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2923,7 +2923,7 @@ static int nvme_simple_resume(struct device *dev)
>  	return 0;
>  }
>  
> -const struct dev_pm_ops nvme_dev_pm_ops = {
> +static const struct dev_pm_ops nvme_dev_pm_ops = {
>  	.suspend	= nvme_suspend,
>  	.resume		= nvme_resume,
>  	.freeze		= nvme_simple_suspend,

IMHO, it should be in static.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
