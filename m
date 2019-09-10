Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33475C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119982067B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391742AbfIJJz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:55:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:59734 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727557AbfIJJzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:55:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F047AF80;
        Tue, 10 Sep 2019 09:55:54 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] xen/pci: try to reserve MCFG areas earlier
To:     Igor Druzhinin <igor.druzhinin@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>
References: <1567556431-9809-1-git-send-email-igor.druzhinin@citrix.com>
 <5054ad91-5b87-652c-873a-b31758948bd7@oracle.com>
 <e3114d56-51cd-b973-1ada-f6a60a7e99cc@citrix.com>
 <43b7da04-5c42-80d8-898b-470ee1c91ed2@oracle.com>
 <adefac87-c2b3-b67f-fb4d-d763ce920bef@citrix.com>
 <1695c88d-e5ad-1854-cdef-3cd95c812574@oracle.com>
 <4d3bf854-51de-99e4-9a40-a64c581bdd10@citrix.com>
 <bc3da154-d451-02cf-6154-5e0dc721a6e6@oracle.com>
 <c45b8786-5735-a95d-bc40-61372c326037@citrix.com>
 <43e492ff-f967-7218-65c4-d16581fabea3@oracle.com>
 <416ff4b7-3186-f61a-75fa-bcfc968f8117@citrix.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <64d52960-28d5-fb23-8892-35c9d4ed9d90@suse.com>
Date:   Tue, 10 Sep 2019 11:55:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <416ff4b7-3186-f61a-75fa-bcfc968f8117@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.09.2019 11:46, Igor Druzhinin wrote:
> On 10/09/2019 02:47, Boris Ostrovsky wrote:
>> On 9/9/19 5:48 PM, Igor Druzhinin wrote:
>>> Actually, pci_mmcfg_late_init() that's called out of acpi_init() -
>>> that's where MCFG areas are properly sized. 
>>
>> pci_mmcfg_late_init() reads the (static) MCFG, which doesn't need DSDT parsing, does it? setup_mcfg_map() OTOH does need it as it uses data from _CBA (or is it _CRS?), and I think that's why we can't parse MCFG prior to acpi_init(). So what I said above indeed won't work.
>>
> 
> No, it uses is_acpi_reserved() (it's called indirectly so might be well
> hidden) to parse DSDT to find a reserved resource in it and size MCFG
> area accordingly. setup_mcfg_map() is called for every root bus
> discovered and indeed tries to evaluate _CBA but at this point
> pci_mmcfg_late_init() has already finished MCFG registration for every
> cold-plugged bus (which information is described in MCFG table) so those
> calls are dummy.

I don't think they're strictly dummy. Even for boot time available devices
iirc there's no strict requirement for there to be respective data in MCFG.
Such a requirement exists only for devices which are actually needed to
start the OS (disk or network, perhaps video or alike), or maybe even just
its loader.

Jan
