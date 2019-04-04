Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD885C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927762082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbfDDOAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:00:02 -0400
Received: from www62.your-server.de ([213.133.104.62]:58588 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfDDOAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:00:02 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hC2ti-0006Pc-VJ; Thu, 04 Apr 2019 15:59:19 +0200
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hC2ti-000VT2-KB; Thu, 04 Apr 2019 15:59:18 +0200
Subject: Re: [PATCH net-next v2] tcp: Ensure DCTCP reacts to losses
To:     Neal Cardwell <ncardwell@google.com>,
        "Tilmans, Olivier (Nokia - BE/Antwerp)" 
        <olivier.tilmans@nokia-bell-labs.com>
Cc:     "De Schepper, Koen (Nokia - BE/Antwerp)" 
        <koen.de_schepper@nokia-bell-labs.com>,
        Bob Briscoe <research@bobbriscoe.net>,
        Lawrence Brakmo <brakmo@fb.com>,
        Florian Westphal <fw@strlen.de>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Shewmaker <agshew@gmail.com>,
        Glenn Judd <glenn.judd@morganstanley.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190404121731.13917-1-olivier.tilmans@nokia-bell-labs.com>
 <CADVnQy=hsPrDwXoym18j7YzCc36669NJ1kVBR76y+FgK6Meytw@mail.gmail.com>
 <CADVnQyks1T8KZibJF+UWR0zWGvqs+fUBkCYPJFxATx5PU-csSQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a5e4be03-24bd-8aec-529f-dda47c992f36@iogearbox.net>
Date:   Thu, 4 Apr 2019 15:59:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CADVnQyks1T8KZibJF+UWR0zWGvqs+fUBkCYPJFxATx5PU-csSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25409/Thu Apr  4 09:53:59 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2019 03:55 PM, Neal Cardwell wrote:
> On Thu, Apr 4, 2019 at 9:48 AM Neal Cardwell <ncardwell@google.com> wrote:
>> On Thu, Apr 4, 2019 at 8:24 AM Tilmans, Olivier (Nokia - BE/Antwerp)
>> <olivier.tilmans@nokia-bell-labs.com> wrote:
>>>
>>> From: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
>>>
>>> RFC8257 §3.5 explicitly states that "A DCTCP sender MUST react to
>>> loss episodes in the same way as conventional TCP".
>> ...
>>> This patch replace the clamping of alpha by setting ssthresh to
>>> half of cwnd for both fast retransmissions and RTOs, at most once
>>> per RTT. Consequently, the dctcp_clamp_alpha_on_loss module parameter
>>> has been removed.
>>
>> Acked-by: Neal Cardwell <ncardwell@google.com>
>>
>> Thanks!
> 
> FWIW, my vote is that this is an important bug fix that is appropriate
> for the net branch and -stable releases, rather than net-next.

Agree, my preference would be for -net tree as well. Thanks for the fix!

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
