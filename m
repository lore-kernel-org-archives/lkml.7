Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DF7FC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCFE21848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEKU9Oof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfKHW2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 17:28:30 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:45814 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHW2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 17:28:30 -0500
Received: by mail-il1-f193.google.com with SMTP id o18so6495800ils.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 14:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mi2iw+Oqn1zkhpAjqTfRgpLqcLPG0FLPCPiiw0Zlvn0=;
        b=QEKU9OofsTu5RHv8oMM+o57xqPPfCClSz3q4/0bRbG2q3Y0GeZR/VrvxdUDaanExrO
         JVapNx+f00ZIehPQgl9WV9AP/vEjuOJsuXyLEc9zh8es0eDh4QyXIkZvclEx5cqvPx9t
         NAyN+UQBr9AAEe8x+UwARZRtmrtAvDmNiIfLFqNGY5W0i0Rvd3Wv4DPnjRJISlkx73go
         CgVRLYePeg6NZD6jbHHFsZpqFiGUMGnzpLdCOTmTNya2xrfqjvHGqPlYPPKcy7KrKzJ5
         7sR9ctijKHYe1zwcq10xOGItZPuvNn1LFN4eZVhyImD/8Q3XuXJZQutMuZotvSPutj9x
         Gq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mi2iw+Oqn1zkhpAjqTfRgpLqcLPG0FLPCPiiw0Zlvn0=;
        b=HD7ileVZOLfPyITPvz2hzw0OcFIs3edueoppjnNMD1pNIABfYlaut2pnycGIIJY9uF
         mE3Fd4+bdsM64ou/cV49HWHuDP3dyDPBEaONgxwiR/kZx/S8gk4+2bgmXyz2mLa3LUGE
         3YxzL0yioCAhwfnNb+eFM5SLXTzg2uVeiPLJY4QLIQb18KSWWfZ85Rb0juuy+b+lh0vB
         Twn8rSNqCSI8dhejgzlpz5vSoTxuSvWCa2hVlQFu5/cafw5oj/rRvgawQ+RaoxKsV45R
         sCjgzR8nIHlFABS8gy243D2oDR3pYS5hBDQGAB/1G0sLOy33/YvChce2x19euDFt+bSB
         kGuw==
X-Gm-Message-State: APjAAAX/c4giEkBwvYtafW2TUpYVSqGvq9jY7E/8HLV86vOiIOuni+g9
        Cp1BjltPit8iVSSqO7bmww5YtMXvc5FcIjzmqkgG//Yn
X-Google-Smtp-Source: APXvYqy1jk4pCHz93zu3QSZ0Nqlqw3CrLIb8MTqy/RMcwECkaHyPGTGHbsM4JebZ1+u6sfnFmz5QQRO5P0RqlIe6sek=
X-Received: by 2002:a92:c888:: with SMTP id w8mr15084644ilo.153.1573252107747;
 Fri, 08 Nov 2019 14:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20191107205914.10611-1-deepa.kernel@gmail.com> <f3d7138b-b254-3c6d-b865-d3b6889aa896@linux.intel.com>
In-Reply-To: <f3d7138b-b254-3c6d-b865-d3b6889aa896@linux.intel.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri, 8 Nov 2019 14:28:16 -0800
Message-ID: <CABeXuvpHYTU8qT5_+vxGUfLN34b6n-dF_5=KfRYp4eY22D8CKA@mail.gmail.com>
Subject: Re: [PATCH] intel-iommu: Turn off translations at shutdown
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     joro@8bytes.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +     x86_platform.iommu_shutdown = intel_iommu_shutdown;
>
> How about moving it to detect_intel_iommu() in drivers/iommu/dmar.c? And

Ok, makes sense to move it along with the init handler.

> make sure that it's included with CONFIG_X86_64.

You mean CONFIG_X86 like the init that is already there?

#ifdef CONFIG_X86
    if (!ret)
        x86_init.iommu.iommu_init = intel_iommu_init;
#endif

Thanks,
-Deepa
