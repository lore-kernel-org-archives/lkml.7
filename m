Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB49EC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E82217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfEUSjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 14:39:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49322 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfEUSjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:39:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 7B20F261254
Message-ID: <5f51eb6be411ae9afb08a9b315fe51e754dc0077.camel@collabora.com>
Subject: Re: [PATCH] media: vimc: fix component match compare
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Helen Koike <helen.koike@collabora.com>
Cc:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl,
        kernel@collabora.com, ezequiel.garcia@collabora.com,
        andrealmeid@collabora.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Tue, 21 May 2019 15:39:00 -0300
In-Reply-To: <20190521145548.27844fa6@collabora.com>
References: <20190517172011.13257-1-helen.koike@collabora.com>
         <20190521145548.27844fa6@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-21 at 14:55 +0200, Boris Brezillon wrote:
> On Fri, 17 May 2019 14:20:11 -0300
> Helen Koike <helen.koike@collabora.com> wrote:
> 
> > If the system has other devices being registered in the component
> > framework, the compare function will be called with a device that
> > doesn't belong to vimc.
> > This device is not necessarily a platform_device, nor have a
> > platform_data (which causes a NULL pointer dereference error) and if it
> > does have a pdata, it is not necessarily type of struct vimc_platform_data.
> > So casting to any of these types is wrong.
> > 
> > Instead of expecting a given pdev with a given pdata, just expect for
> > the device it self. vimc-core is the one who creates them, we know in
> > advance exactly which object to expect in the match.
> > 
> > Fixes: 4a29b7090749 ("[media] vimc: Subdevices as modules")
> 
> Oh, and you forgot to add
> 
> Cc: <stable@vger.kernel.org>
> 

Although it's not really documented (not in process/stable-rules
at least) that a "Fixes" tag alone would be automatically picked by
the stable team, it has been the case for me since always,
as I've never Cced stable explicitly.

