Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EACEC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC432190D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389344AbfGWLy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:54:27 -0400
Received: from smtprelay0163.hostedemail.com ([216.40.44.163]:58337 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387844AbfGWLy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:54:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 49F54100E86C4;
        Tue, 23 Jul 2019 11:54:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: soda70_7dbfed95b2e44
X-Filterd-Recvd-Size: 2059
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jul 2019 11:54:24 +0000 (UTC)
Message-ID: <45d65cf7546fcb5f2195cc831fa60dea20098802.camel@perches.com>
Subject: Re: get_maintainers.pl subsystem output
From:   Joe Perches <joe@perches.com>
To:     "Duda, Sebastian" <sebastian.duda@fau.de>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        ralf.ramsauer@oth-regensburg.de, wolfgang.mauerer@oth-regensburg.de
Date:   Tue, 23 Jul 2019 04:54:22 -0700
In-Reply-To: <2835dfa18922905ffabafb11fca7e1d2@fau.de>
References: <2c912379f96f502080bfcc79884cdc35@fau.de>
         <5a468c6cbba8ceeed6bbeb8d19ca2d46cb749a47.camel@perches.com>
         <2835dfa18922905ffabafb11fca7e1d2@fau.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 09:29 +0200, Duda, Sebastian wrote:
> Hi Joe,
> 
> when analyzing the patch 
> `<20150128012747.824898918@linuxfoundation.org>` [1] with 

https://lore.kernel.org/lkml/220150128012747.824898918@linuxfoundation.org

> `get_maintainers.pl --subsystem --status --separator , /tmp/patch`, 
> there is the following output:

[]

> > Run the script with multiple invocations. once for each file
> > modified by the patch.

For example: perhaps use something like:

$ grep -h '^\+\+\+ b/' <patch> | \
  sed 's@^\+\+\+ b/@@' | sort | uniq | \
  while read file ; do \
    ./scripts/get_maintainer.pl --nogit --nogit-fallback --subsystem --status --separator , $file ; \
  done

or use parallel like:

$ grep -h '^\+\+\+ b/' <patch> | \
  sed 's@^\+\+\+ b/@@' | sort | uniq | \
  parallel -k ./scripts/get_maintainer.pl --nogit --nogit-fallback --subsystem --status --separator ,

runtime on my system for this is

Using while read loop:

real	0m2.509s
user	0m2.236s
sys	0m0.296s

Using parallel:

real	0m1.340s
user	0m4.159s
sys	0m0.429s


