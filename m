Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FEBC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5686239CC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20150623.gappssmtp.com header.i=@draconx-ca.20150623.gappssmtp.com header.b="qKZGGQt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfFCSJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:09:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44304 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfFCSJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:09:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so14318943lfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2MwbLnfgH8HLFZ7YZiwwnwA2Cf4KCn8Tc6YtdsgHXPA=;
        b=qKZGGQt+lNAAZIuXDYax/S2sBVt0az6QjzM/EiDq+8Qe3QVehyXxTWrSyF3/mWwK0m
         yuY8Pk0HjXkGLLKrOZL5Iqz9w9MVBwoXIcT2NXQb7jDPnX0uOa8/Z82rnFNCc55B8l0R
         marr2RegBOgKTNSSHE/KOG+4rhNiFJO+kMeZ9zdOTJHcz1vN0zW1G+XczdJNQhxzrWbX
         JOvuk6VoBrpZ23mM24J/Us2I/eTkydIPNYyepROkz092O2EyBz9uYhr5O9vVQzFEqNLs
         g2i0m/ChfmKIya4xs/Lfcki67BSbhu+3HmAm7DRIM7zToKqBeKG/KTmsYiCvgQihNrlw
         42WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2MwbLnfgH8HLFZ7YZiwwnwA2Cf4KCn8Tc6YtdsgHXPA=;
        b=lZvefB8AkcQTSDIQck/BFQBwA9ah3CRxavq+2kicmHxuaRQD9yjUSj/wTyPBzogRf+
         BvGtnF3dy2lLvAPgyYftZnPnfm4CH8Oplzywn8Tex9p4icHluH85sMY1fDu3wVqY2bBA
         de1R3Yz5PzbitxKPHD5HlBjPXsb1wcQcN+KYFQ3NkXV4oXDsL+r4KBfwRiRfdXM96wyN
         4Y1rSAIesyosdi/5Gc/xR+LBI/s9r+3ekDN7U72gXTzWWFjcrphjgYHrDCSa1UXY7BMe
         FOT4YjinQZIVMtrK/viHmL646mZPn1Hi3koLnu0Z5/s/uzbF7AZGKi9lE2DPh04SA0XR
         f/nQ==
X-Gm-Message-State: APjAAAVx00cOM6YKCdGV90JETV9cIj4B2YmBIBBEavAXygPHCfQvCCg+
        BWBXGIyenrIxZxeoiJ7l7uQJ8Py2ngKgPDB2jNkE+w==
X-Google-Smtp-Source: APXvYqyPr7/4TQemd244Vw4exuLTEj/1EHObaw55iDbMdmKPtpj+/w7tBGXzQijJ06AMqMENV8O09NxkkL+81raKtiU=
X-Received: by 2002:ac2:44b1:: with SMTP id c17mr14379583lfm.87.1559585381637;
 Mon, 03 Jun 2019 11:09:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9d89:0:0:0:0:0 with HTTP; Mon, 3 Jun 2019 11:09:41 -0700 (PDT)
X-Originating-IP: [162.243.96.244]
In-Reply-To: <CADyTPEyJRC+Yi1yJb_Vqb+7zsDKvk-5egBVDvFsTLG=kOrffMA@mail.gmail.com>
References: <20190529151003.hzmesyoiopnbcgkb@aura.draconx.ca>
 <ceecedad1b650f703a12ec3424493c4a73d1e20e.camel@hammerspace.com>
 <CAN-5tyHws9bO5Yuj9FTn6EdcPcY5QGK0419aBbujU7Ugt4_6uQ@mail.gmail.com> <CADyTPEyJRC+Yi1yJb_Vqb+7zsDKvk-5egBVDvFsTLG=kOrffMA@mail.gmail.com>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Mon, 3 Jun 2019 14:09:41 -0400
Message-ID: <CADyTPEyzKMjFi4Tvp9Tq6JBD9wK6iQKezLb0CYG4Wt_6wKaeCQ@mail.gmail.com>
Subject: Re: PROBLEM: oops spew with Linux 5.1.5 (NFS regression?)
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Olga.Kornievskaia@netapp.com" <Olga.Kornievskaia@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-03, Nick Bowler <nbowler@draconx.ca> wrote:
> On 2019-05-29, Olga Kornievskaia <aglo@umich.edu> wrote:
>> On Wed, May 29, 2019 at 1:14 PM Trond Myklebust <trondmy@hammerspace.com>
>>> OK, I think this is the same problem that Olga was seeing (Cced), and
>>> it looks like I missed the use-after-free issue when the server returns
>>> a credential error when she asked.
>>
>> I think this is actually different than what I encountered for the
>> umount case but the trigger is the same -- failing validation.
>>
>> I tried to reproduce Nick's oops on 5.2-rc but haven't been able to
>> (but I'm not confident I produced the right trigger conditions. will
>> try 5.1).
>
> OK, I think I found something that triggers this fault.  This happens
> when certain local users try to stat a file or directory on an nfs
> mount.  Presumably these UIDs do not have appropriate permissions on
> the server but I'm not sure exactly (I do not control the server).
>
> I can reproduce the oops with a command like this:
>
>   # su -s/bin/sh -c 'stat /path/to/nfs/file' problematic_user
>
> which oopes every time (and SIGKILLs the stat command).   (I have not yet
> rebooted since the original report or tried with Trond's patch applied.
> I will do that next, and also try 5.1.6).

OK, armed with this reproducer I can confirm that the issue is still
present in 5.1.6, and that applying Trond's patch on top of 5.1.6
appears to fix the problem.

Thanks,
  Nick
