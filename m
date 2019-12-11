Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41909C2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 03:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1897A206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 03:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L/WpBq9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfLKDhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 22:37:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57202 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfLKDhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 22:37:23 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBB3P45C153230;
        Wed, 11 Dec 2019 03:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=Pk8yzQhSfRv+UdtIPQBqczRUvP3c/3wYixQrmDvJIdM=;
 b=L/WpBq9Hcq0ugPV1O6/fkNdSOkjvoPjiBaKCrgETfqi5G985g5eFUAWdur6G0cJOadI2
 uTUEbGojG/uXUR9hjJJkBHnYXchQ8qLr5KcI3LJXR5Y7ILAlJP7qZqvIa7mGieN6V403
 iYtydiidgRCmCftDycVQOzqU76nRynC4oFvZqy3uzo8yz/8iQ857Bn11zXSOaSPvGw4b
 gGr1Hch0NEhxPH5CTiPpSAIgBWn1thZ/pGQiqmLguQGv2FyqXFd6+mQypfkgjpInDsiG
 sH8euVo2qVR6m1d1yjuvL4ax7O2m/vcpR/gRQwTTgyqEwLHpqv1LEinfSlvohoKNs8JA ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wrw4n6ue4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 03:36:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBB3NtNP083739;
        Wed, 11 Dec 2019 03:36:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wtqg8jh38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 03:36:02 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBB3ZrJQ004814;
        Wed, 11 Dec 2019 03:35:58 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Dec 2019 19:35:53 -0800
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Shane M Seymour <shane.seymour@hpe.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH tip/core/rcu 01/12] rcu: Remove rcu_swap_protected()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
        <20191210040741.2943-1-paulmck@kernel.org>
Date:   Tue, 10 Dec 2019 22:35:49 -0500
In-Reply-To: <20191210040741.2943-1-paulmck@kernel.org> (paulmck@kernel.org's
        message of "Mon, 9 Dec 2019 20:07:30 -0800")
Message-ID: <yq1a77zmt4a.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912110030
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912110030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul,

> Now that the calls to rcu_swap_protected() have been replaced by
> rcu_replace_pointer(), this commit removes rcu_swap_protected().

It appears there are two callers remaining in Linus' master. Otherwise
looks good to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
