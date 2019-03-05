Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADBCC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 02:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A4F206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 02:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cAoil653"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfCECQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 21:16:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37734 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfCECQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 21:16:15 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x252Dai9039555;
        Tue, 5 Mar 2019 02:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1NSl0G5nmVd7t/AyqGx2dw2NY9Olu2oPM7NhUtpF6KI=;
 b=cAoil653FxX/UYtVOgm+nqg2I6ogWaklKBDfOfJr+dvF3dAvnVhIUhS8hDwGqoppOBAt
 w/Kww5u7ih5ccQK+1ZWGOp3guPgALkXvPuelXuBKUb/2rkTimaqPnsj8XQ31HiCWV1Ac
 rKhMbrszggYmjbDqvUXDatMleqCZRW85T9I5frBYynMRbCTIJovOoKwFI5UpOO65nK1K
 HaE1ZIUSPEvvd7CwVs/rnCbAtMtEYt4u0HLN1ub3SAgcQkJuUgIIL+oQt9Fwu55W+qPH
 x65boF6qb6ppaJeK34Gw1sH5C2f6ujGh6Orx0vLiAi/UjlVl5DCopSOSLxpfFPwrMZGs cw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qyjfraf7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Mar 2019 02:15:59 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x252Fwtp010603
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Mar 2019 02:15:59 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x252FwXW003038;
        Tue, 5 Mar 2019 02:15:58 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Mar 2019 18:15:58 -0800
Subject: Re: [BUG linux-4.9.x] xen hotplug cpu leads to 100% steal usage
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     xen-devel@lists.xenproject.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        sstabellini@kernel.org, jgross@suse.com, joe.jin@oracle.com,
        Herbert Van Den Bergh <herbert.van.den.bergh@oracle.com>,
        sboyd@kernel.org, john.stultz@linaro.org
References: <841bb9a9-1cba-483f-a353-1209684f7c74@default>
 <alpine.DEB.2.21.1903020030320.1638@nanos.tec.linutronix.de>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <22c1eb51-1e09-3eb4-f88a-d404b4ffcdb4@oracle.com>
Date:   Tue, 5 Mar 2019 10:19:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1903020030320.1638@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9185 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903050014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 3/2/19 7:43 AM, Thomas Gleixner wrote:
> On Thu, 28 Feb 2019, Dongli Zhang wrote:
>>
>> The root cause is that the return type of jiffies_to_usecs() is 'unsigned int',
>> but not 'unsigned long'. As a result, the leading 32 bits are discarded.
> 
> Errm. No. The root cause is that jiffies_to_usecs() is used for that in the
> first place. The function has been that way forever and all usage sites
> (except a broken dev_debug print in infiniband) feed delta values. Yes, it
> could have documentation....

Thank you very much for the explanation. It would help the developers clarify
the usage of jiffies_to_usecs() (which we should always feed with dealt value)
with comments above it.

Indeed, the input value in this bug is also a delta value. Because of the
special mechanisms used by xen to account steal clock, the initial delta value
is always very large, only when the new cpu is added after the VM is already up
for very long time.

Dongli Zhang


> 
>> jiffies_to_usecs() is indirectly triggered by cputime_to_nsecs() at line 264.
>> If guest is already up for long time, the initial steal time for new vcpu might
>> be large and the leading 32 bits of jiffies_to_usecs() would be discarded.
> 
>> So far, I have two solutions:
>>
>> 1. Change the return type from 'unsigned int' to 'unsigned long' as in above
>> link and I am afraid it would bring side effect. The return type in latest
>> mainline kernel is still 'unsigned int'.
> 
> Changing it to unsigned long would just solve the issue for 64bit.
> 
> Thanks,
> 
> 	tglx
> 
