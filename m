Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6AEC31E49
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 02:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8442089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 02:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfFQCIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 22:08:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727322AbfFQCIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 22:08:42 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5H26rGk135235
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 22:08:40 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t5vdn7fpb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 22:08:40 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alistair@popple.id.au>;
        Mon, 17 Jun 2019 03:08:38 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Jun 2019 03:08:36 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5H28Z2436897230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 02:08:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3CCF42047;
        Mon, 17 Jun 2019 02:08:35 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 548FB42045;
        Mon, 17 Jun 2019 02:08:35 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jun 2019 02:08:35 +0000 (GMT)
Received: from townsend.localnet (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id F31BBA0208;
        Mon, 17 Jun 2019 12:08:33 +1000 (AEST)
From:   Alistair Popple <alistair@popple.id.au>
To:     openbmc@lists.ozlabs.org
Cc:     Eddie James <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org,
        andrew@aj.id.au
Subject: Re: [PATCH] fsi: sbefifo: Don't fail operations when in SBE IPL state
Date:   Mon, 17 Jun 2019 12:08:33 +1000
User-Agent: KMail/5.2.3 (Linux/4.18.0-0.bpo.1-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <1548090958-25908-1-git-send-email-eajames@linux.ibm.com>
References: <1548090958-25908-1-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19061702-0008-0000-0000-000002F449EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061702-0009-0000-0000-000022615954
Message-Id: <1780173.icGFXHrAMq@townsend>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixed the problem I was having trying to issue istep operations to the 
SBE.

Tested-by: Alistair Popple <alistair@popple.id.au>

On Monday, 21 January 2019 11:15:58 AM AEST Eddie James wrote:
> SBE fifo operations should be allowed while the SBE is in any of the
> "IPL" states. Operations should succeed in this state.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/fsi/fsi-sbefifo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> index c7d13ac..f7665b3 100644
> --- a/drivers/fsi/fsi-sbefifo.c
> +++ b/drivers/fsi/fsi-sbefifo.c
> @@ -290,11 +290,11 @@ static int sbefifo_check_sbe_state(struct sbefifo
> *sbefifo) switch ((sbm & CFAM_SBM_SBE_STATE_MASK) >>
> CFAM_SBM_SBE_STATE_SHIFT) { case SBE_STATE_UNKNOWN:
>  		return -ESHUTDOWN;
> +	case SBE_STATE_DMT:
> +		return -EBUSY;
>  	case SBE_STATE_IPLING:
>  	case SBE_STATE_ISTEP:
>  	case SBE_STATE_MPIPL:
> -	case SBE_STATE_DMT:
> -		return -EBUSY;
>  	case SBE_STATE_RUNTIME:
>  	case SBE_STATE_DUMP: /* Not sure about that one */
>  		break;


