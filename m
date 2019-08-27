Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2E1C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA67822DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbfH0RVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 13:21:05 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:55187 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726871AbfH0RVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:21:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id EF1A618045A64;
        Tue, 27 Aug 2019 17:21:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dime76_435d6d917c65a
X-Filterd-Recvd-Size: 2830
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 27 Aug 2019 17:21:02 +0000 (UTC)
Message-ID: <94f293d3d31e9f686e601e2e3c972ae371a40585.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check for nested (un)?likely calls
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 27 Aug 2019 10:21:01 -0700
In-Reply-To: <20190827165515.21668-1-efremov@linux.com>
References: <20190827165515.21668-1-efremov@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-27 at 19:55 +0300, Denis Efremov wrote:
> IS_ERR, IS_ERR_OR_NULL, IS_ERR_VALUE already contain unlikely optimization
> internally. Thus, there is no point in calling these functions under
> likely/unlikely.
> 
> This check is based on the coccinelle rule developed by Enrico Weigelt
> https://lore.kernel.org/lkml/1559767582-11081-1-git-send-email-info@metux.net/
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -6480,6 +6480,13 @@ sub process {
>  			     "Using $1 should generally have parentheses around the comparison\n" . $herecurr);
>  		}
>  
> +# nested likely/unlikely calls
> +		if ($perl_version_ok &&
> +		    $line =~ /\b(?:(?:un)?likely)\s*\(!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?)\s*${balanced_parens}\s*\)/) {
> +			WARN("LIKELY_MISUSE",
> +			     "nested (un)?likely calls, unlikely already used in $1 internally\n" . $herecurr);
> +		}
> +

Couple things:

1:

Are you going to submit patches for the just 10 instances that exist?

$ git grep -P -n '\b(?:(?:un)?likely)\s*\(!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?)\s*\([^\)]+\)\s*\)'
arch/x86/kernel/irq.c:246:      if (likely(!IS_ERR_OR_NULL(desc))) {
drivers/infiniband/hw/hfi1/verbs.c:1044:        if (unlikely(IS_ERR_OR_NULL(pbuf))) {
drivers/input/mouse/alps.c:1479:        } else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
fs/ntfs/mft.c:74:       if (likely(!IS_ERR(page))) {
fs/ntfs/mft.c:157:      if (likely(!IS_ERR(m)))
fs/ntfs/mft.c:274:              if (likely(!IS_ERR(m))) {
fs/ntfs/mft.c:1779:             if (likely(!IS_ERR(rl2)))
fs/ntfs/namei.c:118:            if (likely(!IS_ERR(dent_inode))) {
fs/ntfs/runlist.c:954:  if (likely(!IS_ERR(old_rl)))
include/net/udp.h:483:  if (unlikely(IS_ERR_OR_NULL(segs))) {

2:

This will not warn about code like:

fs/ntfs/mft.c:  if (unlikely(IS_ERR(rl) || !rl->length || rl->lcn < 0)) {

that could probably be better written as:

		if (IS_ERR(rl) || unlikely(!rl->length || rl->lcn < 0)) {


