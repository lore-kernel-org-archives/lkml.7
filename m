Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21FCC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C9320B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="VkQKSEsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfDZS7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:59:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37508 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfDZS7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:59:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id b12so2673453lji.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Wz/PWMDiAPpClT9APmRK4naNYYxdyy7AEY+udhk0FE=;
        b=VkQKSEsiRRwqEds/Ww2sUGohASABi4uB5atCmUlkYCK2mJEe67JBR3NJGVvmxA660u
         Ah7OFwsozOnNCdShvgfL4j85hsCw+JvP4CP04PCiWyeYCV0n938tXxqyBig6Ko5fMvcY
         9iYwX0GwBqQjFKHjPaGu9/Ma5uXlTLTdacrQsZw81jrXsU+2OpPhJ+lup+rCdPDSCnc6
         AZPboC0DKgKGRYCk48W+LraBRfBj+8wpprOy5CNwha8PcaqiU3YqPMxbRHu8MskeG2iq
         28bYXSKKIVj9JMLleQLTXZuLBbxzYiEfaGXY9Vo6Yqk0MjcYNV85JF1ePrz6j/zIZjW3
         yS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Wz/PWMDiAPpClT9APmRK4naNYYxdyy7AEY+udhk0FE=;
        b=Hq5TpOwQLs7nviZfL9cV8MMDcVnioz2ki44I1ELq4ZVw8Z38sjpRWJvWKuev6n5Gd2
         Fen8zWV+CdxwFVN0fymnCJEMrKADX3cMHMcdFBbt3Mlwk7lHRPPGD8SSztOHES0GYBTJ
         oy5HeSzz5uHuJ0QQJHMO++zpXggMF9nlq/u6yQ6z/vcMc39ERC9ok6k04ONaINnRZ1FZ
         nNPyWWu4A1KgSdgmDsVcFvqMVcSidM6GH29++cpEHScDZFDjz9sGbxkXhM4G8v180vvW
         qrvD24bXuV5xVTBEZDLvkuN9Isa7ODu436s2ApskeZw6ob8S1HeGyPGY50zvt6b/5loD
         dUSw==
X-Gm-Message-State: APjAAAVQP4bcVfBgsWAET4iB5/Z1xHnTJwSDe+FkBkItAyyGG3kHDf8T
        +Rj3mvPdXso9ykbxgedp4c0CRj6bQfoFVDyMbs+G
X-Google-Smtp-Source: APXvYqy52CavdnfAbtAYHwsDSAFsqd0798HEBqTPCPdpFzQpE6/kc+Jm/473MMGFTZZD34Bzh/BTpWr4KztJ+mLDjpU=
X-Received: by 2002:a2e:7605:: with SMTP id r5mr4241563ljc.161.1556305155446;
 Fri, 26 Apr 2019 11:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190426182847.25088-1-jlayton@kernel.org> <20190426185158.GB2217@ZenIV.linux.org.uk>
In-Reply-To: <20190426185158.GB2217@ZenIV.linux.org.uk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 26 Apr 2019 14:59:04 -0400
Message-ID: <CAHC9VhRhy_oiAj2g6YZXyVpXTjw7Ha+PH8keV9yidVAZSwxyuQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] vfs: track the dentry name length in name_snapshot
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        gregkh@linuxfoundation.org, tj@kernel.org, jack@suse.cz,
        amir73il@gmail.com, Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 2:52 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Apr 26, 2019 at 02:28:42PM -0400, Jeff Layton wrote:
> > name_snapshot will snapshot the current contents of a dentry's name for
> > later consumption. Several of those users end up needing to do a strlen
> > on the resulting string later. We already have that info in the original
> > dentry though, so we can do this a bit more efficiently by stuffing the
> > name length into the name_snapshot as well.
> >
> > This is not well tested, but it built and booted. Do we have a testsuite
> > that exercises the fsnotify code, in particular?
>
> FWIW, my variant sits in vfs.git@work.dcache.

Jan Kara contributed some audit related stress tests to the
audit-testsuite (link below).  You can find the tests under
./tests_manual/stress_tree.

* https://github.com/linux-audit/audit-testsuite

-- 
paul moore
www.paul-moore.com
