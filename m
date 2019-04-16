Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FB6C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC66020651
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfDPJ2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:28:42 -0400
Received: from www62.your-server.de ([213.133.104.62]:42920 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbfDPJ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:28:39 -0400
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJpX-0007uW-No; Tue, 16 Apr 2019 10:52:39 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJpX-0003vr-Cx; Tue, 16 Apr 2019 10:52:39 +0200
Subject: Re: [PATCH bpf v2] tools: bpftool: fix infinite loop in map create
To:     Alban Crequy <alban.crequy@gmail.com>, ast@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alban@kinvolk.io, iago@kinvolk.io
References: <20190412124050.32120-1-alban@kinvolk.io>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6f39c306-465b-66ae-44f1-534654bf9579@iogearbox.net>
Date:   Tue, 16 Apr 2019 10:52:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190412124050.32120-1-alban@kinvolk.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25420/Mon Apr 15 09:57:25 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2019 02:40 PM, Alban Crequy wrote:
> From: Alban Crequy <alban@kinvolk.io>
> 
> "bpftool map create" has an infinite loop on "while (argc)". The error
> case is missing.
> 
> Symptoms: when forgetting to type the keyword 'type' in front of 'hash':
> $ sudo bpftool map create /sys/fs/bpf/dir/foobar hash key 8 value 8 entries 128
> (infinite loop, taking all the CPU)
> ^C
> 
> After the patch:
> $ sudo bpftool map create /sys/fs/bpf/dir/foobar hash key 8 value 8 entries 128
> Error: unknown arg hash
> 
> Fixes: 0b592b5a01be ("tools: bpftool: add map create command")
> Signed-off-by: Alban Crequy <alban@kinvolk.io>

Applied, thanks!
