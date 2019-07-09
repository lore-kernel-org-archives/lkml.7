Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9B9C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F572166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KrdmdLub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfGIAJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:09:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34946 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfGIAJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:09:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6908Vfr068374;
        Tue, 9 Jul 2019 00:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=EyhI2SGXqBWf0uwma9BuLGltYhuzLwYJcUaoP1McYqc=;
 b=KrdmdLubkfVXtIz1koe2WpIL/995GfgDfzv96B9yGzgQ4MPsszpkodh3LwYK9SB1ShWC
 K5vF1XCHwYFdw69MKMLZ+5OFYbWeeyyXTWJb0wkvTjSMdRrEztRhl2X0nnEqEQH7xIMU
 7cp3padi+QzsN2JGpHaw5tV2obpz30fWiQa4WYUqrMSaBG5+oeeKFSQr58zgACJwSXKI
 ogjnBBYExwrWier2uUgBh4BkszKWFInbcAkpOS+eyuPO5OItjpcLyiq9u/YZ/USf9wLZ
 cp66QpwTMMWk/rNFepJuuctEiGsfMzJZvLDtDmCJvgOhyndjJrjOkR0AT2/Gc+6hLayg GQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tjk2th8p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 00:08:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6908MTc043766;
        Tue, 9 Jul 2019 00:08:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2tjgrtsg7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 00:08:30 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6908RHn023985;
        Tue, 9 Jul 2019 00:08:28 GMT
Received: from Subhras-MacBook-Pro.local (/103.217.243.93)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jul 2019 17:08:26 -0700
Subject: Re: [RFC 0/2] Optimize the idle CPU search
To:     Parth Shah <parth@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
References: <20190708045432.18774-1-parth@linux.ibm.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <839c6cc8-b550-3066-d856-3c8a919cc318@oracle.com>
Date:   Tue, 9 Jul 2019 05:38:10 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708045432.18774-1-parth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9312 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=883
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907090000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9312 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=939 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907090000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/8/19 10:24 AM, Parth Shah wrote:
> When searching for an idle_sibling, scheduler first iterates to search for
> an idle core and then for an idle CPU. By maintaining the idle CPU mask
> while iterating through idle cores, we can mark non-idle CPUs for which
> idle CPU search would not have to iterate through again. This is especially
> true in a moderately load system
>
> Optimize idle CPUs search by marking already found non idle CPUs during
> idle core search. This reduces iteration count when searching for idle
> CPUs, resulting in lower iteration count.
>
I believe this can co-exist with latency-nice? We can derive the 'nr' in
select_idle_cpu from latency-nice and use the new mask to iterate.
