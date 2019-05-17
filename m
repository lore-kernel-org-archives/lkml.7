Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DB5C04AAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 00:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879662082E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 00:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="goD8WGYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfEQACW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 20:02:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55796 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfEQACW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 20:02:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4H00CXw195918;
        Fri, 17 May 2019 00:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=wOL7Y2USzQ9HfFUmu2R99hBKeQx5shjfX/gs/NjLiiA=;
 b=goD8WGYWY/LAAhT5aiZ0jrWwtFG6K8R4fBt8JVShsdYUyQbaHl5ZLD9eG9+qjTQUq4mE
 p/NmNhQ20FZck+Gpa/+hT6rMeKX2wgb6IH5QT9FW53IxeSx8YNJf0N7n/0ZdkQHYEEUj
 vLp/vf8cLl6fC0zr5n+xc0dZYZQAtMMBB37k5cW8kg9DtBjrWIPQXKlvJzrBgdcnqWOz
 p8JItLa1I1LXbi5xwHHri0p09VjJhfQ2YFBbIQOAo5S1IDWzYsxuk/gpqhK7iPeP7qy1
 JCSbEAbJ/APZqXenrBVpFZnuEMK/zySp9evjKGVBOkyt9mQOEe3GfqI3q3mYiUCiZv4d Sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2sdntu6mtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 00:01:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4H01iJs127295;
        Fri, 17 May 2019 00:01:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2shh5grkv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 May 2019 00:01:54 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4H01peW018225;
        Fri, 17 May 2019 00:01:51 GMT
Received: from [10.159.143.229] (/10.159.143.229)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 May 2019 17:01:51 -0700
Subject: Re: [PATCH v2 0/6] mm/devm_memremap_pages: Fix page release race
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
References: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
 <059859ca-3cc8-e3ff-f797-1b386931c41e@deltatee.com>
 <17ada515-f488-d153-90ef-7a5cc5fefb0f@deltatee.com>
 <8a7cfa6b-6312-e8e5-9314-954496d2f6ce@oracle.com>
 <CAPcyv4i28tQMVrscQo31cfu1ZcMAb74iMkKYhu9iO_BjJvp+9A@mail.gmail.com>
 <6bd8319d-3b73-bb1e-5f41-94c580ba271b@oracle.com>
 <d699e312-0e88-30c7-8e50-ff624418d486@oracle.com>
 <CAPcyv4hujnGHtTwE78gvmEoY3Y6nLsd1AhJfeKMwHrxLvStf9w@mail.gmail.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <d5227f37-4e44-169e-c54b-587c335514c1@oracle.com>
Date:   Thu, 16 May 2019 17:01:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hujnGHtTwE78gvmEoY3Y6nLsd1AhJfeKMwHrxLvStf9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9259 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905160146
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9259 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905160146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/2019 2:51 PM, Dan Williams wrote:

> On Thu, May 16, 2019 at 9:45 AM Jane Chu <jane.chu@oracle.com> wrote:
>> Hi,
>>
>> I'm able to reproduce the panic below by running two sets of ndctl
>> commands that actually serve legitimate purpose in parallel (unlike
>> the brute force experiment earlier), each set in a indefinite loop.
>> This time it takes about an hour to panic.  But I gather the cause
>> is probably the same: I've overlapped ndctl commands on the same
>> region.
>>
>> Could we add a check in nd_ioctl(), such that if there is
>> an ongoing ndctl command on a region, subsequent ndctl request
>> will fail immediately with something to the effect of EAGAIN?
>> The rationale being that kernel should protect itself against
>> user mistakes.
> We do already have locking in the driver to prevent configuration
> collisions. The problem looks to be broken assumptions about running
> the device unregistration path in a separate thread outside the lock.
> I suspect it may be incorrect assumptions about the userspace
> visibility of the device relative to teardown actions. To be clear
> this isn't the nd_ioctl() path this is the sysfs path.

I see, thanks!

>
>> Also, sensing the subject fix is for a different problem, and has been
>> verified, I'm happy to see it in upstream, so we have a better
>> code base to digger deeper in terms of how the destructive ndctl
>> commands interacts to typical mission critical applications, include
>> but not limited to rdma.
> Right, the crash signature you are seeing looks unrelated to the issue
> being address in these patches which is device-teardown racing active
> page pins. I'll start the investigation on the crash signature, but
> again I don't think it reads on this fix series.

Agreed on investigating the crash as separate issue, looking forward
to see this patchset in upstream.

Thanks!
-jane

