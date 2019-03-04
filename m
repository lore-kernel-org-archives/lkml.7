Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A70C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C6C20645
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfCDMBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:01:44 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60774 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfCDMBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:01:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73ED6A78;
        Mon,  4 Mar 2019 04:01:43 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A32AD3F703;
        Mon,  4 Mar 2019 04:01:39 -0800 (PST)
Subject: Re: [PATCH v3 05/34] c6x: mm: Add p?d_large() definitions
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-c6x-dev@linux-c6x.org, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Mark Salter <msalter@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-6-steven.price@arm.com>
 <20190301214851.ucems2icwt64iabx@kshutemo-mobl1>
From:   Steven Price <steven.price@arm.com>
Message-ID: <f840db0e-bbb3-db7e-d883-79b5a630767c@arm.com>
Date:   Mon, 4 Mar 2019 12:01:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190301214851.ucems2icwt64iabx@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2019 21:48, Kirill A. Shutemov wrote:
> On Wed, Feb 27, 2019 at 05:05:39PM +0000, Steven Price wrote:
>> walk_page_range() is going to be allowed to walk page tables other than
>> those of user space. For this it needs to know when it has reached a
>> 'leaf' entry in the page tables. This information is provided by the
>> p?d_large() functions/macros.
>>
>> For c6x there's no MMU so there's never a large page, so just add stubs.
> 
> Other option would be to provide the stubs via generic headers form !MMU.
> 

I agree that could be done, but equally the definitions of
p?d_present/p?d_none/p?d_bad etc could be provided by a generic header
for !MMU but currently are not. It makes sense to keep the p?d_large
definitions next to the others.

I'd prefer to stick with a (relatively) small change here - it's already
quite a long series! But this is certainly something that could be
tidied up for !MMU archs.

Steve
