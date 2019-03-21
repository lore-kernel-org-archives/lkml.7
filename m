Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38954C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E8F21900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="m4TbOO9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfCUXgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:36:51 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:33337 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfCUXgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:36:50 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 430E58066C;
        Fri, 22 Mar 2019 12:36:46 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1553211406;
        bh=ASgEoS06bGTq5chChrbSHAh/0RRrpEwRt0bcX2Jr+UY=;
        h=From:To:Cc:Subject:Date;
        b=m4TbOO9lCa1se/e0VyiUAl6t87TJ8IN/JoctjlO0HrAjl/hRBGFcjvcyzjudJnn/L
         4raUTPIccRI9a9ayuvD1Xg2Do98fz0dTDVJvMCPYpXfCJOVotFgLcpGqu3aV358+cj
         84zqIwQ4z/DNQFEWrxMH0RI7+ZIg0EJ/27vfkggVEzbPm/SD3ibZWRBp31DnVnUCto
         wV+tFL5OBDX5NbLuOcDIhEHgWap/OQEu3sQBDgj79kHnyNwM0/6fdv1Gbveubxgb/G
         1CqfI6qzjuLp1K7iM/vjg4AsAaGFlOLYj1GJuMWxM1xCrd1NoKSPMQwbJz1u2ldCKQ
         9EKYGYTw32VNg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c94200b0000>; Fri, 22 Mar 2019 12:36:44 +1300
Received: from richardl-dl.ws.atlnz.lc (richardl-dl.ws.atlnz.lc [10.33.23.10])
        by smtp (Postfix) with ESMTP id EE91A13EC40;
        Fri, 22 Mar 2019 12:36:44 +1300 (NZDT)
Received: by richardl-dl.ws.atlnz.lc (Postfix, from userid 1481)
        id C5ABF4C05D3; Fri, 22 Mar 2019 12:36:44 +1300 (NZDT)
From:   Richard Laing <richard.laing@alliedtelesis.co.nz>
To:     rjui@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc:     linux-kernel@vger.kernel.org,
        Richard Laing <richard.laing@alliedtelesis.co.nz>
Subject: [PATCH] Add I2C recovery handling for bcm-iproc based devices.
Date:   Fri, 22 Mar 2019 12:35:27 +1300
Message-Id: <20190321233528.16568-1-richard.laing@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds I2C bus recovery support to the bcm-iproc I2C driver.
use the existing generic recovery mechanism by providing the hooks needed
to get and set the SCL and SDA lines.

The device must be placed in bit-bang mode before recovery starts and
returned to normal operation when complete.

Richard Laing (1):
  Add i2c recovery handling for bcm-iproc based devices.

 drivers/i2c/busses/i2c-bcm-iproc.c | 120 +++++++++++++++++++++++++++++++=
++++++
 1 file changed, 120 insertions(+)

--=20
2.1.4

