Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE77C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA41D2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfECArp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 20:47:45 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51933 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfECArp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:47:45 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x430l87H085453;
        Fri, 3 May 2019 09:47:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Fri, 03 May 2019 09:47:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x430l3WU085429
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 3 May 2019 09:47:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] RFC: hung_task: taint kernel
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Liu, Chuansheng" <chuansheng.liu@intel.com>
References: <20190502194208.3535-1-daniel.vetter@ffwll.ch>
 <20190502204648.5537-1-daniel.vetter@ffwll.ch>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <7e4ef8c8-2def-5af9-f80e-b276fea8696a@i-love.sakura.ne.jp>
Date:   Fri, 3 May 2019 09:47:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502204648.5537-1-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/03 5:46, Daniel Vetter wrote:
> There's the hung_task_panic sysctl, but that's a bit an extreme measure.
> As a fallback taint at least the machine.
> 
> Our CI uses this to decide when a reboot is necessary, plus to figure
> out whether the kernel is still happy.

Why your CI can't watch for "blocked for more than" message instead of
setting the taint flag? How does your CI decide a reboot is necessary?

There is no need to set the tainted flag when some task was just blocked
for a while. It might be due to memory pressure, it might be due to setting
very short timeout (e.g. a few seconds), it might be due to busy CPUs doing
something else...
