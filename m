Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6FFC072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3849D217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfEVHda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 03:33:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:39940 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfEVHd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 03:33:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 00:33:28 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 May 2019 00:33:26 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH RFC 0/2] docs: Deal with some Sphinx deprecation warnings
In-Reply-To: <20190521211714.1395-1-corbet@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190521211714.1395-1-corbet@lwn.net>
Date:   Wed, 22 May 2019 10:36:45 +0300
Message-ID: <87d0kb7xf6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Jonathan Corbet <corbet@lwn.net> wrote:
> The Sphinx folks are deprecating some interfaces in the upcoming 2.0
> release; one immediate result of that is a bunch of warnings that show up
> when building with 1.8.  These two patches make those warnings go away,
> but at a cost:
>
>  - It introduces a couple of Sphinx version checks, which are always
>    ugly, but the alternative would be to stop supporting versions
>    before 1.7.  For now, I think we can carry that cruft.

Frankly, I'd just require Sphinx 1.7+, available even in Debian stable
through stretch-backports.

>  - The second patch causes the build to fail horribly on newer
>    Sphinx installations.  The change to switch_source_input() seems
>    to make the parser much more finicky, increasing warnings and
>    eventually failing the build altogether.  In particular, it will
>    scream about problems in .rst files that are not included in the
>    TOC tree at all.  The complaints appear to be legitimate, but it's
>    a bunch of stuff to clean up.

I can understand Sphinx complaining that a file is not included in a TOC
tree, but I don't understand why it goes on to parse them anyway.

BR,
Jani.


>
> I've tested these with 1.4 and 1.8, but not various versions in between.
>
> Jonathan Corbet (2):
>   doc: Cope with Sphinx logging deprecations
>   doc: Cope with the deprecation of AutoReporter
>
>  Documentation/sphinx/kerneldoc.py | 48 ++++++++++++++++++++++++-------
>  Documentation/sphinx/kernellog.py | 28 ++++++++++++++++++
>  Documentation/sphinx/kfigure.py   | 38 +++++++++++++-----------
>  3 files changed, 87 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/sphinx/kernellog.py

-- 
Jani Nikula, Intel Open Source Graphics Center
