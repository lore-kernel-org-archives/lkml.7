Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9057AC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633FE20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520334;
	bh=OxYwnqLQ1QAZvpJc6sgWJ50aPD3ACT8Jh6DfAB9Bt6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wz9BnQLQi1HssMTlFzU4WkC5SFVe/XU8MTYd3HPl6+bJiOGAN6CjCMvq6GSsMYTqo
	 AuNa0toz1b0nXr/f5T092OTPgDYZDX6uE7+3PkU4MgMmbezhyXHXY3WuV6knT9CZfJ
	 FXFMizUtwA8Ayb0ddbbhkiEED64POpLZ/ZLRs+f8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbfLPSSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:18:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731689AbfLPSSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:18:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 226A4206EC;
        Mon, 16 Dec 2019 18:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520327;
        bh=OxYwnqLQ1QAZvpJc6sgWJ50aPD3ACT8Jh6DfAB9Bt6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RvPhHspc9/XLRZktdGjc+84oZNPwWxbQeyKGIba3yxOOAmXpkIbgqeVTeJwLgYbwV
         la6Cs9YiKXMMNS0yQeG8UJ3uMgv4GOZ3E7bMPsf0DRf6BcAQjVoH10xj544eprFgIn
         rqnATESx5EInHf8skjciwDGOLpx9oCBhx6toYLa8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 109/177] cpuidle: use first valid target residency as poll time
Date:   Mon, 16 Dec 2019 18:49:25 +0100
Message-Id: <20191216174841.912757790@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Tosatti <mtosatti@redhat.com>

commit 36fcb4292473cb9c9ce7706d038bcf0eda5cabeb upstream.

Commit 259231a04561 ("cpuidle: add poll_limit_ns to cpuidle_device
structure") changed, by mistake, the target residency from the first
available sleep state to the last available sleep state (which should
be longer).

This might cause excessive polling.

Fixes: 259231a04561 ("cpuidle: add poll_limit_ns to cpuidle_device structure")
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpuidle/cpuidle.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -384,6 +384,7 @@ u64 cpuidle_poll_time(struct cpuidle_dri
 			continue;
 
 		limit_ns = (u64)drv->states[i].target_residency * NSEC_PER_USEC;
+		break;
 	}
 
 	dev->poll_limit_ns = limit_ns;


