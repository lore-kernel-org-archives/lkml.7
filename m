Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C55BC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58B0214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="izX7Mt4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbfHAIHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 04:07:09 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:39876 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729578AbfHAIHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:07:08 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7184GcN019463;
        Thu, 1 Aug 2019 03:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Qe3BSURddtW0xIR5vVf0i7K36vS4J8Vn6YUqcPqkVr0=;
 b=izX7Mt4G0AtObSGFQm8SYBHcWz2vEpYHq8MJSAoQXqlhwRwwrggNEDccPrMAYtthcBS+
 oBAsnsSuGOPpF+mWatgTybnwsvs+MdCmNnd34QVe1wqj+yNZ9DsucQVkcK4L8GKsrEK1
 ldz2wmqw92RjijfakyFLW7q6/1c9TiaBX5vYHghWmzsnXcp8O2XF8Jz8kH2pW7KvnkXi
 7b0xqAi5Y813BUEtRa3QC35c3C8DKPPAazkXsKtCkf+rW2F4XirHpdU5HCFlolUqAkSg
 TldH+ZKFZF9uMV0LCEKN5C7O2/oXM+7/MmYukMLBVKfpQsOK0UgmUPj6mdAcl9rcAlOa 6A== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 2u3gpvrsrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Aug 2019 03:07:05 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 1 Aug
 2019 09:07:04 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Thu, 1 Aug 2019 09:07:04 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1D9352C5;
        Thu,  1 Aug 2019 09:07:04 +0100 (BST)
Date:   Thu, 1 Aug 2019 09:07:04 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH 2/9] clk: lochnagar: Don't reference clk_init_data after
 registration
Message-ID: <20190801080704.GK54126@ediswmail.ad.cirrus.com>
References: <20190731193517.237136-1-sboyd@kernel.org>
 <20190731193517.237136-3-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190731193517.237136-3-sboyd@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 phishscore=0 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=781
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908010082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 12:35:10PM -0700, Stephen Boyd wrote:
> A future patch is going to change semantics of clk_register() so that
> clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> referencing this member here so that we don't run into NULL pointer
> exceptions.
> 
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
> 

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
