Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9F5C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 04:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046532075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 04:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rAGOG/Z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfE1E2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 00:28:08 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:17042 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfE1E2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 00:28:07 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190528042804epoutp0240851ac720e651017291ebcd9a2e6e39~ivlLgGsQb2249522495epoutp02_
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 04:28:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190528042804epoutp0240851ac720e651017291ebcd9a2e6e39~ivlLgGsQb2249522495epoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559017684;
        bh=bQu5BjQ3jzLNW/T4QuFjc+aW8c+wXrn8uNE3SokrEY4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rAGOG/Z386FfWG/zMGIvk1qid9pkIB/e0T1eNUJvzWFEo3x79EnJ3+b4jiR5XKKfl
         33HZYUOSeCGzeK0shRT43fWgBa6DYFDqzCyJGw+PgW+1UYEFko2kFwm6mkpsorvaQg
         zCdvR5VNhIUOdZLFXIMt7Agi9UFbZs4mxT/2HvRw=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20190528042803epcas5p24124ee639e59191ce3e787e5fcbf26df~ivlLJzHfP1276912769epcas5p2K;
        Tue, 28 May 2019 04:28:03 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.60.04071.3D8BCEC5; Tue, 28 May 2019 13:28:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20190528042802epcas5p3bbc42e5efadc2476f711960767feb067~ivlKNeJFC2518425184epcas5p3_;
        Tue, 28 May 2019 04:28:02 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190528042802epsmtrp1b4cc8a7fe63e79feeb3ceff9b281a611~ivlKMhb_J2768927689epsmtrp1G;
        Tue, 28 May 2019 04:28:02 +0000 (GMT)
X-AuditID: b6c32a49-5b7ff70000000fe7-47-5cecb8d3e2b5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.17.03662.2D8BCEC5; Tue, 28 May 2019 13:28:02 +0900 (KST)
Received: from [107.108.73.28] (unknown [107.108.73.28]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190528042801epsmtip17efcc98ae55c763df5d9e500bef3799e~ivlIw6-rq0870108701epsmtip1G;
        Tue, 28 May 2019 04:28:01 +0000 (GMT)
Subject: Re: [PATCH] scsi: ufs: Check that space was properly alloced in
 copy_query_response
To:     Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Bean Huo <beanhuo@micron.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Cc:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>
From:   Alim Akhtar <alim.akhtar@samsung.com>
Message-ID: <cd9f0d7b-8ce6-e432-e1df-c4316b191156@samsung.com>
Date:   Tue, 28 May 2019 09:37:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558427062-5084-1-git-send-email-avri.altman@wdc.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7bCmlu7lHW9iDCYu1LW4ti7Y4uuuBcwW
        L39eZbM4+LCTxaL1/nQmi1UT8ywu75rDZtF9fQebxfLj/5gsWo59ZXHg8pjdcJHF48GhzSwe
        39d3sHl8fHqLxWPL/s+MHp83yXm0H+hmCmCP4rJJSc3JLEst0rdL4Mr49fQGU8Fn7op/+1cw
        NTDe5uxi5OSQEDCR+LtqOWsXIxeHkMBuRom/HcuYIJxPjBKnNr9jhHC+MUqsPbedHaalc95a
        ZhBbSGAvo8T9N+4QRW8ZJT7ev8kKkhAWiJP48egLG0hCRGA7k0T39nNsIAlmgTCJczv3gU1i
        E9CWuDt9CxOIzStgJ3F/90oWEJtFQFXi6PxPYINEBSIk7h/bwApRIyhxcuYTsBpOAWeJ04/3
        Q80Ul7j1ZD4ThC0vsf3tHGaIS5vZJf7eFYWwXSTm3W1jhLCFJV4d3wL1jZTEy/42IJsDyM6W
        6NllDBGukVg67xgLhG0vceDKHBaQEmYBTYn1u/QhNvFJ9P5+wgTRySvR0SYEUa0q0fzuKlSn
        tMTE7m5WCNtDonnleWh4TmOUaHyxkG0Co8IsJI/NQvLMLCTPzELYvICRZRWjZGpBcW56arFp
        gWFearlecWJucWleul5yfu4mRnDS0vLcwTjrnM8hRgEORiUeXotTr2OEWBPLiitzDzFKcDAr
        ifDaTnkTI8SbklhZlVqUH19UmpNafIhRmoNFSZx3EuvVGCGB9MSS1OzU1ILUIpgsEwenVAOj
        oY2Xz/qS38tVu840eTP+tr6f98Hys+Sti+tWvBNPT5V9G2U3eUpvWcN9/hf5Zz7Htx3vm6Vw
        dnLrTSvj8yE25kYnxErWSy03vHjmTqSnS7fmb6Xdk2vOX9CZOT1vD/f5HUYCOQX/zn1O8E1P
        mL68/ufK2a6b19wXNonhEObYUcfZsZHpeiCjEktxRqKhFnNRcSIAd1Tl/lYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSnO6lHW9iDJ5u0bK4ti7Y4uuuBcwW
        L39eZbM4+LCTxaL1/nQmi1UT8ywu75rDZtF9fQebxfLj/5gsWo59ZXHg8pjdcJHF48GhzSwe
        39d3sHl8fHqLxWPL/s+MHp83yXm0H+hmCmCP4rJJSc3JLEst0rdL4Mr49fQGU8Fn7op/+1cw
        NTDe5uxi5OSQEDCR6Jy3lrmLkYtDSGA3o8SmrmssEAlpiesbJ7BD2MISK/89Z4coes0o8WBJ
        P1hCWCBO4sejL2wgCRGBnUwSP1s3soEkmAXCJL6sWw41dhqjRNfRycwgCTYBbYm707cwgdi8
        AnYS93evBFvHIqAqcXT+J1YQW1QgQuLM+xUsEDWCEidnPgGzOQWcJU4/3g+1wExi3uaHzBC2
        uMStJ/OZIGx5ie1v5zBPYBSahaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iwwCgvtVyvODG3
        uDQvXS85P3cTIzjStLR2MJ44EX+IUYCDUYmH1+LU6xgh1sSy4srcQ4wSHMxKIry2U97ECPGm
        JFZWpRblxxeV5qQWH2KU5mBREueVzz8WKSSQnliSmp2aWpBaBJNl4uCUamBkfsgS9DoqY453
        0IVH/tMcX5+4psskfIPx89mnUfeOCaz3evX75DHXs66Pzy6KmTFdNPHbh8jv16/O6HMzX/Tb
        k7npKvNKB9/gt7eMaz6c6DZS7eZVfWf09VL7swN+Tkc6pF8ufsq7qiOus8Vk/tLnbXKnVP9s
        1pA9oWeyoOGyckf7ze3GjnfVlViKMxINtZiLihMBSaFThLACAAA=
X-CMS-MailID: 20190528042802epcas5p3bbc42e5efadc2476f711960767feb067
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190521082527epcas1p44fe0c4659549ae265c9d59ef7844e57e
References: <CGME20190521082527epcas1p44fe0c4659549ae265c9d59ef7844e57e@epcas1p4.samsung.com>
        <1558427062-5084-1-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Avri

On 5/21/19 1:54 PM, Avri Altman wrote:
> struct ufs_dev_cmd is the main container that supports device management
> commands. In the case of a read descriptor request, we assume that the
> proper space was allocated in dev_cmd to hold the returning descriptor.
> 
> This is no longer true, as there are flows that doesn't use dev_cmd
> for device management requests, and was wrong in the first place.
> 
Can you please put some light on those flows? Are those platform 
specific? Just curious.
> fixes: d44a5f98bb49 (ufs: query descriptor API)
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>   drivers/scsi/ufs/ufshcd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 8c1c551..3fe3029 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -1917,7 +1917,8 @@ int ufshcd_copy_query_response(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
>   	memcpy(&query_res->upiu_res, &lrbp->ucd_rsp_ptr->qr, QUERY_OSF_SIZE);
>   
>   	/* Get the descriptor */
> -	if (lrbp->ucd_rsp_ptr->qr.opcode == UPIU_QUERY_OPCODE_READ_DESC) {
> +	if (hba->dev_cmd.query.descriptor &&
> +	    lrbp->ucd_rsp_ptr->qr.opcode == UPIU_QUERY_OPCODE_READ_DESC) {
>   		u8 *descp = (u8 *)lrbp->ucd_rsp_ptr +
>   				GENERAL_UPIU_REQUEST_SIZE;
>   		u16 resp_len;
> 
This change looks ok to me. I hope you have tested this patch.
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

