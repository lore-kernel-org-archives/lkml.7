Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C081C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB29F2722C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20150623.gappssmtp.com header.i=@draconx-ca.20150623.gappssmtp.com header.b="u8ZfzoD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfFCQep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:34:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38189 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbfFCQep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:34:45 -0400
Received: by mail-lf1-f65.google.com with SMTP id b11so14126442lfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=20IQdLWV7LoswGVHvSCpf8ERmeNkVp/K1G2Z5GkZ+1U=;
        b=u8ZfzoD3hHurL5QG+Z+mWq3CZdM3MIEEVB3w0hJMMnl2vWx4nC/soIoZSNR6nCkvWJ
         0/ExaNuiYQOoutuvMtBd3tfrU5EyoYPGDpSnNkc2CvJ+mTaaGVYFdjDNCtBCqUgK8OCv
         vhW/eaG+/FeVpMQRKDJDwwDR7Kj/YhYETdxP59uFUyrsvHkCxH/T9igDZ9rxeNOPXuw+
         ssvJ9RnlKlOFlf1agAcQLraZHRWa4g5L6rnm8umQU+TvnvFZBrnN2EGHS7UmaHhaN4cW
         D546v2z54ieNiynWg4TkVZZFpS2s1Qu49FrkN/3oPyqnyIOrq+O2a6V1xoLaLaO2/G7g
         hhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=20IQdLWV7LoswGVHvSCpf8ERmeNkVp/K1G2Z5GkZ+1U=;
        b=mvT4YJZVM0sKgzNS8beszml6Knn3pEaOo7FrIqXob6eCdRDkLP8zYVkaQOWiA43rAx
         oAvJro27+iyZvJvUT6d5edcy8IN/WtE5TFkdCpfTVd4Q+Kd2vtKR2qPf1JhDwkcX9oyv
         O9TbJP1/XjXqfDkk/klSEhhyqM4KzfvxV9fq+SUJkGi9/vmbvaGoErt8AoxU1CKylc/C
         BrOyqmIT3owDkBLCxTIcvvUybtq19qm50YEUkurBSbS2sncbCQFOJOPSW21w58Yijqzg
         bT8R2/p6UWdqFPACkoqSawWf+6YHIMJ39IfrFiuggLk4pbkpb/GYisCzR8H3BjVmklG5
         MKOg==
X-Gm-Message-State: APjAAAU5VcL+EL8/eNcnTUmGG6hF5fIBy32Zs8ns4UrZhPZp+lQDmIEX
        vg4wnxO1IkL81YSCMJExD9hfrZ0qZK9pVKoxCkySNA==
X-Google-Smtp-Source: APXvYqz+KdFqPyEMENFndOR9VE/dXUxVoGpFujxYLLjTpgVpbz0x3OjumZjOp3+WmstyFCo9OomSPnUxROYGc9swfcQ=
X-Received: by 2002:a19:5046:: with SMTP id z6mr14316936lfj.185.1559579683831;
 Mon, 03 Jun 2019 09:34:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9d89:0:0:0:0:0 with HTTP; Mon, 3 Jun 2019 09:34:43 -0700 (PDT)
X-Originating-IP: [162.243.96.244]
In-Reply-To: <CAN-5tyHws9bO5Yuj9FTn6EdcPcY5QGK0419aBbujU7Ugt4_6uQ@mail.gmail.com>
References: <20190529151003.hzmesyoiopnbcgkb@aura.draconx.ca>
 <ceecedad1b650f703a12ec3424493c4a73d1e20e.camel@hammerspace.com> <CAN-5tyHws9bO5Yuj9FTn6EdcPcY5QGK0419aBbujU7Ugt4_6uQ@mail.gmail.com>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Mon, 3 Jun 2019 12:34:43 -0400
Message-ID: <CADyTPEyJRC+Yi1yJb_Vqb+7zsDKvk-5egBVDvFsTLG=kOrffMA@mail.gmail.com>
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

On 2019-05-29, Olga Kornievskaia <aglo@umich.edu> wrote:
> On Wed, May 29, 2019 at 1:14 PM Trond Myklebust <trondmy@hammerspace.com>
> wrote:
>>
>> On Wed, 2019-05-29 at 11:10 -0400, Nick Bowler wrote:
>> > Hi,
>> >
>> > I upgraded to Linux 5.1.5 on one machine yesterday, and this morning
>> > I happened noticed a large amount of backtraces in the log.  It appears
>> > that the system oopsed 62 times over a period of about 5 minutes,
>> > producing about half a megabyte of log messages, after which the
>> > messages stopped.  No idea what action (if any) triggered these.
>> >
>> > However, other than the noise in the logs there is nothing obviously
>> > broken, but I thought I should report the spews anyway.  I was
>> > running 5.0.9 previously and have not seen any similar errors.  The
>> > first couple spews are appended.  All 64 faults look very similar
>> > to these ones, with the same faulting address and the same
>> > rpc_check_timeout function at the top of the backtrace.
>>
>> OK, I think this is the same problem that Olga was seeing (Cced), and
>> it looks like I missed the use-after-free issue when the server returns
>> a credential error when she asked.
>
> I think this is actually different than what I encountered for the
> umount case but the trigger is the same -- failing validation.
>
> I tried to reproduce Nick's oops on 5.2-rc but haven't been able to
> (but I'm not confident I produced the right trigger conditions. will
> try 5.1).

OK, I think I found something that triggers this fault.  This happens
when certain local users try to stat a file or directory on an nfs
mount.  Presumably these UIDs do not have appropriate permissions on
the server but I'm not sure exactly (I do not control the server).

I can reproduce the oops with a command like this:

  # su -s/bin/sh -c 'stat /path/to/nfs/file' problematic_user

which oopes every time (and SIGKILLs the stat command).   (I have not yet
rebooted since the original report or tried with Trond's patch applied.
I will do that next, and also try 5.1.6).

Cheers,
  Nick
