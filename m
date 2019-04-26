Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB9FC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E46B2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfDZMIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:08:37 -0400
Received: from www62.your-server.de ([213.133.104.62]:40134 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDZMIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:08:36 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hJzeN-00059X-Ex; Fri, 26 Apr 2019 14:08:20 +0200
Received: from [178.199.41.31] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hJzeN-0002hV-8j; Fri, 26 Apr 2019 14:08:19 +0200
Subject: Re: [PATCH] bpf, x32: Fix bug for BPF_JMP | {BPF_JSGT, BPF_JSLE,
 BPF_JSLT, BPF_JSGE}
To:     Wang YanQing <udknight@gmail.com>, ast@kernel.org,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, tglx@linutronix.de,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190426105609.GA19147@udknight>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6735a15f-57af-2d09-016e-d81b1877eca6@iogearbox.net>
Date:   Fri, 26 Apr 2019 14:08:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190426105609.GA19147@udknight>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25431/Fri Apr 26 09:57:33 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

On 04/26/2019 12:56 PM, Wang YanQing wrote:
> The current method to compare 64-bit numbers for conditional jump is:
> 
> 1) Compare the high 32-bit first.
> 
> 2) If the high 32-bit isn't the same, then goto step 4.
> 
> 3) Compare the low 32-bit.
> 
> 4) Check the desired condition.
> 
> This method is right for unsigned comparison, but it is buggy for signed
> comparison, because it does signed comparison for low 32-bit too.
> 
> There is only one sign bit in 64-bit number, that is the MSB in the 64-bit
> number, it is wrong to treat low 32-bit as signed number and do the signed
> comparison for it.
> 
> This patch fixes the bug.
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>

I presume this issue has coverage in our BPF kselftest suite, right? (If
not, please also add a test into the test_verifier tool.)

Thanks,
Daniel
