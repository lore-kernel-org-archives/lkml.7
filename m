Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C36C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8D8208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="OfXKbvcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfDAQER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:04:17 -0400
Received: from tomli.me ([153.92.126.73]:32876 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfDAQER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:04:17 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id acc5f6e6;
        Mon, 1 Apr 2019 16:04:14 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:ddd9:ae88)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Mon, 01 Apr 2019 16:04:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=IPhU0F+Bjzo8SQNtXlH9wbjBATaXswUurNUBdyayQgg=; b=OfXKbvczkFhV+L3N7OVsU8UmNWbhtk+rwYakgqWS+eWi4AYhV6Y22mVat9Tta5vUKuEqB2uVrlKbHDNRiK0b7q0WY3hG2ZaiEcC92k6wmabQ+gOk/sxIJAnfbO+D59arxWCBdqNL/zg6Tokfc6GsYCo2ld6tXPJ85ayw3K6Cay2ZlywZUnHWSh6Z5vR86AodftGdq7KqPDWN9tN9iODJ7/BHVs5i8LJYIRPo7TZy35EhpEngyh/LTBtO68Dm/dM+hMy6qZDLTf8WTfUpsGpooX0qG+zQWtMckdIPSWTVVHFvmFVjGKcFZBFVy+5H6+3EhkV4rMv74LYMWTOXDSO1iA==
Date:   Tue, 2 Apr 2019 00:04:05 +0800
From:   Tom Li <tomli@tomli.me>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/7] fbdev: sm712fb: add 2D-related I/O headers and
 functions.
Message-ID: <20190401160404.GA15736@localhost.localdomain>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-3-tomli@tomli.me>
 <20190331172558.ndvtilm7c2cy6xa4@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331172558.ndvtilm7c2cy6xa4@debian>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 06:25:58PM +0100, Sudip Mukherjee wrote:
> On Fri, Mar 22, 2019 at 01:17:54PM +0800, Yifeng Li wrote:
> > +#define DE_CTRL_COMMAND_SHIFT			16
> > +#define DE_CTRL_COMMAND_BITBLT			0x00
> > +#define DE_CTRL_COMMAND_SOLIDFILL		0x01
> > +#define DE_CTRL_COMMAND_HOSTWRITE		0x08
> > +#define DE_CTRL_ROP2_SELECT		0x00008000
> > +#define DE_CTRL_ROP2_SRC_IS_PATTERN	0x00004000
> > +#define DE_CTRL_ROP2_SHIFT			0
> > +#define DE_CTRL_ROP2_COPY			0x0c
> > +#define DE_CTRL_HOST_SHIFT			22
> > +#define DE_CTRL_HOST_SRC_IS_MONO		0x01
> > +#define DE_CTRL_FORMAT_XY			0x00
> > +#define DE_CTRL_FORMAT_24BIT			0x30
> 
> Please fix the alignment. Some of them are right aligned and some are left.

Noted. It will be fixed in PATCH v3.

Thanks,
Tom Li
