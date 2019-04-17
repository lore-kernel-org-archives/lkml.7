Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA69C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9E8206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbfDQU3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:29:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbfDQU3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:29:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEA33206BA;
        Wed, 17 Apr 2019 20:29:43 +0000 (UTC)
Date:   Wed, 17 Apr 2019 16:29:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ktest: Add workaround to avoid unexpected power cycle
Message-ID: <20190417162942.375b3e3f@gandalf.local.home>
In-Reply-To: <20190417201442.15030-1-msys.mizuma@gmail.com>
References: <20190417201442.15030-1-msys.mizuma@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 16:14:42 -0400
Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:

> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> Unexpected power cycle occurs while the installation of the
> kernel.
> 
> That is because the default reboot command, "ssh $SSH_USER@$MACHINE
> reboot" exits as 255 even if the reboot is successfully done,
> like as:
> 
>   ]# ssh root@Test reboot
>   Connection to Test closed by remote host.
>   ]# echo $?
>   255
>   ]#
> 
> To avoid the unexpected power cycle, the reboot is considered as
> successfully done if the reboot is the default command and the
> return code is 255.
> 

Ah that explains why I've been seeing this :-)

Can we add a config modifying variable called:

REBOOT_RETURN_CODE

that is by default 255 and can be changed by the config file?

You just need to add in %default:

	"REBOOT_RETURN_CODE"	=> 255,

my $reboot_return_code;


and in %option_map:

	"REBOOT_RETURN_CODE"	=> \$reboot_return_code,


> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  tools/testing/ktest/ktest.pl | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> index ea07d43856b8..765c6bc83ab4 100755
> --- a/tools/testing/ktest/ktest.pl
> +++ b/tools/testing/ktest/ktest.pl
> @@ -1737,6 +1737,11 @@ sub run_command {
>      my $dord = 0;
>      my $dostdout = 0;
>      my $pid;
> +    my $is_default_reboot = 0;
> +
> +    if ($command eq $default{REBOOT}) {
> +	$is_default_reboot = 1;
> +    }

Do we really need to add this variable?

>  
>      $command =~ s/\$SSH_USER/$ssh_user/g;
>      $command =~ s/\$MACHINE/$machine/g;
> @@ -1791,6 +1796,10 @@ sub run_command {
>      # shift 8 for real exit status
>      $run_command_status = $? >> 8;
>  
> +    if ($run_command_status == 255 && $is_default_reboot) {

Instead can we have:

	if ($command eq $default{REBOOT} &&
	    $run_command_status == $reboot_return_code) {

?

Thanks for these patches!

-- Steve

> +	$run_command_status = 0;
> +    }
> +
>      close(CMD);
>      close(LOG) if ($dolog);
>      close(RD)  if ($dord);

