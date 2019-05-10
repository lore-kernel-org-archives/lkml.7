Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993B9C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DDE2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ydg8SGUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfEJL3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:29:42 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46776 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfEJL3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:29:42 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4ABOA2u175195;
        Fri, 10 May 2019 11:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=eFx0/1Sjq6T3wYnUN/0FMPpgas0ovyNplaKIzYVNF6o=;
 b=Ydg8SGUXnyhvgNBbEZ6dybDAAXpXcdTAsObYThByUJCYZyAxSA1/eeenONCuFh53EA5I
 Ltw9SiU03BHXSzy9/XnGOJ4tdZ/EaOEVdcE3F9b3jaUZ2Qboxcrdp/E2vwpnMHSWMypi
 aPixgq53vNJ49CY1IUvPi39dbRn/7FbvY1mZc8dbcvvLes7fWjORZd37J7pzl40ledLL
 OlcZCdizTtqxZwkmMfFu0GL+EzVYz5TCioXL8QeyOYwS0L+zC2bmEUEEil+0pBUQPWTa
 nj8+zH3FK/LiPu6l93nAqc2hVQvgNGadzubPgcBYlVSMNuSIDgerLw8a0aQ0AAOAHUug 8A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2s94b6gf11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 11:29:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4ABTP5a079567;
        Fri, 10 May 2019 11:29:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2schw0c9j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 11:29:31 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4ABTSV4013098;
        Fri, 10 May 2019 11:29:29 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 May 2019 04:29:28 -0700
Date:   Fri, 10 May 2019 14:29:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     QLogic-Storage-Upstream@cavium.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, mojha@codeaurora.org,
        skashyap@marvell.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: qedi: remove memset/memcpy to nfunc and use func
 instead
Message-ID: <20190510112920.GD18105@kadam>
References: <20190412094829.15868-1-colin.king@canonical.com>
 <20190420040554.41888-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420040554.41888-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=876
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905100081
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=922 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905100081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It took me a while to figure out that this is almost the same as Colin's
qedf patch but for qedi.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

