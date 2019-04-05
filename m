Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAABC10F0A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99E3204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbfDEQFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:05:54 -0400
Received: from wp260.webpack.hosteurope.de ([80.237.133.29]:45278 "EHLO
        wp260.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbfDEQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:05:54 -0400
Received: from hsi-kbw-46-223-87-231.hsi.kabel-badenwuerttemberg.de ([46.223.87.231] helo=vega.skynet.aixah.de); authenticated
        by wp260.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1hCRLj-0002n4-EF; Fri, 05 Apr 2019 18:05:51 +0200
Received: by vega.skynet.aixah.de (Postfix, from userid 1005)
        id E67E4E5352; Fri,  5 Apr 2019 18:05:50 +0200 (CEST)
Date:   Fri, 5 Apr 2019 18:05:50 +0200
From:   Luis Ressel <aranea@aixah.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] objtool: Don't use -Werror
Message-ID: <20190405160550.62arkmvj67zm6oc2@vega.skynet.aixah.de>
References: <20190405110151.2461-1-aranea@aixah.de>
 <20190405123909.tupbgueie4czg2dd@treble>
 <20190405142443.rgpwbgyym76xizad@vega.skynet.aixah.de>
 <20190405143926.wmrkjsazlheeg6qs@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405143926.wmrkjsazlheeg6qs@treble>
User-Agent: NeoMutt/20180716
X-bounce-key: webpack.hosteurope.de;aranea@aixah.de;1554480353;b6aa34e8;
X-HE-SMSGID: 1hCRLj-0002n4-EF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 09:39:26AM -0500, Josh Poimboeuf wrote:

> Hm, I would actually argue the reverse.  Warnings are generally bad and
> -Werror is useful for ensuring that we don't have any.  For warnings
> that don't provide value, we just disable those individual warnings.

Sure, during development it's an excellent idea to investigate compiler
warnings, and -Werror can be useful for that. But the Linux kernel is
built by countless users in wildly varying environments, and it's almost
a given that someone will use a compiler that'll complain about a valid
part of your code whose style it considers bad.

As an example, the warning that's breaking the build for me is -Wundef
complaining about several "#if UNDEFINED_IDENTIFIER" constructs in the
libelf headers. (I agree with gcc in considering this bad style, but
it's perfectly valid C, and there probably wasn't a warning about it
back when this header was written.)

Regards,
Luis
