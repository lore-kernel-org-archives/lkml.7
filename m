Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26636C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BEF20657
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V34ObfZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfCDPhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:37:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57916 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfCDPhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:37:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x24FSlaM101088;
        Mon, 4 Mar 2019 15:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ze7c7Ip+VLn5lQ9SGdkecFqbPBGWYqPFeRZSa/8f8N0=;
 b=V34ObfZtY3w/sMYp8jRd6BSYLWT6IUlrno6Iea2h8ZHJb84HsWqPRsPQXFZJQ5FQFVyD
 Bkiok/yN48JHLRxD6w3mP4Y67IZ8qwujZcj6XRLolY7LtFrttwbikF0+EUG3mNPvNKmE
 QhK5sgPy9A12dChkO+kQFRBFKC3/S1HrIlfdwifUhvm0+vxToHUq+wwWYXHb73E1LA8q
 0XEBJq70lOg2gd6lmyY8qcRSoeIMkfm4JAD7QrhhBTqZUbGb5hcjbdvmzwuNq/RgpiYW
 DKrEp3xqcMjdgZOAYQnJ6Hy6jm2p7CxujTgfKiRoDLfV/29sbsxc3+tX5FI+6NK2j5Oi jg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qyh8tyj7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Mar 2019 15:37:25 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x24FbOvo027884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Mar 2019 15:37:24 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x24FbNrr014364;
        Mon, 4 Mar 2019 15:37:23 GMT
Received: from kadam (/197.157.34.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Mar 2019 07:37:22 -0800
Date:   Mon, 4 Mar 2019 18:37:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     erico.nunes@datacom.ind.br, wsa@the-dreams.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: KASAN: i2c dev use after free
Message-ID: <20190304153714.GD13452@kadam>
References: <CADYN=9KkjPSP4KJ+AzG=Njq49zJ5fbWNZ4V_jOvHkq_kt0biyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYN=9KkjPSP4KJ+AzG=Njq49zJ5fbWNZ4V_jOvHkq_kt0biyA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9184 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903040113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wasn't trying to fix anything so complicated as this, it was a
more obvious use after free.  It does feel intuitively that we should
call device_destroy() before the cdev_del() so that it's in the reverse
order from how it was allocated but I don't see any reason to think
that will make a difference.

---
 drivers/i2c/i2c-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 3f7b9af11137..7e85e2cf26c1 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -687,9 +687,9 @@ static int i2cdev_detach_adapter(struct device *dev, void *dummy)
 	if (!i2c_dev) /* attach_adapter must have failed */
 		return 0;
 
+	device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
 	cdev_del(&i2c_dev->cdev);
 	put_i2c_dev(i2c_dev);
-	device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
 
 	pr_debug("i2c-dev: adapter [%s] unregistered\n", adap->name);
 	return 0;
-- 
2.17.1

