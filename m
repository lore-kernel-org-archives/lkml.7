Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3949CC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1035120833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="kmCA/ecD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfEPS1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:27:48 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40154 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfEPS1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:27:47 -0400
Received: by mail-oi1-f196.google.com with SMTP id r136so3273282oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Y+Oy6YWaHW3Y5EmZplWPCzvPKWgZJckhlgjaNz/4A4=;
        b=kmCA/ecDeCxycovbrXLXCxmJKC2gNWQrig4EB41Rfpt3BcdU9SN4HillTadniXfdTw
         Bph3ZtI/7E9NtUQLrXslh4joaSt2kxFsm+CnuxdRo601rTRf2yW5e0YsyRYewIbMVuqC
         Nh1TTMxkYm86rHxldOjJC7TdcPXkBAUp3mX4sOtKgAs9elzTw+CkrRy0qug4tMPTre5E
         Ew8GoEWjdKFYwRIRuc7hNBgRkydeHzZj5yHWCVsV7TSEPuSZu+e+zhslXIrYhQyHDW0n
         /395cIUVH11nUHkt95Y2xHNeWzpfpwjcbTgToE3jP1WU9tnRzuNMH0P9a56LmR6e1aTh
         dhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Y+Oy6YWaHW3Y5EmZplWPCzvPKWgZJckhlgjaNz/4A4=;
        b=sZRlvEfW/GBZqZHO8YEoXYghy9tcv/VHxV2U9DA/O9zxaENt+k89okw/5fIDfrPqUO
         hQdkUOYx8cFDeu5aPUTdBMsSgABSi5FqmkXZOdUMJ24XQH6EQOuWC5+KYBhghgJ0/BVM
         njajN/heoYSX+ZEA7giuoxtNmjP6jua1XLkFjIb7kr2yp1kshzTzZjKRioQE+AdQcFkR
         EWKDTDto6b89tQoeSkX97xflzbHaC5VEv3nmlYOj35pH/KCz/kPCLpZoG/yfyygBE5wj
         Tw5QkgMCHnKMTBoioszbT2Jg0cDf2iKWEOL8sEN3NSOIZEibN8RT6xAcqN0OmnvROoQn
         03uQ==
X-Gm-Message-State: APjAAAV8gQEKaS/So1SIUpC7QxHk48QOltORWP8ZvlVI5qtFZzGeadxR
        zeuYckMC6KFvzzKDR/ltLnJ4GZB0LG06+ayBaGdH8Q==
X-Google-Smtp-Source: APXvYqxYBblZJBgYSIlhubthLqgDnClOs30HE4kc12ldNOKu1qTw/psxOmXhYfknENYh987lHsPCQVQZ7Gl70ZShJ34=
X-Received: by 2002:aca:dfc4:: with SMTP id w187mr11276071oig.70.1558031266988;
 Thu, 16 May 2019 11:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <1558022693-9631-1-git-send-email-cai@lca.pw>
In-Reply-To: <1558022693-9631-1-git-send-email-cai@lca.pw>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 16 May 2019 11:27:36 -0700
Message-ID: <CAPcyv4jJ4AX7OKLBMo3SSomrneRef6OB=qpBESiQwAinnM+How@mail.gmail.com>
Subject: Re: [PATCH] nvdimm: fix compilation warnings with W=1
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 9:05 AM Qian Cai <cai@lca.pw> wrote:
>
> Several places (dimm_devs.c, core.c etc) include label.h but only
> label.c uses NSINDEX_SIGNATURE, so move its definition to label.c
> instead.
>
> In file included from drivers/nvdimm/dimm_devs.c:23:
> drivers/nvdimm/label.h:41:19: warning: 'NSINDEX_SIGNATURE' defined but
> not used [-Wunused-const-variable=]
>
> Also, some places abuse "/**" which is only reserved for the kernel-doc.
>
> drivers/nvdimm/bus.c:648: warning: cannot understand function prototype:
> 'struct attribute_group nd_device_attribute_group = '
> drivers/nvdimm/bus.c:677: warning: cannot understand function prototype:
> 'struct attribute_group nd_numa_attribute_group = '
>
> Those are just some member assignments for the "struct attribute_group"
> instances and it can't be expressed in the kernel-doc.

Ah, good point, I missed that.

> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Qian Cai <cai@lca.pw>

Looks good, I'll pull this in for a post -rc1 update.
