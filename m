Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF33C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A9B2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfCLPCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:02:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726336AbfCLPCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:02:33 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2CEnGYw118365
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 11:02:32 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r6dejptxy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 11:02:18 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 12 Mar 2019 15:02:14 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Mar 2019 15:02:13 -0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2CF29BT55836784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 15:02:10 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA73613605D;
        Tue, 12 Mar 2019 15:02:09 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2580813604F;
        Tue, 12 Mar 2019 15:02:09 +0000 (GMT)
Received: from [9.60.75.235] (unknown [9.60.75.235])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 12 Mar 2019 15:02:08 +0000 (GMT)
Subject: Re: [PATCH v3] zcrypt: handle AP Info notification from CHSC SEI
 command
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        freude@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com,
        akrowiak@linux.vnet.ibm.com, oberpar@linux.ibm.com
References: <1550509295-1199-1-git-send-email-akrowiak@linux.ibm.com>
 <9224eca6-6d2c-7089-1fb2-618a04d7286b@linux.ibm.com>
 <alpine.LFD.2.21.1903111656170.8196@schleppi>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 12 Mar 2019 11:02:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1903111656170.8196@schleppi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19031215-0036-0000-0000-00000A9756C5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010745; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01173330; UDB=6.00613456; IPR=6.00953989;
 MB=3.00025946; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-12 15:02:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031215-0037-0000-0000-00004B013979
Message-Id: <6117b968-bb06-78e6-1687-9d03b1544099@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=707 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903120105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/19 11:57 AM, Sebastian Ott wrote:
> On Mon, 11 Mar 2019, Tony Krowiak wrote:
>> On 2/18/19 12:01 PM, Tony Krowiak wrote:
>>> The current AP bus implementation periodically polls the AP configuration
>>> to detect changes. When the AP configuration is dynamically changed via the
>>> SE or an SCLP instruction, the changes will not be reflected to sysfs until
>>> the next time the AP configuration is polled. The CHSC architecture
>>> provides a Store Event Information (SEI) command to make notification of an
>>> AP configuration change. This patch introduces a handler to process
>>> notification from the CHSC SEI command by immediately kicking off an AP bus
>>> scan-after-event.
>>
>> Ping
> 
> Applied.

Thank you Sebastian.

> 

