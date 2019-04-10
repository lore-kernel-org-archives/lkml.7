Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B10AC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DE920850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Pqji4CEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfDJELB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:11:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34407 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfDJEK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 00:10:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so1154187wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 21:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IewjcLSJnQrO08PbnPGd5ADILHnS1hScA5/IGBONAXw=;
        b=Pqji4CEps5vlS2C6w+QeTo4oa1s6i51fB1ohQC71pRVe8DUty81aas0k1RLuJjLOz3
         hsmYd2AwdQQ5COgc4BSDA/KMlV4//yjuOJ34RMxWLnXu4eGLgMheoTPgX2Sgogf/9aFc
         kq1FFXy+xBgXjV0IjUv/sh6ImN/BZLKR3V57+4v4L8lmrEdJ1ins4kdd6y6S3izGSKJM
         gKczDPHxKbwymzhWWwVZLNcZ/2YODkHYhNaVVfsg6nzGlHWE8GUhRPMOCaMAqsdQvU5G
         JCxCj1/eWVnYPca7XH0s3qb17fEdW9a1ctt1mhmg79q8vg0vhr1LLiy4pn1uPLpMaCzA
         ScJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IewjcLSJnQrO08PbnPGd5ADILHnS1hScA5/IGBONAXw=;
        b=E1rDjbI74+ajIgzrnpYRKWnLYoWr1PwfuzMCD9TEqNFdQpjyU804QjhjvlIZh9wY6W
         ZLxoEzTEK2qFjvxzRkJZE+VU9D8VNnWi9jbBoYGk6cyWdzfsl4YrBSCdN0qP5STTAf9L
         lFCVwUuKbxiRpp2ulyBIeu/L1r97lqFUGWvQbmI/VNX4fnseWatMZKMY8Gc3quKKSpJ+
         5O53L1jJ6ztdmtp4kA+qDqjtjCjQiC+4Tw/s5x/CoKK2IWDKE8/Cmm0pM3A3SE42pvoe
         kkj9MnBjCL/6l4NmdiqBDdVFUFD1axFI14f32HVwGd7JOiin+j1B+Qa4NUsZK9Wr0gNZ
         ClBw==
X-Gm-Message-State: APjAAAW+zquJaiTWqEOl1EAuECp2YKjlTjQS8VE0xi5m4T4FhfLKyMMA
        EqfMlfEC8X1KOBvhpKieRfz0/6N6cbz1tlyi/+2S+JFjWyE=
X-Google-Smtp-Source: APXvYqwHi/MEm58V/UYsSMUvFmagM6orEbnr7iNRXhTqA0TJ7rvNFCPTMzDWiPRQgeRH/m8CJPklWAr7BuxjdYcrzI4=
X-Received: by 2002:adf:e610:: with SMTP id p16mr24936946wrm.64.1554869454862;
 Tue, 09 Apr 2019 21:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190312220752.128141-3-anup.patel@wdc.com> <mhng-3d9a3b8a-2d5d-4db8-b8b0-4ef410a9ad52@palmer-si-x1c4>
In-Reply-To: <mhng-3d9a3b8a-2d5d-4db8-b8b0-4ef410a9ad52@palmer-si-x1c4>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 10 Apr 2019 09:40:43 +0530
Message-ID: <CAAhSdy2MQmPte7=YaVw5Ae5vWgQYcHX-zGiEBXP1a15=CkXzwg@mail.gmail.com>
Subject: Re: [PATCH 2/3] RISC-V: Make setup_vm() independent of GCC code model
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 10:17 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Tue, 12 Mar 2019 15:08:16 PDT (-0700), Anup Patel wrote:
> > The setup_vm() must access kernel symbols in a position independent way
> > because it will be called from head.S with MMU off.
> >
> > If we compile kernel with cmodel=medany then PC-relative addressing will
> > be used in setup_vm() to access kernel symbols so it works perfectly fine.
> >
> > Although, if we compile kernel with cmodel=medlow then either absolute
> > addressing or PC-relative addressing (based on whichever requires fewer
> > instructions) is used to access kernel symbols in setup_vm(). This can
> > break setup_vm() whenever any absolute addressing is used to access
> > kernel symbols.
> >
> > With the movement of setup_vm() from kernel/setup.c to mm/init.c, the
> > setup_vm() is now broken for cmodel=medlow but it works perfectly fine
> > for cmodel=medany.
> >
> > This patch fixes setup_vm() and makes it independent of GCC code model
> > by accessing kernel symbols relative to kernel load address instead of
> > assuming PC-relative addressing.
>
> I think we ended up with a cleaner solution as 387181dcdb6c ("RISC-V: Always
> compile mm/init.c with cmodel=medany and notrace"), but let me know if I missed
> something here.

Yes, please ignore this patch. I have dropped it in latest version of
this patch series.

Regards,
Anup
