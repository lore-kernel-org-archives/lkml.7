Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D7FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B722620850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfDLLto convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:49:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:41838 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbfDLLto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:49:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20CCCAA85;
        Fri, 12 Apr 2019 11:49:43 +0000 (UTC)
Date:   Fri, 12 Apr 2019 13:49:39 +0200
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rtc: ds1685: disable interrupts when moving work to
 work queue
Message-Id: <20190412134939.cf32e03ba23cf8c8eef36bf4@suse.de>
In-Reply-To: <20190412101418.GV3578@piout.net>
References: <20190411143323.20945-1-tbogendoerfer@suse.de>
        <20190411143323.20945-3-tbogendoerfer@suse.de>
        <20190412101418.GV3578@piout.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019 12:14:18 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 11/04/2019 16:33:23+0200, Thomas Bogendoerfer wrote:
> > Handling of extended interrupts (kickstart, wake-up, ram-clear) is
> > moved off to a work queue, but the interrupts aren't acknowledged
> > in the interrupt handler. This leads to a deadlock, if driver
> > is used with interrupts. To fix this we now disable in irq handler
> > and re-enable it after work queue is done.
> > 
> 
> The correct fix to that seems to switch to a threaded interrupt handler.
> Can you do that?

sure, shouldn't be a big problem.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
