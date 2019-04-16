Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F9EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65DB20652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfDPPNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:13:49 -0400
Received: from www62.your-server.de ([213.133.104.62]:55460 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfDPPNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:13:49 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGPKD-0005C2-DS; Tue, 16 Apr 2019 16:44:41 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGPKD-000AUB-4e; Tue, 16 Apr 2019 16:44:41 +0200
Subject: Re: BPF RNG
To:     Kees Cook <keescook@google.com>
Cc:     Hannes Frederic Sowa <hannes@stressinduktion.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <CAGXu5jL6LVU7KyUvwaEHWE6t2TaVBs5TWNayB5cW2=PWzSMyEw@mail.gmail.com>
 <CAGXu5j+Ny=1YF0BkATbU3Xb-fb=_0a1W-iZ3jYFhTcWrTPqCJQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <40a6486d-2dba-5574-06da-3e0ebb25f2b1@iogearbox.net>
Date:   Tue, 16 Apr 2019 16:44:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+Ny=1YF0BkATbU3Xb-fb=_0a1W-iZ3jYFhTcWrTPqCJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25421/Tue Apr 16 09:57:17 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/2019 03:55 PM, Kees Cook wrote:
> [correcting Alexei's email address and resending...]
> 
> On Tue, Apr 16, 2019 at 8:54 AM Kees Cook <keescook@google.com> wrote:
>>
>> Hi,
>>
>> In looking at prandom_u32() users, I noticed that BPF uses its own
>> state variable with bpf_user_rnd_u32(). It appears that this state is

Correct, we split that off from the main one.

>> never reseeded like regular prandom_u32(). (See __prandom_timer().) Is
>> this intentional, or should reseeding be happening?

The prng is not to be used in any security-critical context. That said,
we optionally could perform reseeding from time to time, though that
should probably be done generically, so that all "external"
prandom_u32_state() users could register themselves upon init whether
they opt-in for periodic reseeding or not.

Thanks,
Daniel
