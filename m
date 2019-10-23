Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08C6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 01:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AEA207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 01:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="TFoKqTjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388505AbfJWB45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 21:56:57 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:44180 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727582AbfJWB44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 21:56:56 -0400
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9N1rN5u029356;
        Wed, 23 Oct 2019 02:55:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=jan2016.eng;
 bh=BqGmH2JxEqEbAiNxKXAPOoEeFbhaMLD6EHMMK5gsR7M=;
 b=TFoKqTjPSi3jM8T+9S17AYzdJGDKfA+EOIRNcdniE53+1eqrriNmmTtdT39ZAtcZ1UIg
 wZ34Semn3qYT30dMKJnVlN0cz/qj43SPXSwxtbBMtnGCp6oPVECwTfMBrlNSL6eYAgt9
 fiugceUovGL6gvEiMF+LsxVWLrk1WXLIRl6LLoHqIpD260jHJ6aI88rzLwmeTVIugU8Z
 ZiOC2cs0lNf5zs0ASNApb+4TCq5fp7kDI6PAnYGGEoNZlIvd+SGhXwGq54RtUmpK70AK
 H4lj/JN8gBd2IqpHoJucOUI+fRuWS0zF04o34E7yH1B8P1fDrLzwtzXL6PDxhe4tsjz6 dw== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 2vqthjjek3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 02:55:41 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x9N1lCuD024927;
        Tue, 22 Oct 2019 21:55:40 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.33])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2vqwtwq07e-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 21:55:40 -0400
Received: from USMA1EX-DAG1MB5.msg.corp.akamai.com (172.27.123.105) by
 usma1ex-dag1mb6.msg.corp.akamai.com (172.27.123.65) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Tue, 22 Oct 2019 21:55:39 -0400
Received: from usma1ex-cas4.msg.corp.akamai.com (172.27.123.57) by
 usma1ex-dag1mb5.msg.corp.akamai.com (172.27.123.105) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Tue, 22 Oct 2019 21:55:39 -0400
Received: from igorcastle.kendall.corp.akamai.com (172.29.170.135) by
 usma1ex-cas4.msg.corp.akamai.com (172.27.123.57) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Tue, 22 Oct 2019 18:55:39 -0700
Received: by igorcastle.kendall.corp.akamai.com (Postfix, from userid 29659)
        id 51C8F61E64; Tue, 22 Oct 2019 21:55:37 -0400 (EDT)
From:   Igor Lubashev <ilubashe@akamai.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     Igor Lubashev <ilubashe@akamai.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] perf kvm: Use evlist layer api when possible
Date:   Tue, 22 Oct 2019 21:54:53 -0400
Message-ID: <1571795693-23558-4-git-send-email-ilubashe@akamai.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571795693-23558-1-git-send-email-ilubashe@akamai.com>
References: <1571795693-23558-1-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-22_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=789
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910230015
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-23_01:2019-10-22,2019-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=776 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910230016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for layer violations when a proper evlist api is available.

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
---
 tools/perf/builtin-kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 5217aa3596c7..340927c2b243 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1005,7 +1005,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 		}
 
 		if (!rc && !done)
-			err = fdarray__poll(fda, 100);
+			err = evlist__poll(kvm->evlist, 100);
 	}
 
 	evlist__disable(kvm->evlist);
-- 
2.7.4

