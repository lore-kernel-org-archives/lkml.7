Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AAFC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93AB206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfLJJHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:07:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:45722 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbfLJJHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:07:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8E83AD2B;
        Tue, 10 Dec 2019 09:07:50 +0000 (UTC)
Subject: Re: [Patch v2] mm/hotplug: Only respect mem= parameter during boot
 stage
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mhocko@kernel.org, david@redhat.com,
        akpm@linux-foundation.org
References: <20191210084413.21957-1-bhe@redhat.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <d3752014-9db1-9dc6-7268-b510a3dab553@suse.com>
Date:   Tue, 10 Dec 2019 10:07:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210084413.21957-1-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.12.19 09:44, Baoquan He wrote:
> In commit 357b4da50a62 ("x86: respect memory size limiting via mem=
> parameter") a global varialbe global max_mem_size is added to store
> the value parsed from 'mem= ', then checked when memory region is
> added. This truly stops those DIMM from being added into system memory
> during boot-time.
> 
> However, it also limits the later memory hotplug functionality. Any
> memory board can't be hot added any more if its region is beyond the
> max_mem_size. System will print error like below:
> 
> [  216.387164] acpi PNP0C80:02: add_memory failed
> [  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
> [  216.392187] acpi PNP0C80:02: Enumeration failure
> 
>  From document of 'mem= ' parameter, it should be a restriction during
> boot, but not impact the system memory adding/removing after booting.
> 
>    mem=nn[KMG]     [KNL,BOOT] Force usage of a specific amount of memory
> 	          ...
> 
> So fix it by also checking if it's during boot-time when restrict memory
> adding. Otherwise, skip the restriction.
> 
> Fixes: 357b4da50a62 ("x86: respect memory size limiting via mem= parameter")
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
