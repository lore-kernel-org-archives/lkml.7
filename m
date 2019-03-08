Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A190FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696322087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfCHON5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 09:13:57 -0500
Received: from smtprelay0091.hostedemail.com ([216.40.44.91]:41082 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726534AbfCHON4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 09:13:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1BD2818224BBA;
        Fri,  8 Mar 2019 14:13:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: box53_3f21f3cb28324
X-Filterd-Recvd-Size: 1935
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri,  8 Mar 2019 14:13:53 +0000 (UTC)
Message-ID: <10c498eede0b780af7bbea9ae4f9848e74d9da55.camel@perches.com>
Subject: Re: [PATCH v1 4/5] scripts: checkpatch.pl: don't complain that
 debian/rules is executable
From:   Joe Perches <joe@perches.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        apw@canonical.com, linux-kbuild@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Fri, 08 Mar 2019 06:13:52 -0800
In-Reply-To: <1552049064-32044-5-git-send-email-info@metux.net>
References: <1552049064-32044-1-git-send-email-info@metux.net>
         <1552049064-32044-5-git-send-email-info@metux.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-08 at 13:44 +0100, Enrico Weigelt, metux IT consult wrote:
> checkpatch.pl complains when adding executable "debian/rules",
> obviously a false alarm. Therefore add an exception for that.

This is predicated on a debian/ directory actually being added
to the generic kernel tree.

I'm not sure that's a good idea.

As debian/ does not currently exist in the generic kernel source,
I think this can be kept locally in their tree if they choose.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2576,6 +2576,7 @@ sub process {
>  		if ($line =~ /^new (file )?mode.*[7531]\d{0,2}$/) {
>  			my $permhere = $here . "FILE: $realfile\n";
>  			if ($realfile !~ m@scripts/@ &&
> +			    $realfile !~ "debian/rules" &&
>  			    $realfile !~ /\.(py|pl|awk|sh)$/) {
>  				ERROR("EXECUTE_PERMISSIONS",
>  				      "do not set execute permissions for source files\n" . $permhere);

