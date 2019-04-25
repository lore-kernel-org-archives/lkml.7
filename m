Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974E3C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D6520717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556217419;
	bh=BlBnaTLAE7TBhCOz3IxNSscJLP0yJ+egegDku4/Lwp4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=qQgUqPGSmxXEFPGbA/4rBdFBT6L+Xkzq9ea3s3Vrt6F2e5dRwAeh1FLMSeBO4TMvv
	 O8qV2NTdbQRmkXElofw+uvTdILN8bTzdavhg0AM6lJ/zk44L331o2ns9ze+h7dwMSz
	 F9xouhJ5p52XQI5neMCqPemmkw2L9/p7w+tP30Rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfDYSg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbfDYSgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:36:55 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E54B2067C;
        Thu, 25 Apr 2019 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556217415;
        bh=BlBnaTLAE7TBhCOz3IxNSscJLP0yJ+egegDku4/Lwp4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jRhaMNX3ilHyZkRydLziF9b0WG6fKkSHLJ4RG7zxXU6RfZ4eMi7+8Qo3PSpT45zVo
         ALT66RLZBLBQNkon/Yvnu7VVLvsRqgbLMu58/sZ2dGcoN8L783h/z+jb7xpzS2YyB0
         Kyb+5gqnHXTAGBS3MvWHdRCRLl0Tj7VK/lS0EXUk=
Message-ID: <7c25c38a57a61f0603364e64956a8f54026c6e3f.camel@kernel.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Date:   Thu, 25 Apr 2019 14:36:53 -0400
In-Reply-To: <CAHk-=winWXbk2dPa8x2AhkiRKFe07Vk9yuqOi+B_rZsUottGUQ@mail.gmail.com>
References: <20190425174739.27604-1-idryomov@gmail.com>
         <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
         <20190425182100.GU2217@ZenIV.linux.org.uk>
         <CAHk-=winWXbk2dPa8x2AhkiRKFe07Vk9yuqOi+B_rZsUottGUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-25 at 11:24 -0700, Linus Torvalds wrote:
> On Thu, Apr 25, 2019 at 11:21 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > I really wonder if 76a495d666e5 (ceph: ensure d_name stability in
> > ceph_dentry_hash()) makes any sense; OK, you have ->d_lock held
> > over that, but what does it protect against?  Sure, you'll get
> > something that was valid while you held ->d_lock, but what good
> > does it do to the callers?  If they really have to care about
> > races with d_move(), which value do they want?
> 
> I suspect they only care that the data they gather for the network
> packet is coherent, and passes internal sanity tests. You get either
> old or new, but at least you don't get "not NUL terminated because the
> length didn't match the data".
> 
>                     Linus

Right. My main concern was preventing oopses while iterating over
d_name.

The main use for this hash is to help determine to which MDS we should
direct the request. My understanding is that if we get it wrong, we'll
end up retrying the request and pick a different MDS, so it's not fatal
if we do race in this fashion.
-- 
Jeff Layton <jlayton@kernel.org>

