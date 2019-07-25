Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE66C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9CD21951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389116AbfGYP1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:27:11 -0400
Received: from gecko.sbs.de ([194.138.37.40]:59964 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388457AbfGYP1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:27:11 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id x6PFR12c018059
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 17:27:01 +0200
Received: from [139.23.76.89] ([139.23.76.89])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x6PFR1oM018756;
        Thu, 25 Jul 2019 17:27:01 +0200
Subject: Re: [PATCH v3 07/12] kbuild: modpost: read modules.order instead of
 $(MODVERDIR)/*.mod
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190717061800.10018-1-yamada.masahiro@socionext.com>
 <20190717061800.10018-8-yamada.masahiro@socionext.com>
 <230d2ca1-19cd-b60e-1b1b-6d7413eea9e2@siemens.com>
 <CAK7LNARu--p-tiJA2RGM5_KSQPSeo6-pkp-4GRd2AwM_1dtD7Q@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0ee802e1-5563-3615-d08f-c936d4e96ebc@siemens.com>
Date:   Thu, 25 Jul 2019 17:27:00 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <CAK7LNARu--p-tiJA2RGM5_KSQPSeo6-pkp-4GRd2AwM_1dtD7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.19 17:18, Masahiro Yamada wrote:
> Hi Jan,
> 
> On Thu, Jul 25, 2019 at 5:39 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>
>>
>> This affects also external modules builds: I have patterns here that do
>>
>> [Makefile]
>> subdir-y := some-module
>>
>> [some-module/Makefile]
>> obj-m := some-module.o
>>
>> and since this patch, the final some-module.ko is no longer built. Am I missing
>> something in the kbuild makefiles, or is this a regression?
> 
> Thanks for the report.
> Interesting. I have never imagined that Makefiles were written like that.
> 
> I just wrote a fix-up, but I have not determined to apply it.
> https://patchwork.kernel.org/patch/11059033/
> 
> It is easy to fixup your Makefile, though.

Thanks for addressing this quickly! I'm happy to adjust our code [1]. Is the
suggested pattern usable with recent stable kernels as well, say down to 4.4 at
least?

Jan

[1] https://github.com/siemens/jailhouse/blob/master/Kbuild#L54

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
