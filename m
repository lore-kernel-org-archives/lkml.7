Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCF2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AFC2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DINf0EIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfHNSnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:43:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45808 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbfHNSng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:43:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EIcmGn136901;
        Wed, 14 Aug 2019 18:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=ogTf0C7vEGLcQeFZFv8Efl6J1d0vvpCj4vlJxV70x7Y=;
 b=DINf0EIt8bJ66rb45YXVqckaWEBxqsKEBl8ld5JcS29HKKAFhCKRUtT9pOTNFJDCbTVZ
 Rl3yX5oSX4AScdMqI4HDYGaWJsySh1r7kcOgSGhkwCmf6TGIRj4fZNIwlUKD0205vVGO
 b8kHkCddDfoSAKGs+B3gh2lO0+yG/0sdnWsXswZOVyKkXBt7p6g2sppgdg3UA/CY2r/m
 GXwqrgbR1yMWabhD5LBLufxiUr8YdQxcHIc5u/13VTaJGPPq0K73Jo3cTqC4UB74Avn6
 jsa7h1RKgxeseJUjgDB4RUeB3pZ6Q/NskI9TJ6a1SjcgTe4G1heZ0Z0LmbQ/nSY7wnXW 4w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u9pjqpfgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 18:43:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EIciNM043330;
        Wed, 14 Aug 2019 18:43:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2ubwrhkuf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 18:43:06 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7EIh6hT008781;
        Wed, 14 Aug 2019 18:43:06 GMT
Received: from aruna-dev.us.oracle.com (/10.211.44.177)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 11:43:05 -0700
Subject: Re: [PATCH 2/5] tracing: Verify if trace array exists before
 destroying it.
To:     Divya Indi <divya.indi@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <1565805327-579-1-git-send-email-divya.indi@oracle.com>
 <1565805327-579-3-git-send-email-divya.indi@oracle.com>
Cc:     Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
From:   Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Message-ID: <090274c8-6e8c-2526-5515-dbd5cbc11093@oracle.com>
Date:   Wed, 14 Aug 2019 11:42:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1565805327-579-3-git-send-email-divya.indi@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=742
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=812 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/14/2019 10:55 AM, Divya Indi wrote:
> A trace array can be destroyed from userspace or kernel. Verify if the
> trace exists before proceeding to destroy/remove it.
>

^^ s/trace/trace array/

As you pointed out yourself. :)

All the patches look good to me. For this patchset:

Reviewed-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>

Thanks,
Aruna
