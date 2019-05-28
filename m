Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5117C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998DC20717
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="TXfkP60A";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="pNBW4xRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfE1TCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:02:23 -0400
Received: from mail179-11.suw41.mandrillapp.com ([198.2.179.11]:55267 "EHLO
        mail179-11.suw41.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726961AbfE1TCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:02:22 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 May 2019 15:02:21 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=LojlEPe8YR70GfOe6f/ftvxLfgd8jqj7S65SitE1l4c=;
 b=TXfkP60AvsSN5mk0Qy5l2u4NO/ZXLPtD30y1zgr7WkPaQxeSuHHAG7VcQ3gSRahkKWlOsGMTT35e
   oWrfm2SPLRiewZt5UvkFItp/dq3tBjCyix00M274BOIhVvXPD5JU4Dq07el4g9XzqYjQY2H2+FTd
   a1WyU2yLamHxAnqXxbQ=
Received: from pmta04.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail179-11.suw41.mandrillapp.com id htm2rq22s28f for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 18:47:18 +0000 (envelope-from <bounce-md_31050260.5ced8236.v1-bfcc271fb3a2477ea827fd474912cc3d@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1559069238; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=LojlEPe8YR70GfOe6f/ftvxLfgd8jqj7S65SitE1l4c=; 
 b=pNBW4xRBG/Rfu8SQI2XJbOdJzB+cW0yJlmwOa2KlfwoE+MbJmZertWr5t1k+IwOokTQ4ow
 UalryLJF+1F9ILzXOOx9jwtRPiVcmgvIRjDxU72/LQpA9ey96NZ3rYtrbH6mq3lXU3BP/DA+
 WLXqzlDNHhby+rbtrO+Emc8MZs3u0=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH 4.19 082/114] fuse: Add FOPEN_STREAM to use stream_open()
Received: from [87.98.221.171] by mandrillapp.com id bfcc271fb3a2477ea827fd474912cc3d; Tue, 28 May 2019 18:47:18 +0000
To:     Pavel Machek <pavel@ucw.cz>
Cc:     <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Message-Id: <20190528184712.GA3483@deco.navytux.spb.ru>
References: <20190523181731.372074275@linuxfoundation.org> <20190523181739.135794147@linuxfoundation.org> <20190528111657.GA23674@amd>
In-Reply-To: <20190528111657.GA23674@amd>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.bfcc271fb3a2477ea827fd474912cc3d
X-Mandrill-User: md_31050260
Date:   Tue, 28 May 2019 18:47:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 01:16:58PM +0200, Pavel Machek wrote:
> Hi!
> 
> > +++ b/include/uapi/linux/fuse.h
> > @@ -219,10 +219,12 @@ struct fuse_file_lock {
> >   * FOPEN_DIRECT_IO: bypass page cache for this open file
> >   * FOPEN_KEEP_CACHE: don't invalidate the data cache on open
> >   * FOPEN_NONSEEKABLE: the file is not seekable
> > + * FOPEN_STREAM: the file is stream-like (no file position at all)
> >   */
> >  #define FOPEN_DIRECT_IO		(1 << 0)
> >  #define FOPEN_KEEP_CACHE	(1 << 1)
> >  #define FOPEN_NONSEEKABLE	(1 << 2)
> > +#define FOPEN_STREAM		(1 << 4)
> 
> Interesting choice of constants. It is too late to change it now, but
> was (1 << 3) meant here?

It is just because this is 4.19 backport of original patch. There (on
5.2) it was like this:

--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -232,11 +232,13 @@ struct fuse_file_lock {
  * FOPEN_KEEP_CACHE: don't invalidate the data cache on open
  * FOPEN_NONSEEKABLE: the file is not seekable
  * FOPEN_CACHE_DIR: allow caching this directory
+ * FOPEN_STREAM: the file is stream-like (no file position at all)
  */
 #define FOPEN_DIRECT_IO        (1 << 0)
 #define FOPEN_KEEP_CACHE       (1 << 1)
 #define FOPEN_NONSEEKABLE      (1 << 2)
 #define FOPEN_CACHE_DIR        (1 << 3)
+#define FOPEN_STREAM           (1 << 4)
 

i.e. (1 << 3) was already occupied by FOPEN_CACHE_DIR which was added by commit
6433b8998a21 (fuse: add FOPEN_CACHE_DIR)

Kirill
