Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02308C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C377820578
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfEHK4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:56:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40544 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725910AbfEHK4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:56:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x48AmCkb060607
        for <linux-kernel@vger.kernel.org>; Wed, 8 May 2019 06:56:35 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sbvj8c0ed-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 06:56:34 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 8 May 2019 11:56:32 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 May 2019 11:56:30 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x48AuTRm56754200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 May 2019 10:56:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9C1742047;
        Wed,  8 May 2019 10:56:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80B8642042;
        Wed,  8 May 2019 10:56:29 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  8 May 2019 10:56:29 +0000 (GMT)
Date:   Wed, 8 May 2019 12:56:28 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        David Arcari <darcari@redhat.com>
Subject: Re: [PATCH v2] modules: Only return -EEXIST for modules that have
 finished loading
References: <20190507145413.16297-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507145413.16297-1-prarit@redhat.com>
X-TM-AS-GCONF: 00
x-cbid: 19050810-4275-0000-0000-0000033297F3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050810-4276-0000-0000-000038420669
Message-Id: <20190508105628.GC4102@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=739 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905080070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prarit,

On Tue, May 07, 2019 at 10:54:13AM -0400, Prarit Bhargava wrote:
> Heiko, it would still be good to get a test of this patch from you.  I
> tested this here at Red Hat on some System Z machines.  Without the
> modification made here in v2, the systems failed to boot ~10% of the time.
> After the modification I do not see any boot failures.  I also was
> able to reproduce the boot issue with the acpi_cpufreq driver on a very
> large & fast x86 system which had closer to 100% failure rate without
> the changes in v2.  After the modification in v2 the system has rebooted
> all weekend without any issues.

I gave it a try on a machine that failed quite reliably with your
first patch (the one that was in linux-next and caused problems on
s390) - it now comes up without any issues. Also a machine with 80
CPUs (+SMT2 -> 160 CPUs) comes up without problems.

So everything seems to work. Thanks!

