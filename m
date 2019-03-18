Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08C2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7AD20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfCRPk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:40:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726990AbfCRPk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:40:56 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2IFdBNK069633
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 11:40:54 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ractyvan6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 11:40:54 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 18 Mar 2019 15:40:53 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Mar 2019 15:40:50 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2IFen1d22020162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 15:40:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDD2FB206C;
        Mon, 18 Mar 2019 15:40:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0887B2064;
        Mon, 18 Mar 2019 15:40:49 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 18 Mar 2019 15:40:49 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2EDB516C33E6; Mon, 18 Mar 2019 08:41:38 -0700 (PDT)
Date:   Mon, 18 Mar 2019 08:41:38 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Nikos Tsironis <ntsironis@arrikto.com>
Cc:     snitzer@redhat.com, agk@redhat.com, dm-devel@redhat.com,
        mpatocka@redhat.com, hch@infradead.org, iliastsi@arrikto.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] list_bl: Add hlist_bl_add_before/behind helpers
Reply-To: paulmck@linux.ibm.com
References: <20190317122258.21760-1-ntsironis@arrikto.com>
 <20190317122258.21760-3-ntsironis@arrikto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190317122258.21760-3-ntsironis@arrikto.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031815-0060-0000-0000-0000031E1993
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010780; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01176182; UDB=6.00615181; IPR=6.00956866;
 MB=3.00026033; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-18 15:40:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031815-0061-0000-0000-000048A63263
Message-Id: <20190318154138.GI4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-18_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903180116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 02:22:54PM +0200, Nikos Tsironis wrote:
> Add hlist_bl_add_before/behind helpers to add an element before/after an
> existing element in a bl_list.
> 
> Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
> Signed-off-by: Ilias Tsitsimpis <iliastsi@arrikto.com>

On both this and the previous patch, the double signed-off-by lines
are a bit strange.  You might be wanting Co-developed-by, but please
see Documentation/process/submitting-patches.rst.

Other than that:

Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>

> ---
>  include/linux/list_bl.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
> index 3fc2cc57ba1b..ae1b541446c9 100644
> --- a/include/linux/list_bl.h
> +++ b/include/linux/list_bl.h
> @@ -86,6 +86,32 @@ static inline void hlist_bl_add_head(struct hlist_bl_node *n,
>  	hlist_bl_set_first(h, n);
>  }
>  
> +static inline void hlist_bl_add_before(struct hlist_bl_node *n,
> +				       struct hlist_bl_node *next)
> +{
> +	struct hlist_bl_node **pprev = next->pprev;
> +
> +	n->pprev = pprev;
> +	n->next = next;
> +	next->pprev = &n->next;
> +
> +	/* pprev may be `first`, so be careful not to lose the lock bit */
> +	WRITE_ONCE(*pprev,
> +		   (struct hlist_bl_node *)
> +			((uintptr_t)n | ((uintptr_t)*pprev & LIST_BL_LOCKMASK)));
> +}
> +
> +static inline void hlist_bl_add_behind(struct hlist_bl_node *n,
> +				       struct hlist_bl_node *prev)
> +{
> +	n->next = prev->next;
> +	n->pprev = &prev->next;
> +	prev->next = n;
> +
> +	if (n->next)
> +		n->next->pprev = &n->next;
> +}
> +
>  static inline void __hlist_bl_del(struct hlist_bl_node *n)
>  {
>  	struct hlist_bl_node *next = n->next;
> -- 
> 2.11.0
> 

