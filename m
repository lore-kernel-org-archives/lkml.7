Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDDFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81255217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfEVPAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:00:10 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49953 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVPAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:00:10 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4MEwU3L044008;
        Wed, 22 May 2019 23:58:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Wed, 22 May 2019 23:58:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4MEwEkC043762
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 22 May 2019 23:58:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kernel/hung_task.c: Monitor killed tasks.
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Liu Chuansheng <chuansheng.liu@intel.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
References: <1557745331-10367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190515105540.vyzh6n62rqi5imqv@pathway.suse.cz>
 <ee7501c6-d996-1684-1652-f0f838ba69c3@i-love.sakura.ne.jp>
 <20190516115758.6v7oitg3vbkfhh5j@pathway.suse.cz>
 <a3d9de97-46e8-aa43-1743-ebf66b434830@i-love.sakura.ne.jp>
 <a6b6a5ef-c65c-6999-2bc1-7aaf9dd19fe8@i-love.sakura.ne.jp>
 <20190522234134.44327256@canb.auug.org.au>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <03b5834d-5f8f-9c7e-20df-cfdf5395d245@i-love.sakura.ne.jp>
Date:   Wed, 22 May 2019 23:58:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522234134.44327256@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/22 22:41, Stephen Rothwell wrote:
> Hi Tetsuo,
> 
> On Wed, 22 May 2019 21:38:45 +0900 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> I want to send debug printk() patches to linux-next.git. Petr Mladek
>> is suggesting me to have a git tree for debug printk() patches.
>> But it seems that there is "git quiltimport" command, and I prefer
>> "subversion + quilt", and I don't have trees for sending "git pull"
>> requests. Therefore, just ignoring "git quiltimport" failure is fine.
>> What do you think?
> 
> Sure, we can try.  I already have one quilt tree (besides Andrew's) in
> linux-next, but much prefer a git tree.  If you have to use a quilt
> tree, I will import it into a local branch on the base you tell me to
> and then fetch it every morning and reimport it if it changes.  I will
> then merge it like any other git branch.  Let me know what you can deal
> with.
> 

What I do for making patches is:

  git fetch --tags
  git reset --hard next-$date
  edit files
  git commit -a -s
  git format-patch -1
  git send-email --to=$recipient 0001-*.patch

I'm sure I will confuse git history/repository everyday if
I try to send changes using git. For my skill level, managing
0001-*.patch in a subversion repository is the simplest and safest.
