Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF36AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFCD20684
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="NcA3edqK";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="Hv26thj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfK0I1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:27:36 -0500
Received: from mail187-16.suw11.mandrillapp.com ([198.2.187.16]:18789 "EHLO
        mail187-16.suw11.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbfK0I1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:27:36 -0500
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Nov 2019 03:27:35 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=FyS2d7WYMN0XOjwqfqtBJxC7BKxHzrTUpalh89S9EPA=;
 b=NcA3edqKKW328oETwaJrje3RWQsX3x+AuM+0PSExfg++KrUBadyB4hOU3GJyg50Lj3PI/1rjXbC/
   DKUeH5RUjdIj7IuuomYjnQXx/ADcijd1qJvu+eJUej3uglxfXcHyAzOkWNLIlMdyDnBe4Axy7xjt
   HJ9h2+kC8fMSX0Nz718=
Received: from pmta01.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail187-16.suw11.mandrillapp.com id hropne174i46 for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 08:12:34 +0000 (envelope-from <bounce-md_31050260.5dde2ff2.v1-79c01fdeceb14bb68d395f4859771242@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1574842354; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : Date : MIME-Version : 
 Content-Type : Content-Transfer-Encoding : From : Subject : Date : 
 X-Mandrill-User : List-Unsubscribe; 
 bh=FyS2d7WYMN0XOjwqfqtBJxC7BKxHzrTUpalh89S9EPA=; 
 b=Hv26thj983lyL85quVozUQ8Kq7K/sjb9TulHzXDwrZIa16sBWaK1Hf9XxmA01hXJh+zfdv
 +FS6/RY6I0yvfPcY/mzsx+mtybkYPpTXmXVS9Gr0HDW0+rtT63+v1HE/Qbpyqu85oVIe2E2T
 8ilVkSHbLs8f1mqtbWWG6DqajUMNg=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: Commit 0be0ee71 ("fs: properly and reliably lock f_pos in fdget_pos()") breaking userspace
Received: from [87.98.221.171] by mandrillapp.com id 79c01fdeceb14bb68d395f4859771242; Wed, 27 Nov 2019 08:12:34 +0000
To:     "Kenneth R. Crudup" <kenny@panix.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <20191127081229.GA3506@deco.navytux.spb.ru>
In-Reply-To: <CAHk-=wh6w6U5FgZZXq-Eo8+aH1Y6ffp+Nwr_6GzmuzjVuGXmNw@mail.gmail.com> <alpine.DEB.2.21.1911260445170.6292@hp-x360n>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.79c01fdeceb14bb68d395f4859771242
X-Mandrill-User: md_31050260
Date:   Wed, 27 Nov 2019 08:12:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 12:03:36PM -0800, Linus Torvalds wrote:
> On Mon, Nov 25, 2019 at 7:39 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I think I'll have to revert that trial commit. I'll give it another
> > day in case somebody has a better idea, but it looks like it's too
> > early to do that nice cleanup as things are now.
> 
> I've reverted it for now,
> 
> I don't want this problem to cause people to report known bugs during
> the merge window. The fact that I saw no issues obviously is just a
> matter of my workloads being too simple.

I see, ok; let's move on incrementally. What is the fate of small
net/socket.c cleanup patch? Should I resend it to netdev or something?


On Tue, Nov 26, 2019 at 04:46:39AM -0800, Kenneth R. Crudup wrote:
> 
> On Tue, 26 Nov 2019, Kirill Smelkov wrote:
> 
> > P.S. even though I was put into cc there, somehow I did not received any
> > notification email for commits d8e464ecc17b (vfs: mark pipes and sockets as
> > stream-like file descriptors) and 0be0ee71816b (vfs: properly and
> > reliably lock f_pos in fdget_pos()).
> 
> That's my fault; the CC: list for those commits was pretty long and I was
> worried about it appearing like SPAMming anyone who'd signed off on it, so
> I'd punted and sent it to Linus and the LKML only.

I did not mean it was your fault. I was trying to say that there was no
automatic notification just as those commits were pushed to master. And
neither there is for 2be7d348fe92 (Revert "vfs: properly and reliably
lock f_pos in fdget_pos()").

Kirill
