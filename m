Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9B3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B22B20850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfCTTN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfCTTN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:13:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 760A420850;
        Wed, 20 Mar 2019 19:13:55 +0000 (UTC)
Date:   Wed, 20 Mar 2019 15:13:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <tzanussi@gmail.com>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        linux-kernel@vger.kernel.org
Subject: Re: dell_smbios KASAN bug
Message-ID: <20190320151353.1a223c0e@gandalf.local.home>
In-Reply-To: <1553108749.2079.1.camel@gmail.com>
References: <1553106560.2080.5.camel@gmail.com>
        <20190320144146.08ecd5e4@gandalf.local.home>
        <1553108749.2079.1.camel@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 14:05:49 -0500
Tom Zanussi <tzanussi@gmail.com> wrote:

> On Wed, 2019-03-20 at 14:41 -0400, Steven Rostedt wrote:
> > On Wed, 20 Mar 2019 13:29:20 -0500
> > Tom Zanussi <tzanussi@gmail.com> wrote:
> >   
> > > Hi,
> > > 
> > > While looking into an unrelated problem, I hit this KASAN use-
> > > after-
> > > free warning, so thought I'd let you know.
> > > 
> > > I have no idea how to fix it, but let me know if you need more
> > > info.
> > >   
> > 
> > Could you run with debug in the kernel command line, and see if you
> > hit
> > any failed messages from the dell_smbios_init() call?
> >   
> 
> Not much, but this looks relevant:
> 
> [   26.783749] dell_smbios: No SMBIOS backends available (wmi: -19,
> smm: -19)
> [   26.963648] dell_smbios: No dell-smbios drivers are loaded
>

And does this fix you problem?

-- Steve

diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-smbios-base.c
index 9dc282ed5a9e..c3825c674522 100644
--- a/drivers/platform/x86/dell-smbios-base.c
+++ b/drivers/platform/x86/dell-smbios-base.c
@@ -619,6 +619,7 @@ static int __init dell_smbios_init(void)
 
 fail_platform_driver:
 	kfree(da_tokens);
+	da_num_tokens = 0;
 	return ret;
 }
 
