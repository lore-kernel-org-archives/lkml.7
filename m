Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5816EC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 07:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262182084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 07:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="k27NWz4l";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="NnBDonfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfDNH02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 03:26:28 -0400
Received: from mail18.wdc04.mandrillapp.com ([205.201.139.18]:38427 "EHLO
        mail18.wdc04.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725681AbfDNH02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 03:26:28 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Apr 2019 03:26:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=CpRIjSQUR3adhoOiy1dNtcnl6hTH9Y4lP11nhbiW5+g=;
 b=k27NWz4l9r4di4fxgLybjNmNIoLl+Q/yNxwST7rMUXNu+uv+419SsJ0u7Jxn7ExRXCwOFfPria5s
   n+fX6W4YSCNMumdTBPGpIPHNTPalnFNtoSX3taK85ILNNXIYbNLxoWY0AgsNE0fdR0flTf3PYzvy
   Rs3hzsIQmXHfVr0jGLk=
Received: from pmta08.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail18.wdc04.mandrillapp.com id hmbga61jvmgr for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 07:11:26 +0000 (envelope-from <bounce-md_31050260.5cb2dd1d.v1-a0412a8a7c8f413ab314b472d4c48433@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1555225885; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=CpRIjSQUR3adhoOiy1dNtcnl6hTH9Y4lP11nhbiW5+g=; 
 b=NnBDonfisDQgx3h//L1usT1P0p9nE875fQmFEPnp+GcAS82B7kAVFq9Rt/MrRlqWjTlmDc
 vq1YnGf3djOo/tLGmLTNNZsCvB127LPvohkCLtFQNZLtIW7C5nQURq3/TZY5htBdxgk+GVxS
 /NQxMNBqeI5Dfiq6e7KE0mWdcBl/w=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH 1/3] fs: stream_open - opener for stream-like files so that read and write can run simultaneously without deadlock
Received: from [87.98.221.171] by mandrillapp.com id a0412a8a7c8f413ab314b472d4c48433; Sun, 14 Apr 2019 07:11:25 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yongzhi Pan <panyongzhi@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Tejun Heo <tj@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Message-Id: <20190414071117.GA4842@deco.navytux.spb.ru>
References: <c44fcf87d4c9d417b6cdced787091300fd45a3e4.1553637461.git.kirr@nexedi.com> <CAHk-=wgqgN5j1ZWnyVLqqoyU=CCWTYOko3MDyU8L_5e21KvHAg@mail.gmail.com> <20190407200423.GA2829@deco.navytux.spb.ru> <CAHk-=whQQdoQsgEx1vO7OkfPDcV5hurPnMRLgzfXAPN63n5Sbg@mail.gmail.com>
In-Reply-To: <CAHk-=whQQdoQsgEx1vO7OkfPDcV5hurPnMRLgzfXAPN63n5Sbg@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.a0412a8a7c8f413ab314b472d4c48433
X-Mandrill-User: md_31050260
Date:   Sun, 14 Apr 2019 07:11:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 02:09:08PM -1000, Linus Torvalds wrote:
> On Sun, Apr 7, 2019 at 10:04 AM Kirill Smelkov <kirr@nexedi.com> wrote:
> >
> > Fixing regression on FUSE side is my reason to do this whole work -
> > that's why I care about it the most and ask.
> 
> Yeah, we can do the actual FUSE fix, I think. Preferably through the
> FUSE tree. Miklos?

Linus, thanks for feedback.

I'm not sure what is going on, but I'm afraid we can wait very long
here. It's been already 1 week, and I was also struggling to get
feedback from Miklos on my FUSE patches starting from end of February
without any luck:

https://lore.kernel.org/linux-fsdevel/cover.1553680185.git.kirr@nexedi.com/
	https://lore.kernel.org/linux-fsdevel/12f7d0d98555ee0d174d04bb47644f65c07f035a.1553680185.git.kirr@nexedi.com/
	https://lore.kernel.org/linux-fsdevel/d74b17b9d33c3dcc7a1f2fa2914fb3c4e7cda127.1553680185.git.kirr@nexedi.com/

https://lore.kernel.org/linux-fsdevel/cover.1553677194.git.kirr@nexedi.com/
	https://lore.kernel.org/linux-fsdevel/d916d401a80e9834c95970d86ca71c0154e988a6.1553677194.git.kirr@nexedi.com/
	https://lore.kernel.org/linux-fsdevel/e0b43507976d6ea9010f1bacaef067f18de49f1f.1553677194.git.kirr@nexedi.com/

https://lore.kernel.org/linux-fsdevel/dc47c061f20c464ccf46b43822b062dca6486e90.1553637462.git.kirr@nexedi.com/

I'm not sure what to do with my FUSE patches. It feels like knocking
into closed door...

Kirill
