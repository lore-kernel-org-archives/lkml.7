Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6571C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9721D206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfHSOR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:17:27 -0400
Received: from mx0a-002e3702.pphosted.com ([148.163.133.112]:37352 "EHLO
        mx0a-002e3702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726670AbfHSOR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:17:26 -0400
X-Greylist: delayed 4839 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Aug 2019 10:17:26 EDT
Received: from pps.filterd (m0171835.ppops.net [127.0.0.1])
        by mx0a-002e3702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JCtAnC018043
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:56:47 GMT
Received: from g9t1613g.houston.hpe.com (g9t1613g.houston.hpe.com [15.241.32.99])
        by mx0a-002e3702.pphosted.com with ESMTP id 2ue7c8rgvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:56:47 +0000
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id B247860590
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:56:46 +0000 (UTC)
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 846B14E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:56:46 +0000 (UTC)
Received: from hpe.com (teo-eag.americas.hpqcorp.net [10.33.152.10])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 67EC148
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:56:46 +0000 (UTC)
Received: from AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:910:74::24) by CS1PR8401MB0375.NAMPRD84.PROD.OUTLOOK.COM with
 HTTPS via CY4PR1801CA0011.NAMPRD18.PROD.OUTLOOK.COM; Mon, 19 Aug 2019
 12:56:24 +0000
Received: from CS1PR8401CA0072.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7504::34) by AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7425::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Mon, 19 Aug
 2019 12:56:24 +0000
Received: from CO1NAM03FT036.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::200) by CS1PR8401CA0072.outlook.office365.com
 (2a01:111:e400:7504::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2178.16 via Frontend
 Transport; Mon, 19 Aug 2019 12:56:24 +0000
Received-SPF: Neutral (protection.outlook.com: 15.219.147.16 is neither
 permitted nor denied by domain of hpe.com)
Received: from G1W8108.americas.hpqcorp.net (15.219.147.16) by
 CO1NAM03FT036.mail.protection.outlook.com (10.152.80.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2178.16 via Frontend Transport; Mon, 19 Aug 2019 12:56:23 +0000
Received: from G2W6309.americas.hpqcorp.net (2002:10c5:4033::10c5:4033) by
 G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Mon, 19 Aug 2019 12:56:12 +0000
Received: from g9t2301.houston.hpecorp.net (16.220.97.129) by
 G2W6309.americas.hpqcorp.net (16.197.64.51) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 19 Aug 2019 12:56:12 +0000
Received: from hpe.com (teo-eag.americas.hpqcorp.net [10.33.152.10])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 824F04A;
        Mon, 19 Aug 2019 12:56:11 +0000 (UTC)
Date:   Mon, 19 Aug 2019 07:56:11 -0500
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     Bharath Vedartham <linux.bhar@gmail.com>
CC:     <sivanich@hpe.com>, <jhubbard@nvidia.com>, <jglisse@redhat.com>,
        <ira.weiny@intel.com>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <william.kucharski@oracle.com>, <hch@lst.de>,
        <inux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-kernel-mentees][PATCH v6 1/2] sgi-gru: Convert put_page()
 to put_user_page*()
Message-ID: <20190819125611.GA5808@hpe.com>
References: <1566157135-9423-1-git-send-email-linux.bhar@gmail.com>
 <1566157135-9423-2-git-send-email-linux.bhar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566157135-9423-2-git-send-email-linux.bhar@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-OrganizationHeadersPreserved: G1W8108.americas.hpqcorp.net
X-MS-Exchange-Organization-ExpirationStartTime: 19 Aug 2019 12:56:23.9216
 (UTC)
X-MS-Exchange-Organization-ExpirationStartTimeReason: OriginalSubmit
X-MS-Exchange-Organization-ExpirationInterval: 1:00:00:00.0000000
X-MS-Exchange-Organization-ExpirationIntervalReason: OriginalSubmit
X-MS-Exchange-Organization-Network-Message-Id: ae2c6a4d-c226-4882-1939-08d724a4a3e6
X-EOPAttributedMessage: 0
X-MS-Exchange-Organization-MessageDirectionality: Originating
X-MS-Exchange-Organization-AuthSource: G2W6309.americas.hpqcorp.net
X-MS-Exchange-Organization-AuthAs: Internal
X-MS-Exchange-Organization-AuthMechanism: 10
X-CrossPremisesHeadersPromoted: CO1NAM03FT036.eop-NAM03.prod.protection.outlook.com
X-CrossPremisesHeadersFiltered: CO1NAM03FT036.eop-NAM03.prod.protection.outlook.com
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:15.219.147.16;IPV:NLI;CTRY:US;EFV:NLI;SFV:SKI;SFS:;DIR:INB;SFP:;SCL:-1;SRVR:AT5PR8401MB0371;H:G1W8108.americas.hpqcorp.net;FPR:;SPF:None;LANG:en;
X-OriginatorOrg: hpe.onmicrosoft.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae2c6a4d-c226-4882-1939-08d724a4a3e6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:AT5PR8401MB0371;
X-MS-TrafficTypeDiagnostic: AT5PR8401MB0371:
X-MS-Oob-TLC-OOBClassifiers: OLM:230;
X-MS-Exchange-Organization-SCL: -1
X-MS-Exchange-ABP-GUID: 02950aeb-3c14-4da5-8c60-ccbcc3967284
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2019 12:56:23.7865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2c6a4d-c226-4882-1939-08d724a4a3e6
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=105b2061-b669-4b31-92ac-24d304d195dc;Ip=[15.219.147.16];Helo=[G1W8108.americas.hpqcorp.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0371
X-MS-Exchange-Transport-EndToEndLatency: 00:00:01.0764555
X-MS-Exchange-Processed-By-BccFoldering: 15.20.2178.000
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;ex:0;auth:0;dest:I;ENG:(750119)(520011016)(706158)(944506383)(944626516);
X-Microsoft-Antispam-Message-Info: YeEsH6FDG9X/ZrVDstwmW+IjrPdqgNP7yfYfBbcSPZ6Z/ZIcWX+Qk4Me3vUTbMFzMAj7y66pWzZ5//Lh7a1wCa88Q6tp/NODn0XhS2+SMvNTKsCxaDcrmkvTYM6VE+S9eHx7teu41bW0yD1EF007oAGQpwhLxHgPfStCthJisT6wnxCPs+VaQ8vCv20NzwrxBcU0NmO0LU3rQk8Bl/wS2CxHGb8nKaTeC8WQeZ+DznfQyVSTFiORZnPYY6iReRSpBuSxWr/YmMdbEwK2WIO8LirCv/fF0MyneySLGvkEPkaYoY5HJujYzitIfLbVCBUHRSG9oJUk86eSFRrKsYSWT0r8KpCAT0l1160RdD1fWreK/5p3oELo0mzAFDEV/0b4itcyh/kq5TdnF0OrY1YTAxmKuUlzomwZeiJlMNanOEwa6EH/RsKbp22/PY4PvaLV
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908190147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20190819125611.hQ2y_TH9n2u2oOB34HQUV6gc8Wq8qMWlDXc490B_pGM@z>

Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>

On Mon, Aug 19, 2019 at 01:08:54AM +0530, Bharath Vedartham wrote:
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page() or
> release_pages().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").
> 
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Dimitri Sivanich <sivanich@sgi.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: William Kucharski <william.kucharski@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel-mentees@lists.linuxfoundation.org
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  drivers/misc/sgi-gru/grufault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> index 4b713a8..61b3447 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -188,7 +188,7 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
>  	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
>  		return -EFAULT;
>  	*paddr = page_to_phys(page);
> -	put_page(page);
> +	put_user_page(page);
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 
