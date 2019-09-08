Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BAAC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8363218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567961025;
	bh=QcXOe6VPWYtj/hGsx0flEYarB4jaGMtWqVwLTq8Wodk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t0p5OVY6xMHvxx6DQjI7WksGwmiphtuBtW1akIqIO2Lm9y8xtnU0Z1OqgFhxw8fFC
	 H0zgu0tnw/yOObdHkX0MxIPo0tV+AVMXDrNZmO3D3DicYPxFOpgr7CE108PCQqh4/O
	 d/RZ9djrBuYHc4FMfxHbMKZhOSR150/srEn8Y6y4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfIHQnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 12:43:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729797AbfIHQno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 12:43:44 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CE20216C8;
        Sun,  8 Sep 2019 16:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567961023;
        bh=QcXOe6VPWYtj/hGsx0flEYarB4jaGMtWqVwLTq8Wodk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=02QA/j/TgJM1ZCODvJd6zqsT1442AJ4r2qWFdHnwsS5BtgaMxgXrVx+7XQ9uuOffe
         S9v+UlxWoloVMN8vJatHGDzFGtXDH8iasoS8+Q54wvjFCH+ACCPko4bPu4zQeveS8y
         MRqNXcSrckTFlaHxb8ZW6e3mL1BUy9CDgR8KA9QY=
Date:   Sun, 8 Sep 2019 17:43:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
Cc:     devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: add millisecond support
Message-ID: <20190908164341.GC8362@kroah.com>
References: <20190908124808.23739-1-vvidic@valentin-vidic.from.hr>
 <20190908130337.GA9056@kroah.com>
 <20190908144735.GA7664@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190908144735.GA7664@valentin-vidic.from.hr>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 02:47:35PM +0000, Valentin Vidić wrote:
> On Sun, Sep 08, 2019 at 02:03:37PM +0100, Greg Kroah-Hartman wrote:
> > Please run checkpatch on your patches so that we don't have to go and
> > fix up those issues later on.
> 
> Strange, it did not report anything for me:
> 
> total: 0 errors, 0 warnings, 0 checks, 439 lines checked
> 0001-staging-exfat-add-millisecond-support.patch has no obvious style problems and is ready for submission.

See my response to the broken out patch as to where it should have
complained.

> > Also, can you break this up into smaller patches please?  You are doing
> > multiple things all at once.
> 
> Sure, I was just trying to improve the code a bit :)

No problem, it's much appreciated.

> > And, are you sure about the millisecond field for access time stuff?  It
> > was obviously added for some reason (there are lots in the spec that the
> > code does not yet cover, this seems odd being the other way around).
> > Did you test it against any other operating system exfat images to
> > ensure that it really is not being used at all?  If so, which ones?
> 
> Don't really have access to another OS, but here is what exfat-fuse has:
> 
> struct exfat_entry_meta1                        /* file or directory info (part 1) */
> {
>         uint8_t type;                                   /* EXFAT_ENTRY_FILE */
>         uint8_t continuations;
>         le16_t checksum;
>         le16_t attrib;                                  /* combination of EXFAT_ATTRIB_xxx */
>         le16_t __unknown1;
>         le16_t crtime, crdate;                  /* creation date and time */
>         le16_t mtime, mdate;                    /* latest modification date and time */
>         le16_t atime, adate;                    /* latest access date and time */
>         uint8_t crtime_cs;                              /* creation time in cs (centiseconds) */
>         uint8_t mtime_cs;                               /* latest modification time in cs */
>         uint8_t __unknown2[10];
> }
> 
> The spec matches this and defines 3 additional UtcOffset fields that we don't use:

I would only go off of the spec, who knows where exfat-fuse got its
information from :)

> EntryType
> SecondaryCount
> SetChecksum
> FileAttributes
> Reserved1
> CreateTimestamp
> LastModifiedTimestamp
> LastAccessedTimestamp
> Create10msIncrement
> LastModified10msIncrement
> 
> CreateUtcOffset (1 byte)
> LastModifiedUtcOffset (1 byte)
> LastAccessedUtcOffset (1 byte)
> Reserved2 (7 bytes)
> 
> So I'm not sure where access_time_ms came from. In any case it was always set to
> 0 so it should not matter much?

If it really is CreateUtcOffset, we should use that.

For things like messing with fields, testing on another operating system
to ensure we got this right is going to be very essential.  Virtual
machines of osx or windows might be a good way to do that.

thanks,

greg k-h
