Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A608EC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B54E2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="nAE6WDg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfCNWQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:16:05 -0400
Received: from rfvt.org.uk ([37.187.119.221]:48116 "EHLO rfvt.org.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbfCNWQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:16:04 -0400
Received: from wylie.me.uk (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by rfvt.org.uk (Postfix) with ESMTPS id 1B02A821B4;
        Thu, 14 Mar 2019 22:16:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
        s=mydkim005; t=1552601762;
        bh=pbOI9QrDiQUfsKVWPs056XmDc4zkl9xyF7DFauWcvzM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To;
        b=nAE6WDg2c9v93IT7UiUVhKA66Eml6YJU/UOjwk+tt/P248CwRTrkZ53CJtGRBOUTm
         +ho0j3jx7sbR54YZIkn+cnMxVDl9MDwirJTE1qCClDl/Xde3cyuGtcHnBzCVXqw0Ta
         eDKde1X6Zkj9kqvpMBz3wA+ET/rEsVVF292QC5tU2ddgP/62qQpbmkunDuVwI5GO1z
         hXXRNZMoRvaJOn4wJ/ovDY6S3q6FBFoQP7uRgQJS/F+sXivZUVjpzxvJz79oFVQg9j
         zdQ+jNdNYTrbM/JB1c0g7aZTS5Xk9ybFQMx+CkfLOv/nKv2ymc2qBy0DlWHcchOh4W
         Ixm6sR4OkNc4g==
From:   alan@wylie.me.uk (Alan J. Wylie)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alec Ari <neotheuser@gmail.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Regression] Re: Linux 5.0.2
References: <20190314162756.GA20704@kroah.com> <87pnqtkz23.fsf@wylie.me.uk>
        <20190314200709.GA16125@kroah.com> <87ftrpkx0d.fsf@wylie.me.uk>
        <20190314215250.GB17893@kroah.com> <20190314215901.GA19535@kroah.com>
Date:   Thu, 14 Mar 2019 22:16:01 +0000
In-Reply-To: <20190314215901.GA19535@kroah.com> (Greg KH's message of "Thu, 14
        Mar 2019 14:59:01 -0700")
Message-ID: <875zslkspq.fsf@wylie.me.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Thu, Mar 14, 2019 at 02:52:50PM -0700, Greg KH wrote:
>> On Thu, Mar 14, 2019 at 08:43:14PM +0000, Alan J. Wylie wrote:
>> > 
>> > (Adding Linus, since his tree is also broken)
>> 
>> Again, can you try running 'git bisect' to find the offending commit?
>
> Ah, looks like Guenter found it, nevermind...

I'd just finished bisecting:

$ git bisect good
3ad8e57560d7652a66da12b41c668a593509f3ad is the first bad commit
commit 3ad8e57560d7652a66da12b41c668a593509f3ad
Author: Peter Zijlstra (Intel) <peterz@infradead.org>
Date:   Tue Mar 5 22:23:15 2019 +0100

    perf/x86/intel: Make cpuc allocations consistent
    
    The cpuc data structure allocation is different between fake and real
    cpuc's; use the same code to init/free both.
    
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

:040000 040000 9066c98aacccc5c85a5783907a8431fe3ab7004c 139f04cab3ddd303ffc595e848d01fac3989ac75 M      arch
$ git bisect log
git bisect start
# good: [283506fcd65de1bc10fcc6e2ca633a7b63171ffa] Linux 5.0.1
git bisect good 283506fcd65de1bc10fcc6e2ca633a7b63171ffa
# bad: [9e6fdea016e45c5feab60589241e0d3607d39945] Linux 5.0.2
git bisect bad 9e6fdea016e45c5feab60589241e0d3607d39945
# good: [e3f5c3cbe16356cd98518765d891aec90dc34e3d] drm: disable uncached DMA optimization for ARM and arm64
git bisect good e3f5c3cbe16356cd98518765d891aec90dc34e3d
# good: [e7b0b71c22e7f9529ae677ba7299efbe6bfbb232] staging: erofs: compressed_pages should not be accessed again after freed
git bisect good e7b0b71c22e7f9529ae677ba7299efbe6bfbb232
# bad: [3ad8e57560d7652a66da12b41c668a593509f3ad] perf/x86/intel: Make cpuc allocations consistent
git bisect bad 3ad8e57560d7652a66da12b41c668a593509f3ad
# good: [3dfe7538f80acf0edf33ae4ae4f639c86e3a3be5] ath9k: Avoid OF no-EEPROM quirks without qca,no-eeprom
git bisect good 3dfe7538f80acf0edf33ae4ae4f639c86e3a3be5
# first bad commit: [3ad8e57560d7652a66da12b41c668a593509f3ad] perf/x86/intel: Make cpuc allocations consistent
$ 

Regards
Alan

-- 
Alan J. Wylie                                          https://www.wylie.me.uk/

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience
