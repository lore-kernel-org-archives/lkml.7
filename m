Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1EBC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF3521473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="QEWNNzv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfDIQG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:06:58 -0400
Received: from a9-36.smtp-out.amazonses.com ([54.240.9.36]:58882 "EHLO
        a9-36.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726595AbfDIQG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1554825675;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=50hYcoxn2BeHRqUR1dpDDp6CiUZIJ7B2QB39HCVWIo4=;
        b=QEWNNzv2USVY0eK4qZBeLwqUhjEJKQaLcv2Sjoj0ui7jHwhE5VYqbs+gguUqGV/Y
        8jePuQR1l7hK5LYSixUqXo6iIejvUJ8sb0KgVNwUC3sZX6/LBq8ked3lgviThFihuJO
        R9zkPKuicFLqOtOOWM81WYtIAFsm6miHL94a1KDw=
Date:   Tue, 9 Apr 2019 16:01:15 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: Basics : Memory Configuration
In-Reply-To: <SG2PR02MB3098925678D8D40B683E10E2E82D0@SG2PR02MB3098.apcprd02.prod.outlook.com>
Message-ID: <0100016a02d5038e-2e436033-7726-4d2a-b29d-d3dbc4c66637-000000@email.amazonses.com>
References: <SG2PR02MB3098925678D8D40B683E10E2E82D0@SG2PR02MB3098.apcprd02.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.09-54.240.9.36
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019, Pankaj Suryawanshi wrote:


> I am confuse about memory configuration and I have below questions

Hmmm... Yes some of the terminology that you use is a bit confusing.

> 1. if 32-bit os maximum virtual address is 4GB, When i have 4 gb of ram
> for 32-bit os, What about the virtual memory size ? is it required
> virtual memory(disk space) or we can directly use physical memory ?

The virtual memory size is the maximum virtual size of a single process.
Multiple processes can run and each can use different amounts of physical
memory. So both are actually independent.

The size of the virtual memory space per process is configurable on x86 32
bit (2G, 3G, 4G). Thus the possible virtual process size may vary
depending on the hardware architecture and the configuration of the
kernel.

> 2. In 32-bit os 12 bits are offset because page size=4k i.e 2^12 and
> 2^20 for page addresses
>    What about 64-bit os, What is offset size ? What is page size ? How it calculated.

12 bits are passed through? Thats what you mean?

The remainder of the bits  are used to lookup the physical frame
number(PFN) in the page tables.

64 bit is the same. However, the number of bits used for lookups in the
page tables are much higher.


> 3. What is PAE? If enabled how to decide size of PAE, what is maximum
> and minimum size of extended memory.

PAE increases the physical memory size that can be addressed through a
page table lookup. The number of bits that can be specified in the PFN is
increased and thus more than 4GB of physical memory can be used by the
operating system. However, the virtual memory size stays the same and an
individual process still cannot use more memory.

