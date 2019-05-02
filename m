Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7FBC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CCA20873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556792549;
	bh=4mdXNVY+kl8cfyLSCQh4IJghFaPWYmafUtecWx4C16Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zCE8PB7uzd8FTWE0GrkEgZCkXvH55KAsguaYutOevlGDYlfFrNq21WYTTD7nx0b3K
	 WHMAVHnCPo9Uy3WZTdgsfWWOX5OnyXhLPn4S/vju5h8f501wbDvR8g5C5pr7JBsiK7
	 FG8KKv4enz86SFYi14ytKugL4Qmjth4x6gQyi3BY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfEBKW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfEBKW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:22:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE8D7206DF;
        Thu,  2 May 2019 10:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556792547;
        bh=4mdXNVY+kl8cfyLSCQh4IJghFaPWYmafUtecWx4C16Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TDJPehgFE1ceoeouin1SVGSnFGfo0tJRn79/zfaAOhvE57cR4UaaM/xgZEMde+9yg
         d1VcUWhBzCNcJpC1x9YFccXf/HgtNIJJQmEZiGp+5KsNrmvrm/IAUOogQ0/Y1s+67L
         aIKzR/deFfy+mGa2ItldUuepKDrhLvVq+c1upkU0=
Date:   Thu, 2 May 2019 12:22:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, cl@linux.com,
        tycho@tycho.ws, willy@infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kobject: clean up the kobject add documentation a bit more
Message-ID: <20190502102224.GA15012@kroah.com>
References: <20190427081330.GA26788@eros.localdomain>
 <20190427192809.GA8454@kroah.com>
 <20190501215616.GD18827@eros.localdomain>
 <20190502071742.GC16247@kroah.com>
 <20190502072808.GA14064@kroah.com>
 <20190502081918.GA18363@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502081918.GA18363@eros.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1fd7c3b438a2 ("kobject: Improve doc clarity kobject_init_and_add()")
tried to provide more clarity, but the reference to kobject_del() was
incorrect.  Fix that up by removing that line, and hopefully be more explicit
as to exactly what needs to happen here once you register a kobject with the
kobject core.

Cc: Tobin C. Harding <tobin@kernel.org>
Fixes: 1fd7c3b438a2 ("kobject: Improve doc clarity kobject_init_and_add()")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/lib/kobject.c b/lib/kobject.c
index 3f4b7e95b0c2..f2ccdbac8ed9 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -416,8 +416,12 @@ static __printf(3, 0) int kobject_add_varg(struct kobject *kobj,
  *         to this function be directly freed with a call to kfree(),
  *         that can leak memory.
  *
- *         If this call returns successfully and you later need to unwind
- *         kobject_add() for the error path you should call kobject_del().
+ *         If this function returns success, kobject_put() must also be called
+ *         in order to properly clean up the memory associated with the object.
+ *
+ *         In short, once this function is called, kobject_put() MUST be called
+ *         when the use of the object is finished in order to properly free
+ *         everything.
  */
 int kobject_add(struct kobject *kobj, struct kobject *parent,
 		const char *fmt, ...)
