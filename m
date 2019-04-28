Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2D9C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA07205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfD1Twh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 15:52:37 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:36316 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfD1Twh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 15:52:37 -0400
Received: from [192.168.0.2] (188-167-58-14.dynamic.chello.sk [188.167.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 5FD3F7A006E;
        Sun, 28 Apr 2019 21:52:35 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 1/4] fdomain: Resurrect driver (core)
Date:   Sun, 28 Apr 2019 21:52:31 +0200
User-Agent: KMail/1.9.10
Cc:     Rik Faith <faith@cs.unc.edu>,
        "David A . Hinds" <dahinds@users.sourceforge.net>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190422173323.15365-1-linux@zary.sk> <20190422173323.15365-2-linux@zary.sk> <20190424060212.GA5506@infradead.org>
In-Reply-To: <20190424060212.GA5506@infradead.org>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201904282152.32077.linux@zary.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 April 2019 08:02:12 Christoph Hellwig wrote:
> > +static void fdomain_work(struct work_struct *work)
> > +{
> > +	struct fdomain *fd = container_of(work, struct fdomain, work);
> > +	struct Scsi_Host *sh = container_of((void *)fd, struct Scsi_Host,
> > +					    hostdata);
> 
> This looks odd.  We should never need a void cast for container_of.

This cast is present in all drivers involving container_of, struct Scsi_Host and hostdata. hostdata in struct Scsi_Host is defined as "unsigned long hostdata[0]"...

-- 
Ondrej Zary
