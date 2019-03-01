Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C53FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C2A2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbfCAP0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:26:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728234AbfCAP0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:26:36 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x21FKKPN083396
        for <linux-kernel@vger.kernel.org>; Fri, 1 Mar 2019 10:26:35 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qy534qd89-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 10:26:34 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Fri, 1 Mar 2019 15:26:33 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Mar 2019 15:26:30 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x21FQT9R24182984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Mar 2019 15:26:29 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17A24124054;
        Fri,  1 Mar 2019 15:26:29 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5313124062;
        Fri,  1 Mar 2019 15:26:27 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.80.228.140])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  1 Mar 2019 15:26:27 +0000 (GMT)
Subject: Re: [PATCH v2] scsi: smartpqi_init: Reporting 'logical unit failure'
From:   James Bottomley <jejb@linux.ibm.com>
To:     Erwan Velu <erwanaliasr1@gmail.com>, elliott@hpe.com
Cc:     Erwan Velu <e.velu@criteo.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:MICROSEMI SMART ARRAY SMARTPQI DRIVER (smartpqi)" 
        <esc.storagedev@microsemi.com>,
        "open list:MICROSEMI SMART ARRAY SMARTPQI DRIVER (smartpqi)" 
        <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 01 Mar 2019 07:26:27 -0800
In-Reply-To: <20190301145832.12735-1-e.velu@criteo.com>
References: <20190227163133.26283-1-e.velu@criteo.com>
         <20190301145832.12735-1-e.velu@criteo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19030115-0052-0000-0000-00000392F330
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010686; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01168108; UDB=6.00610299; IPR=6.00948723;
 MB=3.00025794; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-01 15:26:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030115-0053-0000-0000-0000600298A4
Message-Id: <1551453987.3334.2.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=585 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903010107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-01 at 15:58 +0100, Erwan Velu wrote:
> +			dev_err_ratelimited(&ctrl_info->pci_dev-
> >dev, "received 'logical unit failure' from controller for scsi
> %d:%d:%d:%d\n",
> +							ctrl_info-
> >scsi_host->host_no, device->bus,
> +							device-
> >target, device->lun);

Shouldn't this be a variant of sdev/scmd_printk?  Otherwise it tells
you what disk in the array terms is the problem but not what device in
your actual system is affected.

James

