Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92114C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B0620643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="VDNZtG59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfCKHuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:50:03 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:58528 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfCKHuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:50:03 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 8CE109CC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:50:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CnuFJQi6ucRH for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 02:50:01 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 5ABF89BB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:50:01 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id q184so4357440itd.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 00:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ad+Ht6iuPEK3V66itIO25xm2d2MmiWnk2HmclFaUdgw=;
        b=VDNZtG59PFO7DSh0K1Jhd7J/P9sr1z5nGz5m24NANiVWhaC6/kijvsGQKeLD+9NTV/
         RlsQoOio6SjU5DcZnFd5dqBdQYO1qDtjNDSHFVx6fZ4tZtElwS6uleVsLehsznLbEQiU
         Az/VaVelJECl2hvDUu34Sj3sUVD6AL5uHhi/FSaTvucmJ8LTU0nxG7SNKLh9aEGQqM+Q
         ErilQYuzOGronQY8OiIRExqvOvybK51e4xvuGMfAAC6FJjRaXk6J6APnVsZm9yZ9EjX6
         KIOIJsRa+hkEhxsDzMBahiY5AoxjcL8VfYLhrcl7ZFG3I+AagOyewqzkEanrnA735PEQ
         56AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ad+Ht6iuPEK3V66itIO25xm2d2MmiWnk2HmclFaUdgw=;
        b=FPLNMz9G/JODwNCvMYgMwwQ1lC66Iohxzljhldx6JtKkyKw0cZy5CsXwt5C5qvJqjg
         Q0w7Dmu45ce/fzX8wUcSUTIDZ/vLzDBbG2vxtyXRTv/9TnXCWc36tfNGzrsKAUOjpa4f
         w9ZdHnCNMexc4eWVLs9kCgtfR2tZBpp9z5X4C+c53nOBqQLBw+k8kseQDjIs8Z/ylv+S
         v7OcnPgrdYqIVZldHRnphUL8KBhJV1NJiEtzrI49gnCywSFdepx6er5OZaS0RH3+YDEC
         pYszRzovMTS0PCzpp+OQddCQC53/tm5AlyXqQo3T5yiyTm/mgmC6CUutCeywBbew226S
         Hb/Q==
X-Gm-Message-State: APjAAAWEDxayDM9XyWYNcNS7gYM9PTkIv8h6CjNw4pMpQuTil/5FGQU3
        9ghJBaCeIKd2L9qKXA8kQ99aYPORvuzgOsAvfwGyE6zMLxv0iFDN3XmakV25HKhyY8ULLcuBtdU
        dJMKL9qw9vRUV2aLxoXiNFzxG0u3s
X-Received: by 2002:a24:1091:: with SMTP id 139mr15197826ity.110.1552290600964;
        Mon, 11 Mar 2019 00:50:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxEcwbeVHeTUD0YZEey71JInwRH/jTEenqU6CZEUTD1zMNotqyC2OqmpD6lJpywuJsoIPrvZg==
X-Received: by 2002:a24:1091:: with SMTP id 139mr15197810ity.110.1552290600647;
        Mon, 11 Mar 2019 00:50:00 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id d6sm1852609ioc.44.2019.03.11.00.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 00:49:59 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Chris Brandt <chris.brandt@renesas.com>,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: renesas: fix a missing check of of_get_phy_mode
Date:   Mon, 11 Mar 2019 02:49:37 -0500
Message-Id: <20190311074939.517-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_phy_mode may fail and return a negative error code;
the fix checks the return value of of_get_phy_mode and
returns NULL of it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/renesas/sh_eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 339b2eae2100..239eeafe1b2d 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3187,6 +3187,8 @@ static struct sh_eth_plat_data *sh_eth_parse_dt(struct device *dev)
 		return NULL;
 
 	pdata->phy_interface = of_get_phy_mode(np);
+	if (pdata->phy_interface < 0)
+		return NULL;
 
 	mac_addr = of_get_mac_address(np);
 	if (mac_addr)
-- 
2.17.1

