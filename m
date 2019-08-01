Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66100C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D1E20B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DeAqgFnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbfHALqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:46:15 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41888 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfHALqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:46:15 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so69727470qtj.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 04:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ji9M1yX+YQfbla2NsLs+sY5Cv6jiMB46Tl3q0Srbae8=;
        b=DeAqgFnBS/ODi7Z7oKwA7CiEzCSUtve9oUVSnmmseRmMIDejgfAbdrdaaQHfOSbJyh
         G/5qzqgha8dwdYfvIYnT8lx56A9Oc3kz4XzulYsJUdC4ur1esvlRDIubDEGdby/dvn5X
         vFeUteP296yILmYSMf4/E3/y7K0FljbPuLGIgiYZEF3S5Ol5lA1GvFEF+uY0FJ0ck1KL
         iVcupjGeufbu/HhEG7G2Xj8Q9f87C5P/a0ok3xVwJkVksx88uMdiv6Jlaq/rDsD+hnCV
         j1Pm2DzjKVQxL2vmTzo0dYpsBgQtUNbJqy4pSR6sdmMsC+wPsNFIhRdO43AyyCocJgXj
         1jSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ji9M1yX+YQfbla2NsLs+sY5Cv6jiMB46Tl3q0Srbae8=;
        b=oR1pFHl3HVjnh348mQg8S/1Z4rBJnkORy7+xoXty9H+PQZrZFKF7p83cq2ISHW8pMZ
         IKPPMeelbnP6EiCJkiImQxaJoSjp2IacVgQL5QFe4bpGc3Yghrrn4x9qmCMgC4Bj8lMP
         NVs1uXbP2zaZAevtTH1dirqzoCrigunoYdZSkY8kAVYWK3QxppNcQnzVCcBJV1iKyejC
         mZLGBbaGqr6HVqXxs8S2HTZr8jGSMAjt2khc16cmfcymVcgkOX8iTxL9IKnVs7wajdJy
         9UnJwuoOyTEYUBcyfiMXaiNQgp64zP1KbYc96N6jFV4lJ0EFEaGY4McsYuSz2z88lpdy
         yK3Q==
X-Gm-Message-State: APjAAAWOK3bU1SjlNYByHdyVJx27ZvGqsAkENuvSH4Iy35H0Hd7A5v5+
        Ebj4n/NM8EDk9j5ZsYYEXxC0B+yY+RqsLg==
X-Google-Smtp-Source: APXvYqxQzX6GSyEt/KYH4tIGLdfmqpWTbK24pum1MnBSCFJ90L7fLUP908m18PqJbphN1k7Ldv4qtQ==
X-Received: by 2002:a05:6214:42e:: with SMTP id a14mr94443239qvy.19.1564659973840;
        Thu, 01 Aug 2019 04:46:13 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 39sm39030400qts.41.2019.08.01.04.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 04:46:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: "mm: account nr_isolated_xxx in [isolate|putback]_lru_page"
 breaks OOM with swap
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190801065108.GA179251@google.com>
Date:   Thu, 1 Aug 2019 07:46:10 -0400
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <53837B9C-7E73-47DA-9373-5E989A9EEC4F@lca.pw>
References: <1564503928.11067.32.camel@lca.pw>
 <20190731053444.GA155569@google.com> <1564589346.11067.38.camel@lca.pw>
 <1564597080.11067.40.camel@lca.pw> <20190801065108.GA179251@google.com>
To:     Minchan Kim <minchan@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 1, 2019, at 2:51 AM, Minchan Kim <minchan@kernel.org> wrote:
>=20
> On Wed, Jul 31, 2019 at 02:18:00PM -0400, Qian Cai wrote:
>> On Wed, 2019-07-31 at 12:09 -0400, Qian Cai wrote:
>>> On Wed, 2019-07-31 at 14:34 +0900, Minchan Kim wrote:
>>>> On Tue, Jul 30, 2019 at 12:25:28PM -0400, Qian Cai wrote:
>>>>> OOM workloads with swapping is unable to recover with linux-next =
since
>>>>> next-
>>>>> 20190729 due to the commit "mm: account nr_isolated_xxx in
>>>>> [isolate|putback]_lru_page" breaks OOM with swap" [1]
>>>>>=20
>>>>> [1] =
https://lore.kernel.org/linux-mm/20190726023435.214162-4-minchan@kerne
>>>>> l.
>>>>> org/
>>>>> T/#mdcd03bcb4746f2f23e6f508c205943726aee8355
>>>>>=20
>>>>> For example, LTP oom01 test case is stuck for hours, while it =
finishes in
>>>>> a
>>>>> few
>>>>> minutes here after reverted the above commit. Sometimes, it prints =
those
>>>>> message
>>>>> while hanging.
>>>>>=20
>>>>> [  509.983393][  T711] INFO: task oom01:5331 blocked for more than =
122
>>>>> seconds.
>>>>> [  509.983431][  T711]       Not tainted 5.3.0-rc2-next-20190730 =
#7
>>>>> [  509.983447][  T711] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs"
>>>>> disables this message.
>>>>> [  509.983477][  T711] oom01           D24656  5331   5157 =
0x00040000
>>>>> [  509.983513][  T711] Call Trace:
>>>>> [  509.983538][  T711] [c00020037d00f880] [0000000000000008] 0x8
>>>>> (unreliable)
>>>>> [  509.983583][  T711] [c00020037d00fa60] [c000000000023724]
>>>>> __switch_to+0x3a4/0x520
>>>>> [  509.983615][  T711] [c00020037d00fad0] [c0000000008d17bc]
>>>>> __schedule+0x2fc/0x950
>>>>> [  509.983647][  T711] [c00020037d00fba0] [c0000000008d1e68]
>>>>> schedule+0x58/0x150
>>>>> [  509.983684][  T711] [c00020037d00fbd0] [c0000000008d7614]
>>>>> rwsem_down_read_slowpath+0x4b4/0x630
>>>>> [  509.983727][  T711] [c00020037d00fc90] [c0000000008d7dfc]
>>>>> down_read+0x12c/0x240
>>>>> [  509.983758][  T711] [c00020037d00fd20] [c00000000005fb28]
>>>>> __do_page_fault+0x6f8/0xee0
>>>>> [  509.983801][  T711] [c00020037d00fe20] [c00000000000a364]
>>>>> handle_page_fault+0x18/0x38
>>>>=20
>>>> Thanks for the testing! No surprise the patch make some bugs =
because
>>>> it's rather tricky.
>>>>=20
>>>> Could you test this patch?
>>>=20
>>> It does help the situation a bit, but the recover speed is still way =
slower
>>> than
>>> just reverting the commit "mm: account nr_isolated_xxx in
>>> [isolate|putback]_lru_page". For example, on this powerpc system, it =
used to
>>> take 4-min to finish oom01 while now still take 13-min.
>>>=20
>>> The oom02 (testing NUMA mempolicy) takes even longer and I gave up =
after 26-
>>> min
>>> with several hang tasks below.
>>=20
>> Also, oom02 is stuck on an x86 machine.
>=20
> Yeb, above my patch had a bug to test page type after page was freed.
> However, after the review, I found other bugs but I don't think it's
> related to your problem, either. Okay, then, let's revert the patch.
>=20
> Andrew, could you revert the below patch?
> "mm: account nr_isolated_xxx in [isolate|putback]_lru_page"
>=20
> It's just clean up patch and isn't related to new madvise hint system =
call now.
> Thus, it shouldn't be blocker.
>=20
> Anyway, I want to fix the problem when I have available time.
> Qian, What's the your config and system configuration on x86?
> Is it possible to reproduce in qemu?
> It would be really helpful if you tell me reproduce step on x86.

https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config

The config could work in Openstack, and I never tried in QEMU. It might =
need
a few modification here or there. The reproduced x86 server is,

HPE ProLiant DL385 Gen10
AMD EPYC 7251 8-Core Processor
Smart Storage PQI 12G SAS/PCIe 3
Memory: 32768 MB
NUMA Nodes: 8=
