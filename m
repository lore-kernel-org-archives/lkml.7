Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B57C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C101A2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfDWHOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:14:16 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:48145 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWHOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:14:16 -0400
Received: from [192.168.1.115] ([95.114.123.200]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MCGag-1h9RhX3plC-009QMK; Tue, 23 Apr 2019 09:13:34 +0200
Subject: Re: [PATCH v3 1/4] Make anon_inodes unconditional
To:     Christian Brauner <christian@brauner.io>,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, oleg@redhat.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com
References: <20190419120904.27502-1-christian@brauner.io>
 <20190419120904.27502-2-christian@brauner.io>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <0dd5adcf-51e9-00a8-cc79-e9bd36b4125e@metux.net>
Date:   Tue, 23 Apr 2019 09:13:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190419120904.27502-2-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:emM3eXxI05JT8S+OqULP6Kg9KAarI3ieMQsAZsbHn+2f87O1dTG
 qruH0uUAPPSNglcBmk8TB3ixzR/0xM0ga2fJ3vtYGdIUJd+UAy6AJG2Bf737pjb6W0+THdt
 duVJBkhI2QpJf1YGM7leKASzixipcwsC/jG5V0c5ChFaTg33DXM2gCXJus/THWxsaYk3gIe
 KUrGN5ErNvYS4SAME6pPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:45EFRHFi3q4=:He2yMQis37HsWQqM7YTjVB
 YLh17sOB1jsT5Y/PgbecKXBs/ck6RIjeAHyVu5yTi8Zc8NuIusSo4Qwd82VBEOlss6zxE2I6D
 I/OjWf1BBj9jzfQVAws2i7tqZQ84v8Y696JHbKIqs/8auXvG1TmOhCYhf3u2LzHJtO3pLAqKX
 aE9UnrfShDqnM2vvynUds2Cb87TNdYKjtP1alongcxSf2Zy5xCTBLRwZdZ76c0ie+vFq0pZf1
 QmjWg2kxsklwv1oJJnsz8esUTplZbZij0FPVTOip9ptkrG4mef/R8AXGUqYjJolbK0nr9aHz5
 hx6zsCGLXKQOwdOiOE4WoZcGsCiIGGzXo1BQVbHegWl5u949Pxo+RD2EmO81eggHym47Dfvdh
 9d0jiWGYeKswBk8aHv0N7i3wDCZonOkpM1ijx+wj1gzuJYo+E5Jjmky92zh0hXUTs/aV5lk59
 3PenRXZzNX8N9M+YzYSQBw+5JhTFk1iqfpEjul6q1hL0+OtsgxsmAjPhBxGpaM0+bkYgY+XD9
 Cy2W3mRblgDSKGdYNCbD0+FDlVMliqnK4rJCjcdy2XQPUOlEDlGpm0TTSDFlC/pdaVT38DF3h
 WBgREpCj8If6nq3MkYFy4U5nwq1qWZGbx+VujBGn/hIiSpTKsKsgdcArpgxsyQBmQAUhDmUK7
 2iDU2vaZYItZhh4LvZAsqXtH87WJrySaT4GytcC5HmFdVmhUly+tFPLjWLXPUye96T05RpGBi
 rMTLGVYNQfPhnrYLa8XxcTnmDH5AYY2YipIuY+VGWufS5KTrUKNPhautC/g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.19 14:09, Christian Brauner wrote:

Hi,

> From: David Howells <dhowells@redhat.com>
> 
> Make the anon_inodes facility unconditional so that it can be used by core
> VFS code and pidfd code.

I'm not convinced this is necessary. Instead the new features should
select ANON_INODES when enabled. And yes: these features should be
configurable.

Why ? Because embedded folks need to trim down the kernel and drop
everything that's not absolutely needed.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
