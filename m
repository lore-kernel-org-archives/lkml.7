Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75369C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 11:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ED920706
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 11:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="g/errFyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfLNL1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 06:27:53 -0500
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:57297 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725895AbfLNL1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 06:27:52 -0500
Received: from [IPv6:2001:983:e9a7:1:c52:2c9:63c9:e34f]
 ([IPv6:2001:983:e9a7:1:c52:2c9:63c9:e34f])
        by smtp-cloud7.xs4all.net with ESMTPA
        id g5aOisLHbapzpg5aQikTpn; Sat, 14 Dec 2019 12:27:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1576322870; bh=nzyq0mgltd7eujv6kQMWXRQOAhLD8nHzYbknU6p3W0Q=;
        h=Subject:From:To:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=g/errFyks3JBDVrjv45WPQ274sgS32WNO2DcrKMarrejBR26w/P+dpCWMVtrUZcbQ
         OUu/3aAgdcF1KKaFlCpDvMGc1/TQn96eA61+LR3dazuBkO7woyhM+x53ozmtfVSApp
         sI2ce6mlm7u1tLUJxQ1VCHhYaBj3BeSfL/pfwg4dx6GgohNLtY9l/PdSdqBtXKNFvX
         9VIBYG4nlIbvriMrMndfNDSq5zpsty0dnzDyHQwoyLDcd7KrEjy9HuF6Ut3FzXk0YX
         SfXgTe7S9GiAl+SEWkTR0/XESeWX+9zv3UKaefXopf7XLvTWNmfrhSO0NMyvwghc83
         mRItAOkyQHs5Q==
Subject: Re: [PATCH v5 6/8] media: v4l2-core: fix v4l2_buffer handling for
 time64 ABI
From:   Hans Verkuil <hverkuil@xs4all.nl>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191126161824.337724-1-arnd@arndb.de>
 <20191126161824.337724-7-arnd@arndb.de>
 <09c664fd-87fb-4fac-f104-9afbe7d33aa2@xs4all.nl>
 <CAK8P3a1TvFCJf8t9T1yOXjsp088s9dbEOKLVDPinfwJe2B-27g@mail.gmail.com>
 <81bb5da1-6b84-8473-4ada-c174f43bbae2@xs4all.nl>
Message-ID: <0843718f-1391-3379-38be-41fa9558ea6d@xs4all.nl>
Date:   Sat, 14 Dec 2019 12:27:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <81bb5da1-6b84-8473-4ada-c174f43bbae2@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfI+6qlEmU4zRwcQGZcQkuwRnTzsDXY+L9CVkVfr2d+0iyXeZkc2nQ0Lec5MhODFFLRZzaxlqZSpd2B1ObmWXwLxnaCmVjLu7vE0j1TlmlJA27t5Wxb+R
 qUoIOKbcI43VZ8GIuYIYCLbMuol5fT0ArRP4wk6Yo62ULZZTdXkYvbTY17MGrKr2mqCbT21e5VACNaPC6OOlHwIQSahhCFJqoK8rgaJQDCMix0nfjvzVYmTC
 kTEq/Gzfyz7ESaXDloNOTxeR8GTC4BOeinRrGeuWEAQLoKN3WVaTXFnmIUHNKR6GfWD5MiNn5/KmRGoUS8++cZOudZ4lHwJrL0KNWJKZuYRdBr4WnzpIuoRd
 9Mhdg/wNspM+yqS5daY32PFI/zpmiSD8SAgjNwsMMFUzgNLeOpw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/19 4:32 PM, Hans Verkuil wrote:
>>> I am unable to test with musl since v4l2-ctl and v4l2-compliance are C++ programs,
>>> and there doesn't appear to be an easy way to compile a C++ program with musl.
>>>
>>> If you happen to have a test environment where you can compile C++ with musl,
>>> then let me know and I can give instructions on how to run the compliance tests.
>>>
>>> If you can't test that, then I can merge this regardless, and hope for the best
>>> once the Y2038 fixes end up in glibc. But ideally I'd like to have this tested.
>>
>> I've heard good things about the prebuilt toolchains from http://musl.cc/.
>> These seems to come with a libstdc++, but I have not tried that myself.
> 
> I'll see if I can give those a spin, but if I can't get it to work quickly,
> then I don't plan on spending much time on it.

I managed to build v4l2-ctl/compliance with those toolchains, but they seem to be
still using a 32-bit time_t.

Do I need to get a specific version or do something special?

Regards,

	Hans
