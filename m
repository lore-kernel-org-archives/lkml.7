Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED295C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71392077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PgheN4bS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfCMQ5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:57:10 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:55124 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMQ5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:57:10 -0400
Received: by mail-it1-f180.google.com with SMTP id w18so41078itj.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 09:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=m+lL9RC2p4cmZIetTO80+JmKXVjcdjlYgQjdj8SOpDU=;
        b=PgheN4bS9HVuMISN72fdZOOiO5br5STUj5iRfoMnZrpzEJ0iswUEy9oGG0m871bX4G
         ZES5haEA1R7SQZxWkccMPkEsA9G9Ef8w66x0i4k37rFV5RIp1e6h55E0CPqoH3N/WlT1
         W5REB6piYyXaeQCpGoqggMW61ydj7KugIj+7HzQZtQVdqmuR/CeHBRe88YjuhwNeu911
         iLdb9b7rI1Gx5fB+3PZu0REIAm4JmiNcjYf74YSlTh+L/9jUBu0g3k3K+PDk6LwLb8V6
         nPvawDaHaTJmIQJ+rxCNe0xPonfhr5Dh+itrff8pI34xGOD1AfgZDLTE3Abq06Refspl
         CmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=m+lL9RC2p4cmZIetTO80+JmKXVjcdjlYgQjdj8SOpDU=;
        b=pJ1/lbe+rOmwNKLqr1IpUT8ktRiu5mN53ZFq/Gd54N+VQ8HMHzlQIf+xg8YMIGI7kh
         UwJkhWZ6/rmdXYHrRP9A97XfxenzD1DolKdcspwdMe4MdvtR9M6VqRlgTHVdxN/zEovw
         6unNWaYaxXC0MAYtaGg+faFRrAtmrP6KqQu6bOdsFP1eVYEO4eO1OBAN+lq5LDSyI25b
         peM1PR7R2sYycFdVJ72xHx1QfnUp18NypzqrzTwaAiKugnGKq82y0I93EKy0DYLFZiQO
         PXbiJCkspX+KFNm72xbqZ/PraiixFlu5TE5fRrA0/CyRG0zyFJo1f8Nhkg3jXZQ5YeLT
         VWYg==
X-Gm-Message-State: APjAAAWxYw61d5kOUi11LkdDl0CviGZL2CXu+rZLC9dzdMn+K58HYlGp
        aOj+DrrgZn0qIADFLRjp1ph2swGeafSd0DJWOrWbvA==
X-Google-Smtp-Source: APXvYqzGwAQdFK4D6MO7jVpFKHb2PX+tP+HD066o3irQzitLM1tLJm3LeYPY98XhPsLMjArtAXQaysmh1/flH/Qa4OU=
X-Received: by 2002:a05:660c:3d1:: with SMTP id c17mr2232149itl.166.1552496228643;
 Wed, 13 Mar 2019 09:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000010b2fc057fcdfaba@google.com> <0000000000008c75b50583ddb5f8@google.com>
 <20190312040829.GQ2217@ZenIV.linux.org.uk> <491ff1c3-91d6-eaa7-f551-46a4f8b90f5a@i-love.sakura.ne.jp>
 <CACT4Y+ahcZpJ1Q-TKkCJkyhzGc07XFusuwBcKjg_rfAeos8RWA@mail.gmail.com>
 <92a4e5e5-33ca-7b39-16c0-82c7fb742d18@i-love.sakura.ne.jp>
 <CACT4Y+ZQD=raWY4Tp8nrUcpAAbwRt0D3sH65KrTP+JURtQ3n-Q@mail.gmail.com> <20190313163701.GE672@mit.edu>
In-Reply-To: <20190313163701.GE672@mit.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 13 Mar 2019 17:56:57 +0100
Message-ID: <CACT4Y+Yjdf6Gf20A2vUjxwhEW6GeydwneJZzzQ8Gt9PAAT9WyQ@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_sendfile64 (2)
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 5:37 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Mar 13, 2019 at 07:43:38AM +0100, Dmitry Vyukov wrote:
> > It would be more useful to accept patches that make syzkaller create
> > better reproducers from these people. Manual work is not scalable. We
> > would need 10 reproducers per day for a dozen of OSes (incl some
> > private kernels/branches). Anybody is free to run syzkaller manually
> > and do full manual (perfect) reporting. But for us it become clear
> > very early that it won't work. Then see above, while that human is
> > sleeping/on weekend/vacation, syzbot will already bisect own
> > reproducer. Adding manual reproducer later won't help in any way.
> > syzkaller already does lots of smart work for reproducers. Let's not
> > give up on the last mile and switch back to all manual work.
>
> I suspect a scalable solution that would significantly improve things
> is one where Syzbot tries N times for a "good" result to make sure
> it's not a flaky pass.  N could either be hard-coded to some value
> like 8 or 10, or Syzbot could experimentally try to figure out how
> reliable the reproducer happens to be, and figure out what an ideal
> "N" value should be for a particular reproducer.

It currently tries 8 times, see e.g.:
https://syzkaller.appspot.com/text?tag=Log&x=13354d9d200000
