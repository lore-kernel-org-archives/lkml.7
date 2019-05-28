Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFCCC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED5E2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iK/5LXAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfE1GKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 02:10:20 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42809 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfE1GKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 02:10:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id b18so14814264qkc.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 23:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CfzRW4N1S5mQQ9jKEqA6Swt1CN89Kjydym5ZfJt8dUU=;
        b=iK/5LXAIuLIO1C32CYwsHjikO7+xCvRY9jx7o7UCcogfiYLbP9BacScQJmso+Ya5v1
         1HueyBOqg3TriLfytDaOTDU/ZQ5RhnvMqlhl3Gw1laySJIlHispAhgo+cGDyxZqgZqTA
         R2bTx+4lIKnCAZVuF9ZuaY/PMJ4Bx8ZktZvbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CfzRW4N1S5mQQ9jKEqA6Swt1CN89Kjydym5ZfJt8dUU=;
        b=QV8tQswDbWS0fQJJYMXL40yFCunZKubmOjEtivsBUCT0hb6UnZ3QB+S6vcGeKiIhKQ
         OciBSL30WFzx23qrz5ai8ieDJiZGwkcPdwwcq+CCMkUCpW5wavPePfkbhE5RGQgAntjv
         5wmf0G1T+rCqRipXKFKOGIC0gYes45u2VmHkuYh1NE/tPgQWh59qY+3ox2zWlmEkUAVE
         aD3Iry2HT6DbVs4j68qbCBWtPxt6ByexrqRvH+4NI6JAd2EGEiKSfxCkkNCqg9DZutAG
         MY/lCFVSWMbqzdRIrCRWjmichIePs5xsvG3yh7FsqpWlHDXmzWFI0N0NbunXHKfjJWcX
         Gb/A==
X-Gm-Message-State: APjAAAWb5Hz1mUi7y2eEUwfoRG9A0pjthE55E55700jS20TivX/yc8jz
        9BbnZRKKaI8Gvyf3ntXCiJuIPx+Kygca10THJvK4+g==
X-Google-Smtp-Source: APXvYqxetHiiu8ZvaIWpXnfgto8rpHgFK3rGPtRdFeHg6oQR0w7N9F6nCetysUy/ssRqnaMDZXZDfsQ8gOXd3N9x6Ys=
X-Received: by 2002:ac8:3861:: with SMTP id r30mr4820195qtb.341.1559023818442;
 Mon, 27 May 2019 23:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190527005716.GA17015@zhanggen-UX430UQ>
In-Reply-To: <20190527005716.GA17015@zhanggen-UX430UQ>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Tue, 28 May 2019 11:44:35 +0530
Message-ID: <CA+RiK64ddLM1Uhp_neqaX3HeaGqn-b=MgK3fGzXnee-o3SAVdg@mail.gmail.com>
Subject: Re: [PATCH] mpt3sas_ctl: fix double-fetch bug in _ctl_ioctl_main()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>,
        Gen Zhang <blackgod016574@gmail.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please consider this patch as Ack-by: Suganath Prabu S
<suganath-prabu.subramani@broadcom.com>

Thanks,
Suganath.


On Mon, May 27, 2019 at 6:27 AM Gen Zhang <blackgod016574@gmail.com> wrote:
>
> In _ctl_ioctl_main(), 'ioctl_header' is fetched the first time from
> userspace. 'ioctl_header.ioc_number' is then checked. The legal result
> is saved to 'ioc'. Then, in condition MPT3COMMAND, the whole struct is
> fetched again from the userspace. Then _ctl_do_mpt_command() is called,
> 'ioc' and 'karg' as inputs.
>
> However, a malicious user can change the 'ioc_number' between the two
> fetches, which will cause a potential security issues.  Moreover, a
> malicious user can provide a valid 'ioc_number' to pass the check in
> first fetch, and then modify it in the second fetch.
>
> To fix this, we need to recheck the 'ioc_number' in the second fetch.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> ---
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> index b2bb47c..5181c03 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> @@ -2319,6 +2319,10 @@ _ctl_ioctl_main(struct file *file, unsigned int cmd, void __user *arg,
>                         break;
>                 }
>
> +               if (karg.hdr.ioc_number != ioctl_header.ioc_number) {
> +                       ret = -EINVAL;
> +                       break;
> +               }
>                 if (_IOC_SIZE(cmd) == sizeof(struct mpt3_ioctl_command)) {
>                         uarg = arg;
>                         ret = _ctl_do_mpt_command(ioc, karg, &uarg->mf);
