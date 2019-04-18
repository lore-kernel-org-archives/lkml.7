Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4EBC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 02:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7498C217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 02:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387886AbfDRCWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 22:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbfDRCWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 22:22:08 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD063217FA;
        Thu, 18 Apr 2019 02:22:07 +0000 (UTC)
Date:   Wed, 17 Apr 2019 22:22:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ktest: Add workaround to avoid unexpected power cycle
Message-ID: <20190417222205.71650f42@oasis.local.home>
In-Reply-To: <20190417205912.pqwzbrrm6435mqqu@gabell>
References: <20190417201442.15030-1-msys.mizuma@gmail.com>
        <20190417162942.375b3e3f@gandalf.local.home>
        <20190417205912.pqwzbrrm6435mqqu@gabell>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 16:59:13 -0400
Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:

> > > diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> > > index ea07d43856b8..765c6bc83ab4 100755
> > > --- a/tools/testing/ktest/ktest.pl
> > > +++ b/tools/testing/ktest/ktest.pl
> > > @@ -1737,6 +1737,11 @@ sub run_command {
> > >      my $dord = 0;
> > >      my $dostdout = 0;
> > >      my $pid;
> > > +    my $is_default_reboot = 0;
> > > +
> > > +    if ($command eq $default{REBOOT}) {
> > > +	$is_default_reboot = 1;
> > > +    }  
> > 
> > Do we really need to add this variable?
> >   
> 
> > >  
> > >      $command =~ s/\$SSH_USER/$ssh_user/g;
> > >      $command =~ s/\$MACHINE/$machine/g;  
> 
> $command is modified here, so...

Ah thanks. This is what I get for reviewing patches without looking at
the code it touches ;-)

> 
> > > @@ -1791,6 +1796,10 @@ sub run_command {
> > >      # shift 8 for real exit status
> > >      $run_command_status = $? >> 8;
> > >  
> > > +    if ($run_command_status == 255 && $is_default_reboot) {  
> > 
> > Instead can we have:
> > 
> > 	if ($command eq $default{REBOOT} &&
> > 	    $run_command_status == $reboot_return_code) {
> > 
> > ?  
> 
> How about the following?
> 
> @@ -1737,6 +1740,7 @@ sub run_command {
>      my $dord = 0;
>      my $dostdout = 0;
>      my $pid;
> +    my $command_orig = $command;
> 
>      $command =~ s/\$SSH_USER/$ssh_user/g;
>      $command =~ s/\$MACHINE/$machine/g;
> @@ -1791,6 +1795,11 @@ sub run_command {
>      # shift 8 for real exit status
>      $run_command_status = $? >> 8;
> 
> +    if ($command_orig eq $default{REBOOT} &&
> +       $run_command_status == $reboot_return_code) {
> +       $run_command_status = 0;
> +    }
> +

Looks fine to me.

Thanks!

-- Steve

>      close(CMD);
>      close(LOG) if ($dolog);
>      close(RD)  if ($dord);
> 
> Thanks!
> Masa

