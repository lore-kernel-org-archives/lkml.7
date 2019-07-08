Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC50C606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2E120844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbfGHO1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:27:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730062AbfGHO1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:27:45 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68ERKLD115629
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jul 2019 10:27:44 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tm60yvfds-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:27:43 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Mon, 8 Jul 2019 15:27:41 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Jul 2019 15:27:39 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x68ERcGF41550226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jul 2019 14:27:38 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C1D7A4054;
        Mon,  8 Jul 2019 14:27:38 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7927A405B;
        Mon,  8 Jul 2019 14:27:36 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon,  8 Jul 2019 14:27:36 +0000 (GMT)
Date:   Mon, 8 Jul 2019 19:57:36 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/topology: One function call less in
 build_group_from_child_sched_domain()
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <ad2e7dfb-3323-b214-716e-a6cae41b8bcc@web.de>
 <20190706172223.GA12680@linux.vnet.ibm.com>
 <65dedcbc-aefb-eb30-39e1-194248214369@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <65dedcbc-aefb-eb30-39e1-194248214369@metux.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19070814-4275-0000-0000-0000034A3964
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070814-4276-0000-0000-0000385A6110
Message-Id: <20190708142736.GC10675@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=797 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Enrico Weigelt, metux IT consult <lkml@metux.net> [2019-07-08 11:38:58]:

> > 
> > At runtime, Are we avoiding a function call?
> > However I think we are avoiding a branch instead of a conditional, which may
> > be beneficial.
> 
> If you're assuming the compiler doesn't already optimize that (no idea
> whether gcc really does that).
> 
> @Markus: could you check what gcc is actually generating out of both the
> old and your new version ?
> 
> 

I had already tried looking at the object files both on X86 and PowerPc and
in both cases (with and without patch) the generated code differs.

> --mtx
> 
> -- 
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
> 

-- 
Thanks and Regards
Srikar Dronamraju

