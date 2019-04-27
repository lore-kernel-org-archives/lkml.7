Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FD1C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 11:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F90206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 11:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfD0LSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 07:18:40 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:58043 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD0LSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 07:18:39 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 46FE95C2B3F; Sat, 27 Apr 2019 13:17:48 +0200 (CEST)
Date:   Sat, 27 Apr 2019 13:17:48 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] staging: fieldbus: anybus-s: use proper type for
 wait_for_completion_timeout
Message-ID: <20190427111748.GA3157@osadl.at>
References: <1556339208-7722-1-git-send-email-hofrat@osadl.org>
 <CAGngYiXBrNu7Jrk535=L89-mOSNx-6EfqL=1EwwG49Sf44R0Vg@mail.gmail.com>
 <20190427070021.GA2290@osadl.at>
 <CAGngYiX-s6dCc5focdXW5WYaiWiBF=dzacqFjSvXggvdxD3zAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiX-s6dCc5focdXW5WYaiWiBF=dzacqFjSvXggvdxD3zAQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 03:20:54AM -0400, Sven Van Asbroeck wrote:
> On Sat, Apr 27, 2019 at 3:01 AM Nicholas Mc Guire <der.herr@hofr.at> wrote:
> > > > (some unrelated sparse warnings (cast to restricted __be16))
> > >
> > > That sounds interesting too. Could you provide more details?
> >
> > make C=1
> > drivers/staging/fieldbus/anybuss/host.c:1350:25: warning: cast to restricted __be16
> > drivers/staging/fieldbus/anybuss/host.c:1350:25: warning: cast to restricted __be16
> > drivers/staging/fieldbus/anybuss/host.c:1350:25: warning: cast to restricted __be16
> > drivers/staging/fieldbus/anybuss/host.c:1350:25: warning: cast to restricted __be16
> > drivers/staging/fieldbus/anybuss/host.c:1350:25: warning: cast to restricted
> 
> regmap_bulk_read(cd->regmap, REG_FIELDBUS_TYPE, &fieldbus_type,
i>         sizeof(fieldbus_type));
> fieldbus_type = be16_to_cpu(fieldbus_type);
> 
> Probably because the parameter to be16_to_cpu() should be __be16.
> Would you like to spin a separate patch for this too? Or shall I?

so the issue is simply that the endiannes anotatoin is missing even 
though the conversion is being done - with other words there is no code
lvel funcitonal bug here but rather sparse needs the anotation to verify
correctness and that is missing. Just want to make sure I understand
this before I try to "fix" a sparse warning.

thx!
hofrat
