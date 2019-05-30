Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FACC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570F125F8D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfE3S0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:26:33 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56736 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfE3S0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:26:31 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 19E9F14D92C59;
        Thu, 30 May 2019 11:26:31 -0700 (PDT)
Date:   Thu, 30 May 2019 11:26:30 -0700 (PDT)
Message-Id: <20190530.112630.476132829981439143.davem@davemloft.net>
To:     mkubecek@suse.cz
Cc:     netdev@vger.kernel.org, vivien.didelot@gmail.com,
        linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com,
        linville@redhat.com, f.fainelli@gmail.com
Subject: Re: [PATCH net-next] ethtool: copy reglen to userspace
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190530082722.GB27401@unicorn.suse.cz>
References: <20190529.221744.1136074795446305909.davem@davemloft.net>
        <20190530064848.GA27401@unicorn.suse.cz>
        <20190530082722.GB27401@unicorn.suse.cz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 May 2019 11:26:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kubecek <mkubecek@suse.cz>
Date: Thu, 30 May 2019 10:27:22 +0200

> I believe this should be handled by ethtool_get_regs(), either by
> returning an error or by only copying data up to original regs.len
> passed by userspace. The former seems more correct but broken userspace
> software would suddenly start to fail where it "used to work". The
> latter would be closer to current behaviour but it would mean that
> broken userspace software might nerver notice there is something wrong.

I therefore think we need to meticulously fixup all of these adjustments
of regs.len before adjusting the copy call here in generic ethtool.
