Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84C8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B59206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfCKP5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:57:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726820AbfCKP5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:57:13 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BFsZM6070249
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 11:57:12 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r5rh6qwp4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 11:57:12 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sebott@linux.ibm.com>;
        Mon, 11 Mar 2019 15:57:06 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Mar 2019 15:57:04 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2BFv2tA61472970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Mar 2019 15:57:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8924811C054;
        Mon, 11 Mar 2019 15:57:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E32C611C04C;
        Mon, 11 Mar 2019 15:57:01 +0000 (GMT)
Received: from sig-9-145-10-72.uk.ibm.com (unknown [9.145.10.72])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Mar 2019 15:57:01 +0000 (GMT)
Date:   Mon, 11 Mar 2019 16:57:00 +0100 (CET)
From:   Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To:     Tony Krowiak <akrowiak@linux.ibm.com>
cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        freude@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com,
        akrowiak@linux.vnet.ibm.com, oberpar@linux.ibm.com
Subject: Re: [PATCH v3] zcrypt: handle AP Info notification from CHSC SEI
 command
In-Reply-To: <9224eca6-6d2c-7089-1fb2-618a04d7286b@linux.ibm.com>
References: <1550509295-1199-1-git-send-email-akrowiak@linux.ibm.com> <9224eca6-6d2c-7089-1fb2-618a04d7286b@linux.ibm.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Matthias?=
 =?ISO-8859-15?Q?_Hartmann_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 19031115-0020-0000-0000-000003214DFC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031115-0021-0000-0000-00002173734D
Message-Id: <alpine.LFD.2.21.1903111656170.8196@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=526 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903110114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019, Tony Krowiak wrote:
> On 2/18/19 12:01 PM, Tony Krowiak wrote:
> > The current AP bus implementation periodically polls the AP configuration
> > to detect changes. When the AP configuration is dynamically changed via the
> > SE or an SCLP instruction, the changes will not be reflected to sysfs until
> > the next time the AP configuration is polled. The CHSC architecture
> > provides a Store Event Information (SEI) command to make notification of an
> > AP configuration change. This patch introduces a handler to process
> > notification from the CHSC SEI command by immediately kicking off an AP bus
> > scan-after-event.
> 
> Ping

Applied.

