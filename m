Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EC2C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C0421479
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053604;
	bh=5+pIcsxL3+kMfNjKRKyMxU8gJGrwjrepimwCwm6k9zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AbPmSVx6/72lwHKNQDcygJSu9Tmknv+01Fqg4P0XXESHmAhMEugDUGDNnTwsi+//q
	 bOB5q7qJ+3HOb/XcF+bkVYdcZdUUfANmz5srjekkDOOvqLlcem8yTn/kCxxUJfr1aI
	 hg0Ry7OcfZ0VHhuw8FhB71zljaBRCJREIiIPV42A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfFTSAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfFTSAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:00:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 660F421479;
        Thu, 20 Jun 2019 17:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053599;
        bh=5+pIcsxL3+kMfNjKRKyMxU8gJGrwjrepimwCwm6k9zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omYaL+qoM1AN3QL53jASbD130jlWtBvSuwd7/Sxx6lwtb8VzyelhWew6CDXkP+iSI
         MC+qq0D9QXUQ2Qe1sbylyQ+0nM5PYELWwx3fvZBljKoVO9IY7Pc7RLBfn8e/C03NKQ
         MQLS1NpZ5457kweQQXHm61CaMCFNURkIUmJYHJLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Wolfram Sang <wsa@the-dreams.de>, stable@kernel.org
Subject: [PATCH 4.4 46/84] i2c: acorn: fix i2c warning
Date:   Thu, 20 Jun 2019 19:56:43 +0200
Message-Id: <20190620174345.476720144@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174337.538228162@linuxfoundation.org>
References: <20190620174337.538228162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

commit ca21f851cc9643af049226d57fabc3c883ea648e upstream.

The Acorn i2c driver (for RiscPC) triggers the "i2c adapter has no name"
warning in the I2C core driver, resulting in the RTC being inaccessible.
Fix this.

Fixes: 2236baa75f70 ("i2c: Sanity checks on adapter registration")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-acorn.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/i2c/busses/i2c-acorn.c
+++ b/drivers/i2c/busses/i2c-acorn.c
@@ -83,6 +83,7 @@ static struct i2c_algo_bit_data ioc_data
 
 static struct i2c_adapter ioc_ops = {
 	.nr			= 0,
+	.name			= "ioc",
 	.algo_data		= &ioc_data,
 };
 


