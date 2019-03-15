Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A307C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B8A218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfCOKSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:18:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727354AbfCOKSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:18:33 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2FA9epx057693
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:18:32 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r894k3j9n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:18:31 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Fri, 15 Mar 2019 10:18:30 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Mar 2019 10:18:26 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2FAIPdV51183642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Mar 2019 10:18:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A601842042;
        Fri, 15 Mar 2019 10:18:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A41C4204B;
        Fri, 15 Mar 2019 10:18:25 +0000 (GMT)
Received: from oc5311105230.ibm.com (unknown [9.145.23.208])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Mar 2019 10:18:25 +0000 (GMT)
Subject: Re: [PATCH] net: smc: fix a NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Karsten Graul <kgraul@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190315041555.1801-1-kjlu@umn.edu>
From:   Ursula Braun <ubraun@linux.ibm.com>
Openpgp: preference=signencrypt
Date:   Fri, 15 Mar 2019 11:18:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190315041555.1801-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19031510-0012-0000-0000-0000030336F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031510-0013-0000-0000-0000213A3892
Message-Id: <9887da6d-fc29-eedb-e172-a28edc3d1c4d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903150075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/19 5:15 AM, Kangjie Lu wrote:
> In case alloc_ordered_workqueue fails, the fix returns NULL
> to avoid NULL pointer dereference.
> 

Thanks, looks good. Your patch will be part of our next patch
submission for the net-tree.

Regards, Ursula

> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  net/smc/smc_ism.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> index 2fff79db1a59..e89e918b88e0 100644
> --- a/net/smc/smc_ism.c
> +++ b/net/smc/smc_ism.c
> @@ -289,6 +289,11 @@ struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
>  	INIT_LIST_HEAD(&smcd->vlan);
>  	smcd->event_wq = alloc_ordered_workqueue("ism_evt_wq-%s)",
>  						 WQ_MEM_RECLAIM, name);
> +	if (!smcd->event_wq) {
> +		kfree(smcd->conn);
> +		kfree(smcd);
> +		return NULL;
> +	}
>  	return smcd;
>  }
>  EXPORT_SYMBOL_GPL(smcd_alloc_dev);
> 

