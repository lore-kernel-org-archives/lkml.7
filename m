Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB67C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 04:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9567A20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 04:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfD3ETl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 00:19:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38462 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD3ETl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 00:19:41 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hLKEw-0007Ls-Ie; Tue, 30 Apr 2019 04:19:34 +0000
Date:   Tue, 30 Apr 2019 05:19:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Nicholas Mc Guire <der.herr@hofr.at>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] staging: fieldbus: anybus-s: force endiannes
 annotation
Message-ID: <20190430041934.GI23075@ZenIV.linux.org.uk>
References: <1556517940-13725-1-git-send-email-hofrat@osadl.org>
 <CAGngYiVDFL1fm2oKALXORNziX6pdcBBNtp7rSnj_FBdr6u4j5w@mail.gmail.com>
 <20190430022238.GA22593@osadl.at>
 <20190430030223.GE23075@ZenIV.linux.org.uk>
 <20190430033310.GB23144@osadl.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430033310.GB23144@osadl.at>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 05:33:10AM +0200, Nicholas Mc Guire wrote:

> ok - my bad thn - I had assumed that using __force is reasonable
> if the handling is correct and its a localized conversoin only 
> like var = be16_to_cpu(var) which evaded introducing additinal
> variables just to have different types but no different function.

If compiler can't recognize that in

	T1 v1;
	T2 v2;

	code using v1, but not v2
	v2 = f(v1);
	code using v2, but not v1

it can use the same memory for v1 and v2, file a bug against the
compiler.  Or stop using that toy altogether - that kind of
optimizations is early 60s stuff and any real compiler will
handle that.  Both gcc and clang certainly do handle that.

Another thing they handle is figuring out that be16_to_cpu()
et.al. are pure functions, so

	f(be16_to_cpu(n));
	no modifications of n
	g(be16_to_cpu(n));

doesn't need to have le16_to_cpu recalculated.  IOW, that particular
code could as well have been
	dev_info(dev, "Fieldbus type: %04X", be16_to_cpu(fieldbus_type));
	...
	cd->client->fieldbus_type = be16_to_cpu(fieldbus_type);

... not that there's much sense keeping ->fieldbus_type in host-endian,
while we are at it.
