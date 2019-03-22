Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2E8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A49218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="VEEywSkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfCVWzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:55:22 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44148 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfCVWzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:55:22 -0400
Received: by mail-ot1-f65.google.com with SMTP id d24so3326887otl.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 15:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upbNMLpI0X86aVZZo1g1MqpgVhmYo1BXLtxATqKVkf8=;
        b=VEEywSkzwZT/3lo7CtHMNLfdXabMqG3hH+rKxUEerA2QMjX/xsiBzxyPNUKzSnALAc
         oZgxSbZwKAZ2Na1S5ELIzCIOJyIjOm5IMYaui3W9eI0FwrrfbSgUVlqMJ7lOnw1NykNw
         Ou/g77QqYDfye2OfBecDoTC8kEEcxkDg142KGLRCxD3OVoWuBRUX0WTmo5dMIwNNFwch
         8sqHVPqFmkrc+LLW5sPt2Ze5x+Vr9pmpitCw8kFxWwhS0HsEpejzIPFJCNm51IOrDJ8I
         8osG8u9PImVmqZyLWyQw5K1T38/pz/bKRNNK1NOWgq6YoVQc+BrxOSuHz1yUl0/wcpHt
         e1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upbNMLpI0X86aVZZo1g1MqpgVhmYo1BXLtxATqKVkf8=;
        b=aGQTvVakpUkKqpS5+yskyL57tk/zhYwI78nUruN72w9tzgc51sOb05HjXBd7TngCAz
         8MQuMhF+RJK7ITlqThhA1PgCOxpOGFd50iV0DrGEjT0HeinMrNgD9FPpRFkQApjCXgnv
         QpkPQdB0tPPXRAedJU1yVq1XoXzmT5A06kZgYMPgBpJTp00ws8r67XqGVfwFgl89fABG
         RvmArEImjWlfdP7/EoImXyiyoEf40sj3sBUpbRyRGFA7PAOJ+ZR22kquDM16NCwItP2+
         Eo7mSlrpAuD8KowUZEsaIgcJN9qoQpcq79uAFlOXcxdYPrcTgQTx7g3YE2Q0wXt60dZ1
         /vNA==
X-Gm-Message-State: APjAAAUWTAS+xNCR0WoPZR+Yg5gVPeZOCodAohHguzNEsDA2+isbhXiu
        jePiPSLVfMsAADdW1IC+BOyU7GADjUEOJlpw3YXmhsVotD0=
X-Google-Smtp-Source: APXvYqyMNOAvNKZLPPWlA48yzXu4dcwX80bxtc/3Yd3ymNieIqfD8K+g1ghQSQZci2Zs71KsgZv9Q5ssFy/ivTu2gnE=
X-Received: by 2002:a9d:224a:: with SMTP id o68mr9135935ota.214.1553295321323;
 Fri, 22 Mar 2019 15:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190312081529.4889-1-kjlu@umn.edu>
In-Reply-To: <20190312081529.4889-1-kjlu@umn.edu>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Mar 2019 15:55:10 -0700
Message-ID: <CAPcyv4jfoUCK8dCCgGRG3GPxxk2mgrQd=zpJ9OnwzngXJ+LwpA@mail.gmail.com>
Subject: Re: [PATCH] nvdimm: btt_devs: fix a NULL pointer dereference and a
 memory leak
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 1:16 AM Kangjie Lu <kjlu@umn.edu> wrote:
>
> In case kmemdup fails, the fix releases resources and returns to
> avoid the NULL pointer dereference.
> Also, the error paths in the following code should release
> resources to avoid memory leaks.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/nvdimm/btt_devs.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
> index 795ad4ff35ca..565ea0b6f765 100644
> --- a/drivers/nvdimm/btt_devs.c
> +++ b/drivers/nvdimm/btt_devs.c
> @@ -196,8 +196,13 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
>         }
>
>         nd_btt->lbasize = lbasize;
> -       if (uuid)
> +       if (uuid) {
>                 uuid = kmemdup(uuid, 16, GFP_KERNEL);
> +               if (!uuid) {
> +                       kfree(nd_btt);
> +                       return NULL;

What about nd_btt->id? That needs to be released as well.

> +               }
> +       }
>         nd_btt->uuid = uuid;
>         dev = &nd_btt->dev;
>         dev_set_name(dev, "btt%d.%d", nd_region->id, nd_btt->id);
> @@ -209,6 +214,7 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
>                 dev_dbg(&ndns->dev, "failed, already claimed by %s\n",
>                                 dev_name(ndns->claim));
>                 put_device(dev);
> +               kfree(uuid);

This will be a double free because put_device() will arrange for
nd_btt_release() to be called which does kfree(nd_btt->uuid);
