Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC09EC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30D424278
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfFCMcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:32:51 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38091 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfFCMcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:32:48 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45HZFp6yhxz9s7h; Mon,  3 Jun 2019 22:32:46 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 02c5f5394918b9b47ff4357b1b18335768cd867d
X-Patchwork-Hint: ignore
Content-Type: text/plain; charset="utf-8";
In-Reply-To: <155568805354.600470.13376593185688810607.stgit@bahia.lan>
To:     Greg Kurz <groug@kaod.org>, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org,
        Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH] powerpc/powernv/npu: Fix reference leak
Message-Id: <45HZFp6yhxz9s7h@ozlabs.org>
Date:   Mon,  3 Jun 2019 22:32:46 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-19 at 15:34:13 UTC, Greg Kurz wrote:
> Since 902bdc57451c, get_pci_dev() calls pci_get_domain_bus_and_slot(). This
> has the effect of incrementing the reference count of the PCI device, as
> explained in drivers/pci/search.c:
> 
>  * Given a PCI domain, bus, and slot/function number, the desired PCI
>  * device is located in the list of PCI devices. If the device is
>  * found, its reference count is increased and this function returns a
>  * pointer to its data structure.  The caller must decrement the
>  * reference count by calling pci_dev_put().  If no device is found,
>  * %NULL is returned.
> 
> Nothing was done to call pci_dev_put() and the reference count of GPU and
> NPU PCI devices rockets up.
> 
> A natural way to fix this would be to teach the callers about the change,
> so that they call pci_dev_put() when done with the pointer. This turns
> out to be quite intrusive, as it affects many paths in npu-dma.c,
> pci-ioda.c and vfio_pci_nvlink2.c. Also, the issue appeared in 4.16 and
> some affected code got moved around since then: it would be problematic
> to backport the fix to stable releases.
> 
> All that code never cared for reference counting anyway. Call pci_dev_put()
> from get_pci_dev() to revert to the previous behavior.
> 
> Fixes: 902bdc57451c ("powerpc/powernv/idoa: Remove unnecessary pcidev from pci_dn")
> Cc: stable@vger.kernel.org # v4.16
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/02c5f5394918b9b47ff4357b1b183357

cheers
