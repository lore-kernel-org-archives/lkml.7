Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F4FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF8C206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDCKgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:36:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:47746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726263AbfDCKgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:36:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B21A0AB6D;
        Wed,  3 Apr 2019 10:36:48 +0000 (UTC)
Message-ID: <1554287791.20869.6.camel@suse.com>
Subject: Re: [PATCH V6 1/3] USB: serial: f81232: clear overrun flag
From:   Oliver Neukum <oneukum@suse.com>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>,
        peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Wed, 03 Apr 2019 12:36:31 +0200
In-Reply-To: <1554280832-29286-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1554280832-29286-1-git-send-email-hpeter+linux_kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2019-04-03 at 16:40 +0800,  Ji-Ze Hong (Peter Hong)  wrote:
> The F81232 will report data and LSR with bulk like following format:
> bulk-in data: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]...
> 
> LSR will auto clear frame/parity/break error flag when reading by H/W,
> but overrrun will only cleared when reading LSR. So this patch add a
> worker to read LSR when overrun and flush the worker on close() &
> suspend().
> 
> Cc: Oliver Neukum <oneukum@suse.com>
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
Reviewed-by: Oliver Neukum <oneukum@suse.com>
