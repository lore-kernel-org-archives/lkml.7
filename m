Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E25CC28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530E8206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFEUKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:10:35 -0400
Received: from www62.your-server.de ([213.133.104.62]:36612 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfFEUKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:10:35 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1hYcEx-0002kS-Qb; Wed, 05 Jun 2019 22:10:31 +0200
Received: from [178.197.249.21] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hYcEx-000Xli-JO; Wed, 05 Jun 2019 22:10:31 +0200
Subject: Re: [BPF v1] tools: bpftool: Fix JSON output when lookup fails
To:     Krzesimir Nowak <krzesimir@kinvolk.io>, bpf@vger.kernel.org
Cc:     Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?Q?Iago_L=c3=b3pez_Galeiras?= <iago@kinvolk.io>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Stanislav Fomichev <sdf@google.com>,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Okash Khawaja <osk@fb.com>,
        David Calavera <david.calavera@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190605191707.24429-1-krzesimir@kinvolk.io>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bd439a28-fed1-b35c-79b0-2100c58584ed@iogearbox.net>
Date:   Wed, 5 Jun 2019 22:10:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190605191707.24429-1-krzesimir@kinvolk.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25471/Wed Jun  5 10:12:21 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2019 09:17 PM, Krzesimir Nowak wrote:
> In commit 9a5ab8bf1d6d ("tools: bpftool: turn err() and info() macros
> into functions") one case of error reporting was special cased, so it
> could report a lookup error for a specific key when dumping the map
> element. What the code forgot to do is to wrap the key and value keys
> into a JSON object, so an example output of pretty JSON dump of a
> sockhash map (which does not support looking up its values) is:
> 
> [
>     "key": ["0x0a","0x41","0x00","0x02","0x1f","0x78","0x00","0x00"
>     ],
>     "value": {
>         "error": "Operation not supported"
>     },
>     "key": ["0x0a","0x41","0x00","0x02","0x1f","0x78","0x00","0x01"
>     ],
>     "value": {
>         "error": "Operation not supported"
>     }
> ]
> 
> Note the key-value pairs inside the toplevel array. They should be
> wrapped inside a JSON object, otherwise it is an invalid JSON. This
> commit fixes this, so the output now is:
> 
> [{
>         "key": ["0x0a","0x41","0x00","0x02","0x1f","0x78","0x00","0x00"
>         ],
>         "value": {
>             "error": "Operation not supported"
>         }
>     },{
>         "key": ["0x0a","0x41","0x00","0x02","0x1f","0x78","0x00","0x01"
>         ],
>         "value": {
>             "error": "Operation not supported"
>         }
>     }
> ]
> 
> Fixes: 9a5ab8bf1d6d ("tools: bpftool: turn err() and info() macros into functions")
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>

Applied, thanks!
