Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC001C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9210206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sdgb6fcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfHMXHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 19:07:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43062 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfHMXHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 19:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XR/aTfxjW+u4/IwnrY5MnVS9VjSpHvSRvQz/tDpgxco=; b=sdgb6fcL0M6F1fiyrpgLRXefvJ
        2JfPHBWZW8mQVHXce0aSdczbiZ8MaglNQ5bZOZO4se/4fCcy2sCVJ8R+cnAOjPd2o00G/gnCdxEvw
        I4TqaEMfdneeWH6Uyx7QmXGFOa841NYs5YukBDoALKh4cS9CdqO16F2pvLGJUI0yd2zWm+Q82TVVf
        Fvrn/+8tlnHMJ/oRbblf3JGW3KaH2q3FWEwS0H7XQemENHS8LpNc62rgzyJQbgRQvOQNsQ4ccta7O
        GYnJaN00QGOU2P8xvXdodvVFK3WwOFFWFY+RUSWKhv9OtVWqdOhYOyMO3UqKKnyHDBnqNemAv+OK/
        hU65PrTA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxfsi-0007CK-6Q; Tue, 13 Aug 2019 23:07:08 +0000
Subject: Re: Build regressions/improvements in v5.3-rc4
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190812102049.27836-1-geert@linux-m68k.org>
 <a74dd048-8501-a973-5b03-eefbc83d7f79@infradead.org>
 <CAMuHMdVAKwTWeeT4H6NrzvRc2Fgav0owAqGjRtZawOLOf=HVAA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cce06e87-ff83-2e90-7748-28f05ddc80df@infradead.org>
Date:   Tue, 13 Aug 2019 16:07:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVAKwTWeeT4H6NrzvRc2Fgav0owAqGjRtZawOLOf=HVAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/19 2:09 PM, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Mon, Aug 12, 2019 at 10:34 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 8/12/19 3:20 AM, Geert Uytterhoeven wrote:
>>> Below is the list of build error/warning regressions/improvements in
>>> v5.3-rc4[1] compared to v5.2[2].
>>>
>>> Summarized:
>>>   - build errors: +5/-1
>>>   - build warnings: +137/-136
>>>
>>> JFYI, when comparing v5.3-rc4[1] to v5.3-rc3[3], the summaries are:
>>>   - build errors: +0/-4
>>>   - build warnings: +105/-69
>>>
>>> Happy fixing! ;-)
>>>
>>> Thanks to the linux-next team for providing the build service.
>>>
>>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d45331b00ddb179e291766617259261c112db872/ (all 242 configs)
>>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0ecfebd2b52404ae0c54a878c872bb93363ada36/ (all 242 configs)
>>> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e21a712a9685488f5ce80495b37b9fdbe96c230d/ (all 242 configs)
>>
>>
>>> *** WARNINGS ***
>>>
>>> 137 warning regressions:
>>
>>>   + warning: unmet direct dependencies detected for MTD_COMPLEX_MAPPINGS:  => N/A
> 
> WARNING: unmet direct dependencies detected for MTD_COMPLEX_MAPPINGS:
> 8 warnings in 2 logs
>         v5.3-rc4/um-x86_64/um-allyesconfig v5.3-rc4/um-x86_64/um-allmodconfig

Thanks.  I sent patches for 2 drivers that should depend on HAS_IOMEM.

>> It would be Really Good if there was some automated way to know which
>> of the 242 configs this is from (instead of you having to grep and reply to
>> email or someone/me having to download up to 242 log files).
> 
> I used to upload the summary containing that info to kernel.org. Then they
> made kup mandatory, and during the last 7 years, I still haven't looked into
> mastering kup. Ugh...

Ack and ditto here.

-- 
~Randy
