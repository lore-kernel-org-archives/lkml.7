Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19083C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E826420828
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfCFJ2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:28:09 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:53992 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbfCFJ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:28:08 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x269K5ZX029929;
        Wed, 6 Mar 2019 03:28:01 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2r1v7xa22x-1;
        Wed, 06 Mar 2019 03:28:01 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 7B634611C8AF;
        Wed,  6 Mar 2019 03:28:51 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Mar 2019
 09:28:00 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com
 [198.61.86.93])        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 x269RxZC000421;        Wed, 6 Mar 2019 09:27:59 GMT
Date:   Wed, 6 Mar 2019 09:27:59 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cirrus Patches <patches@opensource.cirrus.com>
Subject: Re: [PATCH 11/13] regulator: wm831x: Fix notifier mutex lock warning
Message-ID: <20190306092759.GG46536@ediswmail.ad.cirrus.com>
References: <cover.1551808797.git.stwiss.opensource@diasemi.com>
 <08948a3fe926ba9fbae124fa972df766820d3289.1551808797.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <08948a3fe926ba9fbae124fa972df766820d3289.1551808797.git.stwiss.opensource@diasemi.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=884 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903060064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 03:48:46PM +0000, Steve Twiss wrote:
> The mutex for the regulator_dev must be controlled by the caller of
> the regulator_notifier_call_chain(), as described in the comment
> for that function.
> 
> Failure to mutex lock and unlock surrounding the notifier call results
> in a kernel WARN_ON_ONCE() which will dump a backtrace for the
> regulator_notifier_call_chain() when that function call is first made.
> The mutex can be controlled using the regulator_lock/unlock() API.
> 
> Fixes: e4ee831f949a ("regulator: Add WM831x DC-DC buck convertor support")
> Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
