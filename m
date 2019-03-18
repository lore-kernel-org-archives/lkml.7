Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CFFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA5F20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfCRKzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:55:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:44396 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726493AbfCRKzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:55:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BBA13ACFA;
        Mon, 18 Mar 2019 10:55:46 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     "Yan\, Zheng" <ukernel@gmail.com>
Cc:     Gregory Farnum <gfarnum@redhat.com>,
        "Yan\, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hendrik Peyerl <hpeyerl@plusline.net>
Subject: Re: [PATCH v2 2/2] ceph: quota: fix quota subdir mounts
References: <20190312142019.30936-1-lhenriques@suse.com>
        <20190312142019.30936-3-lhenriques@suse.com>
        <CAAM7YAmMBv1Z4Etp5yf9K=RqpTNF0kJ3tsiAysfs_wv9mdNG8w@mail.gmail.com>
        <CAJ4mKGZ3a9xq4HkR3JQ0yRyBCh1acm0YEz14OBUK+bQFzbVEDg@mail.gmail.com>
        <CAAM7YAmt+OS8=ycPrtLLe_FqeD2F_szdkShNAPA49FOPoJd+Gg@mail.gmail.com>
Date:   Mon, 18 Mar 2019 10:55:45 +0000
In-Reply-To: <CAAM7YAmt+OS8=ycPrtLLe_FqeD2F_szdkShNAPA49FOPoJd+Gg@mail.gmail.com>
        (Zheng Yan's message of "Mon, 18 Mar 2019 17:12:39 +0800")
Message-ID: <87lg1czc26.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Yan, Zheng" <ukernel@gmail.com> writes:

> On Mon, Mar 18, 2019 at 5:06 PM Gregory Farnum <gfarnum@redhat.com> wrote:
>>
>> On Mon, Mar 18, 2019 at 2:32 PM Yan, Zheng <ukernel@gmail.com> wrote:
>> > After reading the code carefully. I feel a little uncomfortable with
>> > the "lookup_ino" in get_quota_realm.  how about populating directories
>> > above the 'mount subdir' during mounting (similar to cifs_get_root ).

Wouldn't it be a problem if the directory layout (or, in this case, the
snaprealm layout) change during the mount lifetime?  In that case we
would need to do this lookup anyway.

>>
>> Isn't that going to be a problem for any clients which have
>>restricted filesystem access permissions? They may not be able to see
>>all the directories above their mount point.  -Greg
>
> using lookup_ino to get inode above the "mount subdir" has the same problem
>

In this case I believe we get an -EPERM from the MDS.  And then the
client simply falls back to the 'default' behaviour, which is to allow
the user to create/write to files as if there were no quotas set.

Cheers,
-- 
Luis
