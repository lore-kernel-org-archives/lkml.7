Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1B1C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6222922CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfIDMJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:09:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:37686 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729316AbfIDMJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:09:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 15384B66A;
        Wed,  4 Sep 2019 12:09:31 +0000 (UTC)
Subject: Re: [PATCH] xen/pci: try to reserve MCFG areas earlier
To:     Igor Druzhinin <igor.druzhinin@citrix.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
References: <1567556431-9809-1-git-send-email-igor.druzhinin@citrix.com>
 <52fe7f67-ffd0-2d22-90fb-f3462ea059cd@suse.com>
 <d5dd94c2-070e-b3ff-57cf-92893b3cca7b@citrix.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <d2bcdab9-7bf5-9266-eadf-5c5ab4de7105@suse.com>
Date:   Wed, 4 Sep 2019 14:09:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d5dd94c2-070e-b3ff-57cf-92893b3cca7b@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.2019 13:36, Igor Druzhinin wrote:
> On 04/09/2019 10:08, Jan Beulich wrote:
>> On 04.09.2019 02:20, Igor Druzhinin wrote:
>>> If MCFG area is not reserved in E820, Xen by default will defer its usage
>>> until Dom0 registers it explicitly after ACPI parser recognizes it as
>>> a reserved resource in DSDT. Having it reserved in E820 is not
>>> mandatory according to "PCI Firmware Specification, rev 3.2" (par. 4.1.2)
>>> and firmware is free to keep a hole E820 in that place. Xen doesn't know
>>> what exactly is inside this hole since it lacks full ACPI view of the
>>> platform therefore it's potentially harmful to access MCFG region
>>> without additional checks as some machines are known to provide
>>> inconsistent information on the size of the region.
>>
>> Irrespective of this being a good change, I've had another thought
>> while reading this paragraph, for a hypervisor side control: Linux
>> has a "memopt=" command line option allowing fine grained control
>> over the E820 map. We could have something similar to allow
>> inserting an E820_RESERVED region into a hole (it would be the
>> responsibility of the admin to guarantee no other conflicts, i.e.
>> it should generally be used only if e.g. the MCFG is indeed known
>> to live at the specified place, and being properly represented in
>> the ACPI tables). Thoughts?
> 
> What other use cases can you think of in case we'd have this option?
> From the top of my head, it might be providing a memmap for a second Xen
> after doing kexec from Xen to Xen.
> 
> What benefits do you think it might have over just accepting a hole
> using "mcfg=relaxed" option from admin perspective?

It wouldn't be MCFG-specific, i.e. it could also be used to e.g.
convert holes to E820_RESERVED to silence VT-d's respective RMRR
warning. Plus by inserting the entry into our own E820 we'd also
propagate it to users of XENMEM_machine_memory_map.

Jan
