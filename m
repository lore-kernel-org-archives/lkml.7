Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596C1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2458020872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ugw3hlPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfCSCjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:39:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34750 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfCSCjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:39:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2J2XtGG039801;
        Tue, 19 Mar 2019 02:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=SrWCrmloewbKXSPqrcNLcMLvFQIickS8gB6OQnyLIqE=;
 b=Ugw3hlPwueaNL/T1bU800q/ff+UsRfVTIrCf2CxmJq4G/i0tMEZRQdms3HZvzIB32NEk
 51LNBg5YkCemtKXxPft5OLpj6ITT6Z0VRIvJuPWf1zuNbRkIy9rhmm5WnUxyIWRHIdil
 pSYtEVACapZtG1jfH1wK9fOJ60hFmFEP1MVvzUR6qd+LTlHRMmCEkcXq5l1/cfxp9KpT
 VnOGcrshsPCsjt0stR2OOxsyRZb5BKkx8wA88Woa6p1yHylq1cJEOtvt1xYpihSI4ESf
 lNlewIk4LlZcsZTQHL9f1nJpwtYqa40QfHH/04GYGzZL1Ze29iwrkRtL5AnnE6biS2Af nA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2r8rjuhyvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 02:38:55 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2J2cnOu020920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 02:38:50 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2J2cn5X023967;
        Tue, 19 Mar 2019 02:38:49 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Mar 2019 19:38:49 -0700
Subject: Re: [BUG] scsi: ses: out of bound accessing in
 ses_enclosure_data_process
To:     "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.ibm.com,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Junxiao Bi <junxiao.bi@oracle.com>, diego.gonzalez@oracle.com
References: <78dd3eca-7e8a-72f9-07f9-e2c7cc4569b0@oracle.com>
 <yq1k1gwkc6x.fsf@oracle.com>
 <3b2542225e519a8cf8e329745b0ee2e2464787c7.camel@redhat.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <92bf2380-626c-d51a-3f8b-de30462d4dd3@oracle.com>
Date:   Tue, 19 Mar 2019 10:41:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <3b2542225e519a8cf8e329745b0ee2e2464787c7.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9199 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/19 11:22 PM, Ewan D. Milne wrote:
> On Mon, 2019-03-18 at 01:01 -0400, Martin K. Petersen wrote:
>> Jianchao,
>>
>>> When our customer probe the lpfc devices, they encountered odd memory
>>> corruption issues, and we get 'out of bound' access warning at
>>> following position after open KASAN
>>
>> Please provide the output of:
>>
>> # sg_ses -p 1 /dev/sgN
>> # sg_ses -p 7 /dev/sgN
>>
>> for the enclosure device in question.
>>
> 
> The ses driver is allocating kernel buffers based upon the size
> reported by RECEIVE DIAGNOSTIC commands, and is iterating through
> them based on sizes in the individual descriptors.  It appears to
> be vulnerable to incorrect data from the device causing out-of-bounds
> memory access, because the for() test does not prevent the use of
> the pointer in subsequent code, e.g.:
> 
>         for (i = 0; i < num_enclosures && type_ptr < buf + len; i++) {
>                 types += type_ptr[2];
>                 type_ptr += type_ptr[3] + 4;
>         }
> 
>         ses_dev->page1_types = type_ptr;
>         ses_dev->page1_num_types = types;
> 
> Whether or not this is the current problem, it's wrong.
> 

Yes, I definitely agree with this.
There should be some change here.

Thanks
Jianchao

