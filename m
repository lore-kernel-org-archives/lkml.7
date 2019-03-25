Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7453FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4710920879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfCYOhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:37:33 -0400
Received: from www62.your-server.de ([213.133.104.62]:47760 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbfCYOhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:37:32 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8Qj8-0002YL-6x; Mon, 25 Mar 2019 15:37:26 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8Qj7-0004hr-Uo; Mon, 25 Mar 2019 15:37:26 +0100
Subject: Re: [PATCH] x86, retpolines: entirely disable switch jump tables when
 retpolines are enabled
To:     David Woodhouse <dwmw2@infradead.org>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, mliska@suse.cz,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
References: <20190325135620.14882-1-daniel@iogearbox.net>
 <73ab8319a67a2d894564019c6bb0a806455987c6.camel@infradead.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d7965189-c984-b177-8c69-c0e7ee78e71f@iogearbox.net>
Date:   Mon, 25 Mar 2019 15:37:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <73ab8319a67a2d894564019c6bb0a806455987c6.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25399/Mon Mar 25 08:46:48 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/2019 03:28 PM, David Woodhouse wrote:
> On Mon, 2019-03-25 at 14:56 +0100, Daniel Borkmann wrote:
>> More than 20 switch cases are not expected to be fast-path critical, but
>> it would still be good to align with gcc behavior for versions < 8.4.0 in
>> order to have consistency across supported gcc versions. vmlinux size is
>> slightly growing by 0.27% for older gcc. This flag is only set to work
>> around affected gcc, no change for clang.
> 
> I note your final sentence doesn't actually say that clang doesn't have
> this problem, and doesn't *need* this (or an equivalent) change.
> 
> It should say that (if it's true). And if it isn't true, then other
> remedial action would be in order.

clang doesn't have this problem as analyzed back in ce02ef06fcf7 ("x86,
retpolines: Raise limit for generating indirect calls from switch-case").

I thought both here would make it quite clear, from this patch commit msg:

"After this has been brought to attention to gcc folks [0], Martin Liska
 has then fixed gcc to align with clang by avoiding to generate switch
 jump tables entirely under retpolines."

And the comment in the Makefile code:

  # Additionally, avoid generating expensive indirect jumps which
  # are subject to retpolines for small number of switch cases.
  # clang turns off jump table generation by default when under
  # retpoline builds, however, gcc does not for x86. This has
  # only been fixed starting from gcc stable version 8.4.0 and
  # onwards, but not for older ones. See gcc bug #86952.

Thanks,
Daniel
