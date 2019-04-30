Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0A0C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13CE20652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uUHv4R95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfD3Jx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:53:29 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38294 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfD3Jx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:53:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3U9iLuD028056;
        Tue, 30 Apr 2019 09:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ykA92PBEZsrqODAkwwHgqMq1bTBRvmad1nuDUVg3YvU=;
 b=uUHv4R95VvsToHAOC+Q+RMNXIpbqAzc4CmbXJoOvefsNQRJZjMqKt2UF3VPzRiyT+tNT
 n4olMSizfIKW/1GZwc6z1+SR5s1C0o/DCQ+q4u7sVhhoe7B/ztiy3ucNn/CMCv0I0Z5g
 a5g4GAzTEiGvu91qsIM4jYyw67haPS/+bYfutQg7QmkkQC2JzrY75YFqicAR3wYlPnGe
 bohml4R/sZTppc4KQoWOTrBdF0vxBA8qOLyLBz8r00+rs1JU8hMTDUZ1V6EuV7+iuf1Q
 5jPx/nfV/ozJgG77WTvlodFrbUbt8nhsnHQmFTOshHvz3MjPcEB3XxsekHa4lgV1UEH0 gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2s4ckdbqeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 09:53:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3U9rBPi033223;
        Tue, 30 Apr 2019 09:53:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2s4d4adydp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 09:53:11 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3U9r7PM024586;
        Tue, 30 Apr 2019 09:53:07 GMT
Received: from kadam (/196.97.65.153)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Apr 2019 02:53:06 -0700
Date:   Tue, 30 Apr 2019 12:52:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Matt Sickler <Matt.Sickler@daktronics.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] staging: kpc2000: use int for
 wait_for_completion_interruptible
Message-ID: <20190430095254.GC2269@kadam>
References: <1556332725-7391-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556332725-7391-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=975
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904300066
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904300065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 04:38:45AM +0200, Nicholas Mc Guire wrote:
> weit_for_completion_interruptible returns in (0 on completion and 
> -ERESTARTSYS on interruption) - so use an int not long for API conformance
> and simplify the logic here a bit: need not check explicitly for == 0 as
> this is either -ERESTARTSYS or 0.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
> 
> Problem located with experimental API conformance checking cocci script
> 
> Not sure if making such point-wise fixes makes much sense - this driver has
> a number of issues both style-wise and API compliance wise.
> 
> Note that kpc_dma_transfer() returns int not long - currently rv (long) is
> being returned in most places (some places do return int) - so the return
> handling here is a bit inconsistent.
> 
> Patch was compile-tested with: x86_64_defconfig + KPC2000=y, KPC2000_DMA=y
> (with a number of unrelated sparse warnings about non-declared symbols, and
>  smatch warnings about overflowing constants as well as coccicheck warning
>  about usless casting)

The patch must have got corrupted or something.  Or maybe the code was
ifdeffed out.  It won't compile.

> 
> Patch is against 5.1-rc6 (localversion-next is next-20190426)
> 
>  drivers/staging/kpc2000/kpc_dma/fileops.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
> index 5741d2b..66f0d5a 100644
> --- a/drivers/staging/kpc2000/kpc_dma/fileops.c
> +++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
> @@ -38,6 +38,7 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
>  {
>  	unsigned int i = 0;
>  	long rv = 0;
> +	int ret = 0;
>  	struct kpc_dma_device *ldev;
>  	struct aio_cb_data *acd;
>  	DECLARE_COMPLETION_ONSTACK(done);
> @@ -180,16 +181,17 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
>  	
>  	// If this is a synchronous kiocb, we need to put the calling process to sleep until the transfer is complete
>  	if (kcb == NULL || is_sync_kiocb(kcb)){
> -		rv = wait_for_completion_interruptible(&done);
> -		// If the user aborted (rv == -ERESTARTSYS), we're no longer responsible for cleaning up the acd
> -		if (rv == -ERESTARTSYS){
> +		ret = wait_for_completion_interruptible(&done);
> +		/* If the user aborted (ret == -ERESTARTSYS), we're
> +		 * no longer responsible for cleaning up the acd
> +		 *

This comment is never closed off with a "*/".

> +		if (ret){
                       ^^
Missing space.  Please use checkpatch.pl.

>  			acd->cpl = NULL;
> -		}
> -		if (rv == 0){
> -			rv = acd->len;
> +		} else {
> +			ret = acd->len;
>  			kfree(acd);
>  		}
> -		return rv;
> +		return ret

I don't really see an advantage with introducing a "ret" variable
instead of using "rv".

regards,
dan carpenter

