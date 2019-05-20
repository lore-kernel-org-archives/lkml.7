Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3747CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7212081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DCRbZrTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388500AbfETPa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:30:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42024 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731262AbfETPaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:30:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4KFIvkS157728;
        Mon, 20 May 2019 15:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=0EvPgRUdCIUxRMJnLIUUNZuM8SwOIDsp1UXcz3PVWp8=;
 b=DCRbZrTzikqxea71r02YALc07W4tHXkFF63CP0Ug2ULSIKqWcnSOnp84cf2iaoGoeYFJ
 JfyL1pX+S6ThO6vX9WmFnrH8dy/nsA2bUVXjUAszMnjL+3HJCcVYFBHuee7JvgHmijSt
 nyyeaoQpBM7tdyRCip+6WMmS6+qgZyOPGLeAtuj7Dvcclqya/VaL/5PgVLLjNrvoiMlW
 OtqwLyJmOvoodi4harW84ohv/wk+KdixRbRHVZIi82hIrGSEx8tnFO19GTUJI+CLQrMe
 OfsCrAOp/uTwFaoeUrI4cmOvibvyLV5wnXiE3fPwOJMgUSOSEGJ5SQraLDdMY3dnufHu eA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2sjapq7mep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 15:29:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4KFS9v0161935;
        Mon, 20 May 2019 15:29:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2skudaurj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 15:29:53 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4KFTpxY021854;
        Mon, 20 May 2019 15:29:51 GMT
Received: from [10.132.107.27] (/10.132.107.27)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 May 2019 15:29:51 +0000
Subject: Re: [PATCH] tracing: Kernel access to Ftrace instances
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <1553106531-3281-1-git-send-email-divya.indi@oracle.com>
 <1553106531-3281-2-git-send-email-divya.indi@oracle.com>
 <20190516090942.75f3a957ceed20201edc91a6@kernel.org>
 <a96e884d-534f-65ef-8f82-85cd52953695@oracle.com>
 <20190516120529.4c1f6e6ddd516185df149625@kernel.org>
 <F331FDC8-9E63-4042-A933-BDC197C9A031@goodmis.org>
 <20190520112304.62db2c8c@gandalf.local.home>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>
From:   divya.indi@oracle.com
Organization: Oracle Corporation
Message-ID: <fc8fd0b5-f239-462a-6c22-52b99e56a843@oracle.com>
Date:   Mon, 20 May 2019 08:29:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20190520112304.62db2c8c@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905200100
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905200100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/20/2019 08:23 AM, Steven Rostedt wrote:
> On Wed, 15 May 2019 20:24:43 -0700
> Steven Rostedt <rostedt@goodmis.org> wrote:
>>> It seems your's already in Steve's ftrace/core branch, so I think you
>>> can make
>>> additional patch to fix it. Steve, is that OK?
>>>   
>> Yes. In fact I already sent a pull request to Linus.  Please send a patch on top of my ftrace/core branch.
>>
> And now it is in mainline (v5.2-rc1). Please send a patch with a sample
> module (as Masami requested). Also, that function not only needs to be
> changed to not being static, you need to add it to a header
> (include/linux/trace_events.h?)
>
> Thanks!
Working on it. Will send it out soon.

Thanks,
Divya
>
> -- Steve

