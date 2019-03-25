Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BF82075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfCYPCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:02:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728983AbfCYPCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:02:00 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PF1NPv046360
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:01:59 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rey6k7ce3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:01:56 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Mar 2019 15:01:37 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Mar 2019 15:01:33 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2PF1WTt10027028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 15:01:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAB33B2067;
        Mon, 25 Mar 2019 15:01:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C909B205F;
        Mon, 25 Mar 2019 15:01:32 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Mar 2019 15:01:32 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6AC6D16C42B1; Mon, 25 Mar 2019 08:01:33 -0700 (PDT)
Date:   Mon, 25 Mar 2019 08:01:33 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rcutorture: Select from only online CPUs
Reply-To: paulmck@linux.ibm.com
References: <20190323034619.15792-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323034619.15792-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032515-2213-0000-0000-00000369C128
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010811; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01179493; UDB=6.00617186; IPR=6.00960204;
 MB=3.00026147; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-25 15:01:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032515-2214-0000-0000-00005DC9DD62
Message-Id: <20190325150133.GA4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 11:46:19PM -0400, Joel Fernandes (Google) wrote:
> The rcutorture jitter.sh script selects a random CPU but does not check
> if it is offline or online. This leads to taskset errors many times. On
> my machine, hyper threading is disabled so half the cores are offline
> causing taskset errors a lot of times. Let us fix this by checking from
> only the online CPUs on the system.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Good catch!

Please see below for one suggestion for simplification.

							Thanx, Paul

> ---
>  tools/testing/selftests/rcutorture/bin/jitter.sh | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
> index 3633828375e3..53bf9d99b5cd 100755
> --- a/tools/testing/selftests/rcutorture/bin/jitter.sh
> +++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
> @@ -47,10 +47,19 @@ do
>  		exit 0;
>  	fi
>  
> -	# Set affinity to randomly selected CPU
> +	# Set affinity to randomly selected online CPU
>  	cpus=`ls /sys/devices/system/cpu/*/online |

	cpus=`grep 1 /sys/devices/system/cpu/*/online |

>  		sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//' |
>  		grep -v '^0*$'`

Of course, now I have no idea why I excluded CPU 0...  :-/

> +
> +	for c in $cpus; do
> +		if [ "$(cat /sys/devices/system/cpu/cpu$c/online)" == "1" ];
> +		then
> +			cpus_tmp="$cpus_tmp $c"
> +		fi
> +	done
> +	cpus=$cpus_tmp
> +
>  	cpumask=`awk -v cpus="$cpus" -v me=$me -v n=$n 'BEGIN {
>  		srand(n + me + systime());
>  		ncpus = split(cpus, ca);
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 

