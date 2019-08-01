Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A6DC32751
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E444520449
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfHAAIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 20:08:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58380 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfHAAIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 20:08:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 262F0287EEF
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH RFC 1/2] futex: Split key setup from key queue locking and read
Organization: Collabora
References: <20190730220602.28781-1-krisman@collabora.com>
        <alpine.DEB.2.21.1908010131200.1788@nanos.tec.linutronix.de>
Date:   Wed, 31 Jul 2019 20:07:55 -0400
In-Reply-To: <alpine.DEB.2.21.1908010131200.1788@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Thu, 1 Aug 2019 01:33:25 +0200 (CEST)")
Message-ID: <85sgql7nok.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, 30 Jul 2019, Gabriel Krisman Bertazi wrote:
>
>> split the futex key setup from the queue locking and key reading.  This
>> is useful to support the setup of multiple keys at the same time, like
>> what is done in futex_requeue() and what will be done for the
>
> What has this to do with futex_requeue()? Absolutely nothing unleass you
> can reused that code there, which I doubt.

futex_requeue is another place where more than one key is setup at a
time.  Just that.  I think it could be reused there, but this change is
out of scope for this patch.

-- 
Gabriel Krisman Bertazi
