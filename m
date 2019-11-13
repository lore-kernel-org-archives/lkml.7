Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732D4C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 06:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46742222C6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 06:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKMGi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 01:38:27 -0500
Received: from david.siemens.de ([192.35.17.14]:46587 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfKMGi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 01:38:26 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id xAD6cF7e031765
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 07:38:15 +0100
Received: from [167.87.41.29] ([167.87.41.29])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id xAD6cEwY008709;
        Wed, 13 Nov 2019 07:38:15 +0100
Subject: Re: [FYI PATCH 0/7] Mitigation for CVE-2018-12207
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1573593697-25061-1-git-send-email-pbonzini@redhat.com>
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <23353382-53ea-8b20-7e30-763ef6df374c@siemens.com>
Date:   Wed, 13 Nov 2019 07:38:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1573593697-25061-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.11.19 22:21, Paolo Bonzini wrote:
> CVE-2018-12207 is a microarchitectural implementation issue
> that could allow an unprivileged local attacker to cause system wide
> denial-of-service condition.
> 
> Privileged software may change the page size (ex. 4KB, 2MB, 1GB) in the
> paging structures, without following such paging structure changes with
> invalidation of the TLB entries corresponding to the changed pages. In
> this case, the attacker could invoke instruction fetch, which will result
> in the processor hitting multiple TLB entries, reporting a machine check
> error exception, and ultimately hanging the system.
> 
> The attached patches mitigate the vulnerability by making huge pages
> non-executable. The processor will not be able to execute an instruction
> residing in a large page (ie. 2MB, 1GB, etc.) without causing a trap into
> the host kernel/hypervisor; KVM will then break the large page into 4KB
> pages and gives executable permission to 4KB pages.

When reading MCE, error code 0150h, ie. SRAR, I was wondering if that 
couldn't simply be handled by the host. But I suppose the symptom of 
that erratum is not "just" regular recoverable MCE, rather 
sometimes/always an unrecoverable CPU state, despite the error code, right?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
