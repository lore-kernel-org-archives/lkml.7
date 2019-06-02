Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E67C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 18:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DF427904
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 18:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfFBSEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 14:04:33 -0400
Received: from smtprelay0190.hostedemail.com ([216.40.44.190]:38314 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbfFBSEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 14:04:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 5FD4E83777EE;
        Sun,  2 Jun 2019 18:04:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spot30_618cb00fb963a
X-Filterd-Recvd-Size: 2528
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun,  2 Jun 2019 18:04:30 +0000 (UTC)
Message-ID: <f53401a0aba4c20b542ae89860bef371077d693f.camel@perches.com>
Subject: Re: checkpatch query regarding .c and .h files..
From:   Joe Perches <joe@perches.com>
To:     Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Rob Herring <robh@kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Date:   Sun, 02 Jun 2019 11:04:28 -0700
In-Reply-To: <25942.1559494964@turing-police>
References: <25942.1559494964@turing-police>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-02 at 13:02 -0400, Valdis Klētnieks wrote:
> scripts/checkpatch.pl contains this code near line 3070:
> 
>                                if ($realfile =~ /\.(h|s|S)$/) {
>                                         $comment = '/*';
>                                 } elsif ($realfile =~ /\.(c|dts|dtsi)$/) {
>                                         $comment = '//';
>                                 } elsif (($checklicenseline == 2) || $realfile =~ /\.(sh|pl|py|awk|tc)$/) {
>                                         $comment = '#';
>                                 } elsif ($realfile =~ /\.rst$/) {
>                                         $comment = '..';
>                                 }
> 
> Was there a specific reason why .h files have /* */ and .c files have C89 // on
> the SPDX comment line?
> 
> Would anybody like a patch that fixed checkpatch to allow either flavor on .c and .h files?
> (I know I would, I just blew close to an hour trying to figure out why it whined about a
> SPDX in a .h file I'm getting ready to upstream...)

It's described in Documentation/process/license-rules.rst

----------------------------------

2. Style:

   The SPDX license identifier is added in form of a comment.  The comment
   style depends on the file type::

      C source:	// SPDX-License-Identifier: <SPDX License Expression>
      C header:	/* SPDX-License-Identifier: <SPDX License Expression> */

----------------------------------

It was because old versions of build tools could not handle
// in asm files.

It could be changed today because build tool version minimums
have been increased.



