Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885B9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445092087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kF7VAyhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfCLA5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:57:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41814 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfCLA5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:57:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2C0o947093450;
        Tue, 12 Mar 2019 00:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=C1L8nGF8CywAim1Xy+fKWVkaCdIR02QASTJPE1EHPxs=;
 b=kF7VAyhifUJc2woIzoFHCV7naSli6nWiIl1ZBEOxEnJWH9sKa9+SUWK84y2MXgGtamvR
 FcjdIR1V348hb1SNnC1f4OPTzKV+jNpP+ObGw9URdvLgbFP57Pi/iXTwy/MUEF3HGV3S
 EOWoJKrtAIoi5aGqYvw5v2dV6yrsuybgHD0jlwtcT4ZaMPfQx249D76ZQX9aQM5UyzDN
 gcB6eAq0qH7fhdPkLfHCrMJG3Ed+ajfy2JoXF8/5IkyJXOa+ak5tpbj1kLHlBxw3ltle
 0wHHHTilf28U36/XrP1D7YLoIB6wkMvVXKVUSOTD1Y6Q/TR/38Ab4COOoEX1w8kEkzTT xA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2r44wu1n6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 00:57:08 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2C0v6ax024506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 00:57:07 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2C0v5O2019832;
        Tue, 12 Mar 2019 00:57:06 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 17:57:05 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-scsi@vger.kernel.org, qla2xxx-upstream@qlogic.com,
        linux-kernel@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        don.brace@microsemi.com, esc.storagedev@microsemi.com,
        dongli.zhang@oracle.com
Subject: [PATCH 0/4] scsi: cleanup hardcoding by replacing 0 by HCTX_TYPE_DEFAULT
Date:   Tue, 12 Mar 2019 09:00:27 +0800
Message-Id: <1552352431-18821-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9192 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=597 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903120004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As in commit 7d76f8562f4c ("blk-mq: use HCTX_TYPE_DEFAULT but not 0 to
index blk_mq_tag_set->map"), this patch set cleanup driver/scsi/* to index
blk_mq_tag_set->map[] with HCTX_TYPE_DEFAULT, but not 0.

 drivers/scsi/qla2xxx/qla_os.c         | 2 +-
 drivers/scsi/scsi_lib.c               | 2 +-
 drivers/scsi/smartpqi/smartpqi_init.c | 2 +-
 drivers/scsi/virtio_scsi.c            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

Dongli Zhang

