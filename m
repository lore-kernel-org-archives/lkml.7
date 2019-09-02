Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1EAC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA9B216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zv6I/vnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfIBLKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 07:10:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52012 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730277AbfIBLKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 07:10:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x82B9QA3003761;
        Mon, 2 Sep 2019 11:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=8Ppji8qGbcASH6uk0TDCwGeLmvTPI4dJnc6pTo22Ce0=;
 b=Zv6I/vnEMRyLoBnpGYwaRAqrkkCCAU0ysXuPeQQXMwqhhEV7x+4nNi5rGN//oHNpD1yN
 W783HlUw2Q+82K48bI4WYxoxXVPB58ztlJye6Z30ECuK0mRxTyEHbdQz5ARmE2WqqGqV
 lGKOisNhfZuqEhbU87nFHVuV65y1erfqivNHZhcN0HtYYoT7Bud7p+fBdZQJ0doruiH9
 YUMSLidX45mWL9RfwKSDCtKoWYaKF4wRpV4/181BDvvRqhDCq5gGD/9ulGLfhui9F124
 hUz0hnig51erZUZUvpakHK2VZDLF6Tvx/I0qHgm3TJmw+mLWjLdtjmETv+xHAt2Ry3pW 2A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2us1cbg549-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Sep 2019 11:10:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x82B9N8P102202;
        Mon, 2 Sep 2019 11:10:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2uqg83214p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Sep 2019 11:10:37 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x82BAZtN025913;
        Mon, 2 Sep 2019 11:10:36 GMT
Received: from [172.17.0.254] (/141.85.241.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Sep 2019 04:10:35 -0700
Subject: Re: [PATCH] Parallel microcode update in Linux
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, ashok.raj@intel.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        patrick.colp@oracle.com, kanth.ghatraju@oracle.com,
        Jon.Grimm@amd.com, Thomas.Lendacky@amd.com
References: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
 <20190901172547.GD1047@bug> <5BACA033-7613-49A9-801C-9F75F4306909@oracle.com>
 <20190902073931.GA15850@amd>
From:   Mihai Carabas <mihai.carabas@oracle.com>
Message-ID: <c2bafc82-2e93-ab5c-d1ac-68ef94d8eebc@oracle.com>
Date:   Mon, 2 Sep 2019 14:10:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902073931.GA15850@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: ro
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909020128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909020128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

La 02.09.2019 10:39, Pavel Machek a scris:
> Hi!
> 
>>>> +       u64 p0, p1;
>>>>         int ret;
>>>>
>>>>         atomic_set(&late_cpus_in,  0);
>>>>         atomic_set(&late_cpus_out, 0);
>>>>
>>>> +       p0 = rdtsc_ordered();
>>>> +
>>>>         ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
>>>> +
>>>> +       p1 = rdtsc_ordered();
>>>> +
>>>>         if (ret > 0)
>>>>                 microcode_check();
>>>>
>>>>         pr_info("Reload completed, microcode revision: 0x%x\n", boot_cpu_data.microcode);
>>>>
>>>> +       pr_info("p0: %lld, p1: %lld, diff: %lld\n", p0, p1, p1 - p0);
>>>> +
>>>>         return ret;
>>>> }
>>>>
>>>> We have used a machine with a broken microcode in BIOS and no microcode in
>>>> initramfs (to bypass early loading).
>>>>
>>>> Here are the results for parallel loading (we made two measurements):
>>>
>>>> [   18.197760] microcode: updated to revision 0x200005e, date = 2019-04-02
>>>> [   18.201225] x86/CPU: CPU features have changed after loading microcode, but might not take effect.
>>>> [   18.201230] microcode: Reload completed, microcode revision: 0x200005e
>>>> [   18.201232] microcode: p0: 118138123843052, p1: 118138153732656, diff: 29889604
>>>
>>>> Here are the results of serial loading:
>>>>
>>>> [   17.542518] microcode: updated to revision 0x200005e, date = 2019-04-02
>>>> [   17.898365] x86/CPU: CPU features have changed after loading microcode, but might not take effect.
>>>> [   17.898370] microcode: Reload completed, microcode revision: 0x200005e
>>>> [   17.898372] microcode: p0: 149220216047388, p1: 149221058945422, diff: 842898034
>>>>
>>>> One can see that the difference is an order magnitude.
>>>
>>> Well, that's impressive, but it seems to finish 300 msec later? Where does that difference
>>> come from / how much real time do you gain by this?
>>
>> The difference comes from the large amount of cores/threads the machine has: 72 in this case, but there are machines with more. As the commit message says initially the microcode was applied serially one by one and now the microcode is updated in parallel on all cores.
>>
>> 300ms seems nothing but it is enough to cause disruption in some critical services (e.g. storage) - 300ms in which we do not execute anything on CPUs. Also this 300ms is increasing when the machine is fully loaded with guests.
>>
> 
> Yes, but if you look at the dmesgs I quoted, paralel microcode update
> actually finished 300msec _later_.

That is the serial loading (it is written before: "Here are the results 
of serial loading:"), parallel is before. Am I missing something?


> 									Pavel
> 

