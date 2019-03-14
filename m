Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D206FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DD5217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfCNLkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:40:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37650 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfCNLkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:40:37 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so5590776qtn.4;
        Thu, 14 Mar 2019 04:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+jEBW2uvuhAa3Xd+ttZQ0IBL0HAqnScDEf+oC+cSfs=;
        b=V/172+DVq8VLkiXDzz3DygIe8EvW97wlVqGjK20qeh6bkqe0IYPDCarkxyZX5a2qvy
         0D8CXEH1J9+KVGRBQ3Zw5DZtPGCx3jZ0PvN5tlE3KGm7tk4nh41dS36zIaZlNhLfbLcq
         ojjaMFj2zIxTXCQSyf3Q0lWJ5MUWK6hYPso6CHHJGQ9bFlD6iYwnk2CafYPzmhp+Pdz0
         TQ4U/x5xfTVaXT/QL5UFFzwU5zJKSJqMCXPCSnvbDXQvPJoY29t3EMJXC6/aridaEnF8
         bic9XLTdnXz3g5D66f25txxk+PgItPJWIQ9AhXv8RZn02BiU/1pRzi0KX9r2VSgV+z7s
         hezg==
X-Gm-Message-State: APjAAAX0mzb37/9j07DZTYW6PaM3ejq+7l4qKfD45QEh+tzESMGcTbD6
        mh6Lkg9LsjjXWHPdE+rf0q21V2nMhnuBMSzp9Ho=
X-Google-Smtp-Source: APXvYqwZx4Q7UibG6rp3NN3J2hHTx8pHFuDlxL9Gv/BO6P93VzjIX7qWktcsG1draOR9BiBUfCnETOjIjl0KCydmc5c=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr38222815qtb.343.1552563636215;
 Thu, 14 Mar 2019 04:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190215192033.24203-1-faiz_abbas@ti.com> <20190215192033.24203-2-faiz_abbas@ti.com>
 <abcc1506-cd38-5ff4-aaeb-57e9a9622e90@intel.com> <8d72ff93-e07f-52b9-da85-acd54f046694@ti.com>
 <63b6631d-86e7-b8ef-ffaf-40e7d4e96cfb@intel.com> <842caafd-1547-1ea6-faf0-27a85a912622@ti.com>
In-Reply-To: <842caafd-1547-1ea6-faf0-27a85a912622@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Mar 2019 12:40:19 +0100
Message-ID: <CAK8P3a1KJpWtyUOyyyab03tFYwkeROQXXV1+jM7EJ2d8So2bbA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] mmc: sdhci: Get rid of finish_tasklet
To:     "Rizvi, Mohammad Faiz Abbas" <faiz_abbas@ti.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kishon <kishon@ti.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 6:32 PM Rizvi, Mohammad Faiz Abbas
<faiz_abbas@ti.com> wrote:
> On 3/8/2019 7:06 PM, Adrian Hunter wrote:
> > On 6/03/19 12:00 PM, Faiz Abbas wrote:
> > It is a performance drop that can be avoided, so it might as well be.
> > Splitting the success path from the failure path is common for I/O drivers
> > for similar reasons as here: the success path can be optimized whereas the
> > failure path potentially needs to sleep.
>
> Understood. You wanna keep the success path as fast as possible.

I looked at the sdhci_request_done() function and found that almost all
of it is executed inside of a 'spin_lock_irqsave()', including the potentially
expensive dma_sync_single_for_cpu() calls.

This means there is very little benefit in using the tasklet in the first place,
it could just as well run in the hwirq context that triggered it.

The part that is actually run with interrupts enabled in the tasklet
is mmc_blk_cqe_req_done(), but other drivers also call this from
IRQ context.

       Arnd
