Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF82C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689392087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gMNXpYuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbfCYL5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:57:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60742 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731031AbfCYL5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:57:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2PBvClf004672;
        Mon, 25 Mar 2019 06:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553515032;
        bh=THLHzYaL2qNz12734MQVtCxdRhLPXqxOoWZ82S+kNMk=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=gMNXpYuL5tLC6q6gc/UQk4OPk83tYqkwhp9rvky4oo3WjsP/8qmACUs1zTW7Znuwg
         Rt/hirdXI6r2J8sHdTGuxN/LmJbl0c3rbSU0ofDfrXXlHNESu92BooimIb3Hy4I8C/
         Fdq3l4KvxOwtZgqWbDMYwML0M+5k4FF3HwSH9aPE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2PBvCBj053554
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 06:57:12 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 06:57:11 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 06:57:11 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2PBv84X028607;
        Mon, 25 Mar 2019 06:57:09 -0500
Subject: Re: INFO: task hung in process_measurement
To:     syzbot <syzbot+cdc562bc26a2b2b0a94f@syzkaller.appspotmail.com>,
        <airlied@linux.ie>, <dmitry.kasatkin@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <james.l.morris@oracle.com>,
        <jmorris@namei.org>, <jsarha@ti.com>,
        <linux-ima-devel@lists.sourceforge.net>,
        <linux-ima-user@lists.sourceforge.net>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <serge@hallyn.com>,
        <syzkaller-bugs@googlegroups.com>, <zohar@linux.vnet.ibm.com>
References: <000000000000f8654a0584bd7d5d@google.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <26a884b5-8fbe-57cd-a31e-ab1597681a03@ti.com>
Date:   Mon, 25 Mar 2019 13:57:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <000000000000f8654a0584bd7d5d@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2019 08:58, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 8fe5616b20e5742bb5fee0e77dffe2fc76ac92a0
> Author: Jyri Sarha <jsarha@ti.com>
> Date:   Tue Jun 14 08:43:30 2016 +0000
> 
>     drm/tilcdc: Restore old dpms state in pm_resume()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10daff1b200000
> start commit:   291d0e5d Merge tag 'for-linus-20180929' of
> git://git.kerne..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=12daff1b200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=14daff1b200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a8212f992609a887
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=cdc562bc26a2b2b0a94f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140e285e400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1237fe81400000
> 
> Reported-by: syzbot+cdc562bc26a2b2b0a94f@syzkaller.appspotmail.com
> Fixes: 8fe5616b20e5 ("drm/tilcdc: Restore old dpms state in pm_resume()")
> 
> For information about bisection process see:
> https://goo.gl/tpsmEJ#bisection

I don't think the patch from Jyri is related to the crash here.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
