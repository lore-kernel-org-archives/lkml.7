Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F53C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE5820866
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="gE2ITjOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfCIEvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 23:51:50 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:49162 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfCIEvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 23:51:50 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 9A83BCF0
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 04:51:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7Jpq37UoaYME for <linux-kernel@vger.kernel.org>;
        Fri,  8 Mar 2019 22:51:48 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 62C39CCC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 22:51:48 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id l10so16969142iob.22
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 20:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KeNhd+E2bDF8zX/IZPB7tqFnEXniWINKXyUoEIyOmAk=;
        b=gE2ITjOQpV6XyzLKNYiHc3mtkXOxRKKUDS30AcLbnVj3jc6o5h9RkKvfkcxauYrZsX
         cqdnatZTI5tiLpK+sAIMns2BHx/zz7LXqa+NsNNKOs9+gIO032r0ZR5db1tbzyLw+LBt
         k5uVZcyPjbHTjYiit6pnvxCsY4FgRXSrPefL+KPMMq+BVNLu7v6bLZNukDcHFAVWFJ7p
         HrkNcnuWhJ1yaNDxY2JdA/Kg9iSs0cksgKUAmTFvVUxdKIcsJY2pHNvGZ2mENTKqnff3
         yv0BrjHuxGHvxQg9heXHAOmOiMM+odbdA4JUZVDeQLZ3d4e0R+sJgFxrplzG8Gteb2si
         cQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KeNhd+E2bDF8zX/IZPB7tqFnEXniWINKXyUoEIyOmAk=;
        b=QjXl/GDyt1/sCkSN3auCOivA8nOXdLw4uruUvrJT64zLMLPV63OjZD3mS9GTKxVoxl
         k3eWQsyEOQ/qje2210ZSHWsdzwybew3lbndRPGKThOcaNvo9vBhEG1p6lVvkp9daE7yV
         hAk4Unln7+xNpozHeDoEiGCI0MD/C6BerpaXBC15GRN/H50hvSz0mdNI+Qcvb3ci+p/k
         oNiCzx0IkSe+lxrD7ltwpJu5+5x4JNpLbkE1BQDeRSdSqC21bZyZ0ccqNpMJvhPSh/JF
         EmntV3V3fyfsoyChx5wln78IA3joFqNBpN2ZFJk0W7WwJ2YIGHFgAJiJnBD9cgiFAyeJ
         CppQ==
X-Gm-Message-State: APjAAAV2Hi6mqXgNAtJbWbdqk0PHd+x4fMKzBBMe96icevp0HyfRlRDe
        czq8qn09C1C6bk21BL9GBtRYAErUun1ctt/6ykaJ3C69pYhI6gnFMstoF5vxXD5lIMd3nn/mh9D
        3u1ZjvA+5a7ABPEmYwJk9yYN3yiJU
X-Received: by 2002:a24:56c2:: with SMTP id o185mr10086087itb.57.1552107107928;
        Fri, 08 Mar 2019 20:51:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqyeWKVIzpKibJh/vjJcpXYxKT6CUmQ2bYAxg+0H8/FVA8bEYatyXYRRHXMbqPI/DWmjK3ozLg==
X-Received: by 2002:a24:56c2:: with SMTP id o185mr10086077itb.57.1552107107687;
        Fri, 08 Mar 2019 20:51:47 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id v14sm3865118iol.61.2019.03.08.20.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 20:51:46 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stefan Agner <stefan@agner.ch>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: max9611: fix a NULL pointer dereference
Date:   Fri,  8 Mar 2019 22:51:40 -0600
Message-Id: <20190309045141.8015-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device may return NULL when it fails, and in this case,
there will be a NULL pointer dereference. The fix returns
EINVAL when of_match_device returns NULL.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/iio/adc/max9611.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index 917223d5ff5b..531b6614ea29 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -524,13 +524,16 @@ static int max9611_probe(struct i2c_client *client,
 {
 	const char * const shunt_res_prop = "shunt-resistor-micro-ohms";
 	const struct device_node *of_node = client->dev.of_node;
-	const struct of_device_id *of_id =
-		of_match_device(max9611_of_table, &client->dev);
+	const struct of_device_id *of_id;
 	struct max9611_dev *max9611;
 	struct iio_dev *indio_dev;
 	unsigned int of_shunt;
 	int ret;
 
+	of_id = of_match_device(max9611_of_table, &client->dev);
+	if (!of_id)
+		return -EINVAL;
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*max9611));
 	if (!indio_dev)
 		return -ENOMEM;
-- 
2.17.1

