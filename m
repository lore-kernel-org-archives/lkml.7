Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F41CC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672B720679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="l8MZnwbc";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="T3/HR+pF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbfJIPWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:22:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4482 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731340AbfJIPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:21:59 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x99FJqe5024453;
        Wed, 9 Oct 2019 08:21:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RSwVoYYtqeQs0uAmApLtNxJN96yWZ5eQLOSAfu1Rjeo=;
 b=l8MZnwbcB7mn5jXy8IwMSnhfyOFX1WyiDvP4fm6NfVf6HBQ06aYBW41gQK4M/rcpKAk7
 t/zUE63EjX3gv3Wx7Z9kJUgAunMBOCvUc2RdKlb7/YDzk941pw9Gl+YwWXuAyXyxvwmy
 jxDZMQPKqlBAQ23BkpC2B1SekiunOj6h30s= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vgbjxj5w6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Oct 2019 08:21:45 -0700
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 9 Oct 2019 08:21:44 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 9 Oct 2019 08:21:44 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 9 Oct 2019 08:21:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UP05cgeKjvmgpxLLsGHgAhcPg0WTlVl3oLbPixiZCKkgSHIXpkXgvB3wUcCVvbIXbP7akuvYey61U0nZDRhA/hhogXthwNFKlxJUTlR8cknuWT+dZ0GMq7y8onFTIqJ3sWZ4HPRVAycoOcPnYOaZscceeVDFxg1HfyMlDlSHI99ku0OhQ3Ko1VskAjBayjJ9vYvDL1JVzVnDg832uv6zDCEUMbioGP2QLP9iAt/lTkjss8IR8viD0E0W9U+UILFWcSrDVMKld6ueFiN+uhMitaqo2VeRODWtXNw3XmSwQ7aFUdzZdSGghMhNoURpAjjsnYWQnPD0y6ZslS1KFNQlCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSwVoYYtqeQs0uAmApLtNxJN96yWZ5eQLOSAfu1Rjeo=;
 b=ZGxe3kwEUe2K0GkolfkBE22tnQb7LUXwtRhfv/TQN67I2BqKWA5QttWs56RCOEHU1NUS++su/jc7Ai8SRzHvYuZ+EMpTgoiJtZHOgnIZg++XfDF+toZGfvEQ3AmBrBqyDuC5QtWCmtIaR9x7xeo06zph4KGw8QmlF57zujJ5qg7JnCjT2MEN0bEyW59FlqDRoaw6FWyJbiqNLPzhh7sWyhlI9gwTxJB4aCibcY9SAuRTr4I7G3m7WNoN8C0WpuLn3cJcQ8ksiXz0y+Z0VWIWrXPlqdV4Hp2zBwP2kxLS7rUVu6D50YC+g+LdHSLqTkqn1h8wW4bmZI3Yt/iBrGQjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSwVoYYtqeQs0uAmApLtNxJN96yWZ5eQLOSAfu1Rjeo=;
 b=T3/HR+pFzcFE/CZ7ccAkBl1d4dVUAJsjZmHTgZTa8EElS2ME2kr+MAe8RZqKHgLREJ1ihsLZm+E96LOFLmZUGufns8+jFgtp1coVHdmVU5x3n1NvCFq+QqiD4aOarlgI0Tq18pTzYDwMDy24V2FTWMRZ36mK6s8gLI2YfxwWD0s=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3411.namprd15.prod.outlook.com (20.179.75.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 15:21:42 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4%5]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 15:21:42 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Tejun Heo <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>
Subject: Re: [PATCH] cgroup: freezer: call cgroup_enter_frozen() with
 preemption disabled in ptrace_stop()
Thread-Topic: [PATCH] cgroup: freezer: call cgroup_enter_frozen() with
 preemption disabled in ptrace_stop()
Thread-Index: AQHVfrKaoLG3P0+w5kG0208VkVoMq6dSbRUA
Date:   Wed, 9 Oct 2019 15:21:41 +0000
Message-ID: <20191009152136.GA19519@castle.dhcp.thefacebook.com>
References: <CADkTA4PBT374CY+UNb85WjQEaNCDodMZu=MgpG8aMYbAu2eOGA@mail.gmail.com>
 <20191009150230.GB12511@redhat.com>
In-Reply-To: <20191009150230.GB12511@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:300:16::30) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::7da4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 106cf5e9-b35e-45fc-9f9e-08d74ccc6338
x-ms-traffictypediagnostic: BN8PR15MB3411:
x-microsoft-antispam-prvs: <BN8PR15MB3411CF3C896DB8A754F8B6D0BE950@BN8PR15MB3411.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(136003)(396003)(39860400002)(199004)(189003)(14454004)(4744005)(386003)(486006)(25786009)(476003)(1076003)(11346002)(6116002)(478600001)(446003)(6506007)(102836004)(64756008)(66556008)(66476007)(66946007)(99286004)(66446008)(76176011)(52116002)(2906002)(186003)(46003)(7736002)(33656002)(305945005)(14444005)(6916009)(9686003)(6512007)(316002)(229853002)(6436002)(54906003)(8936002)(8676002)(6486002)(81166006)(81156014)(256004)(71190400001)(71200400001)(6246003)(86362001)(4326008)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3411;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d7xgJ4CftQJljvMhhSJAYVZds3DGy6j2b3ZvKwqoaY1T6HtwqjkgpTIHsDSx6FSKX3XBB6qF/74GpY18kHO8eRjlgZgW91ZQKFmvbFB+XYyiUR/f2KegkHFy2oKM51Lf2tHGv5vYn3GieSg9CXEeH1E/HpW0KLqJEw4GWXeE02FqgHxQ8c/uuEz/UhQYrgWEv+nL0YMgHi1zwmoo1uvwTDoB640TXm64hDJxjDJYVwlL5legzUA5yeyrNRf6T7g1jW+ctoZ/KOxrZnWwwlT7Jwqhd0QTsKmJYuT8+e471zLQA0ij1bmoQRgKRvdcDNa/K1Tzjgih0P+hcMP39fi7DqZsR8avTI8eVnGA3FvIwPY+sBoSvIrBnUwK5ikc4NDNleXBuJf3bNmS8rc5zPRxL+Tc/55F8sEBPf00MzKUWII=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <67F1D49F8697B644929005C8CFB08CD8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 106cf5e9-b35e-45fc-9f9e-08d74ccc6338
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 15:21:41.9997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VtPRD3LN+Zl5FO7i82cIXpcreBnS9kpyl/BL3TYRcQC0aVqjB0NhiI9Hsz5aOUWR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3411
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-09_07:2019-10-08,2019-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 mlxlogscore=876 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910090143
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 05:02:30PM +0200, Oleg Nesterov wrote:
> ptrace_stop() does preempt_enable_no_resched() to avoid the preemption,
> but after that cgroup_enter_frozen() does spin_lock/unlock and this adds
> another preemption point.
>=20
> Reported-and-tested-by: Bruce Ashfield <bruce.ashfield@gmail.com>
> Fixes: 76f969e8948d ("cgroup: cgroup v2 freezer")
> Cc: stable@vger.kernel.org # v5.2+
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 534fec2..f8eed86 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2205,8 +2205,8 @@ static void ptrace_stop(int exit_code, int why, int=
 clear_code, kernel_siginfo_t
>  		 */
>  		preempt_disable();
>  		read_unlock(&tasklist_lock);
> -		preempt_enable_no_resched();
>  		cgroup_enter_frozen();
> +		preempt_enable_no_resched();

Acked-by: Roman Gushchin <guro@fb.com>

Thank you!
