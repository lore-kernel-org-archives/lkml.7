Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA55C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E2F21582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576635794;
	bh=VmjPT9K3qzSCrWIaIrmoy2py96o32HiWERhWvk3Gffw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XkGzaLAp+2E/h/IjViyDdShVtXZWWjglxkucax+ecudKdvk7AF2tSe7V0ogM/6jyi
	 h9Iz1MIXfv/SE96YfUVDhX1qwLUU7zPqNfsLzs8SdCqsjl/UNjj+ogEo/9em2b/oDu
	 VzNH6VPeG1yaj5Lu6Yj7lSXn6POgBJw5ImkHFa8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfLRCXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 21:23:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfLRCXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 21:23:13 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4165420716;
        Wed, 18 Dec 2019 02:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576635792;
        bh=VmjPT9K3qzSCrWIaIrmoy2py96o32HiWERhWvk3Gffw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tJwZPvGC10dy3IJw0FBjZ7ODUYk/mZQmXBEqRclbhMMuVSA99IQaxFB6MStJOaUmK
         5erKJJUYmAn5X5Q3qlcRPyGI1Z2CqtM9QWZAgpcLVM7Lc4E5uBGtZ5ojYIaXGlb1ql
         TFcvLNm0bzosPijrmxuLZv+f2OT7ndAZfalrFbNc=
Date:   Tue, 17 Dec 2019 18:23:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joseph Qi <jiangqi903@gmail.com>
Cc:     Kai Li <li.kai4@h3c.com>, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, chge@linux.alibaba.com,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] [PATCH v3] ocfs2: call journal flush to mark
 journal as empty after journal recovery when mount
Message-Id: <20191217182311.6696bbe6f03b5ea81bc96082@linux-foundation.org>
In-Reply-To: <339c2bfc-fc40-77f1-3515-eb90e34854f6@gmail.com>
References: <20191217020140.2197-1-li.kai4@h3c.com>
        <339c2bfc-fc40-77f1-3515-eb90e34854f6@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 10:12:14 +0800 Joseph Qi <jiangqi903@gmail.com> wrote:

> > Due to first commit seq 13 recorded in journal super is not consistent
> > with the value recorded in block 1(seq is 14), journal recovery will be
> > terminated before seq 15 even though it is an unbroken commit, inode
> > 8257802 is a new file and it will be lost.
> > 
> > Signed-off-by: Kai Li <li.kai4@h3c.com>
> 
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

Do we think this fix should be backported into -stable kernels?
