Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376B9C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1524A21670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfIDJIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:08:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:42698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726358AbfIDJIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:08:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 703BEB667;
        Wed,  4 Sep 2019 09:08:39 +0000 (UTC)
Subject: Re: [PATCH] xen/pci: try to reserve MCFG areas earlier
To:     Igor Druzhinin <igor.druzhinin@citrix.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>
References: <1567556431-9809-1-git-send-email-igor.druzhinin@citrix.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <52fe7f67-ffd0-2d22-90fb-f3462ea059cd@suse.com>
Date:   Wed, 4 Sep 2019 11:08:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567556431-9809-1-git-send-email-igor.druzhinin@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.2019 02:20, Igor Druzhinin wrote:
> If MCFG area is not reserved in E820, Xen by default will defer its usage
> until Dom0 registers it explicitly after ACPI parser recognizes it as
> a reserved resource in DSDT. Having it reserved in E820 is not
> mandatory according to "PCI Firmware Specification, rev 3.2" (par. 4.1.2)
> and firmware is free to keep a hole E820 in that place. Xen doesn't know
> what exactly is inside this hole since it lacks full ACPI view of the
> platform therefore it's potentially harmful to access MCFG region
> without additional checks as some machines are known to provide
> inconsistent information on the size of the region.

Irrespective of this being a good change, I've had another thought
while reading this paragraph, for a hypervisor side control: Linux
has a "memopt=" command line option allowing fine grained control
over the E820 map. We could have something similar to allow
inserting an E820_RESERVED region into a hole (it would be the
responsibility of the admin to guarantee no other conflicts, i.e.
it should generally be used only if e.g. the MCFG is indeed known
to live at the specified place, and being properly represented in
the ACPI tables). Thoughts?

Jan
