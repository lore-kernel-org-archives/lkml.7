Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB18C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43BE20685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556130222;
	bh=3xhszeeUVH2FrOVdIWT3dp2t54QPqaQWAtm9NgOKf6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KRHmeRQaTYkrVVKONB1TJdzfZhkP1htKZJkzXnIWQQsEXGTXso6U4wYfx53h84xKN
	 YQSQqzSXehduLvflCRWQk4hujXwVWGZPCq585c2KahjCAgUZ1haHS7lSET7wjBMTHy
	 mEJqhQFo25wHRliuMZbrTqsX8vDnsfUusQZMqTNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbfDXSXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfDXSXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:23:37 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 004662084F;
        Wed, 24 Apr 2019 18:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556130217;
        bh=3xhszeeUVH2FrOVdIWT3dp2t54QPqaQWAtm9NgOKf6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RxyUOlN+T+RSyAQvWFwppwrWmYJsN0nvq5rBrlba/qM/0dr8lksZ/EdttCRp5sJ2v
         ehfheU6HKQclRx59l4fK+CCWMgK4Tr+N8rpWyBdn5YhajvTv0xNlT/OEDLGucDtKel
         e2gDMqe8pUlKR4had4Ii3kIwN13V6UmXw/f07JYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "he, bo" <bo.he@intel.com>,
        "Chen, Hu" <hu1.chen@intel.com>,
        Hans de Goede <hdegoede@redhat.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 26/70] io: accel: kxcjk1013: restore the range after resume.
Date:   Wed, 24 Apr 2019 19:09:46 +0200
Message-Id: <20190424170910.823733351@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: he, bo <bo.he@intel.com>

commit fe2d3df639a7940a125a33d6460529b9689c5406 upstream.

On some laptops, kxcjk1013 is powered off when system enters S3. We need
restore the range regiter during resume. Otherwise, the sensor doesn't
work properly after S3.

Signed-off-by: he, bo <bo.he@intel.com>
Signed-off-by: Chen, Hu <hu1.chen@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/accel/kxcjk-1013.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1340,6 +1340,8 @@ static int kxcjk1013_resume(struct devic
 
 	mutex_lock(&data->mutex);
 	ret = kxcjk1013_set_mode(data, OPERATION);
+	if (ret == 0)
+		ret = kxcjk1013_set_range(data, data->range);
 	mutex_unlock(&data->mutex);
 
 	return ret;


