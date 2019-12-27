Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C9CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 04:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F29320828
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 04:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJQMZNQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfL0EqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 23:46:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48075 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727016AbfL0EqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 23:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577421979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/zDTjKluwv9ecE8hTAF7HzGZWf2Rz0ayEkpZKcGfgA=;
        b=MJQMZNQCtvHujoyCaB9HzLdU7HFgECNaF4WLjWLdg1ETVLjeRCJRLo4nf9ICYVzMP5u1Ms
        Xuqcg1PUqCPBimb6sdzrxovEHBcYk4vZ+NTcfjY0ueP6rbzSe/QR8APz6Dr/nkFFnwk8Gx
        SqJ5Ne18lpD8rLChsiPQ2EZWjVIpYr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-yvszRGreMmy2AAFTdjYZ1Q-1; Thu, 26 Dec 2019 23:46:16 -0500
X-MC-Unique: yvszRGreMmy2AAFTdjYZ1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51B17180417D;
        Fri, 27 Dec 2019 04:46:14 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82C415D9C5;
        Fri, 27 Dec 2019 04:46:05 +0000 (UTC)
Date:   Fri, 27 Dec 2019 12:46:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     syzbot <syzbot+2b9e54155c8c25d8d165@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, axboe@kernel.dk, dave@stgolabs.net,
        hch@lst.de, hughd@google.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        osandov@fb.com, syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in sync_inodes_sb (3)
Message-ID: <20191227044600.GA9220@ming.t460p>
References: <000000000000016d8b059aa2030e@google.com>
 <0000000000002b326d059aa295e9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002b326d059aa295e9@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 02:06:01PM -0800, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 6dc4f100c175dd0511ae8674786e7c9006cdfbfa
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Fri Feb 15 11:13:19 2019 +0000
> 
>     block: allow bio_for_each_segment_all() to iterate over multi-page bvec
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1674423ee00000
> start commit:   46cf053e Linux 5.5-rc3
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1574423ee00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1174423ee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
> dashboard link: https://syzkaller.appspot.com/bug?extid=2b9e54155c8c25d8d165
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152bdc56e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159c489ee00000
> 
> Reported-by: syzbot+2b9e54155c8c25d8d165@syzkaller.appspotmail.com
> Fixes: 6dc4f100c175 ("block: allow bio_for_each_segment_all() to iterate
> over multi-page bvec")

Looks this syzbot test triggers bio truncate(guard_bio_eod()), and the
truncated bytes is bigger than the last bvec, which length is overflowed
by 'bvec->bv_len -= truncated_bytes'.

Finally bio_for_each_segment_all() trigger the issue.

Will figure out one patch to fix it.

Thanks, 
Ming

