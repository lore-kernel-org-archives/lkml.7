Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B22CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D95205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDCRQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfDCRQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:16:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38C07205C9;
        Wed,  3 Apr 2019 17:16:56 +0000 (UTC)
Date:   Wed, 3 Apr 2019 13:16:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <tzanussi@gmail.com>
Cc:     Mario.Limonciello@dell.com, pali.rohar@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: dell_smbios KASAN bug
Message-ID: <20190403131654.7379a991@gandalf.local.home>
In-Reply-To: <1553530847.6114.0.camel@gmail.com>
References: <1553106560.2080.5.camel@gmail.com>
        <20190320144146.08ecd5e4@gandalf.local.home>
        <1553108749.2079.1.camel@gmail.com>
        <20190320151353.1a223c0e@gandalf.local.home>
        <9541737623f942e49e9310aef963ffbf@ausx13mpc120.AMER.DELL.COM>
        <20190325101731.3558ecda@gandalf.local.home>
        <1553530847.6114.0.camel@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 11:20:47 -0500
Tom Zanussi <tzanussi@gmail.com> wrote:

> > Is it OK if I add the following tags to that patch?
> > 
> > Reported-by: Tom Zanussi <tzanussi@gmail.com>
> > Tested-by: Tom Zanussi <tzanussi@gmail.com>
> >   
> 
> Yep, fine with me.

I modified the patch slightly. Can you test this too. There should be
no reason that it wont work as this is "safer" but I don't want to put
your tested-by if you haven't tested it ;-)

-- Steve

diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-smbios-base.c
index 0537d44d45a6..a74c0df25b15 100644
--- a/drivers/platform/x86/dell-smbios-base.c
+++ b/drivers/platform/x86/dell-smbios-base.c
@@ -625,6 +625,8 @@ static int __init dell_smbios_init(void)
 
 fail_platform_driver:
 	kfree(da_tokens);
+	da_tokens = NULL;
+	da_num_tokens = 0;
 	return ret;
 }
 
