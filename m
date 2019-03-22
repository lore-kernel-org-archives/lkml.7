Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4B2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2609218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfCVOAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:00:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44820 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfCVOAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:00:44 -0400
Received: by mail-qt1-f193.google.com with SMTP id w5so2535535qtb.11;
        Fri, 22 Mar 2019 07:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfO3L/ZRyCn9FipqUds+R1OsptxtKrtvfQdAbL11VWk=;
        b=DqwKVCZf2z1BTD+FiBpKdB2mGkEcklYVpfQyBMJQAaEWamEHtTJSMhE0aUtU9TCz4e
         TW+uRGaj8ZP7OhAdxSWZCehO0hL2cck7t2rU2BlF1tyed/ieHIffwsVQ/g9fjnF3/RYm
         d3VGyiZY/zSplHDbLI5CImsgzGt/5iiydVm+dX5ff14vgskiJeNRyqJhsILoLDjXcPmS
         AFxPJdlsMnczlK/fMBqq2xTXLy7XstiJJajJ5Zwv3rWJPNAcsoa1I342z22GCqcau6nM
         xRdWFH9qsJjPXGRQ7NtCr62rVfa9ZVuUhX7B6FJ2IyN7eNflSD6iKJ9qKN9qPV0QMWem
         bsqQ==
X-Gm-Message-State: APjAAAUpvi2qbpgz/IfpMbnHtxNZymy5NkSupce41go9LItOyrk7Vzma
        fxEV3eDqduUVnEVB2ns4kMdYYMNjdvYVfsMbr7M=
X-Google-Smtp-Source: APXvYqwk9CLw6lAoHxBBnLtDn35eu8/Vi7M4yWMlplDLpBgzgGG13CHDRuLrdwFRpNfF/NxLGiNSxmj+2cB7PG2lTOM=
X-Received: by 2002:ac8:2692:: with SMTP id 18mr8147213qto.343.1553263243384;
 Fri, 22 Mar 2019 07:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3MV=0BbOpjwM+2q+7Oehc=4B+u0hka1YdBnJmikfqCig@mail.gmail.com>
 <20190313230137.GA12529@agluck-desk> <CAK8P3a0aDdEt323i=z4BGuh71ntPqm-L33U4q+FiQOdMUin6wg@mail.gmail.com>
 <20190314110413.GA32277@zn.tnic> <20190314215952.GA303@agluck-desk>
 <20190315094341.GA12523@zn.tnic> <20190315155718.GA17775@agluck-desk>
 <20190315173720.GC12523@zn.tnic> <20190315174956.GA20831@agluck-desk>
 <20190315180206.GD12523@zn.tnic> <20190315181108.GA21111@agluck-desk>
 <CAK8P3a2CFyF5wExbZPb20E56sJ=3DpsP+0m2Px6D5Sw_L3pKXA@mail.gmail.com> <3908561D78D1C84285E8C5FCA982C28F7D53BD42@ORSMSX110.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D53BD42@ORSMSX110.amr.corp.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Mar 2019 15:00:25 +0100
Message-ID: <CAK8P3a0WjUi+mBZ0nO2FFFCRvy5mA10frZMAaXisGWOs4pnPCA@mail.gmail.com>
Subject: Re: [PATCH] EDAC, {skx|i10nm}_edac: Fix randconfig build error
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 10:28 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> > Basically I cheat Kconfig, so if one driver is built-in and
> > the other is a loadable module, we compile both as built-in.
>
> My mail client may have munged that path. Both "git am" and "patch -p1"
> barf when I try to apply it.  Since it was small I tried to replicate manually,
> but I must have messed up something because Kconfig still seems content
> to let me have CONFIG_EDAC_SKX=y with CONFIG_EDAC_I10NM=m
>
> :-(

Sorry, this was my mistake, my email was garbled. The patch was
correct though: the idea here is not to change the Kconfig symbols
but to change the Makefile to do the right thing even when Kconfig
is set wrong.

      Arnd
