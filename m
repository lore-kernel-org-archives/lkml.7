Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFA2C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22F2206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfHOXb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 19:31:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39636 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfHOXb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 19:31:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id b1so8035792otp.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 16:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3W/JXRczT4e7iKML5rUyQ8eYma8iSWGGWO86RntEySo=;
        b=qce6QxKNzR2pd2EETO5LGjFqsk86/Ezfo+iDb7nCQNmWNdcxvsdiTVZOpwPNjKyZMa
         k77hDht6Y2u4sSOJlLsfIj4hF8AQXLCY8LXl2pcaRX9QcTzJ/4gpLm1kqrqOWPnTQWaJ
         0+RyX4ifE+Og4QMl0bTFtEKPpEpNIrJa00i49Q6lR9qPiOCK+FBcCcuWtZM4Utt0VSK8
         DJmlLDn0TVH3cw8LYMCTxKz3dSjWan3dSqIOQ/1LJAVD+Y1ougcjMwf0KoGaUSMj+jkz
         Z/p8npRW6NtQxHYpMKXMpllsyHVWiTvC+KV3EiTFeeePrUAWATOeoqnJSVO048/+5AfV
         i1Ig==
X-Gm-Message-State: APjAAAXU/89nIqDoj+7+QRI1STj5QbD8fj1JQgckNn1DRFZoLjhyBuxJ
        uFb++a5W3INwNvhMWYwH8/+Tniu87x4=
X-Google-Smtp-Source: APXvYqzB8N+UBiSSPwSBm+jRmYm+eygvbW+5kj7V0gYJasRUkxsze253TTWOx9UE4oy+bC0jTs2OkA==
X-Received: by 2002:a05:6830:15c5:: with SMTP id j5mr5508412otr.296.1565911918358;
        Thu, 15 Aug 2019 16:31:58 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id o82sm978943oig.27.2019.08.15.16.31.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 16:31:57 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id g17so7219497otl.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 16:31:57 -0700 (PDT)
X-Received: by 2002:a9d:6b84:: with SMTP id b4mr5482166otq.63.1565911917418;
 Thu, 15 Aug 2019 16:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <1564690599-29713-1-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1564690599-29713-1-git-send-email-roy.pledge@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 15 Aug 2019 18:31:46 -0500
X-Gmail-Original-Message-ID: <CADRPPNQ_3muAr_tVYOThhtPmGXk2gh4qMhhZK402HiHh4fO-Fw@mail.gmail.com>
Message-ID: <CADRPPNQ_3muAr_tVYOThhtPmGXk2gh4qMhhZK402HiHh4fO-Fw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] soc/fsl/qbman: Enable Kexec for DPAA1 devices
To:     Roy Pledge <roy.pledge@nxp.com>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 3:20 PM Roy Pledge <roy.pledge@nxp.com> wrote:
>
> Most DPAA1 devices do not support a soft reset which is an issue if
> Kexec starts a new kernel. This patch series allows Kexec to function
> by detecting that the QBMan device was previously initialized.
>
> The patches fix some issues with device cleanup as well as ensuring
> that the location of the QBMan private memories has not changed
> after the execution of the Kexec.
>
> Changes since v1:
>         - Removed a bug fix and sent it separately to ease backporting
> Changes since v2:
>         - Expliciitly flush FQD memory from cache on PPC before unmapping
>
> Roy Pledge (7):
>   soc/fsl/qbman: Rework QBMan private memory setup
>   soc/fsl/qbman: Cleanup buffer pools if BMan was initialized prior to
>     bootup
>   soc/fsl/qbman: Cleanup QMan queues if device was already initialized
>   soc/fsl/qbman: Fix drain_mr_fqni()
>   soc/fsl/qbman: Disable interrupts during portal recovery
>   soc/fsl/qbman: Fixup qman_shutdown_fq()
>   soc/fsl/qbman: Update device tree with reserved memory

Series applied for next.  Thanks!

>
>  drivers/soc/fsl/qbman/bman.c        | 17 ++++----
>  drivers/soc/fsl/qbman/bman_ccsr.c   | 36 +++++++++++++++-
>  drivers/soc/fsl/qbman/bman_portal.c | 18 +++++++-
>  drivers/soc/fsl/qbman/bman_priv.h   |  5 +++
>  drivers/soc/fsl/qbman/dpaa_sys.c    | 63 ++++++++++++++++------------
>  drivers/soc/fsl/qbman/qman.c        | 83 +++++++++++++++++++++++++++++--------
>  drivers/soc/fsl/qbman/qman_ccsr.c   | 68 +++++++++++++++++++++++++++---
>  drivers/soc/fsl/qbman/qman_portal.c | 18 +++++++-
>  drivers/soc/fsl/qbman/qman_priv.h   |  8 ++++
>  9 files changed, 255 insertions(+), 61 deletions(-)
>
> --
> 2.7.4
>
