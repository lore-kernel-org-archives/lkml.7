Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A330C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 17:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06497217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 17:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfI0RyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 13:54:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726294AbfI0RyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 13:54:16 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8RHs4Fo096683
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 13:54:14 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v9n1a4hx6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 13:54:14 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 27 Sep 2019 18:54:12 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Sep 2019 18:54:09 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8RHrfog39977304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 17:53:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA58442045;
        Fri, 27 Sep 2019 17:54:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DF8F42041;
        Fri, 27 Sep 2019 17:54:07 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.102.3.25])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 27 Sep 2019 17:54:06 +0000 (GMT)
Date:   Fri, 27 Sep 2019 23:24:05 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] tracing/probe: Test nr_args match in looking for same
 probe events
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20190927055035.4c3abae9@oasis.local.home>
 <20190927131458.GA19008@linux.vnet.ibm.com>
 <20190927105019.661591cd@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190927105019.661591cd@oasis.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-TM-AS-GCONF: 00
x-cbid: 19092717-0012-0000-0000-00000351631B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092717-0013-0000-0000-0000218BFF88
Message-Id: <20190927175405.GA7088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-27_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=839 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > This has a side-effect where the newer probe has same argument commands, we
> > still end up appending the probe.
> 
> ??
> 
> How so?
> 
> If the two have the same number of arguments we do exactly what we did
> before this patch. Please explain to me how that side effect would happen?
> 
> It basically is doing, "if the two probes do not have the same number
> of arguments, don't bother comparing, because they are different."
> 

Lets take the first probe has 3 arguments passed to it and the second probe
has just 2 arguments. If the first two arguments are same type, name, and
comm, should we append to the first probe? I think No, I would believe we
should append only if the comm of either of the arguments was different.

Example:
echo p:test _do_fork arg1=%ax arg2=%bx arg3=%cx >> kprobe_events

echo p:test _do_fork arg1=%ax arg2=%bx >> kprobe_events

