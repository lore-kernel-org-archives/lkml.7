Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79320C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5406E218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfCVOZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:25:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35734 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfCVOZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:25:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id h39so2708654qte.2;
        Fri, 22 Mar 2019 07:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgU0Bb4r73UXwzDeQmp3uQUPAZnDRzQ3LYlx8zVWUec=;
        b=SnIJ0zBGnGYojgXpeCtfp8+aw2r6n7/UwNgMMsWjIDrTsOkkac0DUO9ZTcBDnjhs+H
         P05pZhvZikQacezCzlUwzewIFcjqhTPNoGn61jtJ64BiRmdTAJ/Bm482i6UAsGivaLr2
         lNwiQQVeiD8Fr5OUxo3vNHgYvVDtieyXsab2j0lt+K4zNPipzhHSB4efvK0K+1cx2keN
         M/6B87FJLNVU7zHpVWUZlKFrxr5bqxXOef6OlMxCPCc9Z6i4dFmC1wcXwEy5hjRxX6RV
         tnFy6qBEsGr+r9pcypjB5abiTD9DV9wSP4SXB0cRMaUZNxFPaEHJv6NFA+03fwdspeB7
         MSCQ==
X-Gm-Message-State: APjAAAW+W5Os3lHqWZ/A98UARmoRV9O50IQfFYFXCUN/VxTVuoXzJ1qY
        +chrEnZhNat6s4zwitcOhJJcctb3h7lmwwG0xOs=
X-Google-Smtp-Source: APXvYqyVv2Xo2XX+arcRjCq2ZGsJiu04YWTqJATL2z97Cua4vAx8Hk450fwcfdWMLTej/AgNecZj2e9VbFelkc9bKXQ=
X-Received: by 2002:ac8:2692:: with SMTP id 18mr8280821qto.343.1553264722573;
 Fri, 22 Mar 2019 07:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190307184125.21419-1-natechancellor@gmail.com>
 <20190307231534.2640-1-natechancellor@gmail.com> <CAKwvOdmFnnGOnbQ-0fAeOpAMDjnYnN1mkiNjbcW8uNss9cSrVg@mail.gmail.com>
In-Reply-To: <CAKwvOdmFnnGOnbQ-0fAeOpAMDjnYnN1mkiNjbcW8uNss9cSrVg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Mar 2019 15:25:05 +0100
Message-ID: <CAK8P3a27E7w804RcNNX1OOfgqwkbcxf42XiyUORFaG_wkSUXqw@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: qla4xxx: Don't call dma_free_coherent when buf
 is NULL
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 10:17 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Thu, Mar 7, 2019 at 3:17 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > When building with -Wsometimes-uninitialized, Clang warns:
> >
> > drivers/scsi/qla4xxx/ql4_os.c:5915:7: warning: variable 'buf_dma' is
> > used uninitialized whenever 'if' condition is false
> > [-Wsometimes-uninitialized]
> >
> > Don't call dma_free_coherent when buf is NULL, meaning that we never
> > called dma_alloc_coherent and initialized buf_dma.
> >
> > Fixes: 2a991c215978 ("[SCSI] qla4xxx: Boot from SAN support for open-iscsi")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/391
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

> > diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
> > index 16a18d5d856f..9f56dafc3cda 100644
> > --- a/drivers/scsi/qla4xxx/ql4_os.c
> > +++ b/drivers/scsi/qla4xxx/ql4_os.c
> > @@ -5982,7 +5982,8 @@ static int get_fw_boot_info(struct scsi_qla_host *ha, uint16_t ddb_index[])
> >                           ddb_index[1]));
> >
> >  exit_boot_info_free:
> > -       dma_free_coherent(&ha->pdev->dev, size, buf, buf_dma);
> > +       if (buf)
> > +               dma_free_coherent(&ha->pdev->dev, size, buf, buf_dma);
>
> Same thoughts as: https://lkml.org/lkml/2019/3/8/786
> WDYT?

Initializing the variable is definitely worse here, don't listen to
clang's bad suggestions ;-)

This was my fix, I'll send that as a proper patch as well:

--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -5928,7 +5928,7 @@ static int get_fw_boot_info(struct scsi_qla_host
*ha, uint16_t ddb_index[])
                val = rd_nvram_byte(ha, sec_addr);
                if (val & BIT_7)
                        ddb_index[1] = (val & 0x7f);
-
+               goto exit_boot_info;
        } else if (is_qla80XX(ha)) {
                buf = dma_alloc_coherent(&ha->pdev->dev, size,
                                         &buf_dma, GFP_KERNEL);


      Arnd
