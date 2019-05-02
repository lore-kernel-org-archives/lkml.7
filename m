Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD59C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D9620C01
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ETPo3WkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfEBRK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 13:10:26 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:43630 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725951AbfEBRK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 13:10:26 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B92D7C0092;
        Thu,  2 May 2019 17:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556817022; bh=Qt62Y3vxu+KfJcsq7q4JgVlHgFUN/Raw5NaEkLKKBXo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=ETPo3WkP3jh7U9lo+qsrUBj6OrHoRaNQgqy1XlNbo/4YZVMjUryzhLCoF3ZIl8wS8
         dOSMyz+V9MCeOHsVrqTEl+fS/2zkeA4FEcccKo2A4dxoIIvKjaIvgWGtuExKvO9dc5
         xh9+igmTHz8sDk8+XvHx3bhvNKbgRhvV99oGi+nCTif583HWjtS0dcfhXj0bYhX0Nn
         yRKaltKxs10jayImLJ+dgWyb7voESiApLOQ3Ri+peroCEWI3tvmxv10HQcfyCl89K6
         lBpq3koWEard95xx6urIDMbGnaGFBKrPOYpS0G+PjBgYGjgJY+pMuAck9o/JgpBDfL
         qTZ/9TW3aURiA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 32E06A0067;
        Thu,  2 May 2019 17:10:23 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 2 May 2019 10:10:22 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 2 May 2019 22:40:32 +0530
Received: from [10.10.161.89] (10.10.161.89) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 2 May 2019 22:40:32 +0530
Subject: Re: perf tools build broken after v5.1-rc1
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "Jiri Olsa" <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.perf.user,gmane.linux.kernel.arc
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A250584C@us01wembx1.internal.synopsys.com>
 <CAK8P3a2JrAApXDws+t=q8AnKFkHJZSox7gsgwW-xEJTfs_mdzw@mail.gmail.com>
 <20190501204115.GF21436@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A2506BF3@us01wembx1.internal.synopsys.com>
 <20190502143618.GH21436@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A2506D04@us01wembx1.internal.synopsys.com>
 <20190502164104.GB23984@kernel.org>
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 hhqBJlyU6MVUa6vZNv8E
Message-ID: <506c2df7-4088-9a18-91c0-c86b944714da@synopsys.com>
Date:   Thu, 2 May 2019 10:10:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502164104.GB23984@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.89]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/19 9:41 AM, Arnaldo Carvalho de Melo wrote:
>> While this takes care of immediate issues, for the long term, are you open to idea
>> of removing the header duplicity.
>
> In the beginning we used the kernel headers directly, then, acting on
> advice/complaints from Linus about tooling breaking when changes were
> made in the kernel sources we were using directly, we moved to have
> copies and notice when things change so that we could think about what
> changed and act accordingly, without putting the burden to the kernel
> developers to keep tools/ building, I want to keep it that way.

Sure, and the reduced duplicity I propose doesn't change that in any way. The onus
is still on perf maintainers to copy over any unistd changes - in the new regime,
it will be just lesser since we only care about a handful of syscalls, not the
entire unistd.


> Now you say, validly, that there are bits that are designed to be used
> by userspace, so for those, we should go back to not copying and using
> it direcly, elliminating the duplicity you don't like.

Indeed.

> I don't know, I'm used to the duplicity and the checks,

:-)

> not breaking
> tools even when kernel developers make mistakes in the UAPI headers,

Not sure how replacing the full header with just a small hunk, out of same header
out-of-line will change anything or cause any more breakage.

> tools/perf is self container wrt the latest and greatest stuff not
> present in older environments, and the onus is on perf developers to do
> the sync.

Sure it is, I'm proposing to make their work less, no more.


> This specific issue here happened because I made a mistake, which I
> fixed when reported,

Exactly, it was a genuien mistake with a super prompt followup - your promptness
is really appreciated and emulation worthy for other maintainers including myself ;-)

> now I have three containers for cross building for
> ARC, two versions for the uCLibc based toolchain, one for the glibc one,
> libnuma, elfutils and zlib are cross build there, so should make it less
> likely problems like this will happen again.

Ok, well lets leave it at that for now then.


>> We could use a "less evil" idiom of copying only the minimal bits (since the sync
>> onus remains one way or the other)
>> e.g. I spotted below in bpf code and also seen in other ah-hoc multi arch projects
>  
>> #ifdef __NR_xx
>> # if defined (__arch_y__)
>>
>> # elif defined (__arch_z__)
>>
>> # endif
>> #endif

Thx,
-Vineet
