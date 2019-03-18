Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957B0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7192064A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfCRRpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:45:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727933AbfCRRpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:45:35 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2IHjUYo071343
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:45:33 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2raefk4fd0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:45:31 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Mon, 18 Mar 2019 17:44:57 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Mar 2019 17:44:54 -0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2IHitDp27656268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 17:44:55 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68FB96E04E;
        Mon, 18 Mar 2019 17:44:55 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2174C6E04C;
        Mon, 18 Mar 2019 17:44:54 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.131.215])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 18 Mar 2019 17:44:53 +0000 (GMT)
Subject: Re: [PATCH] scsi: lpfc_nvme: Fix wrong sizeof argument
From:   James Bottomley <jejb@linux.ibm.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Mar 2019 10:44:53 -0700
In-Reply-To: <20190318171505.GA8748@embeddedor>
References: <20190318171505.GA8748@embeddedor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19031817-0020-0000-0000-00000ECA4318
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010780; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01176223; UDB=6.00615206; IPR=6.00956908;
 MB=3.00026037; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-18 17:44:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031817-0021-0000-0000-000065220FDC
Message-Id: <1552931093.3203.25.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-18_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903180131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-18 at 12:15 -0500, Gustavo A. R. Silva wrote:
> sizeof() is currently using the wrong argument when used in a call to
> memset().  Notice that wqe is a pointer to union lpfc_wqe128, not to
> union lpfc_wqe.
> 
> Fix this by using union lpfc_wqe128 instead of lpfc_wqe as argument
> of sizeof().
> 
> Addresses-Coverity-ID: 1443938 ("Wrong sizeof argument")
> Fixes: 5fd1108517d9 ("scsi: lpfc: Streamline NVME Initiator WQE
> setup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/scsi/lpfc/lpfc_nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_nvme.c
> b/drivers/scsi/lpfc/lpfc_nvme.c
> index d16ca413110d..3dc0c85c7d50 100644
> --- a/drivers/scsi/lpfc/lpfc_nvme.c
> +++ b/drivers/scsi/lpfc/lpfc_nvme.c
> @@ -1981,7 +1981,7 @@ lpfc_get_nvme_buf(struct lpfc_hba *phba, struct
> lpfc_nodelist *ndlp,
>  		/* Fill in word 3 / sgl_len during cmd submission */
>  
>  		/* Initialize WQE */
> -		memset(wqe, 0, sizeof(union lpfc_wqe));
> +		memset(wqe, 0, sizeof(union lpfc_wqe128));

Actually the correct way to avoid potential problems like this is

	memset(wqe, 0, sizeof(*wqe));

James

