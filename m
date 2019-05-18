Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19558C072A4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 15:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED02E20872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 15:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfERPZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 11:25:32 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58690 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbfERPZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 11:25:31 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hS1DG-0002hL-Hj; Sat, 18 May 2019 09:25:30 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hS1DF-0003iq-O1; Sat, 18 May 2019 09:25:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.1905181116330.7855-100000@netrider.rowland.org>
Date:   Sat, 18 May 2019 10:25:05 -0500
In-Reply-To: <Pine.LNX.4.44L0.1905181116330.7855-100000@netrider.rowland.org>
        (Alan Stern's message of "Sat, 18 May 2019 11:20:47 -0400 (EDT)")
Message-ID: <878sv3ss32.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hS1DF-0003iq-O1;;;mid=<878sv3ss32.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Vd8OIugNR8FtTsnNrJrJM9aHdGWcp/AY=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [CFT][PATCH] signal/usb: Replace kill_pid_info_as_cred with kill_pid_usb_asyncio
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Fri, 17 May 2019, Eric W. Biederman wrote:
>
>> Wow I got a little distracted but now I am back to this.
>> 
>> Using your test program I was able to test the basics of this.
>> 
>> I found one bug in my patch where I was missing a memset.  So I have
>> corrected that, and reorganized the patch a little bit.
>> 
>> I have not figured out how to trigger a usb disconnect so I have not
>> tested that.
>
> Heh.  Assuming the device file you tell the test program to use 
> corresponds to an actual USB device, you can trigger a disconnect by 
> literally unplugging the USB cable.  (Add a 10-second delay to the 
> program to give yourself enough time.)

I have just been running this in qemu.  But yes.  I suppose the easy
way would be to print a message asking the usb device to be unplugged
and then just wait for the signal.  I might try that.

>> The big thing I have not been able to test is running a 64bit big-endian
>> kernel with a 32bit user space.  My modified version of your test
>> program should report "Bad" without my patch, and should report "Good"
>> with it.
>> 
>> Is there any chance you can test that configuration?  I could not figure
>> out how to get a 64bit big-endian system running in qemu, and I don't
>> have the necessary hardware so I was not able to test that at all.  As
>> that is the actual bug I am still hoping someone can test it.
>
> Unfortunately, I don't have any big-endian systems either.

That probably explains why the breakage in big-endian was never noticed.
I am starting to wonder if anyone is actually doing big-endian for new
systems anymore.

Eric
