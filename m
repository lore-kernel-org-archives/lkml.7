Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADD5C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581392147A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922594;
	bh=9E2EX28Bw3gXuclGEY/bIpxg/tuh2wZhNIhvZVgFgtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JI38O+grRJOldx1wLnxrsUwdavpbnHdhPetS/yJvVHBi7/ZM48vXswwipUNwiBr0N
	 yR1qFa6a+1d67uImCG0KUK6n2hMHZGRu1RrxTfA7z/nzotlUC5V0uDUf/tGT6RVjSN
	 Wmbdsu7g+OxyggbUHVK+JsTsw8jHveTD7at0Nuo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732057AbfFGPtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732042AbfFGPtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:49:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9BA8214AE;
        Fri,  7 Jun 2019 15:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922590;
        bh=9E2EX28Bw3gXuclGEY/bIpxg/tuh2wZhNIhvZVgFgtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBZxD8pPgz+hkvmjx4cxnQ289IHL7OXHvlHwDuSXahHFSs4aWratnNzAFZrskgXQZ
         gpdK2gW+KZlXrufr9SK8bdJrsQbKhhUKr7BHu61VmWrdWakz+20fqy36asM6nA7nwH
         cBswTYfky1CcDlPbVBJaA/xJW/Lyb4lNAXtFytrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.1 31/85] iio: adc: ti-ads8688: fix timestamp is not updated in buffer
Date:   Fri,  7 Jun 2019 17:39:16 +0200
Message-Id: <20190607153853.114846749@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153849.101321647@linuxfoundation.org>
References: <20190607153849.101321647@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Nyekjaer <sean@geanix.com>

commit e6d12298310fa1dc11f1d747e05b168016057fdd upstream.

When using the hrtimer iio trigger timestamp isn't updated.
If we use iio_get_time_ns it is updated correctly.

Fixes: 2a86487786b5c ("iio: adc: ti-ads8688: add trigger and buffer support")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/ti-ads8688.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -397,7 +397,7 @@ static irqreturn_t ads8688_trigger_handl
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
-			pf->timestamp);
+			iio_get_time_ns(indio_dev));
 
 	iio_trigger_notify_done(indio_dev->trig);
 


