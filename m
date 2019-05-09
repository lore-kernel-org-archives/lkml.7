Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68379C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36768217D6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnYxh+ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfEISmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:42:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33906 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfEISmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:42:06 -0400
Received: by mail-qk1-f195.google.com with SMTP id n68so2130534qka.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 11:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mptSEhGHOQIt+up5U30KoZZlHsfX6RVuFMamD67Y8W4=;
        b=gnYxh+ldLfrRUjqO2nIHOA75ebVHTGKpNFzsD2lTr9WZeB0wfxgipMgWNCZ5Yh575I
         dReUlS5Hcvp4xzRd4Q+AYnpY7PFsjiZIMJeVkg+OCtnXru8iTIO6P5/bwaUbCEe9881t
         byl22PacZPGLwSIE85PozxZuvEsM0e6gQ6vHWC5HGdy0ewW0ll7lgu7xrgSQxP722xg8
         ACOfUtsIu4XvQgb8Z5A1BhCcMxqL9DVHCofF+t7uCfikW/Cde6PvubeA62o39VXV8mgU
         gIwexii9dIUBn3fH5TyIIJSFzxNfVjJdqq5nKYCIOsemjwpM7nPI2uMNnRAqwwrl+pfj
         tTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mptSEhGHOQIt+up5U30KoZZlHsfX6RVuFMamD67Y8W4=;
        b=GdgHwQQJ6Poabkc7uQZo6kQdxqlIAmafQviuCqqaWxFVueTf5c8mcqHOrbxPm31nqe
         kRdfAG2gyMf18mz2LYERGCArgT92IE0HMbAP9L4VSYY+t0FehhFKpHRXTqnKig4UqeIW
         6CQYGnq8BP+iev5+6i7MLOHXkQvCpYDsCRKJFb+GLx5tn7rf6kfHKInheXJLk8070/dA
         XMTm8ka4CInztG3iENyIzxpGrG+RB/dbqFLOpq4sB0tdTuJtS2Vmm5Rsm9PzuJpR+cHG
         BZfP5/S2oRjS5vQVFSKpdtsB4B8SiOQNSR27RHgOuVbLCI1qeBrgphdPiaLUKRixFV42
         eEwg==
X-Gm-Message-State: APjAAAWmOqgLIsINgi5x801OVmy0Hucj04m2xYTqXSyQH4CwlqFtV2jH
        gWOo9/a2P0FdOyXmixqTkw==
X-Google-Smtp-Source: APXvYqwUZj4YdbFp8MuhriehkT+nDLJLYNobH7L/rE/uu+D1DbbtGPihLPK65sq4Zk2379VHwKSAAg==
X-Received: by 2002:a37:7d82:: with SMTP id y124mr4916226qkc.167.1557427325876;
        Thu, 09 May 2019 11:42:05 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t10sm1679402qti.83.2019.05.09.11.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 11:42:05 -0700 (PDT)
Date:   Thu, 9 May 2019 14:41:59 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] ktest: cleanup get_grub_index
Message-ID: <20190509184158.te2cglg2nuvgm6gm@gabell>
References: <20190509174630.26713-1-msys.mizuma@gmail.com>
 <20190509174630.26713-3-msys.mizuma@gmail.com>
 <20190509135721.4802161b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509135721.4802161b@gandalf.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 01:57:21PM -0400, Steven Rostedt wrote:
> On Thu,  9 May 2019 13:46:27 -0400
> Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> 
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > Cleanup get_grub_index().
> 
> Hi Masayoshi,
> 
> Thanks for the patches, quick comment below.
> 
> > 
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > ---
> >  tools/testing/ktest/ktest.pl | 50 +++++++++++-------------------------
> >  1 file changed, 15 insertions(+), 35 deletions(-)
> > 
> > diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> > index 3862b23672f7..1255ea0d9df4 100755
> > --- a/tools/testing/ktest/ktest.pl
> > +++ b/tools/testing/ktest/ktest.pl
> > @@ -1934,46 +1934,26 @@ sub get_grub2_index {
> >  
> >  sub get_grub_index {
> >  
> > -    if ($reboot_type eq "grub2") {
> > -	get_grub2_index;
> > -	return;
> > -    }
> > -
> > -    if ($reboot_type ne "grub") {
> > -	return;
> > -    }
> 
> We still need something like:
> 
> 	if ($reboot_type !~ /^grub/) {
> 		return;
> 	}
> 
> Because I believe this will run (and probably error) for syslinux boot
> systems. I have a couple, I could test it and find out ;-)

Thank you for your review! I'll add the check.

Thanks!
Masa

> 
> -- Steve
> 
> > -    return if (defined($grub_number) && defined($last_grub_menu) &&
> > -	       $last_grub_menu eq $grub_menu && defined($last_machine) &&
> > -	       $last_machine eq $machine);
> > -
> > -    doprint "Find grub menu ... ";
> > -    $grub_number = -1;
> > +    my $command;
> > +    my $target;
> > +    my $skip;
> > +    my $grub_menu_qt;
> >  
> > -    my $ssh_grub = $ssh_exec;
> > -    $ssh_grub =~ s,\$SSH_COMMAND,cat /boot/grub/menu.lst,g;
> > +    return if ($reboot_type ne "grub") and ($reboot_type ne "grub2");
> >  
> > -    open(IN, "$ssh_grub |")
> > -	or dodie "unable to get menu.lst";
> > -
> > -    my $found = 0;
> > -    my $grub_menu_qt = quotemeta($grub_menu);
> > +    $grub_menu_qt = quotemeta($grub_menu);
> >  
> > -    while (<IN>) {
> > -	if (/^\s*title\s+$grub_menu_qt\s*$/) {
> > -	    $grub_number++;
> > -	    $found = 1;
> > -	    last;
> > -	} elsif (/^\s*title\s/) {
> > -	    $grub_number++;
> > -	}
> > +    if ($reboot_type eq "grub") {
> > +	$command = "cat /boot/grub/menu.lst";
> > +	$target = '^\s*title\s+' . $grub_menu_qt . '\s*$';
> > +	$skip = '^\s*title\s';
> > +    } elsif ($reboot_type eq "grub2") {
> > +	$command = "cat $grub_file";
> > +	$target = '^menuentry.*' . $grub_menu_qt;
> > +	$skip = '^menuentry\s|^submenu\s';
> >      }
> > -    close(IN);
> >  
> > -    dodie "Could not find '$grub_menu' in /boot/grub/menu on $machine"
> > -	if (!$found);
> > -    doprint "$grub_number\n";
> > -    $last_grub_menu = $grub_menu;
> > -    $last_machine = $machine;
> > +    _get_grub_index($command, $target, $skip);
> >  }
> >  
> >  sub wait_for_input
> 
