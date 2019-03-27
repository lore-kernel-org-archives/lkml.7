Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7576C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957CA2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="N1B7SbzO";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="nG3tOzx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbfC0KoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:44:19 -0400
Received: from mail177-9.suw61.mandrillapp.com ([198.2.177.9]:58519 "EHLO
        mail177-9.suw61.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729489AbfC0KoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:44:18 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2019 06:44:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=bLuekUlqFzmIMmKwsu2eKGF+DvRjbJugn49IAZaBu1U=;
 b=N1B7SbzOdCwvhsmL47SWMdqZYwH4p9rfmypZbD3LDQprpAxOXZCs3M/V1RoNM/4VDK9J3XKH0F4i
   zi1bhHASBe8q475KEVerFYVVasgJfX1G5KWrUL1y+8H5AKr2f+aAh7yAlrz5aZ7SGU0lPnIZ9BTK
   Ss0MxtZwWkAqYZCEavs=
Received: from pmta06.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail177-9.suw61.mandrillapp.com id hjda0222rtkl for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 10:15:14 +0000 (envelope-from <bounce-md_31050260.5c9b4d32.v1-706099adce7248faa45fa9751e7be9eb@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1553681714; h=From : 
 Subject : To : Cc : Message-Id : Date : MIME-Version : Content-Type : 
 Content-Transfer-Encoding : From : Subject : Date : X-Mandrill-User : 
 List-Unsubscribe; bh=bLuekUlqFzmIMmKwsu2eKGF+DvRjbJugn49IAZaBu1U=; 
 b=nG3tOzx2x3747oFpQnoQSOwSE2GvY1lk5zfJIhk2iNwlFqD4S5ybzgL1qEq1zmQtlbGOsZ
 TcLC9rzDYKxj3YZTccO5eAXlpS9JB5GHxTTSW+ZVl27CxY17kNLE1ldwSzDrdH0rVTsRRhi4
 NU9ZavqXtq32FZiGr0O1sL5/DICw0=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [RESEND4, PATCH 0/2] fuse: don't stuck clients on retrieve_notify with size > max_write
Received: from [87.98.221.171] by mandrillapp.com id 706099adce7248faa45fa9751e7be9eb; Wed, 27 Mar 2019 10:15:14 +0000
X-Mailer: git-send-email 2.21.0.392.gf8f6787159
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <fuse-devel@lists.sourceforge.net>,
        Kirill Smelkov <kirr@nexedi.com>
Message-Id: <cover.1553680185.git.kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.706099adce7248faa45fa9751e7be9eb
X-Mandrill-User: md_31050260
Date:   Wed, 27 Mar 2019 10:15:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos,

On Thu, Mar 14, 2019 at 01:45:20PM +0300, Kirill Smelkov wrote:
> Miklos,
> 
> On Thu, Feb 28, 2019 at 02:47:57PM +0300, Kirill Smelkov wrote:
> > On Thu, Feb 28, 2019 at 09:10:15AM +0100, Miklos Szeredi wrote:
> > > On Wed, Feb 27, 2019 at 9:39 PM Kirill Smelkov <kirr@nexedi.com> wrote:
> > > 
> > > > I more or less agree with this statement. However can we please make the
> > > > breakage to be explicitly visible with an error instead of exhibiting it
> > > > via harder to debug stucks/deadlocks? For example sys_read < max_write
> > > > -> error instead of getting stuck. And if notify_retrieve requests
> > > > buffer larger than max_write -> error or cut to max_write, but don't
> > > > return OK when we know we will never send what was requested to
> > > > filesystem even if it uses max_write sized reads. What is the point of
> > > > breaking in hard to diagnose way when we can make the breakage showing
> > > > itself explicitly? Would a patch for such behaviour accepted?
> > > 
> > > Sure, if it's only adds a couple of lines.   Adding more than say ten
> > > lines for such a non-bug fix is definitely excessive.
> >
> > Ok, thanks. Please consider applying the following patch. (It's a bit
> > pity to hear the problem is not considered to be a bug, but anyway).
> >
> > I will also send the second patch as another mail, since I could not
> > made `git am --scissors` to apply several patched extracted from one
> > mail successfully.
> 
> [...]
> 
> On Thu, Mar 07, 2019 at 12:34:21PM +0300, Kirill Smelkov wrote:
> > Ping. Miklos, is there anything wrong with this patch and its
> > second counterpart?
> 
> As we were talking here are those patches. The first one cuts notify_retrieve
> request to max_write and is one line only. The second one returns error to
> filesystem server if it is buggy and does sys_read with buffer size <
> max_write. It is 2 lines of code and 7 lines of comments.
> 
> I still think that the patches fix real bugs. It is a bug if server behaviour
> is a bit non-confirming or simply on an edge of being correct or questionable,
> and instead of properly getting plain error from kernel, the whole system gets
> stuck. It is a bug because bug amplification factor here is at least one order
> of magnitude instead of staying ~1x.
> 
> I'm sending the patches for the third time already, but did not get any
> feedback. Could you please have a look?

It's been ~ 1 month already since we agreed on the approach and initial
postings of the patches that follow the agreed way:

https://lwn.net/ml/linux-fsdevel/20190228114757.GA2796@deco.navytux.spb.ru/

Since then the patches were resent several times but without getting any
feedback from you.

Is there anything wrong with the patches? Could you please have a look?
I understand everyone is busy but 1 month seems to be too much and I'm
wondering whether maybe my mails got classified as spam or something
else on your side.

Thanks beforehand,
Kirill

Kirill Smelkov (2):
  fuse: retrieve: cap requested size to negotiated max_write
  fuse: require /dev/fuse reads to have enough buffer capacity as negotiated

 fs/fuse/dev.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
2.21.0.392.gf8f6787159
