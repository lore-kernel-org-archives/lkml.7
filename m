Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41279C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D9820835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407616AbfIWRmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 13:42:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394159AbfIWRmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:42:15 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8NHg12Y006151
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:42:14 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v71pc22v7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:42:13 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Mon, 23 Sep 2019 18:42:11 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Sep 2019 18:42:08 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8NHg7Pf39649516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 17:42:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA94111C04C;
        Mon, 23 Sep 2019 17:42:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DA3411C052;
        Mon, 23 Sep 2019 17:42:05 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.85.91.202])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 23 Sep 2019 17:42:04 +0000 (GMT)
Date:   Mon, 23 Sep 2019 23:12:04 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [for-next][PATCH 7/8] tracing/probe: Reject exactly same probe
 event
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20190919232313.198902049@goodmis.org>
 <20190919232400.470062819@goodmis.org>
 <20190923102035.GA30095@linux.vnet.ibm.com>
 <20190923101526.a1a9ccde50da83fbdc86aad8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190923101526.a1a9ccde50da83fbdc86aad8@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-TM-AS-GCONF: 00
x-cbid: 19092317-0020-0000-0000-00000370A81C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092317-0021-0000-0000-000021C664DA
Message-Id: <20190923174204.GA3721@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909230157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think we need something like this:
> > 
> > 	list_for_each_entry(pos, &tpe->probes, list) {
> > 		orig = container_of(pos, struct trace_kprobe, tp);
> > 		if (strcmp(trace_kprobe_symbol(orig),
> > 			   trace_kprobe_symbol(comp)) ||
> > 		    trace_kprobe_offset(orig) != trace_kprobe_offset(comp))
> > 			continue;
> > 
> > 		/*
> > 		 * trace_probe_compare_arg_type() ensured that nr_args and
> > 		 * each argument name and type are same. Let's compare comm.
> > 		 */
> > 		for (i = 0; i < orig->tp.nr_args; i++) {
> > 			if (strcmp(orig->tp.args[i].comm,
> > 				   comp->tp.args[i].comm))
> > 				goto outer_loop;
> > 
> > 		}
> > 
> > 		return true;
> > outer_loop:
> > 	}
> 
> Correct, that's what I intended.
> Could you make a fix patch on top of it? (or do I?)
> 
> Thank you,

Either way is fine. I can send out a patch tomorrow. But fine if you beat
me to it.

-- 
Thanks and Regards
Srikar Dronamraju

