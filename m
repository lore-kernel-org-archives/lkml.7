Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A59BC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6417820B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfF0Pnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:43:47 -0400
Received: from smtprelay0036.hostedemail.com ([216.40.44.36]:54977 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726370AbfF0Pnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:43:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4EEEB182CF670;
        Thu, 27 Jun 2019 15:43:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: whip50_2088efb52ed39
X-Filterd-Recvd-Size: 1590
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Jun 2019 15:43:43 +0000 (UTC)
Message-ID: <d28bb3dce55ade3024109d8e808b58cdd4441181.camel@perches.com>
Subject: Re: [PATCH] scripts: helper for mailing patches from git to the
 maintainers
From:   Joe Perches <joe@perches.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Date:   Thu, 27 Jun 2019 08:43:42 -0700
In-Reply-To: <1561647544-12685-1-git-send-email-info@metux.net>
References: <1561647544-12685-1-git-send-email-info@metux.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-27 at 16:59 +0200, Enrico Weigelt, metux IT consult
wrote:
> This is a little helper script for mailing patches out of a git
> branch to the corresponding maintainers.
> 
> Essentially, it scans the touched files, asks get_maintainer.pl
> for their maintainers and calls git-send-email for mailing out
> the patches.
[]
> +get_maintainers() {
> +    $KERNELSRC/scripts/get_maintainer.pl --m --l --remove-duplicates `get_files` |

--noroles --norolestats

It's also useful to separate the --to and --cc lines
where the --to goes only to direct maintainers and
--cc goes to others.

> +        grep -v "$LKML" | \
> +        grep -E "(maintainer|reviewer|open list)" | \
> +        grep -o '[[:alnum:]+\.\_\-]*@[[:alnum:]+\.\_\-]*'


