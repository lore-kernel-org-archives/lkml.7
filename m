Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1899C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A713D218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564181436;
	bh=jcUbNJUk/+4T10G8HH13wiXX/jvL3CBM+iFCXy8Aj+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=E0OWi31fAuQt66BOmymsErmAgsbufvmgvKnL4MsPSuh7vCZhapBu7MToM0lA46YAS
	 Wmo70AgH1JngUDBeplebGOCAvvB4lVOCvjihtQ2WJ/GM9fT9o+BoG4tncH6FCmqgqH
	 TJZus8NUTgSS+6sxEwJHVqvMeVQ2WtAU6k32QHtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfGZWuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 18:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfGZWue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 18:50:34 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6A3E20657;
        Fri, 26 Jul 2019 22:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564181434;
        bh=jcUbNJUk/+4T10G8HH13wiXX/jvL3CBM+iFCXy8Aj+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y0N0mM41BVeh6RLIAXTqKufpksZcV3vzwvnS3tK7U8IrL/2fbN66+NuYmc8VN01Vk
         KYNR81POgm4zm+5onbmm1elqC7omxeJs+Odxel1tIoMI/kxapMk+QReTgQ7OY5lVQr
         IVecxvbbs0tkzm9pXT5p7G3nDAQzYC1PSoFjcJaM=
Date:   Fri, 26 Jul 2019 15:50:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org
Subject: Re: [PATCH 2/7] vmpressure: Use spinlock_t instead of struct
 spinlock
Message-Id: <20190726155033.d10771437e26dd5007f91a08@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1907261409260.1791@nanos.tec.linutronix.de>
References: <20190704153803.12739-1-bigeasy@linutronix.de>
        <20190704153803.12739-3-bigeasy@linutronix.de>
        <alpine.DEB.2.21.1907261409260.1791@nanos.tec.linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 14:09:50 +0200 (CEST) Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 4 Jul 2019, Sebastian Andrzej Siewior wrote:
> 
> Polite reminder ...

Already upstream!


commit 51b176290496518d6701bc40e63f70e4b6870198
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Thu Jul 11 20:54:52 2019 -0700

    include/linux/vmpressure.h: use spinlock_t instead of struct spinlock
