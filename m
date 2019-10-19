Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D12CA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 18:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAF021925
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 18:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iDtdMIIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfJSSHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 14:07:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40250 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfJSSHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 14:07:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9JI4PpP055516;
        Sat, 19 Oct 2019 18:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=xzaow11/xSCqBracFjPSult9QZ36gtDXdo3LvSEBtNo=;
 b=iDtdMIIk2Ez8a4Y7MNJiIuvn7RpyEMjJg6bALuhHOrokqqRWY0LxR0L1Rk1lZEuwyRJf
 jT5IoSHoudMQe46OEo5xDPYf7McxF1JI+DjVF/V8Hy9ba9Bpv9eDwunKmRuPr2J7T0nL
 MP/2Fm81f9/KvbH2dbynifA7r2/MhQcN6/q5YD6ZwLFnYXmJa5+14PX1r9X1vTRLEIsh
 n5m4A0zf+KYByoNz4HtDSsDNgzEWGfqGE0/f6QoZZ/VX5distDMipKOER2mw/uZAX9I5
 vF8Quo/3IBxxyVyscp4wpQseKrKLVWeROqJ5iM1c4NWumI1QP8rIDUXbfs7T4BSlRL6V vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vqtep9kp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Oct 2019 18:07:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9JI3sUI036452;
        Sat, 19 Oct 2019 18:05:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vqrhe7fe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Oct 2019 18:05:30 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9JI5SJB019107;
        Sat, 19 Oct 2019 18:05:28 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 19 Oct 2019 18:05:27 +0000
Date:   Sat, 19 Oct 2019 21:05:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v1 1/5] staging: wfx: fix warnings of no space is
 necessary
Message-ID: <20191019180514.GI24678@kadam>
References: <20191019140719.2542-1-jbi.octave@gmail.com>
 <20191019140719.2542-2-jbi.octave@gmail.com>
 <20191019142443.GH24678@kadam>
 <alpine.LFD.2.21.1910191603520.6740@ninjahub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1910191603520.6740@ninjahub.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9415 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910190170
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9415 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910190170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 04:09:03PM +0100, Jules Irenge wrote:
> Checkpatch was complaining about  space between type cast and the 
> variable. I just get rid of the space. Well I don't know whether this was 
> false positive one.
> 
> Thanks for the feedback. I will update the patch.

No no.  The patch is fine.  I was saying that in the *future* you might
want to look at the void casts.  Some of them are not required and
others are buggy code.

regards,
dan carpenter
