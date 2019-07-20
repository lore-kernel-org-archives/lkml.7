Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52888C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 02:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B16D21872
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 02:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clh9eyLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390317AbfGTC3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 22:29:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54279 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbfGTC3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 22:29:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so30301847wme.4;
        Fri, 19 Jul 2019 19:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btizYwfe6mTTxTPSbiY0caw59UmfBlWe5Uygrq3sqMY=;
        b=clh9eyLflZh8u307sMXectwSBF7U7lnttdUVNcqGltZM6aSGlUurJ+vHncBUYYMx9d
         6LKKPIAe9vwuR56CwNHqGBwPQHMCyBjhPBFqtIRwVCbwH9emd+4hgRZeqGhKUmkxmf2p
         fS/SRTfaAxaTxThjKMpTljw/HGjQ3m5moykiRNMDDo1Ugw1NGov+rYGtsV9zmZx/Xsh6
         PErHp7FdpLLevkaOCMJeVTyEVzTLvwJvQkTR7TR7vnyyc/8bFwAdTRGCJB6G4GDA+XnG
         zsAgGIoU534mLqp4RcoTvixNIjGtAwDEEn1JwFhTW8LGDIEmss6up5RhC/baAvAFrePf
         CZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btizYwfe6mTTxTPSbiY0caw59UmfBlWe5Uygrq3sqMY=;
        b=mWgQjfVcgSLbZF34f658AQiQU+x4xDbyIxPlDnVN1fdPOAKfrE1RsJctRmIMTA0UK6
         hnPUQ1jXxLDlYYPZZHy9+X4KsSVvOvbOwPix/VWaSKXPUghyw6JfaoDwaVFZjn0zpv1v
         9Al1m/Hh3BUAhEyhM6unQvIHBCc78xT2+drPkyLhH9LNqa0dpZcz/i2rATRe+cMOAMFw
         uvEMMmy4NNA9SOPlW+Zgj6YnQhj+KjaGOtaV9oxyYwX19vyBEjFseKYTqMIkbhK0cK9h
         lG4Kv+ONTzjt/FiDxp6F0z0JTgNdzgIY76fIFBwPXeesnTZPJrvEwO2ULUMhe6ESV4RP
         uM3g==
X-Gm-Message-State: APjAAAU7Ao00qG8wa1U/AmEVR/ql92uNM4tKpxOOzKjcBKU4O4qfsEZz
        FvZeIyl5jvd56cN9hif/rx+qAiOqjQ9qzdgyvZRubXrHT0M1FA==
X-Google-Smtp-Source: APXvYqzUcdut1lbHeqsszLDgLCKsa9HVLpPrATMQnDMEQXYAAFrwtQVzYjkwMKeXp9Ko0ZVuMiA+yA46DXDXyopz65A=
X-Received: by 2002:a1c:a7c6:: with SMTP id q189mr51263042wme.146.1563589792642;
 Fri, 19 Jul 2019 19:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <1563579201.1602.7.camel@HansenPartnership.com>
In-Reply-To: <1563579201.1602.7.camel@HansenPartnership.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sat, 20 Jul 2019 10:29:40 +0800
Message-ID: <CACVXFVNOPhiUhrgw07sna0dt5Jy2zckbNXDWPPRAGadXQAS_mQ@mail.gmail.com>
Subject: Re: [GIT PULL] final round of SCSI updates for the 5.2+ merge window
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2019 at 8:38 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> This is the final round of mostly small fixes in our initial
> submit.  It's mostly minor fixes and driver updates.  The only change
> of note is adding a virt_boundary_mask to the SCSI host and host
> template to parametrise this for NVMe devices instead of having them do
> a call in slave_alloc.  It's a fairly straightforward conversion except
> in the two NVMe handling drivers that didn't set it who now have a
> virtual infinity parameter added.
>
> The patch is available here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
>
> The short changelog is:
>
> Arnd Bergmann (1):
>       scsi: lpfc: reduce stack size with CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE
>
> Benjamin Block (3):
>       scsi: zfcp: fix GCC compiler warning emitted with -Wmaybe-uninitialized
>       scsi: zfcp: fix request object use-after-free in send path causing wrong traces
>       scsi: zfcp: fix request object use-after-free in send path causing seqno errors
>
> Christoph Hellwig (8):
>       scsi: megaraid_sas: set an unlimited max_segment_size
>       scsi: mpt3sas: set an unlimited max_segment_size for SAS 3.0 HBAs
>       scsi: IB/srp: set virt_boundary_mask in the scsi host
>       scsi: IB/iser: set virt_boundary_mask in the scsi host
>       scsi: storvsc: set virt_boundary_mask in the scsi host template
>       scsi: ufshcd: set max_segment_size in the scsi host template
>       scsi: core: take the DMA max mapping size into account

It has been observed on NVMe the above approach("take the DMA max
mapping size into account") causes performance regression, so I'd
suggest to fix dma_max_mapping_size() first.

Christoph has posted fix already, but looks not merged yet:

      https://lkml.org/lkml/2019/7/17/62


Thanks,
Ming Lei
