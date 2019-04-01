Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8427C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D52720857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfDATZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:25:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbfDATZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:25:37 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x31JPVf2050936
        for <linux-kernel@vger.kernel.org>; Mon, 1 Apr 2019 15:25:35 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rkrjx0qav-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 15:25:34 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 1 Apr 2019 20:24:13 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Apr 2019 20:24:10 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x31JO9Nf25493746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 19:24:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5FA8B2065;
        Mon,  1 Apr 2019 19:24:09 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A824BB205F;
        Mon,  1 Apr 2019 19:24:09 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Apr 2019 19:24:09 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0A8B816C34EA; Mon,  1 Apr 2019 12:24:14 -0700 (PDT)
Date:   Mon, 1 Apr 2019 12:24:14 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     syzbot <syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com>
Cc:     alsa-devel-bounces@alsa-project.org, alsa-devel@alsa-project.org,
        colin.king@canonical.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, perex@perex.cz, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
Subject: Re: WARNING in port_delete
Reply-To: paulmck@linux.ibm.com
References: <0000000000004f7eb00570be9f92@google.com>
 <0000000000002402ed05857361e0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002402ed05857361e0@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040119-0060-0000-0000-000003270FDE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010856; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000283; SDB=6.01182908; UDB=6.00619249; IPR=6.00963650;
 MB=3.00026248; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-01 19:24:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040119-0061-0000-0000-000048CD54A0
Message-Id: <20190401192413.GQ4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-01_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904010125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 12:58:01AM -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 63d86a7e85f84b8ac3b2f394570965aedbb03787
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Tue May 1 20:08:46 2018 +0000
> 
>     rcu: Convert rcu_grace_period_init tracepoint to gp_seq
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f86d2f200000
> start commit:   091a1eaa Merge branch 'akpm'
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=14046d2f200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10046d2f200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
> dashboard link: https://syzkaller.appspot.com/bug?extid=e4c8abb920efa77bace9
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102e2c91400000
> 
> Reported-by: syzbot+e4c8abb920efa77bace9@syzkaller.appspotmail.com
> Fixes: 63d86a7e85f8 ("rcu: Convert rcu_grace_period_init tracepoint
> to gp_seq")

I could easily be suffering from a lack of imagination, but I am not
seeing how this change to RCU's event tracing could cause this result.
Especially given that CONFIG_RCU_TRACE=n in your .config.

What am I missing here?

							Thanx, Paul

> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 

