Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1049BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6892176D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519055;
	bh=Qezn44Irrc6jgQSJErdffXCId1xTUQDMw3SjZOStOXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=se+RBJT1DgaJh+A7wmkFUG8XajnXIsWy9DgktCFVyieseoolvjn4xSIMXa76gJ2wp
	 U0QUhtGHmhii8JYMn/w93IneqZ+Y5YvRyVvmjTuphKTJo69SFfVFWq6kLwAJtKpV5e
	 5NFprgNlKOrAngjlrW98xvJRRilSCX7hDQnWZ6fU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfLPR5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:57:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbfLPR5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:57:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33263205ED;
        Mon, 16 Dec 2019 17:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519051;
        bh=Qezn44Irrc6jgQSJErdffXCId1xTUQDMw3SjZOStOXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eorDUIcaOInG46zzJjwB/VWWjr5kfDkStoqYk3d/HoYxymVyPA9xDhwbjAH1sUrJ5
         VPlJTSDqwAWYy39W59/FxugO6LSmysE4p8DgUinHyujq3+PNwGYv+w6W4Z3Y+UQ9e9
         AivGxYsfuDiMS3oxkYlL2/qGQg/LD3sljHALMuLo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Lesiak <chris.lesiak@licor.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 174/267] iio: humidity: hdc100x: fix IIO_HUMIDITYRELATIVE channel reporting
Date:   Mon, 16 Dec 2019 18:48:20 +0100
Message-Id: <20191216174912.036950667@linuxfoundation.org>
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

From: Chris Lesiak <chris.lesiak@licor.com>

commit 342a6928bd5017edbdae376042d8ad6af3d3b943 upstream.

The IIO_HUMIDITYRELATIVE channel was being incorrectly reported back
as percent when it should have been milli percent. This is via an
incorrect scale value being returned to userspace.

Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/humidity/hdc100x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -237,7 +237,7 @@ static int hdc100x_read_raw(struct iio_d
 			*val2 = 65536;
 			return IIO_VAL_FRACTIONAL;
 		} else {
-			*val = 100;
+			*val = 100000;
 			*val2 = 65536;
 			return IIO_VAL_FRACTIONAL;
 		}


