Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEEAC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FDE21473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jwZHi53V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfGBD6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:58:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52478 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfGBD6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:58:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x623sXQN076553;
        Tue, 2 Jul 2019 03:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=5V6Ca9D0YJtlxKjeGSEVk6eiy5PrcguTXF/8goZUOtg=;
 b=jwZHi53VieV6yeulA4hJuxbhy0IKh/zbqGEORo9cRu1QTJkWPNiuoJA6aze04HLjoeBi
 naZWX/mh8TbicbiOQg4g1iZgDI2PnkZ6ohuzNBEG5azuxNqa5Q6oC6AAu/oz1ATUXdQo
 poj19kjAD39o8DM1bU3Qp1Q0fyRgCioMdigrNUKeDi1dYcO07nihu8R/dSC45xb/QHYM
 j8tMkCblTOC/pmC5gC8NMYv2ZRwjNPv33wN1UnuhphBmJTCIPTeLBJHI/euTWUFL2BRU
 dksj+VGLV04M6LelazmSvLOLo7pSLq5o1vBgxLiqTysffG+wKkcgnnnusAsKYUBxmfKp 6Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2te61prvm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 03:57:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x623r96v078875;
        Tue, 2 Jul 2019 03:57:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tebku11n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 03:57:11 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x623v9xs025185;
        Tue, 2 Jul 2019 03:57:10 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 20:57:09 -0700
Date:   Mon, 1 Jul 2019 23:57:35 -0400
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH RESEND] Revert "x86/paravirt: Set up the
 virt_spin_lock_key after static keys get initialized"
Message-ID: <20190702035735.GC8003@bostrovs-us.us.oracle.com>
References: <1561539429-29436-1-git-send-email-zhenzhong.duan@oracle.com>
 <alpine.DEB.2.21.1906272322481.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906272322481.32342@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020041
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:24:41PM +0200, Thomas Gleixner wrote:
> On Wed, 26 Jun 2019, Zhenzhong Duan wrote:
> 
> > This reverts commit ca5d376e17072c1b60c3fee66f3be58ef018952d.
> > 
> > Commit 8990cac6e5ea ("x86/jump_label: Initialize static branching
> > early") adds jump_label_init() call in setup_arch() to make static
> > keys initialized early, so we could use the original simpler code
> > again.
> > 
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> 
> Boris,
> 
> want you to pick that up or should I?
> 
> In case you take it:
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>


We will take it via Xen tree, thanks.

-boris
