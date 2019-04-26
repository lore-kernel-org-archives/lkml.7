Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F71C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC4A2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="PSp3UPrE";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="ANbIMsl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfDZSf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:35:26 -0400
Received: from mail187-19.suw11.mandrillapp.com ([198.2.187.19]:12365 "EHLO
        mail187-19.suw11.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbfDZSf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=5jb4sUuCN7HuD6js4ds8mUyrGlXnyKRVCnkhQDb/ce4=;
 b=PSp3UPrECe/sX7q9+Y2+pNxk+L0tAGMJIIRnc5cgDILgBDcdfXvgXZPYoY8EcfdqcXI2aWjiq/gi
   bWoh/j4VXkSm1N6CBulHLq7Ur+R1T9+cmu6pmK+KADvz5kbJW+iavhRaJegWFveQeLZ8gnRpCiLb
   ICvHmbbvPfutnkYBvy4=
Received: from pmta01.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail187-19.suw11.mandrillapp.com id hod7mq174i4r for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 18:20:24 +0000 (envelope-from <bounce-md_31050260.5cc34be8.v1-ae14908b32de417b8d25a92d1c9a77a2@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1556302824; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=5jb4sUuCN7HuD6js4ds8mUyrGlXnyKRVCnkhQDb/ce4=; 
 b=ANbIMsl/9Ky1KMv9kelgbaM0oj7grCVhgFy7eokRJA5StNTa/17s7uIU0ou+iNzXl/jZcy
 YFNYv0KyZN8JhCnvyDCHFvNSPUDf26Zz87G5WIIBOMOPOOUqFLPlKHPtSRHU9MVUk1pkprbr
 72wJKM6OZZxdK2E+2Hm6PfXAGG8i8=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH AUTOSEL 5.0 59/66] fs: stream_open - opener for stream-like files so that read and write can run simultaneously without deadlock
Received: from [87.98.221.171] by mandrillapp.com id ae14908b32de417b8d25a92d1c9a77a2; Fri, 26 Apr 2019 18:20:24 +0000
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yongzhi Pan <panyongzhi@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Tejun Heo <tj@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-Id: <20190426182014.GA23128@deco.navytux.spb.ru>
References: <20190424143341.27665-1-sashal@kernel.org> <20190424143341.27665-59-sashal@kernel.org> <20190424163415.GB21413@kroah.com> <CAHk-=wjEOyba5As1PEMk6RitNVOJH9oJ_Jbg4y=5B0fcX1iKGw@mail.gmail.com> <20190424171926.GA17719@sasha-vm> <CAHk-=wgh234SyBG810=vB360PCzVkAhQRqGg8aFdATZd+daCFw@mail.gmail.com> <20190424183012.GB3798@deco.navytux.spb.ru> <4d366f81f90442cb9da7ad393680d004@AcuMS.aculab.com> <20190426074522.GA16247@deco.navytux.spb.ru> <073e5def9e654a1d80cdd79cdcf23361@AcuMS.aculab.com>
In-Reply-To: <073e5def9e654a1d80cdd79cdcf23361@AcuMS.aculab.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.ae14908b32de417b8d25a92d1c9a77a2
X-Mandrill-User: md_31050260
Date:   Fri, 26 Apr 2019 18:20:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:00:01AM +0000, David Laight wrote:
> From: Kirill Smelkov
> > Sent: 26 April 2019 08:46
> ...
> > I'm not sure I understand your comment completely, but we convert to
> > stream_open only drivers that actually do _not_ use position at all, and
> > that were already using nonseekable_open, thus pread and pwrite were
> > already returning -ESPIPE for them (nonseekable_open clears
> > FMODE_{PREAD,PWRITE} and ksys_{pread,pwrite}64 check for that flag). We
> > also convert only drivers that use no_llseek for .llseek, so lseek
> > on those files is/was always returning -ESPIPE as well.
> > 
> > If a driver uses position in its read and write and has support for
> > pread/pwrite (FMODE_PREAD and FMODE_PWRITE), pread and pwrite are
> > already working _without_ file->f_pos locking - because those system
> > calls do not semantically update file->f_pos at all and thus do not take
> > file->f_pos_lock - i.e. pread/pwrite can be run simultaneously already.
> 
> Looks like I knew that once :-)
> Mind you, 'man pread' on my system is somewhat uninformative.
> 
> Maybe pread() should always be allowed at offset 0.
> Then you wouldn't need all this extra logic.

I'm not sure I understand. Do you propose any change? If yes - what is
the change you are proposing?


> > If libc implements pread as lseek+read it will work for a single
> > user case  (single thread, or fd not shared between processes), but it
> > will break because of lseek+read non-atomicity if multiple preads are
> > simultaneously used from several threads. And also for such emulation
> > for multiple users case there is a chance for pread vs pwrite deadlock,
> > since those system calls are using read and write and read and write
> > take file->f_pos_lock.
> 
> I'd actually rather the pread() failed to compile.

Ok.

> The actual implementation did 3 lseek()s (to save and restore the offset).
> A user level emulation could usually get away with one lseek().
