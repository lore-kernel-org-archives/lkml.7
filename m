Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE466C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F382133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfCRRa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:30:29 -0400
Received: from ns.iliad.fr ([212.27.33.1]:55298 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfCRRa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:30:28 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 0F61E20723;
        Mon, 18 Mar 2019 18:30:27 +0100 (CET)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id E392A1FF12;
        Mon, 18 Mar 2019 18:30:26 +0100 (CET)
Subject: Re: [PATCH] arm64/io: Don't use WZR in writel
To:     Robin Murphy <robin.murphy@arm.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <68b71c15f32341468a868f6418e4fcb375bc49ba.camel@gmail.com>
 <20190211105755.GB30880@fuggles.cambridge.arm.com>
 <38d8965a-cd41-17cf-1b95-8dd58c079be4@arm.com>
 <874c702b8af760aa8fae38d478c79e3ecba00515.camel@gmail.com>
 <235d20ef-3054-69d9-975d-25aebf32aad3@arm.com>
 <20190223181254.GC572@tuxbook-pro> <86zhqm8i6d.wl-marc.zyngier@arm.com>
 <20190224035356.GD572@tuxbook-pro>
 <33d765b5-1807-fa6c-1ceb-99f09f7c8d5a@free.fr>
 <8eb4f446-6152-ffb6-9529-77fb0bcc307f@arm.com>
 <20190318170041.qu4x2565fmno6sei@shell.armlinux.org.uk>
 <5ba7c4d0-30ec-e38d-41dc-653fd5cb7f05@arm.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <fbacd3df-41c4-f98a-8875-db654aff3a5c@free.fr>
Date:   Mon, 18 Mar 2019 18:30:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <5ba7c4d0-30ec-e38d-41dc-653fd5cb7f05@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Mar 18 18:30:27 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2019 18:19, Robin Murphy wrote:

> For the context bank reset, yes, I am assuming that no complier will
> ever be perverse enough to detect that cfg is not written after the
> NULL check and immediately reallocate it to XZR for no good reason.
> I'd like to think that assumption is going to hold for the reasonable
> scope of this particular workaround, though.

I'm not sure I understand the above paragraph.

In code such as:

	if (val == 0) foo(val);

gcc's algorithm is likely to figure out that the code is equivalent to

	if (val == 0) foo(0)

and perform constant-propagation, etc.

Is that what we're talking about?

Regards.
