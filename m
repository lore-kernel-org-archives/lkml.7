Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63F1C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913B425B5B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfE3Gsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 02:48:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:50884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfE3Gsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 02:48:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28DE6ACF8;
        Thu, 30 May 2019 06:48:49 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 646C0E0326; Thu, 30 May 2019 08:48:48 +0200 (CEST)
Date:   Thu, 30 May 2019 08:48:48 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     netdev@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>, vivien.didelot@gmail.com,
        linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com,
        linville@redhat.com, f.fainelli@gmail.com
Subject: Re: [PATCH net-next] ethtool: copy reglen to userspace
Message-ID: <20190530064848.GA27401@unicorn.suse.cz>
References: <20190528205848.21208-1-vivien.didelot@gmail.com>
 <20190529.221744.1136074795446305909.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529.221744.1136074795446305909.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 10:17:44PM -0700, David Miller wrote:
> From: Vivien Didelot <vivien.didelot@gmail.com>
> Date: Tue, 28 May 2019 16:58:48 -0400
> 
> > ethtool_get_regs() allocates a buffer of size reglen obtained from
> > ops->get_regs_len(), thus only this value must be used when copying
> > the buffer back to userspace. Also no need to check regbuf twice.
> > 
> > Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>
> 
> Hmmm, can't regs.len be modified by the driver potentially?

The driver certainly shouldn't raise it as that could result in kernel
writing past the buffer provided by userspace. (I'll check some drivers
to see if they truncate the dump or return an error if regs.len from
userspace is insufficient.) And lowering it would be also wrong as that
would mean dump would be shorter than what ops->get_regs_len() returned.

Michal Kubecek
