Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE019C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A86022CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nmacleod-com.20150623.gappssmtp.com header.i=@nmacleod-com.20150623.gappssmtp.com header.b="M/sgoQVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfHUS4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:56:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43371 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfHUS4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:56:23 -0400
Received: by mail-io1-f66.google.com with SMTP id 18so6692558ioe.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 11:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nmacleod-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S72wMW8ZIp2v1uArpflhy2yHM6VNW5h/Nqo2tTSkK7w=;
        b=M/sgoQVZfCm1PGh6RApGc9nInq0Yta+I9bZveCL1kCC3kaUcsongDSqLT11DLX6RY6
         eCkGV0I73Hzh1Juwy6liSzRBql751X9eFuPKtLferA0KdpWy+2sSdkLNX/Yd1kxyTIrQ
         OrKCh3gJO4mcVUbSU7mmuAEWsmQKLxvB9HRsIjiG7dVTxMc/vk8HW66OLZgZJHfvdcJZ
         dDBSOpmmmDPWI37kHJlGh61dH6yu573fHobhKx7tN1kf9dbz0FnC5nwJCZCtP955OzZs
         Xpq5H1LpXcQekAL6HIEMA7TZfixTqtbbzUxTFgz303l6+2d9NGjaAuqJEcW6Dpu5OPWI
         7Lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S72wMW8ZIp2v1uArpflhy2yHM6VNW5h/Nqo2tTSkK7w=;
        b=aI9C9FijkTKRoRdM+evXChb6CaCthD6aYL2vbrLxGooQd6dRH5S4KyXNSBvi0ko5qo
         NpZ8aGgWJXlV8O9AGzAzbhEXURYQj8liWRWwOMEO2VB6Zg/yfE7SHCdyKcqIlTOB4UnC
         b1XrNm4B2nGZQFTnmIf3CqdGSLEmaCg5BdnJj/1ClrptJkU0G+OkEmprCmVjQHKtB6FU
         dVmTtcdMgopmWr/CIHoxKCcSMo3SrQB1MJN9LgmzqOwWGumqPFhTdavLBznIbb3BD6lo
         21pZ9XgF4osIzr80vu8BeiAHJNEw4CVH0i/SJLmgswUwiQCWY46eBCW0u7ob8dlrE1EJ
         yQqQ==
X-Gm-Message-State: APjAAAW2ceq0/GllQgLHeSitsgxDfZSDGD6qBXQRm3CTJkmTlxHYY1XC
        MdgIVrBW1roaEzGhpUWTgRRyurLwIzMhdMuiizhOXA==
X-Google-Smtp-Source: APXvYqxE9iP9ZW4bykcIZBTQfIf4Fem6mwz/yEf2Qz2Ow2Y1SMK7+CYNbveknrQdvBx743ryYyyNLK1U0sA4WMRiGHQ=
X-Received: by 2002:a5e:d803:: with SMTP id l3mr9626697iok.126.1566413782271;
 Wed, 21 Aug 2019 11:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAFbqK8m=F_90531wTiwKT4J0R+EC-3ZmqHtKCwA_2th_nVYrpg@mail.gmail.com>
 <900a48bf-c9fc-09bd-52a3-9e16ff8baa19@nvidia.com> <alpine.DEB.2.21.1908212047140.1983@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908212047140.1983@nanos.tec.linutronix.de>
From:   Neil MacLeod <neil@nmacleod.com>
Date:   Wed, 21 Aug 2019 19:56:03 +0100
Message-ID: <CAFbqK8=RUaCnk_WkioodkdwLsDina=yW+eLvzckSbVx_3Py_-A@mail.gmail.com>
Subject: Re: Boot failure due to: x86/boot: Save fields explicitly, zero out
 everything else
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John & Thomas

Thanks both - if you can ping me a suitable patch I'll test it and let
you all know ASAP!

Neil

On Wed, 21 Aug 2019 at 19:51, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 21 Aug 2019, John Hubbard wrote:
> > On 8/21/19 10:05 AM, Neil MacLeod wrote:
> > static void sanitize_boot_params(struct boot_params *boot_params)
> > {
> > ...
> >               const struct boot_params_to_save to_save[] = {
> >                       BOOT_PARAM_PRESERVE(screen_info),
> >                       BOOT_PARAM_PRESERVE(apm_bios_info),
> >                       BOOT_PARAM_PRESERVE(tboot_addr),
> >                       BOOT_PARAM_PRESERVE(ist_info),
> >                       BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
> >                       BOOT_PARAM_PRESERVE(hd0_info),
> >                       BOOT_PARAM_PRESERVE(hd1_info),
> >                       BOOT_PARAM_PRESERVE(sys_desc_table),
> >                       BOOT_PARAM_PRESERVE(olpc_ofw_header),
> >                       BOOT_PARAM_PRESERVE(efi_info),
> >                       BOOT_PARAM_PRESERVE(alt_mem_k),
> >                       BOOT_PARAM_PRESERVE(scratch),
> >                       BOOT_PARAM_PRESERVE(e820_entries),
> >                       BOOT_PARAM_PRESERVE(eddbuf_entries),
> >                       BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
> >                       BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
> >                       BOOT_PARAM_PRESERVE(e820_table),
> >                       BOOT_PARAM_PRESERVE(eddbuf),
> >               };
>
> I think I spotted it:
>
> -               boot_params->acpi_rsdp_addr = 0;
>
> +                       BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
>
> And it does not preserve 'hdr'
>
> Grr. I surely was too tired when staring at this last time.
>
> Thanks,
>
>         tglx
