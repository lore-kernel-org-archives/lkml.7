Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817C6CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DD62245A
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="irU81VrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505730AbfJRS3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:29:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53816 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505612AbfJRS3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:29:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9IIJfYu123323;
        Fri, 18 Oct 2019 18:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=hXYMrEGZzwQiBxefoyJmePRgdYQb4j68CrcBDe3IDzc=;
 b=irU81VrR8BTGLN/APpFS6rFQslAg28wtt7vglzPr5k/IKawaYwfKfMh34HxiwPz94aoh
 XkCrBIM6l4o4QjmnbYgatJPl9bbrrDynx6tk907cdw9lLeGXLPqyuCZgbJhAEvCBpPke
 X60aYbk4UpEn1GcAyAmX4zkVlK24V2SpQZJ6lGfxzBoYfalMg5zpMwHPiEQxhGMJuAkx
 Z7mIO8Vd6FOOZTsGsnadC2Caw0gqOghhxhwqLPFKnJSC7t7Vgt6+uxI2G+QlDN22e6Ut
 95//l/QYvn0FoSNHiU51RjTB+gcIO15O7gNImniu7VxLDO6OvvNJlSG4SRIXTwW2AqRx XQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vq0q45hj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 18:29:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9IIN4Gd145695;
        Fri, 18 Oct 2019 18:29:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vq0ewyd9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 18:29:44 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9IITfS8021199;
        Fri, 18 Oct 2019 18:29:41 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Oct 2019 18:29:41 +0000
Subject: Re: [PATCH] hugetlb: Add nohugepages parameter to prevent hugepages
 creation
To:     "Guilherme G. Piccoli" <guilherme@gpiccoli.net>,
        Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>
Cc:     Guilherme Piccoli <gpiccoli@canonical.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
References: <CAHD1Q_ynd6f2Jc54k1D9JjmtD6tGhkDcAHRzd5nZt5LUdQTvaw@mail.gmail.com>
 <4641B95A-6DD8-4E8A-AD53-06E7B72D956C@lca.pw>
 <CAHD1Q_x+m0ZT_xfLV3j6ma3Cc88fk9KnoS4yytS=PHBvJN7nnQ@mail.gmail.com>
 <20191015121803.GB24932@dhcp22.suse.cz>
 <b6617b4b-bcab-3b40-7d46-46a5d9682856@gpiccoli.net>
 <20191015140508.GJ317@dhcp22.suse.cz>
 <2d593c95-3c69-8f50-17ff-223bd607caf1@gpiccoli.net>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2df9c30d-b1e0-648e-93ba-85c78fbcbd0e@oracle.com>
Date:   Fri, 18 Oct 2019 11:29:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2d593c95-3c69-8f50-17ff-223bd607caf1@gpiccoli.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=27 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=27 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/19 7:09 AM, Guilherme G. Piccoli wrote:
> 
> 
> On 10/15/19 11:05 AM, Michal Hocko wrote:
>> On Tue 15-10-19 10:58:36, Guilherme G. Piccoli wrote:
>>> On 10/15/19 9:18 AM, Michal Hocko wrote:
>>>> I do agree with Qian Cai here. Kdump kernel requires a very tailored
>>>> environment considering it is running in a very restricted
>>>> configuration. The hugetlb pre-allocation sounds like a tooling problem
>>>> and should be fixed at that layer.
>>>>
>>>
>>> Hi Michal, thanks for your response. Can you suggest me a current way of
>>> preventing hugepages for being created, using userspace? The goal for this
>>> patch is exactly this, introduce such a way.
>>
>> Simply restrict the environment to not allocate any hugepages? Kdump
>> already controls the kernel command line and it also starts only a very
>> minimal subset of services. So who is allocating those hugepages?
>> sysctls should be already excluded by default as Qian mentioned.
>>
> 
> 
> OK, thanks Michal and Qian, I'll try to make things work from kdump perspective. The trick part is exactly preventing the sysctl to get applied heh
> 

Please do let us know if this can be done in tooling.

I am not opposed to the approach taken in your v2 patch as it essentially
uses the hugepages_supported() functionality that exists today.  However,
it seems that other distros have ways around this issue.  As such, I would
prefer if the issue was addressed in the tooling.
-- 
Mike Kravetz
