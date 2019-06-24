Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C8DC4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A636020665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfFXWDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:03:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726468AbfFXWDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:03:50 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OLv4KF098970
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 18:03:48 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tb5f6ke6r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 18:03:48 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Mon, 24 Jun 2019 23:03:47 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Jun 2019 23:03:44 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5OM3hOc61342108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 22:03:43 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC233780AF;
        Mon, 24 Jun 2019 22:03:43 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFB65780AE;
        Mon, 24 Jun 2019 22:03:41 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.209.86])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 24 Jun 2019 22:03:41 +0000 (GMT)
References: <20190624062331.388-1-prsriva02@gmail.com> <20190624062331.388-3-prsriva02@gmail.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, vgoyal@redhat.com
Subject: Re: [PATCH V10 2/3] IMA: Define a new template field buf
In-reply-to: <20190624062331.388-3-prsriva02@gmail.com>
Date:   Mon, 24 Jun 2019 19:03:35 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19062422-0016-0000-0000-000009C6A200
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011323; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01222783; UDB=6.00643436; IPR=6.01003943;
 MB=3.00027451; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-24 22:03:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062422-0017-0000-0000-000043C5516A
Message-Id: <87ftnyk5e0.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Prakhar,

Prakhar Srivastava <prsriva02@gmail.com> writes:

> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> index 00dd5a434689..a01a17e5c581 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -26,6 +26,7 @@ static struct ima_template_desc builtin_templates[] = {
>  	{.name = IMA_TEMPLATE_IMA_NAME, .fmt = IMA_TEMPLATE_IMA_FMT},
>  	{.name = "ima-ng", .fmt = "d-ng|n-ng"},
>  	{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
> +	{.name = "ima-buf", .fmt = "d-ng|n-ng|buf"},
>  	{.name = "", .fmt = ""},	/* placeholder for a custom format */
>  };
>
> @@ -43,6 +44,8 @@ static const struct ima_template_field supported_fields[] = {
>  	 .field_show = ima_show_template_string},
>  	{.field_id = "sig", .field_init = ima_eventsig_init,
>  	 .field_show = ima_show_template_sig},
> +	{.field_id = "buf", .field_init = ima_eventbuf_init,
> +	 .field_show = ima_show_template_buf},
>  };
>  #define MAX_TEMPLATE_NAME_LEN 15

Currently, MAX_TEMPLATE_NAME_LEN is the length of a template that
contains all valid fields. It may make sense to increase it since
there's a new field being added.

I suggest using a sizeof() to show where the number comes from (and
which can be visually shown to be correct):

#define MAX_TEMPLATE_NAME_LEN sizeof("d|n|d-ng|n-ng|sig|buf")

The sizeof() is calculated at compile time.

--
Thiago Jung Bauermann
IBM Linux Technology Center

