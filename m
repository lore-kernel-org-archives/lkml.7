Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520D6C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 14:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194DF214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 14:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b="Cx4tVznf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbfIHOrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 10:47:40 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:34659 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfIHOrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 10:47:40 -0400
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 7B1A3214; Sun,  8 Sep 2019 14:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=valentin-vidic.from.hr; s=2017; t=1567954055;
        bh=iMps8Hv8V4ycg9xT22lBI+Z06VFOIDLw6qNSazuJrT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cx4tVznfdjeZdz28aPWZ3k9UBKvN6GBRXxF72OBawL83EUURclkIuwlD3DK+vphOz
         wHMUZAMncttgL5exHo3NW72E7kQLhRTz1J3VKSzVlImZoxrTPPQbZQIWyx+RYkbE0/
         NkbYoTewDhJxhrK24z4LSw5Acfy8eVJxx2ls8BI75hFXThx16wGvJIBNSC/9AaQ42S
         WG5DM4+VvzMeFFlzFoG6NVUbbIhnSGeC2UetULCFalu1EiUvom496NV2hMEfLDvJf9
         yIMUBUV35FvlWxPu7iH/P8QyJWDrvDcfUyzj2pVBiqShavMUPlanMw06M5iTGPT8le
         1ckjQN4qs2a6A==
Date:   Sun, 8 Sep 2019 14:47:35 +0000
From:   Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: add millisecond support
Message-ID: <20190908144735.GA7664@valentin-vidic.from.hr>
References: <20190908124808.23739-1-vvidic@valentin-vidic.from.hr>
 <20190908130337.GA9056@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908130337.GA9056@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 02:03:37PM +0100, Greg Kroah-Hartman wrote:
> Please run checkpatch on your patches so that we don't have to go and
> fix up those issues later on.

Strange, it did not report anything for me:

total: 0 errors, 0 warnings, 0 checks, 439 lines checked
0001-staging-exfat-add-millisecond-support.patch has no obvious style problems and is ready for submission.

> Also, can you break this up into smaller patches please?  You are doing
> multiple things all at once.

Sure, I was just trying to improve the code a bit :)

> And, are you sure about the millisecond field for access time stuff?  It
> was obviously added for some reason (there are lots in the spec that the
> code does not yet cover, this seems odd being the other way around).
> Did you test it against any other operating system exfat images to
> ensure that it really is not being used at all?  If so, which ones?

Don't really have access to another OS, but here is what exfat-fuse has:

struct exfat_entry_meta1                        /* file or directory info (part 1) */
{
        uint8_t type;                                   /* EXFAT_ENTRY_FILE */
        uint8_t continuations;
        le16_t checksum;
        le16_t attrib;                                  /* combination of EXFAT_ATTRIB_xxx */
        le16_t __unknown1;
        le16_t crtime, crdate;                  /* creation date and time */
        le16_t mtime, mdate;                    /* latest modification date and time */
        le16_t atime, adate;                    /* latest access date and time */
        uint8_t crtime_cs;                              /* creation time in cs (centiseconds) */
        uint8_t mtime_cs;                               /* latest modification time in cs */
        uint8_t __unknown2[10];
}

The spec matches this and defines 3 additional UtcOffset fields that we don't use:

EntryType
SecondaryCount
SetChecksum
FileAttributes
Reserved1
CreateTimestamp
LastModifiedTimestamp
LastAccessedTimestamp
Create10msIncrement
LastModified10msIncrement

CreateUtcOffset (1 byte)
LastModifiedUtcOffset (1 byte)
LastAccessedUtcOffset (1 byte)
Reserved2 (7 bytes)

So I'm not sure where access_time_ms came from. In any case it was always set to
0 so it should not matter much?

-- 
Valentin
