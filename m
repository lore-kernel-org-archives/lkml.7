Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E28C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC6E2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfCSLOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:14:20 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:45622 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbfCSLOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:14:19 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JBEHtS005963;
        Tue, 19 Mar 2019 06:14:17 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2ratwugcbf-1;
        Tue, 19 Mar 2019 06:14:16 -0500
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 016EA611C8AC;
        Tue, 19 Mar 2019 06:14:35 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 11:14:13 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com
 [198.61.86.93])        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 x2JBECAZ014340;        Tue, 19 Mar 2019 11:14:12 GMT
Date:   Tue, 19 Mar 2019 11:14:12 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>, <patches@opensource.cirrus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] regmap: debugfs: Jump to the next readable register
Message-ID: <20190319111412.GQ46536@ediswmail.ad.cirrus.com>
References: <20190319094133.8843-1-tanureal@opensource.cirrus.com>
 <20190319094133.8843-2-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190319094133.8843-2-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=726 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 09:41:33AM +0000, Lucas Tanure wrote:
> Improve the speed of the loop jumping to the next
> available register
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

A very brief look shows a pretty reasonable speed up on the
massive wm5110 register map.

First regmap cat on wm5110:
 pre-patch:
  real    2m40.865s
  sys     2m21.104s

 post-patch:
  real    2m16.550s
  sys     2m5.799s

Repeat cat on wm5110:
 pre-patch:
  real    2m5.635s
  sys     2m0.030s

 post-patch:
  real    1m45.539s
  sys     1m44.552s

Thanks,
Charles
