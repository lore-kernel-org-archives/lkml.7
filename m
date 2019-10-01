Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E918C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E103521855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K5qq1ykN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732568AbfJALoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:44:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42934 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfJALoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:44:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91BdPOA108493;
        Tue, 1 Oct 2019 11:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=lnG8BPnD8/6NBUc+rdead5ZSBxoJDpmqlmAuxokp6ew=;
 b=K5qq1ykNGM47h3h3GrvkRvm75Pz6r9gTAUhYA/YsPo/4MUd/2Z+J62R1xZsR1k02jWVW
 QqRVwJxLfc/GKSMcFGvu5B620UbRdQQtPiK2v8Jqk2ie6n46yVJdot4qEWEBzHdQ2e+d
 klqH2Qy+MlROrjUZv1agAvRPHz/d67eewh7T86Y6V1tjdenal6F9xCZhSBlkc2Qb8nWM
 RIV+lhx6DrV+Ceg+QFBbocK5FBoHWDpCUAY+X/lsTqmsm4bhwEzj2sJmKXiONUsy52Xi
 3Mf5P+DCWCW+pT+vYaIgok+BA9h4ItRxqrQaEBoKthDjer3A05Cwg1+z12z+oUTJ3VKA Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2v9yfq56qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 11:43:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91Bcs8N019888;
        Tue, 1 Oct 2019 11:41:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vbsm1txud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 11:41:45 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x91BfcM9029174;
        Tue, 1 Oct 2019 11:41:39 GMT
Received: from tomti.i.net-space.pl (/10.175.183.114)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 04:41:38 -0700
Date:   Tue, 1 Oct 2019 13:41:33 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, corbet@lwn.net,
        dpsmith@apertussolutions.com, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, ross.philipson@oracle.com, tglx@linutronix.de
Subject: Re: [PATCH v2 1/3] x86/boot: Introduce the kernel_info
Message-ID: <20191001114133.xy5nuhepzzixhuh4@tomti.i.net-space.pl>
References: <20190704163612.14311-1-daniel.kiper@oracle.com>
 <20190704163612.14311-2-daniel.kiper@oracle.com>
 <5633066F-01BE-437D-A564-150FD48B6D92@zytor.com>
 <20190930150110.ekir52wu3w67v2fk@tomti.i.net-space.pl>
 <c9eb5a39-ced5-b35d-616d-6ffbe15c1396@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9eb5a39-ced5-b35d-616d-6ffbe15c1396@zytor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=813
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=887 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 10:18:43AM -0700, H. Peter Anvin wrote:
> On 2019-09-30 08:01, Daniel Kiper wrote:
> >
> > OK.
> >
> >> field for the entire .kernel_info section, thus ensuring it is a
> >> single self-contained blob.
> >
> > .rodata.kernel_info contains its total size immediately behind the
> > "InfO" header. Do you suggest that we should add the size of
> > .rodata.kernel_info into setup_header too?
> >
>
> No, what I want is a chunked architecture for kernel_info.
>
> That is:
>
> /* Common chunk header */
> struct kernel_info_header {
> 	uint32_t magic;
> 	uint32_t len;
> };
>
> /* Top-level chunk, always first */
> #define KERNEL_INFO_MAGIC 0x45fdbe4f
>
> struct kernel_info {
> 	struct kernel_info_header hdr;
> 	uint32_t total_size;		/* Total size of all chunks */
>
> 	/* Various fixed-sized data objects, OR offsets to other chunks */
> };

OK, so, this is more or less what I had in my v3 patch before sending
this email. So, it looks that I am on good track. Great! Though I am not
sure that we should have magic for chunked objects. If yes could you
explain why? I would just leave len for chunked objects.

> Also "InfO" is a pretty hideous magic. In general, all-ASCII magics have much
> higher risk of collision than *RANDOM* binary numbers. However, for a chunked
> architecture they do have the advantage that they can be used also as a human
> name or file name for the chunk, e.,g. in sysfs, so maybe something like
> "LnuX" or even "LToP" for the top-level chunk might make sense.
>
> How does that sound?

Well, your proposals are more cryptic, especially the second one, than
mine but I tend to agree that more *RANDOM* magics are better. So,
I would choose "LToP" if you decipher it for me. Linux Top?

Daniel
