Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABA8C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0368B21019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfEMIPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 04:15:33 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:47576 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727355AbfEMIPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 04:15:33 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4D89QCh015186;
        Mon, 13 May 2019 03:15:23 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2sdusy2arj-1;
        Mon, 13 May 2019 03:15:23 -0500
Received: from EDIEX02.ad.cirrus.com (unknown [198.61.84.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 0A979611C8AD;
        Mon, 13 May 2019 03:15:23 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 13 May
 2019 09:15:22 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 13 May 2019 09:15:22 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CA94F2A1;
        Mon, 13 May 2019 09:15:21 +0100 (BST)
Date:   Mon, 13 May 2019 09:15:21 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Daniel Gomez <dagmcr@gmail.com>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        "moderated list:CIRRUS LOGIC MADERA CODEC DRIVERS" 
        <alsa-devel@alsa-project.org>,
        "open list:CIRRUS LOGIC MADERA CODEC DRIVERS" 
        <patches@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>, <javier@dowhile0.org>
Subject: Re: [PATCH v2] mfd: madera: Add missing of table registration
Message-ID: <20190513081521.GE45394@ediswmail.ad.cirrus.com>
References: <1557569038-20340-1-git-send-email-dagmcr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1557569038-20340-1-git-send-email-dagmcr@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=988 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905130060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 12:03:58PM +0200, Daniel Gomez wrote:
> MODULE_DEVICE_TABLE(of, <of_match_table> should be called to complete DT
> OF mathing mechanism and register it.
> 
> Before this patch:
> modinfo ./drivers/mfd/madera.ko | grep alias
> 
> After this patch:
> modinfo ./drivers/mfd/madera.ko | grep alias
> alias:          of:N*T*Ccirrus,wm1840C*
> alias:          of:N*T*Ccirrus,wm1840
> alias:          of:N*T*Ccirrus,cs47l91C*
> alias:          of:N*T*Ccirrus,cs47l91
> alias:          of:N*T*Ccirrus,cs47l90C*
> alias:          of:N*T*Ccirrus,cs47l90
> alias:          of:N*T*Ccirrus,cs47l85C*
> alias:          of:N*T*Ccirrus,cs47l85
> alias:          of:N*T*Ccirrus,cs47l35C*
> alias:          of:N*T*Ccirrus,cs47l35
> 
> Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
