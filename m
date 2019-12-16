Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3FBC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B742072D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518739;
	bh=5EaPEyrukBMg3O+QebSDf5gJFnoIyQFT0LBomUN5WwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FakgX/8kUtlq+oCKuRpT96hLIJJQ6nMLi0PEGHMErvZblma8iTLR48lWtT5WPuEuM
	 O4SQQiHgMlzX3QS4v6ddUffI6egrSBlZD/UGEwv8JYt49610x8xwanM3myTksSvLqF
	 BDR0jWji1sGYr/kG6MNKZGywrr0M5zneedfDuhwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLPRwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:52:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbfLPRwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:52:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FACF20726;
        Mon, 16 Dec 2019 17:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518733;
        bh=5EaPEyrukBMg3O+QebSDf5gJFnoIyQFT0LBomUN5WwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2NzP9wDqh/ZZWxMRTbwnIlRDN9MXVsiruFXb9xNe7DK052utm56hFzwAYyRX3XR+
         SRHpL5jpN/Pac1IDJBj2kex9KMLs8gd6HOrnjuhr2W2jcpuERTb+HtmR3DdqKzH9DW
         E1WoYPYrEbOhCZiWDnrZh56VV4F/EXyfvAhC9+3I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 044/267] Staging: iio: adt7316: Fix i2c data reading, set the data field
Date:   Mon, 16 Dec 2019 18:46:10 +0100
Message-Id: <20191216174853.583168333@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreeya Patel <shreeya.patel23498@gmail.com>

[ Upstream commit 688cd642ba0c393344c802647848da5f0d925d0e ]

adt7316_i2c_read function nowhere sets the data field.
It is necessary to have an appropriate value for it.
Hence, assign the value stored in 'ret' variable to data field.

This is an ancient bug, and as no one seems to have noticed,
probably no sense in applying it to stable.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/iio/addac/adt7316-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index f66dd3ebbab1f..856bcfa60c6c4 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -35,6 +35,8 @@ static int adt7316_i2c_read(void *client, u8 reg, u8 *data)
 		return ret;
 	}
 
+	*data = ret;
+
 	return 0;
 }
 
-- 
2.20.1



