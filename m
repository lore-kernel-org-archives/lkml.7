Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3142BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8CB2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfCYJVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:21:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730056AbfCYJVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:21:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7EBB94620D;
        Mon, 25 Mar 2019 09:20:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6064019C59;
        Mon, 25 Mar 2019 09:20:48 +0000 (UTC)
Subject: Re: [PATCH 1/3 v9] x86/mm: Change the examination condition to avoid
 confusion
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
References: <20190321103309.27883-1-lijiang@redhat.com>
 <20190321103309.27883-2-lijiang@redhat.com> <20190322175114.GL12472@zn.tnic>
 <aa4af285-0aa2-3477-76a8-87f93d4db599@redhat.com>
 <20190325064046.GB12016@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <dd7b5fb6-bd77-61a2-afa5-d52137c24cbd@redhat.com>
Date:   Mon, 25 Mar 2019 17:20:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190325064046.GB12016@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 25 Mar 2019 09:20:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年03月25日 14:40, Borislav Petkov 写道:
> On Mon, Mar 25, 2019 at 11:11:45AM +0800, lijiang wrote:
>> I mean it needs to find all the value of the 'IORES_DESC_ACPI_*' type.
> 
> A function called __ioremap_check_desc_other() needs to find
> IORES_DESC_ACPI_* types...
> 
> No, still don't know what you're trying to do.

Let's look at the discussion in patch v8, please refer to this link:
https://lkml.org/lkml/2019/3/16/15

I did a test according to Tom's reply, and the test indicated his suggestion was
correct, we should change this to check for IORES_DESC_ACPI_* values.

> 
>> As above mentioned, it needs to find all the value of the 'IORES_DESC_ACPI_*'
>> type, so we should explicitly use the 'IORES_DESC_ACPI_*' type as the check
>> condition instead of the 'IORES_DESC_NONE'.
> 
> And now the same question I'm asking you each time: WHY does it need to find
> the ACPI types?
> 

When SEV is enabled and the page being mapped is in memory, need to ensure the
memory encryption attribute is also enabled in the resulting mapping.

I believe Tom knows better than me. :-)

Thanks.
Lianbo
