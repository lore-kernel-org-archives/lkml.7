Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608D5C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAAA205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="VX6iIDn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbfGPRCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 13:02:04 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:38910 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728495AbfGPRCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:02:04 -0400
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.27/8.16.0.27) with SMTP id x6GGvuZl014604;
        Tue, 16 Jul 2019 18:01:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=7gQqMuNYWO+yEB9XDR6J/mWwz7karJedcXgTGFaBj84=;
 b=VX6iIDn8xzLvk/DFMGBI/Pf2vc6gETpH7tFvZLiQHwQUsB480t3s7GxiPHDdH2WRhrtI
 M//hfdwWHFZK+uVA4up2v7UdEvj6lhFXSjxPbF9MR2YTmJQaQ6kYkqpKBCOMgyJSFNR/
 Hp1VdTIA76oe/X+y5ScZ/WCh9JSW59+fj1HFUiTr77WpCaveA/LYyi+MDZpW9vEjM7ng
 UjI8LBvp0omxFp6/XpRlO7LHbTiekQgqz/+i+hPSiYU3zbywu+NfWWcK8B1/GDzgWAp7
 DjR+XGGwXkklw9/LdRCaAy3aLVc5DvmKP+qdF8fLpqwrIAavx//VJxXTfZ3YG9GQXAhk mA== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 2tsa7j1tpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jul 2019 18:01:29 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x6GGknvk006091;
        Tue, 16 Jul 2019 13:01:28 -0400
Received: from email.msg.corp.akamai.com ([172.27.25.31])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2tqamw5b42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Jul 2019 13:01:28 -0400
Received: from USTX2EX-DAG1MB5.msg.corp.akamai.com (172.27.27.105) by
 ustx2ex-dag1mb5.msg.corp.akamai.com (172.27.27.105) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Tue, 16 Jul 2019 12:01:27 -0500
Received: from USTX2EX-DAG1MB5.msg.corp.akamai.com ([172.27.27.105]) by
 ustx2ex-dag1mb5.msg.corp.akamai.com ([172.27.27.105]) with mapi id
 15.00.1473.004; Tue, 16 Jul 2019 12:01:27 -0500
From:   "Lubashev, Igor" <ilubashe@akamai.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>
Subject: RE: [PATCH 2/3] perf: Use CAP_SYS_ADMIN with perf_event_paranoid
 checks
Thread-Topic: [PATCH 2/3] perf: Use CAP_SYS_ADMIN with perf_event_paranoid
 checks
Thread-Index: AQHVMTPFo1SW8Ha07Ua7MbRsBb5FgabNV64AgAAy/wA=
Date:   Tue, 16 Jul 2019 17:01:26 +0000
Message-ID: <cd2b162a59804cdaa7f4de18c3337aa8@ustx2ex-dag1mb5.msg.corp.akamai.com>
References: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
 <1562112605-6235-3-git-send-email-ilubashe@akamai.com>
 <20190716084744.GB22317@krava>
In-Reply-To: <20190716084744.GB22317@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.37.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160206
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I could add another patch to the series for that.  Any suggestion for what =
capability to check for here?

(There is always an alternative to not check for anything and let the kerne=
l refuse to perform actions that the user does not have permissions to perf=
orm.)

- Igor

-----Original Message-----
From: Jiri Olsa <jolsa@redhat.com>=20
Sent: Tuesday, July 16, 2019 4:48 AM
Subject: Re: [PATCH 2/3] perf: Use CAP_SYS_ADMIN with perf_event_paranoid c=
hecks

On Tue, Jul 02, 2019 at 08:10:04PM -0400, Igor Lubashev wrote:
> The kernel is using CAP_SYS_ADMIN instead of euid=3D=3D0 to override
> perf_event_paranoid check. Make perf do the same.

I see another geteuid check in __cmd_ftrace,
perhaps we should cover this one as well

jirka
