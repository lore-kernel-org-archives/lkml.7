Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1713C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9CF2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfDLEaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 00:30:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39826 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDLEaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 00:30:22 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B61CD1403A583;
        Thu, 11 Apr 2019 21:30:21 -0700 (PDT)
Date:   Thu, 11 Apr 2019 21:30:21 -0700 (PDT)
Message-Id: <20190411.213021.1296427633488857138.davem@davemloft.net>
To:     jiaolitao@raisecom.com
Cc:     petrm@mellanox.com, idosch@mellanox.com, roopa@cumulusnetworks.com,
        sbrivio@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vxlan: using hash_lock to protect one budegt in
 vxlan_flush
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1554966369-16259-1-git-send-email-jiaolitao@raisecom.com>
References: <1554966369-16259-1-git-send-email-jiaolitao@raisecom.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 11 Apr 2019 21:30:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Litao Jiao <jiaolitao@raisecom.com>
Date: Thu, 11 Apr 2019 15:06:09 +0800

> The hash_lock will hold long time in vxlan_flush when stopping the
> vxlan device in which there has lots of vxlan fdb entries;it would
> affect the bh process in local cpu; and other cpu would wait for
> a long time in vxlan_snoop until the hash_lock is released;so
> using hash_lock to protect one budegt in vxlan_flush could
> reduce the continuous holding time of the lock.
> 
> Signed-off-by: Litao Jiao <jiaolitao@raisecom.com>

Now you are doing FDB_HASH_SIZE spin lock/unlock sequences.

There has to be a better way.
