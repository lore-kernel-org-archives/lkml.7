Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TRACKER_ID,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE60BC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 12:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A157820731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 12:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0bp8o2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgAFMpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 07:45:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47089 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725787AbgAFMpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 07:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578314739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MKqLuGW3zPtIjcBOVtUkMLFk96xKPBf0H3EtPn0x/cs=;
        b=b0bp8o2h0LppjvI1Zhn9d1z7EyV9USTCAY7/FXqJxQcC85XQ3DQ0aY+kxiJwXPo9EFLGym
        uuLTSkq3AckL3lzf0UKPTKifdyTG9d/0FtW0Q88IhltiMWQiOJiwev5kq4JK0cyG4ij9BZ
        kUylusBSnSnhmHutHp6I6lahHWLr/jY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-V_NnNjeiOOeX1qkb3fkYUw-1; Mon, 06 Jan 2020 07:45:32 -0500
X-MC-Unique: V_NnNjeiOOeX1qkb3fkYUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB261100550E;
        Mon,  6 Jan 2020 12:45:30 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-82.gru2.redhat.com [10.97.116.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ED77C272A3;
        Mon,  6 Jan 2020 12:45:29 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id B9C7A416C882; Fri,  3 Jan 2020 10:36:14 -0300 (-03)
Date:   Fri, 3 Jan 2020 10:36:14 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [cpuidle] 259231a045: will-it-scale.per_process_ops -12.6%
 regression
Message-ID: <20200103133614.GA6604@fuller.cnet>
References: <20190918021334.GL15734@shao2-debian>
 <20191231055923.GA70013@shbuild999.sh.intel.com>
 <20200103023117.GA1313@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103023117.GA1313@shbuild999.sh.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Feng,

On Fri, Jan 03, 2020 at 10:31:17AM +0800, Feng Tang wrote:
> On Tue, Dec 31, 2019 at 01:59:23PM +0800, Feng Tang wrote:
> > Hi Marcelo,
> > 
> > On Wed, Sep 18, 2019 at 10:13:34AM +0800, kernel test robot wrote:
> > > Greeting,
> > > 
> > > FYI, we noticed a -12.6% regression of will-it-scale.per_process_ops due to commit:
> > > 
> > > 
> > > commit: 259231a045616c4101d023a8f4dcc8379af265a6 ("cpuidle: add poll_limit_ns to cpuidle_device structure")
> > > https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git master
> > 
> > Any comments on this? We re-run the test for 5.5-rc1, and the regression remains.
> 
> Anyway, I found commit 259231a04 lost one "break" when moving
> the original code, thus the semantics is changed to the last
> enabled state's target_residency instead of the first enabled
> one's.
> 
> I don't know if it's intentional, and I guess no, so here 
> is a fix patch, please review, thanks

Not intentional.

> But even with this patch, the regression is still not recovered.
> 
> - Feng

This has been fixed upstream already, should be on Rafael's GIT tree.

> >From cddd6b409e18ce97a8d7b851db4400396f71d857 Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang@intel.com>
> Date: Thu, 2 Jan 2020 16:58:31 +0800
> Subject: [PATCH] cpuidle: Add back the lost break in cpuidle_poll_time
> 
> Commit c4cbb8b649b5 move the poll time calculation into a
> new function cpuidle_poll_time(), during which one "break"
> get lost, and the semantic is changed from the last enabled
> state's target_residency instead of the first enabled one's.
> 
> So add it back.
> 
> Fixes: c4cbb8b649b5 "cpuidle: add poll_limit_ns to cpuidle_device structure"
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> ---
>  drivers/cpuidle/cpuidle.c | 1 +
>  1 file changed, 1 insertion(+)

About the regression... if you only revert the 

drivers/cpuidle/poll_state.c

changes from 

259231a045616c4101d023a8f4dcc8379af265a6

Is the performance regression gone?

