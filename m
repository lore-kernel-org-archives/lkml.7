Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7536FCA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 19:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCBC21929
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 19:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfKCTAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 14:00:50 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:34338 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfKCTAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 14:00:50 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iRL7H-0006EK-Uw; Sun, 03 Nov 2019 12:00:47 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iRL7H-0002uW-5J; Sun, 03 Nov 2019 12:00:47 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20191031221602.9375-1-hannes@cmpxchg.org>
        <20191031162825.a545a5d4d8567368501769bd@linux-foundation.org>
        <20191101110901.GB690103@chrisdown.name>
        <20191101144540.GA12808@cmpxchg.org>
        <20191101115950.bb88d49849bfecb1af0a88bf@linux-foundation.org>
        <20191101192405.GA866154@chrisdown.name>
        <20191101122920.798a6d61b2725da8cfe80549@linux-foundation.org>
        <20191101123544.c9b0024a1e8f5ddf63148b48@linux-foundation.org>
        <20191102155536.GA10251@avx2>
Date:   Sun, 03 Nov 2019 13:00:36 -0600
In-Reply-To: <20191102155536.GA10251@avx2> (Alexey Dobriyan's message of "Sat,
        2 Nov 2019 18:55:36 +0300")
Message-ID: <8736f4g4yz.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iRL7H-0002uW-5J;;;mid=<8736f4g4yz.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/cawXAkuIqWPyW19UfJY94OZ2QLEcEU+A=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kernel: sysctl: make drop_caches write-only
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> writes:

> On Fri, Nov 01, 2019 at 12:35:44PM -0700, Andrew Morton wrote:
>> On Fri, 1 Nov 2019 12:29:20 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>> 
>> > > Either change is an upgrade from the current situation, at least. I prefer 
>> > > towards whatever makes the API the least confusing, which appears to be 
>> > > Johannes' original change, but I'd support a patch which always set it to 
>> > > 0 instead if it was deemed safer.
>> > 
>> > On the other hand..  As I mentioned earlier, if someone's code is
>> > failing because of the permissions change, they can chmod
>> > /proc/sys/vm/drop_caches at boot time and be happy.  They have no such
>> > workaround if their software misbehaves due to a read always returning
>> > "0".
>> 
>> I lied.  I can chmod things in /proc but I can't chmod things in
>> /proc/sys/vm.  Huh, why did we do that?
>
> To conserve memory! It was in 2007.
> For the record I support 0200 on vm.drop_caches.
>
> 	commit 77b14db502cb85a031fe8fde6c85d52f3e0acb63
> 	[PATCH] sysctl: reimplement the sysctl proc support
>
> 	+static int proc_sys_setattr(struct dentry *dentry, struct iattr *attr)
> 	+{
> 	+       struct inode *inode = dentry->d_inode;
> 	+       int error;
> 	+
> 	+       if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
> 	+               return -EPERM;


Almost.

The rewrite was both to concerve memory and to support the network
namespace.  Which required a different view of proc files.

But in this case we have always unconditionally called sysctl_perm.  The
change above at best removed a layer of obfuscation that made it look
like some other permission check was being honored.

Eric
