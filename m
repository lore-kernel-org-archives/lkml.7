Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9E2C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 06:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F68D214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 06:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OOMFiXpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440504AbfIXGPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 02:15:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43160 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438592AbfIXGPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 02:15:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8O6DsW8078787;
        Tue, 24 Sep 2019 06:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=63W63rUj8FUJMRRytvPvRJGqPus+X8Ahn8kyiIsIBq4=;
 b=OOMFiXpPYZdFlwg9TOygTePBX/c/cOLvDJ74B4cBvr0biOehWMaytKP1ZDKNfwP11F7x
 8+MYGZvr72C8d2CHwfdyXejp4fG5/FxpgJMVLhI8y5YMiTbLnlUYbUCm4bor/NKnqob5
 rTKqEHh782s9qmXQzseB6e6HaJohr/o1kVeire+hbsFRQ6YQFn5RA1Ak6YOFPW3ebXwg
 ja8HQOhcdQ1QPHW6erIiNRFsumnY0BjYxV9D1ulboRPoMeDVaviaHK7h0k+P1BH42Vmv
 1O9cvC5O4CkIEXyFAgaSzvXnHz0tNUCVQJrfT3rsqecyA/SmTNy300WcRPz0c8cxLWcn Mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v5cgqukwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 06:15:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8O6DRVS031126;
        Tue, 24 Sep 2019 06:15:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2v6yvr02cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 06:15:26 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8O6FP0H002389;
        Tue, 24 Sep 2019 06:15:25 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Sep 2019 23:15:24 -0700
Date:   Tue, 24 Sep 2019 09:15:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Connor Kuehl <connor.kuehl@canonical.com>
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: remove dead code in do-while
 conditional step
Message-ID: <20190924061200.GK2959@kadam>
References: <20190923194806.25347-1-connor.kuehl@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923194806.25347-1-connor.kuehl@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909240063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909240063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 12:48:06PM -0700, Connor Kuehl wrote:
> @@ -103,7 +102,7 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
>  		adapt->HalData->LastHMEBoxNum =
>  			(h2c_box_num+1) % RTL88E_MAX_H2C_BOX_NUMS;
>  
> -	} while ((!bcmd_down) && (retry_cnts--));
> +	} while (!bcmd_down);

Just get rid of the whole do while loop, because it just goes through
one time.  It doesn't loop.   Get rid of bcmd_down as well.

regards,
dan carpenter

