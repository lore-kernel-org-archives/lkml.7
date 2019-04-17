Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B0BC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5281217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zahEpWuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733126AbfDQUwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:52:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33394 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729939AbfDQUwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8sw3pOWFIJ818F8LV05sd4h5C904YE036pXDbfHpd9k=; b=zahEpWuNgo88BtZ19/gkemgQhH
        lPk0DnYs75w2CJ1hounAlfx3e8jG6cvCXX6cQQKOcKZwdW30yBK0nA3kFJ1RcsV/wEgiQFR7DnaWW
        gR3AYGvnaUMYdeCOBcbzn3vdktSuF/loG4SB7/IUUe8U0+HJclkeuz/4MF3C2QU+W3T8Gy3NgeX3w
        dsHcWTWKuFD1nebRY+AGczX5RU87ETGyYie15gWRGx2zY0sIl43nX1pxUjEih1M7iEQYVCXAuPIRF
        O3tp4x5FO8HbOOVAQtnetAHZIyqwxwu35ZJEv1Icur1OPI6CLGf8ooBMleXqEniVfmGy83HKM04sh
        Nf1YisJQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGrXR-0001GC-OD; Wed, 17 Apr 2019 20:52:14 +0000
Subject: Re: [PATCH] ktest: Add support for meta characters in GRUB_MENU
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
References: <20190417201114.14839-1-msys.mizuma@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3af6075b-60e2-5ed2-5cd2-7d6850dbafbc@infradead.org>
Date:   Wed, 17 Apr 2019 13:52:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417201114.14839-1-msys.mizuma@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/19 1:11 PM, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> ktest fails if meta characters are in GRUB_MENU, for example
> GRUB_MENU = 'Fedora (test)'
> 
> The failure happens because the meta characters are not escaped,
> so the menu doesn't match in any entries in GRUB_FILE.
> 
> Use quotameta() to escape the meta characters.

  Use quotemeta()

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
> 


-- 
~Randy
