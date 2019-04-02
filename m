Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225E0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA0720830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1YmP6KQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDBVdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:33:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33054 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfDBVdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pxXvuXnfM56qlzMiNlWVyG/CkRRcaj6fqDPZd0RAYPM=; b=1YmP6KQeQHWx3SMdOj0LydaEUq
        98pncAxzrBL6cChcEnJS0zBUelDTSqmeJIIveA/TmqW58oqUPKFwvOiFY6Luh1HSRpqdhN0A0GfTJ
        CC3DGehioMc43QhPaP0+XWTELZaQQpT431tVFstw6p21lYPdmEXTgPiXttegGcl3AwKz8PD9pfAtw
        rvJrYNZw4L8SC00H2zj3mpTsc5tNEAhaXtceFgxBc5hCc3wKgzg0vtNGYaD/icrGJg88Ycw+eLqmM
        19alfjQCMg8rSnzMsX/P//vbNaiJhMvLqQRKYKUwpQav4YWtVtAUqRVDVBlC5NJZl4mzcGzsVg9xx
        KdIWd4sg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBR1w-0005Rd-UD; Tue, 02 Apr 2019 21:33:17 +0000
Subject: Re: [PATCH v3 2/7] kselftest: Add test runner creation script
To:     Kees Cook <keescook@chromium.org>,
        "Tobin C. Harding" <tobin@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190306214226.14598-1-tobin@kernel.org>
 <20190306214226.14598-3-tobin@kernel.org>
 <CAGXu5j+=O3C6z7H5j93Z4mQkpS3f0ea_7T+LRQEnRCZCoKX8zw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <32a2dca5-d3cd-e7d3-e73b-406d897ae174@infradead.org>
Date:   Tue, 2 Apr 2019 14:33:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+=O3C6z7H5j93Z4mQkpS3f0ea_7T+LRQEnRCZCoKX8zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

nits/typos below:

On 4/2/19 2:27 PM, Kees Cook wrote:
> On Wed, Mar 6, 2019 at 1:43 PM Tobin C. Harding <tobin@kernel.org> wrote:
>>
>>
>> Add test runner creation script.
>>
>> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
>> ---
>>  tools/testing/selftests/kselftest_module.sh | 75 +++++++++++++++++++++
>>  1 file changed, 75 insertions(+)
>>  create mode 100755 tools/testing/selftests/kselftest_module.sh
>>
>> diff --git a/tools/testing/selftests/kselftest_module.sh b/tools/testing/selftests/kselftest_module.sh
>> new file mode 100755
>> index 000000000000..b5d446738614
>> --- /dev/null
>> +++ b/tools/testing/selftests/kselftest_module.sh
>> @@ -0,0 +1,75 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0+
>> +
>> +#
>> +# Runs an individual test module.  kselftest expects a separate
>> +# executable for each test.  So test should each have an individial

                                                             individual

>> +# script that can call this script.
>> +#
>> +
>> +# Individual test scrits should define these:

                      scripts

>> +module=""                      # filename (without the .ko).
>> +desc=""                                # Output prefix.


cheers.
-- 
~Randy
