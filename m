Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AADC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BBB214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfCLIAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:00:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:32377 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfCLIAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:00:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 01:00:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,470,1544515200"; 
   d="scan'208";a="154206711"
Received: from hkrasnod-mobl.ger.corp.intel.com (HELO localhost) ([10.252.62.84])
  by fmsmga001.fm.intel.com with ESMTP; 12 Mar 2019 01:00:37 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com>
Cc:     airlied@linux.ie, akpm@linux-foundation.org, amir73il@gmail.com,
        chris@chris-wilson.co.uk, darrick.wong@oracle.com,
        david@fromorbit.com, dri-devel@lists.freedesktop.org,
        dvyukov@google.com, eparis@redhat.com, hannes@cmpxchg.org,
        hughd@google.com, intel-gfx@lists.freedesktop.org, jack@suse.cz,
        joonas.lahtinen@linux.intel.com, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        mszeredi@redhat.com, penguin-kernel@i-love.sakura.ne.jp,
        peterz@infradead.org, rodrigo.vivi@intel.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: Re: INFO: rcu detected stall in sys_sendfile64 (2)
In-Reply-To: <20190312040829.GQ2217@ZenIV.linux.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <00000000000010b2fc057fcdfaba@google.com> <0000000000008c75b50583ddb5f8@google.com> <20190312040829.GQ2217@ZenIV.linux.org.uk>
Date:   Tue, 12 Mar 2019 10:00:36 +0200
Message-ID: <871s3cfrob.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Mon, Mar 11, 2019 at 08:59:00PM -0700, syzbot wrote:
>> syzbot has bisected this bug to:
>> 
>> commit 34e07e42c55aeaa78e93b057a6664e2ecde3fadb
>> Author: Chris Wilson <chris@chris-wilson.co.uk>
>> Date:   Thu Feb 8 10:54:48 2018 +0000
>> 
>>     drm/i915: Add missing kerneldoc for 'ent' in i915_driver_init_early
>> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13220283200000
>> start commit:   34e07e42 drm/i915: Add missing kerneldoc for 'ent' in i915..
>> git tree:       upstream
>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=10a20283200000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17220283200000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=abc3dc9b7a900258
>> dashboard link: https://syzkaller.appspot.com/bug?extid=1505c80c74256c6118a5
>> userspace arch: amd64
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c4dc28c00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15df4108c00000
>> 
>> Reported-by: syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com
>> Fixes: 34e07e42 ("drm/i915: Add missing kerneldoc for 'ent' in
>> i915_driver_init_early")
>
> Umm...  Might be a good idea to add some plausibility filters - it is,
> in theory, possible that adding a line in a comment changes behaviour
> (without compiler bugs, even - playing with __LINE__ is all it would
> take), but the odds that it's _not_ a false positive are very low.

If it's not a false positive, it's bound to be good source material for
IOCCC.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
