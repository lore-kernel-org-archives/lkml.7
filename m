Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234E9C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D664F217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbfDQURl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbfDQURl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:17:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAAF720651;
        Wed, 17 Apr 2019 20:17:40 +0000 (UTC)
Date:   Wed, 17 Apr 2019 16:17:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ktest: Add support for meta characters in GRUB_MENU
Message-ID: <20190417161739.7046d028@gandalf.local.home>
In-Reply-To: <20190417201114.14839-1-msys.mizuma@gmail.com>
References: <20190417201114.14839-1-msys.mizuma@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 16:11:14 -0400
Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:

> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> ktest fails if meta characters are in GRUB_MENU, for example
> GRUB_MENU = 'Fedora (test)'
> 

Thanks for the patch! One little nit below though.

> The failure happens because the meta characters are not escaped,
> so the menu doesn't match in any entries in GRUB_FILE.
> 
> Use quotameta() to escape the meta characters.
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  tools/testing/ktest/ktest.pl | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> index 87af8a68ab25..ea07d43856b8 100755
> --- a/tools/testing/ktest/ktest.pl
> +++ b/tools/testing/ktest/ktest.pl
> @@ -1866,9 +1866,10 @@ sub get_grub2_index {
>  	or dodie "unable to get $grub_file";
>  
>      my $found = 0;
> +    my $_grub_menu = quotemeta($grub_menu);

I'd like to avoid names that start with underscore. Could you call this:

  $grub_menu_qt

or something similar, to be a bit more descriptive of what the variable
is.

Thanks!

-- Steve



>  
>      while (<IN>) {
> -	if (/^menuentry.*$grub_menu/) {
> +	if (/^menuentry.*$_grub_menu/) {
>  	    $grub_number++;
>  	    $found = 1;
>  	    last;
> @@ -1909,9 +1910,10 @@ sub get_grub_index {
>  	or dodie "unable to get menu.lst";
>  
>      my $found = 0;
> +    my $_grub_menu = quotemeta($grub_menu);
>  
>      while (<IN>) {
> -	if (/^\s*title\s+$grub_menu\s*$/) {
> +	if (/^\s*title\s+$_grub_menu\s*$/) {
>  	    $grub_number++;
>  	    $found = 1;
>  	    last;

