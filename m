Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B51C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4262621D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="gbP2QYfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfJCHyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 03:54:35 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:58600 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726811AbfJCHyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 03:54:35 -0400
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id x937qTQe011541;
        Thu, 3 Oct 2019 08:54:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=to : cc : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=jan2016.eng;
 bh=1+EAAhS1Uqb8Qy/XoTHlfxsWP5AnRiqNm71M3JmRaTw=;
 b=gbP2QYfdVJQiIKwShqu0S2YYLSriqsQ8SIlAYNgFtQoTO6dQMo7yAuP2UNvegxSiIuPM
 mAqCwqHxW7WvQfSGqzAB/9gRQHU1GzWWl/roU0/ba/7zBwsQeh2zlLy8EY6BioQ+Ln5k
 8UacA4ddcz6mg2NaCI87PMUZqR4Esxgx/ormWHsq/i4Ez1O8L12ObO3mRxUPxE5QXjRd
 NfO4vo2ldY17axDmdij6EJV3xNCjy8UoyPVXiIEvlkvrs6Ca0HUHjc8Lt61wrZeF1KIk
 Ndsd9WrE0W7ldQ3FTHkUhRrmhShIY+x/xzDlWwWLnaRNDV5fEmN/eQJBN0s/rLEDGy9m Zg== 
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
        by m0050095.ppops.net-00190b01. with ESMTP id 2v9y24jm89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Oct 2019 08:54:12 +0100
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
        by prod-mail-ppoint5.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x937l23S020229;
        Thu, 3 Oct 2019 00:54:11 -0700
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint5.akamai.com with ESMTP id 2va5g982k5-1;
        Thu, 03 Oct 2019 00:54:10 -0700
Received: from [0.0.0.0] (caldecot.sanmateo.corp.akamai.com [172.22.187.166])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id AF8C31FC6B;
        Thu,  3 Oct 2019 07:54:09 +0000 (GMT)
To:     john@metanate.com, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, khlebnikov@yandex-team.ru,
        namhyung@kernel.org, peterz@infradead.org, acme@redhat.com
Cc:     linux-kernel@vger.kernel.org
From:   Josh Hunt <johunt@akamai.com>
Subject: 4.19 dwarf unwinding broken
Message-ID: <ab87d20b-526c-9435-0532-c298beeb0318@akamai.com>
Date:   Thu, 3 Oct 2019 00:54:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=8 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=823
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910030076
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-03_03:2019-10-01,2019-10-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=18
 bulkscore=0 mlxscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxlogscore=866 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910030077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit is breaking dwarf unwinding on 4.19 kernels:

commit e5adfc3e7e774ba86f7bb725c6eef5f32df8630e
Author: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Date:   Tue Aug 7 12:09:01 2018 +0300

     perf map: Synthesize maps only for thread group leader

It looks like this was fixed later by:

commit e8ba2906f6b9054102ad035ac9cafad9d4168589
Author: John Keeping <john@metanate.com>
Date:   Thu Aug 15 11:01:45 2019 +0100

     perf unwind: Fix libunwind when tid != pid

but was not selected as a backport to 4.19. Are there plans to backport 
the fix? If not, could we have the breaking commit reverted in 4.19 LTS?

Thanks
Josh
