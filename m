Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A54C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C70207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569350525;
	bh=zovrfxXTCXEz4cMUoX9mIiF4vFkLEfgI/P1RvhcdI1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i2wXFzCkx6/TL5ltSbatacizfVe+ccyPdfyGpLAujp3F4fgX6pnTxAdQhQRCtczUh
	 3XIcv/PgKblF17EhEfPPhnPGu0SafQPk5hTjPzyL0tw+8aE83gX4jtmKehtWiMIwCr
	 u09rJFsbeVWnU2MubmA92D4PSuMWg/TBFk8EkF+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437118AbfIXSmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 14:42:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46120 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394900AbfIXSmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 14:42:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so3081362wrv.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 11:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ISPO/AdmT/vPer3JNCi0kThZy7EET6XmBvMXw6pXH4o=;
        b=es1HpChF5Q47KfIsEicqeAtDsopSvJ+4zOAel7rrRYoBZKQ07DNFw11V9mBadcfaoA
         xEzs2zqthXQmM5NmYsDcZDdSQ3uslyZGCzDFSWCZxmYMBQmlRYFNMe4pyNu71ZPzpAFq
         8x/WPTrgXSyVzGmzaiEQRmHnaW6p8YXpLWmNFhSjiZeOqw9GYGG35YJhyJhC7dx0i03y
         dNe6DcQn49VDsT+aAntE2+h/zSzIZzw14jnF0stxfBz0OiEE8Hm5XxwehSytosQJ7qK4
         U3VBnqkRP9UwPA4f9hXt5tSRd8iigzxNOQrlySFXIl8CtDIIqcIVvGm8eCmXlMZqxpXf
         MWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ISPO/AdmT/vPer3JNCi0kThZy7EET6XmBvMXw6pXH4o=;
        b=EtWb1WBCWZi7WmimGfzTrafKzaiE0baUnfptGhv4gc4MPZpTFLvG6B3gIW7EP/PXho
         +RBLBsDLxzVNT0WHQoRf3lXd1VJ7EKKI8E4WeWAv2JuzMnUf/vlmYx3rGHhcDyL7Asyh
         LC5kIHkLV89uDzQ86z+0WFae+VZj4kTuUVQNNhO5tfNvGjfGewHlH8JoH867qKj00I9S
         nhK24cxIM2AxkswgWQhimex1fJmDYvRVIYuJ8HqDpviCwnNBNyxAZ3PR1w6zuUfSnSQe
         6WlaBWGZDLI1gND3bLMkhmjN5WSxtg2pSdsH7A0PhOW73cpD7yoCoer6lb8+1YYbgSta
         wCYg==
X-Gm-Message-State: APjAAAVzzrsAzJsahy/KTwc+s/cKZ1tLY/xSxU85qbEuQTQGuoaBK0ZL
        IWJ6VnrUV6jR4OpkEQfl6Ac=
X-Google-Smtp-Source: APXvYqx6RlpwpfehKhghQUcsF13wy520VK0Tewkg7bpEfVt5Uy1r0ELEpGMmuuTAZZeqNyx39i5R0w==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr3871455wrj.30.1569350521976;
        Tue, 24 Sep 2019 11:42:01 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q192sm1559690wme.23.2019.09.24.11.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 11:42:01 -0700 (PDT)
Date:   Tue, 24 Sep 2019 20:41:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [Tree, v2] De-clutter the top level directory, move ipc/ =>
 kernel/ipc/, samples/ => Documentation/samples/ and sound/ => drivers/sound/
Message-ID: <20190924184159.GA47127@gmail.com>
References: <20190922115247.GA2679387@kroah.com>
 <20190923200818.GA116090@gmail.com>
 <20190924113135.GA82089@gmail.com>
 <874l11u30y.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l11u30y.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> Ingo Molnar <mingo@kernel.org> writes:
> 
> >  - Split it into finer grained steps (3 instead of 2 patches per 
> >    movement), for easier review and bisection testing:
> >
> >      toplevel: Move ipc/ to kernel/ipc/: move the files
> >      toplevel: Move ipc/ to kernel/ipc/: adjust the build system
> >      toplevel: Move ipc/ to kernel/ipc/: adjust comments and documentation
> 
> Can we not mess with ipc/ please.
> 
> I know that will mess with my muscle memory and I don't see the point.
> Especially as long as it is named ipc and not sysvipc.
> 
> A half cleanup really looks worse than a real cleanup.
> 
> SysV IPC really is a side car on the kernel and on unix in general
> and having the directory structure reflect that seems completely sensible.

While such objections are I think valid for scripts/, the situation is 
very different for ipc/:

 - ipc/ is a tiny subsystem of just ~9k lines of code, and it's in the 
   top level directory for historical reasons.

 - ipc/ is an established subsystem of old interfaces with comparatively 
   very few changes these days: there were just about 16 commits added in 
   the last 12 months that changed the code and had 'ipc' in the title. 
   Somewhat ironically, the biggest commit of all was a "system call 
   renaming" commit:

     275f22148e87: ipc: rename old-style shmctl/semctl/msgctl syscalls
     14 files changed, 137 insertions(+), 62 deletions(-)

   Many of the remaining 15 commits were simple in nature - and there 
   were 9 different authors, i.e. the per author frequency of changes for 
   ipc/ is even lower: around one per year for those 9 developers who are 
   interested in ipc/ changes. I doubt there's much muscle memory even 
   for them as a result.

 - The 'muscle memory' argument has to be weighted by probability of 
   interest (linecount), probability of change (frequency of commits) and 
   number of authors. These factors add up to a very low change frequency 
   for ipc/. We've moved and consolidated much, much bigger and higher 
   frequency subsystems in the recent past, such as kernel/sched/ or 
   kernel/locking/.

 - The ipc/ location is arguably random and idiosynchratic - it's a 
   leftover from old times nobody really bothered to clean up - but that 
   fact shouldn't be a permanent barrier IMO.

 - While uncluttering the top level directory for aesthethic and 
   documentation reasons is one technical factor, there's another reason 
   for my ipc/ movement: I have the secret hope to be able to move init/ 
   to kernel/init/ as well, in which case there's a big muscle memory 
   advantage for the future: 'i<tab>' would expand to include/ in a 
   single step! :-) Now *that* is perhaps the highest frequency muscle 
   memory location in the kernel. ;-)

Or looking at it from another angle: if we applied your ipc/ benchmark 
then basically almost *nothing* could be moved from the toplevel 
directory or any other location, pretty much *ever*.

Thanks,

	Ingo
