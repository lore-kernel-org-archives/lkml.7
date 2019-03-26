Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710F2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D07C20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfCZB1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:27:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbfCZB1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:27:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDE4583F40;
        Tue, 26 Mar 2019 01:27:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2FC73842;
        Tue, 26 Mar 2019 01:27:41 +0000 (UTC)
Subject: Re: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when
 SEV is active
To:     Borislav Petkov <bp@alien8.de>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "bhe@redhat.com" <bhe@redhat.com>
References: <20190315103203.13128-1-lijiang@redhat.com>
 <20190315103203.13128-2-lijiang@redhat.com> <20190324150034.GH23289@zn.tnic>
 <7b115829-40d9-e55e-dee3-ec8e4766971f@redhat.com>
 <20190325063742.GA12016@zn.tnic>
 <652b9166-f06e-c210-3c3f-c9e80a97db18@amd.com>
 <20190325173239.GO12016@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <a15e03a2-c2da-aa2f-d0b7-c18d23f49ea8@redhat.com>
Date:   Tue, 26 Mar 2019 09:27:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190325173239.GO12016@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 26 Mar 2019 01:27:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年03月26日 01:32, Borislav Petkov 写道:
> On Mon, Mar 25, 2019 at 05:17:55PM +0000, Singh, Brijesh wrote:
>> By default all the memory regions are mapped encrypted. The
>> set_memory_{encrypt,decrypt}() is a generic function which can be
>> called explicitly to clear/set the encryption mask from the existing
>> memory mapping. The mem_encrypt_active() returns true if either SEV or 
>> SME is active. So the __set_memory_enc_dec() uses the
>> memory_encrypt_active() check to ensure that the function is no-op when
>> SME/SEV are not active.
>>
>> Currently, the arch_kexec_post_alloc_pages() unconditionally clear the
>> encryption mask from the kexec area. In case of SEV, we should not clear
>> the encryption mask.
> 
> Brijesh, I know all that.
> 
> Please read what I said here at the end:
> 
> https://lkml.kernel.org/r/20190324150034.GH23289@zn.tnic
> 
> With this change, the code looks like this:
> 
> +       if (sme_active())
> +               return set_memory_decrypted((unsigned long)vaddr, pages);
> 
> now in __set_memory_enc_dec via set_memory_decrypted():
> 
>         /* Nothing to do if memory encryption is not active */
>         if (!mem_encrypt_active())
>                 return 0;
> 
> 
> so you have:
> 
> 	if (sme_active())
> 
> 		...
> 
> 		if (!mem_encrypt_active())
> 
> 
> now maybe this is all clear to you and Tom but I betcha others will get
> confused. Probably something like "well, what should be active now, SME,
> SEV or memory encryption in general"?
> 
> I hope you're catching my drift.
> 
> So if you want to *not* decrypt memory in the SEV case, then doing something
> like this should make it a bit more clear:
> 
> 
> 	if (sev_active())
> 		return;
> 
> 	return set_memory_decrypted((unsigned long)vaddr, pages);
> 
> along with a comment *why* we're checking here.
It looks good to me. I will improve them next post.

Thank you, everyone.

Lianbo

> 
> But actually, I'd prefer if you had separate wrappers which are called
> for SME and for SEV.
> 
> I'll let Tom chime in too.
> 
