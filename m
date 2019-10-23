Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BA6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 01:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CCC207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 01:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="SGGDphKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbfJWB4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 21:56:54 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:7828 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727582AbfJWB4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 21:56:53 -0400
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9N1sMou012792;
        Wed, 23 Oct 2019 02:55:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=jan2016.eng;
 bh=RsjkaC/U3EOJj+mL7fckMBUMFkrUAndFdH2o3b4CphE=;
 b=SGGDphKDb0oEcBd9A3qPq4t3rCjOhznEkkN7zSXlox7DWiVZDRrp96YJfQAHy8l+ysZW
 8gM6DVLH2HraADFrJ16s5MF5S5s4Jc/VQU2824/DR9SzrsEdIsSrYrk9Z/BZXxeNU+Ea
 Pe8GHDn9TNqVn5vDCTh/ogJbNEU5Gjb2wM8pT62fiPMbcr2Db6YpdTWNW6no/NoVielL
 cyCIOKl5PZsnXlgtZf3m6f5KcFAN2f8/EugGudawA4yU7WSmyOfjyahewegho4JiyKIR
 sGbh4egLhsFLg67XXqUwTJwVlc49wbyT0RBhTjdMgRcBikw+u5m+uy+LodeeKfwt+HQw 0A== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 2vqt4v0rab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 02:55:41 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x9N1lCuC024927;
        Tue, 22 Oct 2019 21:55:40 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.33])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2vqwtwq07e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 21:55:40 -0400
Received: from USMA1EX-DAG1MB5.msg.corp.akamai.com (172.27.123.105) by
 usma1ex-dag1mb6.msg.corp.akamai.com (172.27.123.65) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Tue, 22 Oct 2019 21:55:39 -0400
Received: from USMA1EX-CAS2.msg.corp.akamai.com (172.27.123.31) by
 usma1ex-dag1mb5.msg.corp.akamai.com (172.27.123.105) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Tue, 22 Oct 2019 21:55:39 -0400
Received: from igorcastle.kendall.corp.akamai.com (172.29.170.135) by
 USMA1EX-CAS2.msg.corp.akamai.com (172.27.123.31) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Tue, 22 Oct 2019 21:55:39 -0400
Received: by igorcastle.kendall.corp.akamai.com (Postfix, from userid 29659)
        id 4E88661DCB; Tue, 22 Oct 2019 21:55:37 -0400 (EDT)
From:   Igor Lubashev <ilubashe@akamai.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     Igor Lubashev <ilubashe@akamai.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] perf: Allow running without stdin
Date:   Tue, 22 Oct 2019 21:54:50 -0400
Message-ID: <1571795693-23558-1-git-send-email-ilubashe@akamai.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-22_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=853
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910230015
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-23_01:2019-10-22,2019-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=836 lowpriorityscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910230016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series allows perf to run in batch mode with stdin closed.
This is arguably a bug fix for code that runs with --stdio option and does not
check for EOF return code from getc().

This series makes the following work as expected:

  $ perf top --stdio < /dev/null
  $ perf kvm top --stdio < /dev/null

Patches:
  01: perf top: Allow running without stdin
    Make "perf top --stdio" handle EOF from stdin correctly.
    There is one getc() that does not handle EOF explicitly, since its return
    value is checked against a list of known characters, and the main loop in
    display_thread() will handle the EOF on the next iteration.

  02: perf kvm: Allow running without stdin
    Make "perf kvm --stdio" handle EOF from stdin correctly.

  03: perf kvm: Use evlist layer api when possible
    This is a simple fix for a needless layering violation.

Igor Lubashev (3):
  perf top: Allow running without stdin
  perf kvm: Allow running without stdin
  perf kvm: Use evlist layer api when possible

 tools/perf/builtin-kvm.c | 35 +++++++++++++++++++++--------------
 tools/perf/builtin-top.c | 10 ++++++++--
 2 files changed, 29 insertions(+), 16 deletions(-)

-- 
2.7.4

