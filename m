Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9A4C4320D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6463721D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BE7llfCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404048AbfIYLCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 07:02:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39084 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbfIYLCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:02:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8PAsKrC087155;
        Wed, 25 Sep 2019 11:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=k2ILhHGus9NiOIfWnAl5oqk/Fo6x9w5ynxOn5hufDGA=;
 b=BE7llfCLlaWcANG1958urMQT4ONSqQxepfThJWGtwSCutAlSYnEZD6aikwSPk6zEPM+M
 tT9eiU724rtBrkRku/GO1qOUO6wwljBb/aJ+D+uuXlvKeRECxufnXwqIBnJQ8Fc7ZnJk
 XxsMZmRYR6jOy4Yz6Faymyk3LClp/uMb3IM7K4RcvZdZuewnPaDNrMfJCk333RZGlV2a
 fHDAZPmBVXGDvYz6vJOSK2nM7lxZESryZfgJL2v8yjEpSGFs6v2vg2qoGpx1RmCDfU/3
 f7483T7uQFoYT75CGHoporwopV92R9KWbr3F1jcPDXShznVRjaxCJqja9rm8lrnu/SfK 2g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2v5b9tuvup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 11:02:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8PAx23X047448;
        Wed, 25 Sep 2019 11:02:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2v82q99ye5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 11:02:28 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8PB2QmX009457;
        Wed, 25 Sep 2019 11:02:26 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Sep 2019 04:02:26 -0700
Date:   Wed, 25 Sep 2019 14:02:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] usb: typec: tcpm: Fix a signedness bug in tcpm_fw_get_caps()
Message-ID: <20190925110219.GN3264@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909250112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909250112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "port->typec_caps.data" and "port->typec_caps.type" variables are
enums and in this context GCC will treat them as an unsigned int so they
can never be less than zero.

Fixes: ae8a2ca8a221 ("usb: typec: Group all TCPCI/TCPM code together")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 96562744101c..d3b63e000ae2 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4410,7 +4410,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 	ret = fwnode_property_read_string(fwnode, "data-role", &cap_str);
 	if (ret == 0) {
 		port->typec_caps.data = typec_find_port_data_role(cap_str);
-		if (port->typec_caps.data < 0)
+		if ((int)port->typec_caps.data < 0)
 			return -EINVAL;
 	}
 
@@ -4419,7 +4419,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 		return ret;
 
 	port->typec_caps.type = typec_find_port_power_role(cap_str);
-	if (port->typec_caps.type < 0)
+	if ((int)port->typec_caps.type < 0)
 		return -EINVAL;
 	port->port_type = port->typec_caps.type;
 
-- 
2.20.1

