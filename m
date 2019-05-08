Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F920C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A517216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfEHOvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 10:51:48 -0400
Received: from smtprelay0140.hostedemail.com ([216.40.44.140]:53653 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727049AbfEHOvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:51:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 7138C180A813C;
        Wed,  8 May 2019 14:51:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ray83_ee8e93ad3e2b
X-Filterd-Recvd-Size: 2043
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 May 2019 14:51:42 +0000 (UTC)
Message-ID: <4517dfca6c4692b28c4914410f475d3f521cd230.camel@perches.com>
Subject: Re: [PATCH 1/4] checkpatch: fix multiple const * types
From:   Joe Perches <joe@perches.com>
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 08 May 2019 07:51:40 -0700
In-Reply-To: <20190508122721.7513-1-borneo.antonio@gmail.com>
References: <20190508122721.7513-1-borneo.antonio@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-08 at 14:27 +0200, Antonio Borneo wrote:
> Commit 1574a29f8e76 ("checkpatch: allow multiple const * types")
> claims to support repetition of pattern "const *", but it actually
> allows only one extra instance.
> Check the following lines
> 	int a(char const * const x[]);
> 	int b(char const * const *x);
> 	int c(char const * const * const x[]);
> 	int d(char const * const * const *x);
> with command
> 	./scripts/checkpatch.pl --show-types -f filename
> to find that only the first line passes the test, while a warning
> is triggered by the other 3 lines:
> 	WARNING:FUNCTION_ARGUMENTS: function definition argument
> 	'char const * const' should also have an identifier name
> The reason is that the pattern match halts at the second asterisk
> in the line, thus the remaining text starting with asterisk fails
> to match a valid name for a variable.
> 
> Fixed by replacing "?" (Match 1 or 0 times) with "*" (Match 0 or
> more times) in the regular expression.
> Fix also the similar test for types in unusual order.

It might be better to use a max match like {0,4} instead of *

perl is pretty memory intensive at multiple unrestricted matches
of somewhat complex patterns.


