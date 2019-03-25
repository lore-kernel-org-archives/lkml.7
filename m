Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5A2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B597620883
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfCYDMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:12:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729298AbfCYDMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:12:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40E903082133;
        Mon, 25 Mar 2019 03:12:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71DC45C22B;
        Mon, 25 Mar 2019 03:11:50 +0000 (UTC)
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
From:   lijiang <lijiang@redhat.com>
Message-ID: <aa4af285-0aa2-3477-76a8-87f93d4db599@redhat.com>
Date:   Mon, 25 Mar 2019 11:11:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190322175114.GL12472@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 25 Mar 2019 03:12:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年03月23日 01:51, Borislav Petkov 写道:
> On Thu, Mar 21, 2019 at 06:33:07PM +0800, Lianbo Jiang wrote:
>> Following the commit <0e4c12b45aa8> ("x86/mm, resource: Use
>> PAGE_KERNEL protection for ioremap of memory pages"),
> 
> The proper commit quotation format is done by adding this to your
> .gitconfig:
> 
> [core]
>         abbrev = 12
> [alias]
>         one = show -s --pretty='format:%h (\"%s\")'
> 
> and then doing:
> 
> $ git one <commit id>
> 
> which will give you
> 
> 0e4c12b45aa8 ("x86/mm, resource: Use PAGE_KERNEL protection for ioremap of memory pages")

Nice. I added them to my .gitconfig. It works. Thank you very much.

> 
>> here it is really checking for the 'IORES_DESC_ACPI_*' values.
> 
> Well, it is not really checking that.

I mean it needs to find all the value of the 'IORES_DESC_ACPI_*' type.

> 
>> Therefore, it is necessary to change the examination condition
>> to avoid confusion.
> 
> What confusion?

As above mentioned, it needs to find all the value of the 'IORES_DESC_ACPI_*'
type, so we should explicitly use the 'IORES_DESC_ACPI_*' type as the check
condition instead of the 'IORES_DESC_NONE'.

Thanks.
Lianbo

> 
> The justification for that change sounds really fishy.
> 
