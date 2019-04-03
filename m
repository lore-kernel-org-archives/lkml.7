Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FACC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052992084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u9ynQVtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfDCPbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:31:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46616 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfDCPbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:31:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33FOCjh057518;
        Wed, 3 Apr 2019 15:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=4QXh81wR3zsoqLqoDnsS51MdvvcQecl6/5L4N60e6ZE=;
 b=u9ynQVtmgVdcm53I/mev912u4CDFKjfTfSTrig7jDC4oITLQDQVtuoE9bKtF+6Ae+g1B
 Tv/cwptKziwwL4kWsFt9ODe/ZOenMrfAB+b5KM5zXeI7t3wmbEW3rQhnvZm9Z+LdeM0C
 ssqz70JDqFzry+bO3QR/zPu9y4wA9/6kCNSW0xLxe1RwJjLFrN4ixBuiwNL9iKAwI7My
 UKymPmcB4lH7yGGpbKNPQiy3kjHN78yf+DmxLqTHFQqI05vUWu45R7OaOdBkFqaHPa2H
 SYOZdTxYcQ/i4Bnpw/2gLf31bYYQHGChD5Txpl2XhhkVrQRqCsv4bFnXnmkZLQzHrVeN pQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2rhyvt9u40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 15:31:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33FVbqt117679;
        Wed, 3 Apr 2019 15:31:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2rm8f65ma3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 15:31:37 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x33FVQAC015423;
        Wed, 3 Apr 2019 15:31:26 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Apr 2019 08:31:25 -0700
Date:   Wed, 3 Apr 2019 18:31:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [5/7] cpufreq/pasemi: Checking implementation of
 pas_cpufreq_cpu_init()
Message-ID: <20190403153115.GA22624@kadam>
References: <1554082674-2049-6-git-send-email-wen.yang99@zte.com.cn>
 <c0c9c429-a09f-41ba-611d-123b64e410c8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0c9c429-a09f-41ba-611d-123b64e410c8@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=967
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030104
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 04:23:54PM +0200, Markus Elfring wrote:
> > @@ -146,6 +146,7 @@  static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >
> >  	cpu = of_get_cpu_node(policy->cpu, NULL);
> >
> > +	of_node_put(cpu);
> >  	if (!cpu)
> >  		goto out;
> 
> Can the statement “return -ENODEV” be nicer as exception handling
> in the if branch of this source code place?
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/cpufreq/pasemi-cpufreq.c?id=bf97b82f37c6d90e16de001d0659644c57fa490d#n137
> 

Why am I only receiving only one side of this conversation?

I don't know why you're responding to...  It's not required to fix/change
unrelated style choices.  If people want, they can just focus on their
own thing.

regards,
dan carpenter

