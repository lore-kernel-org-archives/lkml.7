Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0C2C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E82C2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388637AbfLKPtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:49:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:51652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388678AbfLKPtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:49:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E48CAFA9;
        Wed, 11 Dec 2019 15:49:12 +0000 (UTC)
Subject: Re: [PATCH v1] xen-pciback: optionally allow interrupt enable flag
 writes
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     xen-devel@lists.xenproject.org,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20191203054222.7966-1-marmarek@invisiblethingslab.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <17bf38dc-a606-bb92-50a8-9bd8f269acc2@suse.com>
Date:   Wed, 11 Dec 2019 16:49:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191203054222.7966-1-marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.12.2019 06:41, Marek Marczykowski-Górecki  wrote:
> QEMU running in a stubdom needs to be able to set INTX_DISABLE, and the
> MSI(-X) enable flags in the PCI config space. This adds an attribute
> 'allow_interrupt_control' which when set for a PCI device allows writes
> to this flag(s). The toolstack will need to set this for stubdoms.
> When enabled, guest (stubdomain) will be allowed to set relevant enable
> flags, but only one at a time - i.e. it refuses to enable more than one
> of INTx, MSI, MSI-X at a time.
> 
> This functionality is needed only for config space access done by device
> model (stubdomain) serving a HVM with the actual PCI device. It is not
> necessary and unsafe to enable direct access to those bits for PV domain
> with the device attached. For PV domains, there are separate protocol
> messages (XEN_PCI_OP_{enable,disable}_{msi,msix}) for this purpose.
> Those ops in addition to setting enable bits, also configure MSI(-X) in
> dom0 kernel - which is undesirable for PCI passthrough to HVM guests.
> 
> This should not introduce any new security issues since a malicious
> guest (or stubdom) can already generate MSIs through other ways, see
> [1] page 8.

True, albeit this doesn't cover INTX_DISABLE.

> Additionally, when qemu runs in dom0, it already have direct
> access to those bits.

True again, but any bug here (as in: too wide exposure) is a qemu
bug (possibly security issue). The statement also isn't really
correct for de-privileged qemu, I think (but I also think PCI
pass-through doesn't work in that mode at all yet).

On the whole this looks to be an acceptable approach to me. But
I'm not the maintainer, so my opinion may not count much. Some
issues with the implementation itself were already pointed out.

Jan
