Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F1EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73E42175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="KCuTHGGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfDXKUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:20:06 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54132 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728254AbfDXKUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:20:03 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OA6f7L003010;
        Wed, 24 Apr 2019 12:19:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=eDs1odzm2hVYJrKXjcUColLJgIeLynfPVayF+O9nGGI=;
 b=KCuTHGGWfPf66rp+HPVzXbS01KKoM5DYbW7VeE7WaSpTjpoq72gegFf6hgvjGh8EDj//
 Vk4JvDfeXmPWvgzl+Be6b7S7jGFyF6RBz7Fb7SlBJ+qV8U+aMw0ZChDYijJySCMPE8zD
 pleryYbTHeKHYnA64nMsHGg5tDlbm8NZwW5mVoBi6qmaxd8kanKxZ0C04cH9v9O2TVFd
 66X7RQAoC0Fic+d3Cbeauo/lryt64YO2p0pMPHDmyhQd5pjA2SzcnwN8CBUVCHjl+9vz
 NP7f7C6uC1gzzhoP44kJ2ERw2+C3cvGoka00WuZkCJNMFxAxsRZgAt4W5y1lWi/VN9Yv TQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytad5uah-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 12:19:51 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AF63F34;
        Wed, 24 Apr 2019 10:19:29 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7C050164C;
        Wed, 24 Apr 2019 10:19:29 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 24 Apr
 2019 12:19:29 +0200
Received: from localhost (10.201.20.122) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 24 Apr 2019 12:19:26
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <rafael.j.wysocki@intel.com>, <dmitry.torokhov@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <hadess@hadess.net>,
        <frowand.list@gmail.com>, <m.felsch@pengutronix.de>,
        <agx@sigxcpu.org>, <yannick.fertre@st.com>, <arnd@arndb.de>
CC:     <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <broonie@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 0/5] Add of_ functions for device_link_add()
Date:   Wed, 24 Apr 2019 12:19:08 +0200
Message-ID: <20190424101913.1534-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It could happen that we need to control suspend/resume ordering between
devices without obvious consumer/supplier link. For example when touchscreens
and DSI panels share the same reset line, in this case we need to be sure 
of pm_runtime operations ordering between those two devices to correctly
perform reset.
DSI panel and touchscreen aren't sharing any heriachical relationship (unlike
I2C client and I2C bus or regulator client and regulator provider) so we need
to describe this in device-tree.

This series introduce of_device_links_{add,remove} and devm_of_device_links_add()
helpers to find and parse 'links-add' property in a device-tree node.
It allows to create and remove links between consumer and suppliers from 
device-tree data so consumers will be suspend before their suppliers and resume 
after them.

Benjamin Gaignard (3):
  of/device: Add of_ functions for device_link_{add,remove}
  Input: edt-ft5x06: Document links-add property
  Input: goodix: Document links-add property

Yannick FertrÃ© (2):
  input: edt-ft5x06 - Call devm_of_device_links_add() to create links
  input: goodix - Call devm_of_device_links_add() to create links

 .../bindings/input/touchscreen/edt-ft5x06.txt      |   2 +
 .../bindings/input/touchscreen/goodix.txt          |   2 +
 drivers/input/touchscreen/edt-ft5x06.c             |   2 +
 drivers/input/touchscreen/goodix.c                 |   3 +
 drivers/of/device.c                                | 103 +++++++++++++++++++++
 include/linux/of_device.h                          |  20 ++++
 6 files changed, 132 insertions(+)

-- 
2.15.0

