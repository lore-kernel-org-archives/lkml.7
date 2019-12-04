Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12F0C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDEC2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfLDWYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:24:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728053AbfLDWYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 17:24:40 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4MIGBk104081;
        Wed, 4 Dec 2019 17:24:33 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wpmjp9st3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 17:24:33 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xB4MJtRm011913;
        Wed, 4 Dec 2019 22:24:32 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 2wkg273h1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 22:24:32 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB4MOVtH19071394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Dec 2019 22:24:31 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB8EE78060;
        Wed,  4 Dec 2019 22:24:31 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF5FC7805E;
        Wed,  4 Dec 2019 22:24:31 +0000 (GMT)
Received: from localhost (unknown [9.41.179.251])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  4 Dec 2019 22:24:31 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH 2/3] powerpc/sysfs: Show idle_purr and idle_spurr for every CPU
In-Reply-To: <1574856072-30972-3-git-send-email-ego@linux.vnet.ibm.com>
References: <1574856072-30972-1-git-send-email-ego@linux.vnet.ibm.com> <1574856072-30972-3-git-send-email-ego@linux.vnet.ibm.com>
Date:   Wed, 04 Dec 2019 16:24:31 -0600
Message-ID: <87pnh3u3ts.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=1
 bulkscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> @@ -1067,6 +1097,8 @@ static int __init topology_init(void)
>  			register_cpu(c, cpu);
>  
>  			device_create_file(&c->dev, &dev_attr_physical_id);
> +			if (firmware_has_feature(FW_FEATURE_SPLPAR))
> +				create_idle_purr_spurr_sysfs_entry(&c->dev);

Architecturally speaking PURR/SPURR aren't strongly linked to the PAPR
SPLPAR option, are they? I'm not sure it's right for these attributes to
be absent if the platform does not support shared processor mode.
