Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9673BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CB421897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LvcTFOSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfICTpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:45:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54082 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfICTpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:45:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83JiMXo009875;
        Tue, 3 Sep 2019 19:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=TcHYT7fQGknNXWrgw/oj3v7CjWyrsoPnPVhaJsYNEW8=;
 b=LvcTFOSQnIbIlVQ11aR89BouEb4CDaGqxZMrtM9VxYc5KH0xulLKDi9OWuN5FuMYlbxC
 Cm2nizsd4UVR30jRt0H3jRVHeRJiertalfBbPsb9UVZ+HjzpoWFItQMnkQ7E4XQyOphA
 pLGFWvxlwpzJpl1nfUqPfU5/DNAkyVGpV0BOfUhn/mqwPlJ9q16BCviNFQE7chQeF7k9
 djWheAtxSuadqt7ubXe4tSq+UAk3UTF2iXB4jUO8fx3mnVibZJNAcWiBAqzQieQMnfyK
 rvLnz6ddmtPMc0FSmJJH0azQ3kUGUmEpn7G2g2dMF5o0WmyOswG0y4llZ4Ayhoej1eeB OQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2usxjh00eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 19:45:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83JidaA021983;
        Tue, 3 Sep 2019 19:45:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2us4weeaea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 19:45:28 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83JjOYv011183;
        Tue, 3 Sep 2019 19:45:24 GMT
Received: from [10.65.151.64] (/10.65.151.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Sep 2019 12:45:24 -0700
Subject: Re: [RFC PATCH 0/2] Add predictive memory reclamation and compaction
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Bharath Vedartham <linux.bhar@gmail.com>,
        akpm@linux-foundation.org, vbabka@suse.cz,
        mgorman@techsingularity.net, dan.j.williams@intel.com,
        osalvador@suse.de, richard.weiyang@gmail.com, hannes@cmpxchg.org,
        arunks@codeaurora.org, rppt@linux.vnet.ibm.com, jgg@ziepe.ca,
        amir73il@gmail.com, alexander.h.duyck@linux.intel.com,
        linux-mm@kvack.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20190813140553.GK17933@dhcp22.suse.cz>
 <3cb0af00-f091-2f3e-d6cc-73a5171e6eda@oracle.com>
 <20190814085831.GS17933@dhcp22.suse.cz>
 <d3895804-7340-a7ae-d611-62913303e9c5@oracle.com>
 <20190815170215.GQ9477@dhcp22.suse.cz>
 <2668ad2e-ee52-8c88-22c0-1952243af5a1@oracle.com>
 <20190821140632.GI3111@dhcp22.suse.cz>
 <20190826204420.GA16800@bharath12345-Inspiron-5559>
 <20190827061606.GN7538@dhcp22.suse.cz>
 <23eca880-d0d7-00f9-cb1b-b2998f2a1dff@oracle.com>
 <20190902080218.GF14028@dhcp22.suse.cz>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <017a11b1-4115-bdf6-6ebe-e121dd03b386@oracle.com>
Date:   Tue, 3 Sep 2019 13:45:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902080218.GF14028@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=880
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030196
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=933 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/19 2:02 AM, Michal Hocko wrote:
> On Fri 30-08-19 15:35:06, Khalid Aziz wrote:
> [...]
>> - Kernel is not self-tuning and is dependent upon a userspace tool to
>> perform well in a fundamental area of memory management.
>=20
> You keep bringing this up without an actual analysis of a wider range o=
f
> workloads that would prove that the default behavior is really
> suboptimal. You are making some assumptions based on a very specific DB=

> workload which might benefit from a more aggressive background workload=
=2E
> If you really want to sell any changes to auto tuning then you really
> need to come up with more workloads and an actual theory why an early
> and more aggressive reclaim pays off.
>=20

Hi Michal,

Fair enough. I have seen DB and cloud server workloads suffer under
default behavior of reclaim/compaction. It manifests itself as prolonged
delays in populating new database and in launching new cloud
applications. It is fair to ask for the predictive algorithm to be
proven before pulling something like this in kernel. I will implement
this same algorithm in userspace and use existing knobs to tune kernel
dynamically. Running that with large number of workloads will provide
data on how often does this help. If I find any useful tunables missing,
I will be sure to bring it up.

Thanks,
Khalid

