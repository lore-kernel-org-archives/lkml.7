Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1851DC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3569217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE3ikIZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbfDQU7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:59:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33085 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbfDQU7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:59:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id k189so15265467qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PXX9EJnqgjZelrF6WzfDRrTcGtkmS+pCqFJGh8G4i+A=;
        b=FE3ikIZT4FPVH8qTjAabGYJ0Bx6VIabT+wa/oR72nuqGFrGpAoZwy+nTEmsqU+zNd0
         OuYtyNR/DsyqQTyQZSY525nL9ZcJxRw6RaK+Es3fEqvWwKau8T4fGZyFj+y9KhtdW/KQ
         tI16+Mn/4680lXF1z/3hjdXYjyEj/n0Z7ii7P0PLQVYIPXrkGuj4yVVslXDiDH8N0reS
         asQ2pIleaWadpQNnhjTuPxtbcEGnPsCFCcBiJu+CkP7J7tozSDVFM2bcOqIB9CbkWOdj
         o2hE8GW7GOaonnT0/ordCjMYSns7UiSymbt3y8SqfPzRP85QiEB8Rv8VS8HyGp0GKNtl
         My+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PXX9EJnqgjZelrF6WzfDRrTcGtkmS+pCqFJGh8G4i+A=;
        b=j/8BUF40lxT3syplHq89x4JeJATxtQbntFq7Q4g2JHaCJ3fbyFk5tvt1aRMer9F1MP
         x2K3b2cc2SNBFC7ALJdAI+nKbacTduJHA8UErDcAQ4CpWISD00x42a2tXxAGs9bgxY2M
         fcQvjlWmztYhmxvIIYsBduxN1TNB4KspM6FMfhaxJ6LE+hBONDnEn3e+3Gd0G8DVeAgy
         KYv4xmEcXjbEDOwfoM+ChGS76Wb6woseg084vnvpkUHy7/QRqUZ4Su86AMg9sSyjaEGE
         s47R76bderSWq40QxlbplM7uXVU8CfsxOORFIPJtZpnfMKvUpBE0L540UKl7TuRlSUDD
         HYYg==
X-Gm-Message-State: APjAAAVUe6KiDxvX1pUM/ukLdJkinZgel3OCLGmMvfcIBkMihySSbRwk
        8mlyXK8l/TLqMrRGgk35LA==
X-Google-Smtp-Source: APXvYqwT1oLJJqWUL73wcsX1jjiaYkJm6n/dY93TkmTGS2hPLCY8Typ4PfEmrf+w1VcSzuO3pTneZw==
X-Received: by 2002:a37:69c3:: with SMTP id e186mr50084277qkc.308.1555534756369;
        Wed, 17 Apr 2019 13:59:16 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n10sm63679qte.11.2019.04.17.13.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 13:59:15 -0700 (PDT)
Date:   Wed, 17 Apr 2019 16:59:13 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ktest: Add workaround to avoid unexpected power cycle
Message-ID: <20190417205912.pqwzbrrm6435mqqu@gabell>
References: <20190417201442.15030-1-msys.mizuma@gmail.com>
 <20190417162942.375b3e3f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417162942.375b3e3f@gandalf.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:29:42PM -0400, Steven Rostedt wrote:
> On Wed, 17 Apr 2019 16:14:42 -0400
> Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> 
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > Unexpected power cycle occurs while the installation of the
> > kernel.
> > 
> > That is because the default reboot command, "ssh $SSH_USER@$MACHINE
> > reboot" exits as 255 even if the reboot is successfully done,
> > like as:
> > 
> >   ]# ssh root@Test reboot
> >   Connection to Test closed by remote host.
> >   ]# echo $?
> >   255
> >   ]#
> > 
> > To avoid the unexpected power cycle, the reboot is considered as
> > successfully done if the reboot is the default command and the
> > return code is 255.
> > 
> 
> Ah that explains why I've been seeing this :-)
> 
> Can we add a config modifying variable called:
> 
> REBOOT_RETURN_CODE
> 
> that is by default 255 and can be changed by the config file?
> 
> You just need to add in %default:
> 
> 	"REBOOT_RETURN_CODE"	=> 255,
> 
> my $reboot_return_code;
> 
> 
> and in %option_map:
> 
> 	"REBOOT_RETURN_CODE"	=> \$reboot_return_code,

Great idea, thanks! I'll add thease.

> 
> 
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > ---
> >  tools/testing/ktest/ktest.pl | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> > index ea07d43856b8..765c6bc83ab4 100755
> > --- a/tools/testing/ktest/ktest.pl
> > +++ b/tools/testing/ktest/ktest.pl
> > @@ -1737,6 +1737,11 @@ sub run_command {
> >      my $dord = 0;
> >      my $dostdout = 0;
> >      my $pid;
> > +    my $is_default_reboot = 0;
> > +
> > +    if ($command eq $default{REBOOT}) {
> > +	$is_default_reboot = 1;
> > +    }
> 
> Do we really need to add this variable?
> 

> >  
> >      $command =~ s/\$SSH_USER/$ssh_user/g;
> >      $command =~ s/\$MACHINE/$machine/g;

$command is modified here, so...

> > @@ -1791,6 +1796,10 @@ sub run_command {
> >      # shift 8 for real exit status
> >      $run_command_status = $? >> 8;
> >  
> > +    if ($run_command_status == 255 && $is_default_reboot) {
> 
> Instead can we have:
> 
> 	if ($command eq $default{REBOOT} &&
> 	    $run_command_status == $reboot_return_code) {
> 
> ?

How about the following?

@@ -1737,6 +1740,7 @@ sub run_command {
     my $dord = 0;
     my $dostdout = 0;
     my $pid;
+    my $command_orig = $command;

     $command =~ s/\$SSH_USER/$ssh_user/g;
     $command =~ s/\$MACHINE/$machine/g;
@@ -1791,6 +1795,11 @@ sub run_command {
     # shift 8 for real exit status
     $run_command_status = $? >> 8;

+    if ($command_orig eq $default{REBOOT} &&
+       $run_command_status == $reboot_return_code) {
+       $run_command_status = 0;
+    }
+
     close(CMD);
     close(LOG) if ($dolog);
     close(RD)  if ($dord);

Thanks!
Masa
