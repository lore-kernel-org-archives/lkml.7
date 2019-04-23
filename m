Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F60EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B06221738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfDWLGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:06:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33228 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWLGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:06:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hItFc-0005yi-Cj; Tue, 23 Apr 2019 11:06:12 +0000
Date:   Tue, 23 Apr 2019 12:06:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc:     Mukesh Ojha <mojha@codeaurora.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gaurav Kohli <gkohli@codeaurora.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Martin Kepplinger <martink@posteo.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH v2] Input: uinput: Avoid Object-Already-Free with a
 global lock
Message-ID: <20190423110611.GL2217@ZenIV.linux.org.uk>
References: <1554883176-24318-1-git-send-email-mojha@codeaurora.org>
 <7299a6db-38b7-75c7-633a-00d2257eba45@codeaurora.org>
 <20190418014321.dptin7tpxpldhsns@penguin>
 <bb92c3f2-faf1-04ec-4c67-3aba56c507a9@codeaurora.org>
 <a4d1a2f3-1db7-e300-9569-7b7a2fadd64e@codeaurora.org>
 <20190419071152.x5ghvbybjhv76uxt@penguin>
 <f3cd46fb-2bb1-0422-b2be-3f7625ec9c4e@codeaurora.org>
 <20190423032839.xvbldglrmjxkdntj@penguin>
 <17f4a0be-ab04-8537-9197-32fbca807f3f@codeaurora.org>
 <20190423084944.gj2boxfcg7lp4zad@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423084944.gj2boxfcg7lp4zad@penguin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 08:49:44AM +0000, dmitry.torokhov@gmail.com wrote:
> On Tue, Apr 23, 2019 at 12:51:13PM +0530, Mukesh Ojha wrote:

> > I have taken care this case from ioctl and release point of view.
> > 
> > Even if the release gets called first it will make the
> > file->private_data=NULL.
> > and further call to ioctl will not be a problem as the check is already
> > there.
> 
> Al, do we have any protections in VFS layer from userspace hanging onto
> a file descriptor and calling ioctl() on it even as another thread
> calls close() on the same fd?
> 
> Should the issue be solved by individual drivers, or more careful
> accounting for currently running operations is needed at VFS layer?

Neither.  An overlap of ->release() and ->ioctl() is possible only
if you've got memory corruption somewhere.

close() overlapping ioctl() is certainly possible, and won't trigger
that at all - sys_ioctl() holds onto reference to struct file, so
its refcount won't reach zero until we are done with it.
