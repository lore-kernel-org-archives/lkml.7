Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E6BC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780A420665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FzemUOM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405066AbfHBVN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 17:13:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48578 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfHBVN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 17:13:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x72KxZ8R055215;
        Fri, 2 Aug 2019 21:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=TlF04q185lcuzR3fJX9ZXlx2yXo81WJ9iaInWTgL5pg=;
 b=FzemUOM6e6ylFQIXjyejmzykkHyjJgzalQKhCBE8SDbBg2y4X7dSwrtgfxyyO07MSyzh
 IuWhbGEsPAFIPenteVaDgeoBrH71xaN9CLrjT+dNM9O/dW+wrOi533vYdCWzwO8N45o3
 Ni+KGycL6jgcgY5Fh9XCSUBLEV5kQtKP/DG2bMx4xnq3qQvoujYzF7gzpXXKgWi0noDA
 IAhfGuB51/l7+bctFFkBlA8HBnia30P3vPg9TT6YPiPt47wW7exJCiaRnQFpiTPoetWF
 HOzHFHJoVppqekaOmd7b8vhvc6ijX5QiWzwIwXcIVi1kKsZC34LeU8VRZ6ykWgwG+Gom FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2u0f8rmg5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 21:12:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x72LChfF053129;
        Fri, 2 Aug 2019 21:12:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2u49hum3pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 21:12:55 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x72LCtDa003517;
        Fri, 2 Aug 2019 21:12:55 GMT
Received: from dhcp-10-159-253-80.vpn.oracle.com (/10.159.253.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Aug 2019 14:12:54 -0700
Subject: Re: [PATCH 7/7] tracing: Un-export ftrace_set_clr_event
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
References: <1564444954-28685-1-git-send-email-divya.indi@oracle.com>
 <1564444954-28685-8-git-send-email-divya.indi@oracle.com>
 <20190729205138.689864d2@gandalf.local.home>
 <8e50d405-a4fb-fadf-509e-157b031d7542@oracle.com>
 <20190802134229.2a969047@gandalf.local.home>
 <291a12f6-e1eb-052e-0dd6-0e649dd4a752@oracle.com>
 <20190802164641.46416744@gandalf.local.home>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <87e1a9b8-9f72-c240-9b9a-2d454046e2f3@oracle.com>
Date:   Fri, 2 Aug 2019 14:12:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802164641.46416744@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9337 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908020225
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9337 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908020224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

The first patch would be like a temporary fix in case we need more 
changes to the patches that add the new function - trace_array_set_clr() 
and unexport ftrace_set_clr_event() and might take some time. In which 
case I think it would be good to have this in place (But, not part of 
this series).

If they all are to go in together as part of the same release ie if all 
is good with the concerned patches (Patch 6 & Patch 7), then I think 
having this patch would be meaningless.


Thanks,

Divya

On 8/2/19 1:46 PM, Steven Rostedt wrote:
> On Fri, 2 Aug 2019 13:41:20 -0700
> Divya Indi <divya.indi@oracle.com> wrote:
>
>>> As a stand alone patch, the first one may be fine. But as part of a
>>> series, it doesn't make sense to add it.
>> I see. Will separate this out from the series.
> Is that really needed? Do you need to have that patch in the kernel?
>
> Do you plan on marking it for stable?
>
> -- Steve
