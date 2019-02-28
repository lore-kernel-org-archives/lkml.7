Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433F8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1048920854
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbfB1UN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:13:59 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:33250 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbfB1UN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:13:59 -0500
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SKAxUB000934;
        Thu, 28 Feb 2019 20:13:53 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0a-002e3701.pphosted.com with ESMTP id 2qxjw6u2tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Feb 2019 20:13:52 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id D146D66;
        Thu, 28 Feb 2019 20:13:51 +0000 (UTC)
Received: from misato.americas.hpqcorp.net (unknown [10.34.82.176])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 1AE5347;
        Thu, 28 Feb 2019 20:13:51 +0000 (UTC)
From:   Toshi Kani <toshi.kani@hpe.com>
To:     dan.j.williams@intel.com
Cc:     linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Robert Elliott <elliott@hpe.com>
Subject: [PATCH] update NFIT flags error message
Date:   Thu, 28 Feb 2019 13:12:18 -0700
Message-Id: <20190228201218.12501-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.17.2
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=568 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI NFIT flags field reports major errors on NVDIMM, which need
user's attention.

Update the current log to a proper error message with dev_err().
The current message string is kept for grep-compatibility.

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Robert Elliott <elliott@hpe.com>
---
 drivers/acpi/nfit/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index e18ade5d74e9..143a77704481 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2050,7 +2050,7 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
 		if ((mem_flags & ACPI_NFIT_MEM_FAILED_MASK) == 0)
 			continue;
 
-		dev_info(acpi_desc->dev, "%s flags:%s%s%s%s%s\n",
+		dev_err(acpi_desc->dev, "Error found in NVDIMM %s flags:%s%s%s%s%s\n",
 				nvdimm_name(nvdimm),
 		  mem_flags & ACPI_NFIT_MEM_SAVE_FAILED ? " save_fail" : "",
 		  mem_flags & ACPI_NFIT_MEM_RESTORE_FAILED ? " restore_fail":"",
