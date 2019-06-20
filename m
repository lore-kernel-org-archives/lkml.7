Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0132C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9202082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054525;
	bh=bvDOhLS2kF6GV1MDOs5xagA3VZMecFnAsJu3rPT1kOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QOVOKzrr5Pxgo2ddU4o5pla+yqCK+XjUVK0Kxvvv167RbIbaj4pvYbbbJFHIIM5m8
	 p7HNJcovDrzxv6ChI53iVJpOEToKwGVH2qCX+3b15ymN1zOKyynC4FdGA/6oT21lS8
	 Y2xZhnyI3JeHi8YOnfDnFVw7pKZ/Wr2hE1omyI04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbfFTSPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729582AbfFTSPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:15:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 698F2205F4;
        Thu, 20 Jun 2019 18:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054521;
        bh=bvDOhLS2kF6GV1MDOs5xagA3VZMecFnAsJu3rPT1kOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f9TcHvosoIsfIT/GhhCDPM4R0sISyc1DyeYSYoDnPBeN/gn/hVJqbRsEHCx8lEG58
         88twQxkgSR1GKO6Oi+lmpcoaPnbZIQx/OmSIDrR3efRb6Jysj1PT+Ji3yVvBdxD8Q9
         Rq4bybfqsW8C+2tFNqK9FWMNBNvq/XVLF5HeBmcc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 58/98] net: tulip: de4x5: Drop redundant MODULE_DEVICE_TABLE()
Date:   Thu, 20 Jun 2019 19:57:25 +0200
Message-Id: <20190620174351.985424434@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3e66b7cc50ef921121babc91487e1fb98af1ba6e ]

Building with Clang reports the redundant use of MODULE_DEVICE_TABLE():

drivers/net/ethernet/dec/tulip/de4x5.c:2110:1: error: redefinition of '__mod_eisa__de4x5_eisa_ids_device_table'
MODULE_DEVICE_TABLE(eisa, de4x5_eisa_ids);
^
./include/linux/module.h:229:21: note: expanded from macro 'MODULE_DEVICE_TABLE'
extern typeof(name) __mod_##type##__##name##_device_table               \
                    ^
<scratch space>:90:1: note: expanded from here
__mod_eisa__de4x5_eisa_ids_device_table
^
drivers/net/ethernet/dec/tulip/de4x5.c:2100:1: note: previous definition is here
MODULE_DEVICE_TABLE(eisa, de4x5_eisa_ids);
^
./include/linux/module.h:229:21: note: expanded from macro 'MODULE_DEVICE_TABLE'
extern typeof(name) __mod_##type##__##name##_device_table               \
                    ^
<scratch space>:85:1: note: expanded from here
__mod_eisa__de4x5_eisa_ids_device_table
^

This drops the one further from the table definition to match the common
use of MODULE_DEVICE_TABLE().

Fixes: 07563c711fbc ("EISA bus MODALIAS attributes support")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/dec/tulip/de4x5.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/dec/tulip/de4x5.c b/drivers/net/ethernet/dec/tulip/de4x5.c
index 66535d1653f6..f16853c3c851 100644
--- a/drivers/net/ethernet/dec/tulip/de4x5.c
+++ b/drivers/net/ethernet/dec/tulip/de4x5.c
@@ -2107,7 +2107,6 @@ static struct eisa_driver de4x5_eisa_driver = {
 		.remove  = de4x5_eisa_remove,
         }
 };
-MODULE_DEVICE_TABLE(eisa, de4x5_eisa_ids);
 #endif
 
 #ifdef CONFIG_PCI
-- 
2.20.1



