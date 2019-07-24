Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E00C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2529C229F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfGXKMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:12:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42152 "EHLO eggs.gnu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfGXKMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:12:18 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e]:47626)
        by eggs.gnu.org with esmtp (Exim 4.71)
        (envelope-from <dak@gnu.org>)
        id 1hqEFt-0005Zw-Bb
        for linux-kernel@vger.kernel.org; Wed, 24 Jul 2019 06:12:17 -0400
Received: from x5d854e05.dyn.telefonica.de ([93.133.78.5]:39226 helo=lola)
        by fencepost.gnu.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <dak@gnu.org>)
        id 1hqEFs-0008Hv-Kc
        for linux-kernel@vger.kernel.org; Wed, 24 Jul 2019 06:12:16 -0400
From:   David Kastrup <dak@gnu.org>
To:     linux-kernel@vger.kernel.org
Subject: Locating tz=UTC problem with vfat filesystem
Date:   Wed, 24 Jul 2019 12:03:55 +0200
Message-ID: <87v9vrn3zo.fsf@fencepost.gnu.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm plagued with Ubuntu (currently eoan but was the same previously)
with regard to vfat filesystem timezone.

uname -a gives

Linux lola 5.2.0-8-lowlatency #9-Ubuntu SMP PREEMPT Mon Jul 8 13:49:06 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

The documentation states that mount option tz=UTC is required for having
timestamps in fat filesystems interpreted relative to UTC.  However, no
such option is listed in the mount flags and nevertheless timestamps on
my (fat32) memory sticks are interpreted as being relative to UTC.  This
is with several card readers as well as my (timezone agnostic) Sony
DSC-R1 camera as USB reader.  There does not seem to be a corresponding
option for switching tz=UTC off explicitly and I think if it were
switched on explicitly by some code, it should get listed in the mount
flags.

The mount subsystem is some sort of udisks2 based on udev: I don't
really manage to find myself through the documentation of that.  Note
that the exfat file system is supposed to have some sort of timezone
support but that is not the case for other fat filesystems.

So I think something must have gone awry somewhere and due to the lack
of visible mount options, I do suspect this to be kernel involved but
may well be wrong.

Does anybody have a clue how I can get behind this and figure out where
the source of the problem (code and/or documentation) lies and how to
move forward with regard to getting it fixed?  There would be the
workaround of setting the camera clock to UTC, but since this behavior
is clearly completely different than the documented behavior, that seems
like skirting the issue which seems to be in want of fixing.

Or is there something one can set on the filesystem media itself to mark
it as being localtime relative?  That would likely be the most reliable
way since it would allow one to treat different media differently,
depending on whether their usual hosting device has a notion of
timezones and/or UTC.

Thanks!

-- 
David Kastrup

