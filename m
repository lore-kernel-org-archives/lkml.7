Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F41C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4A02089E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfHAGfw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:35:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:52715 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbfHAGfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:35:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 23:35:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,333,1559545200"; 
   d="scan'208";a="371909439"
Received: from irsmsx153.ger.corp.intel.com ([163.33.192.75])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jul 2019 23:35:48 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.59]) by
 IRSMSX153.ger.corp.intel.com ([169.254.9.166]) with mapi id 14.03.0439.000;
 Thu, 1 Aug 2019 07:35:47 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     'Kees Cook' <keescook@chromium.org>,
        'Ingo Molnar' <mingo@kernel.org>,
        'Andy Lutomirski' <luto@kernel.org>
CC:     'Theodore Ts'o' <tytso@mit.edu>,
        'David Laight' <David.Laight@aculab.com>,
        'Eric Biggers' <ebiggers3@gmail.com>,
        "'ebiggers@google.com'" <ebiggers@google.com>,
        "'herbert@gondor.apana.org.au'" <herbert@gondor.apana.org.au>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Daniel Borkmann' <daniel@iogearbox.net>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'jpoimboe@redhat.com'" <jpoimboe@redhat.com>,
        "'jannh@google.com'" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'bp@alien8.de'" <bp@alien8.de>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        'Peter Zijlstra' <a.p.zijlstra@chello.nl>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGAgACIbACAAbyQ8IAA626AgAGZfXCAAARpgIAAWpuAgAAF74CAABf/AIAAAvkAgAGZnrD///dzgIAHjbaA///31ICAAC4VAIABBxmAgAAfuaCAAA5FAIAED8OAgAAYaYCAAINWgIAAbRaAgBjvMfCAACWEgIABZK1ggACCc4CAX3oCYIAEYVlA
Date:   Thu, 1 Aug 2019 06:35:47 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4D530F0@IRSMSX102.ger.corp.intel.com>
References: <20190509055915.GA58462@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C7741F@IRSMSX102.ger.corp.intel.com>
 <20190509084352.GA96236@gmail.com>
 <CALCETrV1067Es=KEjkz=CtdoT79a2EJg4dJDae6oGDiTaubL1A@mail.gmail.com>
 <201905111703.5998DF5F@keescook> <20190512080245.GA7827@gmail.com>
 <201905120705.4F27DF3244@keescook>
 <2236FBA76BA1254E88B949DDB74E612BA4CA8DBF@IRSMSX102.ger.corp.intel.com>
 <20190528133347.GD19149@mit.edu>
 <2236FBA76BA1254E88B949DDB74E612BA4CABA56@IRSMSX102.ger.corp.intel.com>
 <201905291136.FD61FF42@keescook>
 <2236FBA76BA1254E88B949DDB74E612BA4D4BFCA@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4D4BFCA@IRSMSX102.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> The in-stack randomization is really a very small change both code wise and
>> logic wise.
>> It does not affect real workloads and does not require enablement of other
>> features (such as GCC plugins).
>> So, I think we should really reconsider its inclusion.

>I'd agree: the code is tiny and while the benefit can't point to a
>specific issue, it does point to the general weakness of the stack
>offset being predictable which has been a core observation for many
>stack-based attacks.

>If we're going to save state between syscalls (like the 4096 random
>bytes pool), how about instead we just use a single per-CPU long mixed
>with rdtsc saved at syscall exit. That should be a reasonable balance
>between all the considerations and make it trivial for the feature to
>be a boot flag without the extra page of storage, etc.

Sounds like a viable compromise for me. 
Ingo, Andy? 

Best Regards,
Elena.

