Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9489DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6579423429
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pRKUe+NH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfH2M3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:29:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38782 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfH2M3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:29:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7TCTDlM006209;
        Thu, 29 Aug 2019 12:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=ZwaW5u32DIdchmsLgCGFR9Gv4QDILMv0PoINBiFI9gU=;
 b=pRKUe+NHAsjffKU34frQv42lohqc8NrwjAz6T6ZytXK8jCRqu5CwkGnWFjdraLAefTNF
 RdUBUtq78+eY9xR0/IqDqTCSn7GCNk5trIJVDYH4O2Lts0fAwhhkz6zuk/4t5jLNFZD1
 Pqi/M2C1D6iKH3Qv1SkC3ZUQexUwNYzp+gQD93ldOQbApAcIJr7u4Zdykf7XcSIxaYmO
 CDvksh67QgylAF/nqqyj9bnDhJfwx5OMVYjkziwULCFMSeF5OzBlC1D2TwO7F0yongJE
 5qm9Wi8FDimfk50bHV49lqcGGWoRQ1qovB6W/1SByrz7NHuhQlBdJSgNWXtpvj2bfFlB nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2upem8g1xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 12:29:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7TCSDue032045;
        Thu, 29 Aug 2019 12:29:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2unvtyvw2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 12:29:17 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7TCSmIj005841;
        Thu, 29 Aug 2019 12:28:48 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Aug 2019 05:28:47 -0700
Date:   Thu, 29 Aug 2019 15:28:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rui Miguel Silva <rmfrfs@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: greybus: light: fix a couple double frees
Message-ID: <20190829122839.GA20116@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908290137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908290137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is in gb_lights_request_handler().  If we get a request to
change the config then we release the light with gb_lights_light_release()
and re-allocated it.  However, if the allocation fails part way through
then we call gb_lights_light_release() again.  This can lead to a couple
different double frees where we haven't cleared out the original values:

	gb_lights_light_v4l2_unregister(light);
	...
	kfree(light->channels);
	kfree(light->name);

I also made a small change to how we set "light->channels_count = 0;".
The original code handled this part fine and did not cause a use after
free but it was sort of complicated to read.

Fixes: 2870b52bae4c ("greybus: lights: add lights implementation")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/greybus/light.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index 010ae1e9c7fb..40680eaf3974 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -1098,21 +1098,21 @@ static void gb_lights_channel_release(struct gb_channel *channel)
 static void gb_lights_light_release(struct gb_light *light)
 {
 	int i;
-	int count;
 
 	light->ready = false;
 
-	count = light->channels_count;
-
 	if (light->has_flash)
 		gb_lights_light_v4l2_unregister(light);
+	light->has_flash = false;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < light->channels_count; i++)
 		gb_lights_channel_release(&light->channels[i]);
-		light->channels_count--;
-	}
+	light->channels_count = 0;
+
 	kfree(light->channels);
+	light->channels = NULL;
 	kfree(light->name);
+	light->name = NULL;
 }
 
 static void gb_lights_release(struct gb_lights *glights)
-- 
2.20.1

