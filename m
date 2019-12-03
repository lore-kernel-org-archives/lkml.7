Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7B5C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D23A20661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLCJja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:39:30 -0500
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:45879 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbfLCJj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:39:29 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id DD905100E7B4E;
        Tue,  3 Dec 2019 09:39:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: uncle09_8cd93dde3eb45
X-Filterd-Recvd-Size: 1707
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue,  3 Dec 2019 09:39:27 +0000 (UTC)
Message-ID: <7d7c97b0d2aea09f32688bd6644af72b4be121d4.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Look for Kconfig indentation errors
From:   Joe Perches <joe@perches.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date:   Tue, 03 Dec 2019 01:38:54 -0800
In-Reply-To: <874kyhkbje.fsf@intel.com>
References: <1574906800-19901-1-git-send-email-krzk@kernel.org>
         <87a78gnyaz.fsf@intel.com>
         <ab3309596fac1c5a0cb4e0abed0cf1ee7ac13a3d.camel@perches.com>
         <CAJKOXPdqn7+ucwqu2vJFL9ggCerpBz1qN6BSJvcsi4BQ3DU6fg@mail.gmail.com>
         <ea57f41e30f962227855d4f60a93c89a6bf0b2f0.camel@perches.com>
         <874kyhkbje.fsf@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-12-03 at 11:23 +0200, Jani Nikula wrote:
> Alternatively, perhaps you could complain about indentation that is not
> one of 1) empty string, 2) exactly one tab, or 3) exactly one tab
> followed by exactly two spaces?

Way too many false positives.

Try something like:

$ git grep -P -oh "^\s*\w+\b" -- '*/Kconfig*' | \
  perl -p -e 'my $tabs=0;my $spaces=0;while ($_ =~ /^\s/) { if (substr($_,0,1) eq " ") { $spaces++; } else { $tabs++; } $_ = substr($_, 1); } print "tabs: $tabs spaces: $spaces: word: $_";'


