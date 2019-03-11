Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A633C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475A2214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552346191;
	bh=LnjANkZ+uvjp0aJvECm1ram1U1TbrSbsqAjAqxg9evw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gFB5ljBVfYiOcK+1F8V1rfByAj6ZLfkxOrhO4rJiVSI+w8fhvOiQ92LHurqudBqhw
	 gqxJblLSZYJsBbllS9hGJwZIPrpFSCzCBQ9uC1YYrQwZZqQ26fMny2Hc/grNkpUXcv
	 MJWalpFXtaLIAa2KuhAfAycALEunS0F8exZEyyoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfCKXQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfCKXQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:16:29 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 706BD2148D;
        Mon, 11 Mar 2019 23:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552346188;
        bh=LnjANkZ+uvjp0aJvECm1ram1U1TbrSbsqAjAqxg9evw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLWiwHZ4vGL96dh+px6EvERsIO+MW6KrAhSZiOgKP6B7X0I+FNneHLlOrz1NOTwjO
         2lZ+ug3M4C8+eGp6cdAZgCmChN2YonKwJj2cCt/vi2lpLlwltp//rrsLBFSnKfkvlH
         b5HaKGrgU965h4aaUwZuY70CPCuhrcptd+vJzwPo=
Date:   Mon, 11 Mar 2019 19:16:27 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        yuehaibing <yuehaibing@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "gregkh@google.com" <gregkh@google.com>
Subject: Re: [PATCH -next] exec: Fix mem leak in kernel_read_file
Message-ID: <20190311231627.GI158926@sasha-vm>
References: <20190219021038.11340-1-yuehaibing@huawei.com>
 <20190219022512.GW2217@ZenIV.linux.org.uk>
 <ad928cfca24743d5bb9f01e9a3ae74bd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad928cfca24743d5bb9f01e9a3ae74bd@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 04:59:14PM +0000, Dmitry Kasatkin wrote:
>
>From: Al Viro <viro@ftp.linux.org.uk> on behalf of Al Viro <viro@zeniv.linux.org.uk>
>Sent: Tuesday, February 19, 2019 4:25 AM
>To: yuehaibing
>Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; Dmitry Kasatkin; keescook@chromium.org
>Subject: Re: [PATCH -next] exec: Fix mem leak in kernel_read_file
> 
>On Tue, Feb 19, 2019 at 10:10:38AM +0800, YueHaibing wrote:
>> syzkaller report this:
>> BUG: memory leak
>> unreferenced object 0xffffc9000488d000 (size 9195520):
>>   comm "syz-executor.0", pid 2752, jiffies 4294787496 (age 18.757s)
>>   hex dump (first 32 bytes):
>>     ff ff ff ff ff ff ff ff a8 00 00 00 01 00 00 00  ................
>>     02 00 00 00 00 00 00 00 80 a1 7a c1 ff ff ff ff  ..........z.....
>>   backtrace:
>>     [<000000000863775c>] __vmalloc_node mm/vmalloc.c:1795 [inline]
>>     [<000000000863775c>] __vmalloc_node_flags mm/vmalloc.c:1809 [inline]
>>     [<000000000863775c>] vmalloc+0x8c/0xb0 mm/vmalloc.c:1831
>>     [<000000003f668111>] kernel_read_file+0x58f/0x7d0 fs/exec.c:924
>>     [<000000002385813f>] kernel_read_file_from_fd+0x49/0x80 fs/exec.c:993
>>     [<0000000011953ff1>] __do_sys_finit_module+0x13b/0x2a0 kernel/module.c:3895
>>     [<000000006f58491f>] do_syscall_64+0x147/0x600 arch/x86/entry/common.c:290
>>     [<00000000ee78baf4>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>     [<00000000241f889b>] 0xffffffffffffffff
>>
>> It should goto 'out_free' lable to free allocated buf while kernel_read
>> fails.
>
>Applied.
>
>
>This must be applied to stables as well...

It's already in all relevant stable trees...

--
Thanks,
Sasha
