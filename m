Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95379C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A539218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfCUMp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:45:56 -0400
Received: from avasout02.plus.net ([212.159.14.17]:56870 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbfCUMpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:45:55 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Mar 2019 08:45:55 EDT
Received: from deneb ([80.229.24.9])
        by smtp with ESMTP
        id 6wxihzn5H2SW56wxjhK9e7; Thu, 21 Mar 2019 12:38:24 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=NtavjPVJ c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=NTGMnVQrEZIA:10
 a=-An2I_7KAAAA:8 a=CCpqsmhAAAAA:8 a=q6MwtBc8aigTzGVEUL4A:9 a=CjuIK1q_8ugA:10
 a=Sq34B_EcNBM9_nrAYB9S:22 a=ul9cdbp4aOFLsgKbc677:22
Received: from mac by deneb with local (Exim 4.89)
        (envelope-from <mac@mcrowe.com>)
        id 1h6wxi-0001db-8t; Thu, 21 Mar 2019 12:38:22 +0000
Date:   Thu, 21 Mar 2019 12:38:22 +0000
From:   Mike Crowe <mac@mcrowe.com>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kay Sievers <kay@vrfy.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: kmsg: lseek errors confuse glibc's dprintf
Message-ID: <20190321123822.npfxumj2gwlwkxlf@mcrowe.com>
References: <20150115173132.GA7486@mcrowe.com>
 <20190321104726.3c570c41e5757611a13c23ca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321104726.3c570c41e5757611a13c23ca@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CMAE-Envelope: MS4wfDsl0i2Sw2eLevf/cEFsrs7B6Xa7cAKgbOBT1ohV7GeIFZRJLD9AmhroT3NG9Im4EHuJ0GYR56Za1aIsiJb/bKiDJIox2ACaqtnYhTVmWy6p1zRQr792
 szFRdYcGV0zwqj/aOaNfFpBgMkuv455NjPo/ldQ1YO4evKWFHvdNWS3w
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 March 2019 at 10:47:26 +0100, Alexander Sverdlin wrote:
> Hello Mike and all,
> 
> On Thu, 15 Jan 2015 17:31:32 +0000
> Mike Crowe <mac@mcrowe.com> wrote:
> 
> > glibc's dprintf implementation does not work correctly with /dev/kmsg file
> > descriptors because glibc treats receiving EBADF and EINVAL from lseek when
> > trying to determine the current file position as errors. See
> > https://sourceware.org/bugzilla/show_bug.cgi?id=17830
> 
> we need to conclude on this issue. This is a real bug which is ignored
> for 4 years now. Mike, would you like to re-send a formal patch?
> I can do it as well, preserving a link to your original patch/report.
> In case you'd like to post it yourself, I can be a tester and/or
> provide a reproducer.

Hi Alexander,

I'm sorry for dropping the ball on this. I think I was travelling at the
time. :( Thank you for picking it up.

I don't mind rebasing my patch once I know which of my two solutions is
preferred. It seems that the -ESPIPE one is the current favourite.

Thanks.

> > >>From what I can tell prior to Kay Sievers printk record commit
> > e11fea92e13fb91c50bacca799a6131c81929986, calling lseek(fd, 0, SEEK_CUR)
> > with such a file descriptor would not return an error.
> > 
> > Prior to Kay's change, Arnd Bergmann's commit
> > 6038f373a3dc1f1c26496e60b6c40b164716f07e seemed to go to some lengths to
> > preserve the successful return code rather than returning (the perhaps more
> > logical) -ESPIPE.
> > 
> > glibc is happy with either a successful return or -ESPIPE.
> > 
> > For maximum compatibility it seems that success should be returned but
> > given Kay's new seek interface perhaps this isn't helpful.
> > 
> > This patch ensures that such a seek succeeds:
> > 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 02d6b6d..b3ff6f0 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -693,7 +693,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
> >  	loff_t ret = 0;
> >  
> >  	if (!user)
> > -		return -EBADF;
> > +		return (whence == SEEK_CUR) ? 0 : -EBADF;
> >  	if (offset)
> >  		return -ESPIPE;
> >  
> > @@ -718,6 +718,11 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
> >  		user->idx = log_next_idx;
> >  		user->seq = log_next_seq;
> >  		break;
> > +	case SEEK_CUR:
> > +		/* For compatibility with userspace requesting the
> > +		 * current file position. */
> > +		ret = 0;
> > +		break;
> >  	default:
> >  		ret = -EINVAL;
> >  	}
> > 
> > (although it could be argued that the !user case should return -ESPIPE
> > rather than EBADF since the file descriptor _is_ valid.)
> > 
> > and this patch causes a failure that glibc is prepared to accept:
> > 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 02d6b6d..f6b0c93 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -693,7 +693,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
> >  	loff_t ret = 0;
> >  
> >  	if (!user)
> > -		return -EBADF;
> > +		return -ESPIPE;
> >  	if (offset)
> >  		return -ESPIPE;
> >  
> > @@ -718,6 +718,11 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
> >  		user->idx = log_next_idx;
> >  		user->seq = log_next_seq;
> >  		break;
> > +	case SEEK_CUR:
> > +		/* For compatibility with userspace expecting SEEK_CUR
> > +		 * to not yield EINVAL. */
> > +		ret = -ESPIPE;
> > +		break;
> >  	default:
> >  		ret = -EINVAL;
> >  	}
> > 
> > Either makes dprintf work, but is either the right solution?

Mike.
