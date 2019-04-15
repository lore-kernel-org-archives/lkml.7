Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855AEC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7E720645
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfDOMWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:22:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56793 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfDOMWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:22:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15BC4C0AC377;
        Mon, 15 Apr 2019 12:22:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CC2160156;
        Mon, 15 Apr 2019 12:22:26 +0000 (UTC)
Subject: Re: [PATCH 1/2 RESEND v10] x86/mm, resource: add a new I/O resource
 descriptor 'IORES_DESC_RESERVED'
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
References: <20190329123914.20939-1-lijiang@redhat.com>
 <20190329123914.20939-2-lijiang@redhat.com> <20190402090652.GD6826@zn.tnic>
 <c94f887e-2ac8-49c6-e02c-92453e1ad894@redhat.com>
 <20190402124328.GG6826@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <384ba880-1b53-8013-8be8-66f294c27100@redhat.com>
Date:   Mon, 15 Apr 2019 20:22:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190402124328.GG6826@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 15 Apr 2019 12:22:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年04月02日 20:43, Borislav Petkov 写道:
> On Tue, Apr 02, 2019 at 08:02:04PM +0800, lijiang wrote:
>> These regions(E820_TYPE_{RESERVED_KERN,RAM,UNUSABLE}) are still marked as
>> IORES_DESC_NONE and should not be mapped encrypted when using ioremap().
> 
> Seems to me like we're going in circles. You said here:
> 
> https://lkml.kernel.org/r/9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com
> 
> that the kernel doesn't pass the e820 reserved ranges to the second
> kernel.
> 
> I suggested to use a special IORES descriptor for them -
> IORES_DES_RESERVED.
> 
> Now you say that that is not enough and some of those you want passed,
> are still marked as IORES_DESC_NONE.
> 
Sorry for the delay.

They are different problems.

The first problem is that passes the e820 reserved ranges to the second kernel,
for this case, it is good enough to use the IORES_DESC_RESERVED, which can
ensure that exactly matches the reserved resource ranges when walking through
iomem resources.

The second problem is about the SEV case. Now, the IORES_DESC_RESERVED has been
created for the reserved areas, therefore the check needs to be expanded so that
these areas are not mapped encrypted when using ioremap().

+static int __ioremap_check_desc_none_and_reserved(struct resource *res)
 {
-       return (res->desc != IORES_DESC_NONE);
+       return ((res->desc != IORES_DESC_NONE) &&
+               (res->desc != IORES_DESC_RESERVED));
 }


Maybe i should split it into two patches. The change of __ioremap_check_desc_none_and_reserved()
should be a separate patch. Any idea?

Thanks.
Lianbo

> Sounds to me like you need try again.
>
