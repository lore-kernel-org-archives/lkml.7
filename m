Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD180C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D71206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfCUV65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:58:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54014 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfCUV65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:58:57 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 915CE13407F4A;
        Thu, 21 Mar 2019 14:58:56 -0700 (PDT)
Date:   Thu, 21 Mar 2019 14:58:53 -0700 (PDT)
Message-Id: <20190321.145853.422691977128044341.davem@davemloft.net>
To:     mkubecek@suse.cz
Cc:     netdev@vger.kernel.org, jakub.kicinski@netronome.com,
        jiri@resnulli.us, andrew@lunn.ch, f.fainelli@gmail.com,
        linville@tuxdriver.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 01/22] rtnetlink: provide permanent
 hardware address in RTM_NEWLINK
From:   David Miller <davem@davemloft.net>
In-Reply-To: <c46e29b557e54652cce569e3348ed0385eac1469.1553170807.git.mkubecek@suse.cz>
References: <cover.1553170807.git.mkubecek@suse.cz>
        <c46e29b557e54652cce569e3348ed0385eac1469.1553170807.git.mkubecek@suse.cz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Mar 2019 14:58:56 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kubecek <mkubecek@suse.cz>
Date: Thu, 21 Mar 2019 14:40:21 +0100 (CET)

> Permanent hardware address of a network device was traditionally provided
> via ethtool ioctl interface but as Jiri Pirko pointed out in a review of
> ethtool netlink interface, rtnetlink is much more suitable for it so let's
> add it to the RTM_NEWLINK message.
> 
> As permanent address is not modifiable, reject userspace requests
> containing IFLA_PERM_ADDRESS attribute.
> 
> Note: we already provide permanent hardware address for bond slaves;
> unfortunately we cannot drop that attribute for backward compatibility
> reasons.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Jakub asked if we should check the perm_addr and if it is set.

I would say no, in order to be consistent with what ethtool does which
is that it does not check.
