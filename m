Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77776C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 06:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F3E208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 06:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfHKGvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 02:51:16 -0400
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:5710 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfHKGvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 02:51:15 -0400
Received: from thorin.petrovitsch.priv.at (80-110-97-231.cgn.dynamic.surfer.at [80.110.97.231])
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id x7B6oTFa029135
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO);
        Sun, 11 Aug 2019 08:50:30 +0200
Subject: Re: [PATCH] Makefile: Convert -Wimplicit-fallthrough=3 to just
 -Wimplicit-fallthrough for clang
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
 <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
 <CAHk-=wiL7jqYNfYrNikgBw3byY+Zn37-8D8yR=WUu0x=_2BpZA@mail.gmail.com>
 <6a5f470c1375289908c37632572c4aa60d6486fa.camel@perches.com>
 <20190811020442.GA22736@archlinux-threadripper>
 <871efd6113ee2f6491410409511b871b7637f9e3.camel@perches.com>
 <20190811031715.GA22334@archlinux-threadripper>
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Message-ID: <514fb156-7d81-a812-510a-7f252c27e79e@petrovitsch.priv.at>
Date:   Sun, 11 Aug 2019 08:50:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190811031715.GA22334@archlinux-threadripper>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-DCC-EATSERVER-Metrics: esgaroth.tuxoid.at 1166; Body=6 Fuz1=6 Fuz2=6
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2019 05:17, Nathan Chancellor wrote:
> On Sat, Aug 10, 2019 at 08:06:05PM -0700, Joe Perches wrote:
>> On Sat, 2019-08-10 at 19:04 -0700, Nathan Chancellor wrote:
>>> On a tangential note, how are you planning on doing the fallthrough
>>> comment to attribute conversion? The reason I ask is clang does not
>>> support the comment annotations, meaning that when Nathan Huckleberry's
>>> patch is applied to clang (which has been accepted [1]), we are going
>>> to get slammed by the warnings. I just ran an x86 defconfig build at
>>> 296d05cb0d3c with his patch applied and I see 27673 instances of this
>>> warning... (mostly coming from some header files so nothing crazy but it
>>> will be super noisy).
>>>
>>> If you have something to share like a script or patch, I'd be happy to
>>> test it locally.
>>>
>>> [1]: https://reviews.llvm.org/D64838
>>
>> Something like this patch:
>>
>> https://lore.kernel.org/patchwork/patch/1108577/
>>
>> Maybe use:
>>
>> #define fallthrough [[fallthrough]]
>>
>> if the compiler supports that notation
>>
> 
> That patch as it stands will work with D64838, as it is adding support
> for the GNU fallthrough attribute.
>
> However, I assume that all of the /* fall through */ comments will need
> to be converted to the attribute macro, was that going to be done with
> Coccinelle or something else?

clang has not problem with the comment - it's just a comment;-)

The #define above works BTW.

MfG,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
