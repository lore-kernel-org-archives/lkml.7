Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA44C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD01522CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hS0SaDL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfH1WW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:22:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34058 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfH1WWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:22:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so466109pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akmKqcTFKUa05TGRL2FcXxr4lJl27fsl6mDvDHiP0vo=;
        b=hS0SaDL5O1Ph2r+HBw7A/4RKfAomkMAO8XQ2sY2YLFTXzIBFDP+VHPdWnkcagGW+QX
         AeGj2YhFC+3kPKry8yIndOXmr/DagrT+AF2RVE9osqN8GwAb6iUflMwlUzj7Y5PJrOpJ
         lcOJ2NQmG9BhMIo7ziUQALZw79UAz9rdEaMD/x4kJ56I4ZXQQA4DMyYDp0AlgfkhDVgn
         T5pJUmQJWssVShrLPCxgtT9VDvkhVoZOO9ufqj+ALRpZD1vnSXtPS+9A/MhlT6tI29j2
         3+TNciM3ykz9nZAonW1stQ6zJtY7gn1uSo8yuAFOsAZmBD47Naog0+JK3hEyTGX1WUj3
         txkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akmKqcTFKUa05TGRL2FcXxr4lJl27fsl6mDvDHiP0vo=;
        b=LFwME1jDlJ+x+Oqzy3fepc5gHo3esVJnpTwTJ9241c3FTSUeOLYs1nHqgmmxUDpZIj
         tU7nHW7xCu09/gYzUFRmN9fFAvig8mAeX1LkOZPzPZFy+7VFHEQbgONaHjgIQxUmkQ9M
         gu+IcsOkAGHEPpMXsGojeU0WtXpKPgMj75FE79po3Wg0CIqUYhlFeIaFszEMW+aoedjj
         eaWr25zqHAPDP6eai+5oEBP9Z0Jf3wRWrO1he/diAIgfFfMvF605eLfYnu46GjJKMeUD
         lvhC325DLYsNG7TcQRhlQsU+cKD9TO2GRZWDxbuxioiPodso5l2J+p/sybqxsNdX+4ke
         XLhA==
X-Gm-Message-State: APjAAAU+gmqX8itFBx04CfH1ldyOBwvejholAuytzn8KQtpGRbxUha+I
        nMoWjqjCOP/FpkNrvVMO/QHcVpBvFHgUk9gqOLWyGw==
X-Google-Smtp-Source: APXvYqwAn085HfIVfC7aVZyQ7KsL80NObNnhXjbstU80YtcTM4BNQ5KVXEV3WNdwPDLSJvOGwtdF+TF5PiceeW1EzLo=
X-Received: by 2002:a17:90a:ac02:: with SMTP id o2mr6606147pjq.134.1567030944115;
 Wed, 28 Aug 2019 15:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190828194226.GA29967@swahl-linux> <CAKwvOdn0=7YabPD-5EUwkSoJgWjdYHY2mirM2LUz0TxZTBOf_Q@mail.gmail.com>
 <20190828221048.GB29967@swahl-linux>
In-Reply-To: <20190828221048.GB29967@swahl-linux>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Aug 2019 15:22:13 -0700
Message-ID: <CAKwvOdnaxZuJHpbmMzdtKSZD10m3Rd52FdHeq2gvkas3XVmk7w@mail.gmail.com>
Subject: Re: Purgatory compile flag changes apparently causing Kexec
 relocation overflows
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 3:14 PM Steve Wahl <steve.wahl@hpe.com> wrote:
>
> On Wed, Aug 28, 2019 at 02:51:21PM -0700, Nick Desaulniers wrote:
> > On Wed, Aug 28, 2019 at 12:42 PM Steve Wahl <steve.wahl@hpe.com> wrote:
> > >
> > > Please CC me on responses to this.
> > >
> > > I normally would do more diligence on this, but the timing is such
> > > that I think it's better to get this out sooner.
> > >
> > > With the tip of the tree from https://github.com/torvalds/linux.git  (a
> > > few days old, most recent commit fetched is
> > > bb7ba8069de933d69cb45dd0a5806b61033796a3), I'm seeing "kexec: Overflow
> > > in relocation type 11 value 0x11fffd000" when I try to load a crash
> > > kernel with kdump. This seems to be caused by commit
> > > 059f801a937d164e03b33c1848bb3dca67c0b04, which changed the compiler
> > > flags used to compile purgatory.ro, apparently creating 32 bit
> > > relocations for things that aren't necessarily reachable with a 32 bit
> > > reference.  My guess is this only occurs when the crash kernel is
> > > located outside 32-bit addressable physical space.
> > >
> > > I have so far verified that the problem occurs with that commit, and
> > > does not occur with the previous commit.  For this commit, Thomas
> > > Gleixner mentioned a few of the changed flags should have been looked
> > > at twice.  I have not gone so far as to figure out which flags cause
> > > the problem.
> > >
> > > The hardware in use is a HPE Superdome Flex with 48 * 32GiB dimms
> > > (total 1536 GiB).
> > >
> > > One example of the exact error messages seen:
> > >
> > > 019-08-28T13:42:39.308110-05:00 uv4test14 kernel: [   45.137743] kexec: Overflow in relocation type 11 value 0x17f7affd000
> > > 2019-08-28T13:42:39.308123-05:00 uv4test14 kernel: [   45.137749] kexec-bzImage64: Loading purgatory failed
> >
> > Thanks for the report and sorry for the breakage.  Can you please send
> > me more information for how to precisely reproduce the issue?  I'm
> > happy to look into fixing it.
>
> Here's the details I know might be important:
>
> Since this appears to be a problem with the result of a relocation not
> fitting within 32 bits, I think the location chosen to place the crash
> kernel needs to be above 4GiB; so you need a machine with more memory
> than that.
>
> At the moment I'm running SLES 12 sp 4 as the rest of the
> environment.  rpm says kdump is kdump-0.8.16-9.2.x86_64.  I've fetched
> the kernel sources and compiled directly on this system.  I believe I
> copied the kernel config from the SLES kernel and did a make
> olddefconfig for configuration.  Made and installed the kernel from
> the kernel tree.
>
> crashkernel=512M,high is set on the command line.
>
> As the system boots, and systemd initializes kdump, it tries to load
> the crash kernel, I believe through
> /usr/lib/systemd/system/kdump.service running /lib/kdump/load.sh
> --update.
>
> Once that completes, 'systemctl status kdump' indicates a failure, and
> dmesg | grep kexec shows the error messages mentioned above.
>
> > Let me go dig up the different listed flags.  Steve, it may be fastest
> > for you to test re-adding them in your setup to see which one is
> > important.
>
> I will work through that tomorrow and let you know what I find.
>
> > Tglx, if you want to revert the above patches, I'm ok with that.  It's
> > important that we fix the issue eventually that my patches were meant
> > to address, but precisely *when* it's solved isn't critical; our
> > kernels can carry out of tree patches for now until the issue is
> > completely resolved worst case.

One point that might be more useful first would be, is a revert of:

commit b059f801a937 ("x86/purgatory: Use CFLAGS_REMOVE rather than
reset KBUILD_CFLAGS")

good enough, or must:

commit 4ce97317f41d ("x86/purgatory: Do not use __builtin_memcpy and
__builtin_memset")

be reverted additionally?  They were part of a 2 patch patchset.  I
would prefer tglx to revert as few patches as necessary if possible
(to avoid "revert of revert" soup), and I doubt the latter patch needs
to be reverted.  (Even more preferential would be a fix, with no
reverts, but whichever).
-- 
Thanks,
~Nick Desaulniers
