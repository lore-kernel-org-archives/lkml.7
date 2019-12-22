Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC43C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 12:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565682070A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 12:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfLVMAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 07:00:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726267AbfLVMAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 07:00:24 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBMBpt67062672
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 07:00:22 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x21f80mfd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 07:00:22 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Sun, 22 Dec 2019 12:00:20 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 22 Dec 2019 12:00:16 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBMC0FS950593814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Dec 2019 12:00:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FE94AE064;
        Sun, 22 Dec 2019 12:00:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43615AE04D;
        Sun, 22 Dec 2019 12:00:13 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Sun, 22 Dec 2019 12:00:13 +0000 (GMT)
Date:   Sun, 22 Dec 2019 17:30:12 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        valentin.schneider@arm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20191220084252.GL3178@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191220084252.GL3178@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19122212-0016-0000-0000-000002D74FBA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19122212-0017-0000-0000-000033399E19
Message-Id: <20191222120012.GB13192@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-22_01:2019-12-17,2019-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912220111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

* Mel Gorman <mgorman@techsingularity.net> [2019-12-20 08:42:52]:

> Changelog since V1
> o Alter code flow 						vincent.guittot
> o Use idle CPUs for comparison instead of sum_nr_running	vincent.guittot
> o Note that the division is still in place. Without it and taking
>   imbalance_adj into account before the cutoff, two NUMA domains
>   do not converage as being equally balanced when the number of
>   busy tasks equals the size of one domain (50% of the sum).
>   Some data is in the changelog.

I still plan to run SpecJBB on the same setup but for now I have few perf
bench test results. The setup and results are below.
We might notice that except for numa01, all other cases the system was not
fully loaded.
Summary: We seem to be regressing in all the 5 situations I tried.

lscpu o/p
Architecture:        ppc64le
Byte Order:          Little Endian
CPU(s):              256
On-line CPU(s) list: 0-255
Thread(s) per core:  8
Core(s) per socket:  1
Socket(s):           32
NUMA node(s):        8
Model:               2.1 (pvr 004b 0201)
Model name:          POWER8 (architected), altivec supported
Hypervisor vendor:   pHyp
Virtualization type: para
L1d cache:           64K
L1i cache:           32K
L2 cache:            512K
L3 cache:            8192K
NUMA node0 CPU(s):   0-31
NUMA node1 CPU(s):   32-63
NUMA node2 CPU(s):   64-95
NUMA node3 CPU(s):   96-127
NUMA node4 CPU(s):   128-159
NUMA node5 CPU(s):   160-191
NUMA node6 CPU(s):   192-223
NUMA node7 CPU(s):   224-255

numa01 is a set of 2 process each running 128 threads;
each thread doing 50 loops on 3GB process shared memory operations.

numa02 is a single process with 32 threads;
each thread doing 800 loops on 32MB thread local memory operations.

numa03 is a single process with 32 threads;
each thread doing 50 loops on 3GB process shared memory operations.

numa04 is a set of 8 process (as many nodes) each running 4 threads;
each thread doing 50 loops on 3GB process shared memory operations.

numa05 is a set of 16 process (twice as many nodes) each running 2 threads;
each thread doing 50 loops on 3GB process shared memory operations.

(Since we are measuring duration in seconds, lower is better;
-ve %Change would mean duration has increased)

v5.5-rc2
Testcase       Time:  Min        Max        Avg        StdDev
numa01.sh      Real:  479.46     501.07     490.26     10.80
numa01.sh      Sys:   79.74      128.24     103.99     24.25
numa01.sh      User:  118577.01  121002.82  119789.92  1212.90
numa02.sh      Real:  12.53      14.80      13.66      1.14
numa02.sh      Sys:   0.89       1.49       1.19       0.30
numa02.sh      User:  318.74     354.86     336.80     18.06
numa03.sh      Real:  80.19      83.64      81.91      1.73
numa03.sh      Sys:   3.87       3.91       3.89       0.02
numa03.sh      User:  2501.34    2574.68    2538.01    36.67
numa04.sh      Real:  59.62      65.79      62.70      3.09
numa04.sh      Sys:   26.99      29.36      28.17      1.19
numa04.sh      User:  1637.57    1657.55    1647.56    9.99
numa05.sh      Real:  58.03      60.54      59.28      1.26
numa05.sh      Sys:   66.01      66.48      66.25      0.24
numa05.sh      User:  1522.61    1526.41    1524.51    1.90

v5.5-rc2 + patch
Testcase       Time:  Min        Max        Avg        StdDev   %Change
numa01.sh      Real:  518.80     526.75     522.77     3.97     -6.2188%
numa01.sh      Sys:   133.63     154.35     143.99     10.36    -27.7797%
numa01.sh      User:  123964.16  127670.38  125817.27  1853.11  -4.79056%
numa02.sh      Real:  23.70      24.58      24.14      0.44     -43.4134%
numa02.sh      Sys:   1.66       1.99       1.82       0.17     -34.6154%
numa02.sh      User:  525.45     550.45     537.95     12.50    -37.392%
numa03.sh      Real:  111.58     139.86     125.72     14.14    -34.8473%
numa03.sh      Sys:   4.32       4.34       4.33       0.01     -10.1617%
numa03.sh      User:  2837.44    3581.76    3209.60    372.16   -20.9244%
numa04.sh      Real:  102.01     110.14     106.08     4.06     -40.8937%
numa04.sh      Sys:   41.62      41.63      41.62      0.01     -32.3162%
numa04.sh      User:  2402.66    2465.31    2433.98    31.33    -32.31%
numa05.sh      Real:  97.96      109.59     103.78     5.81     -42.8792%
numa05.sh      Sys:   76.57      84.83      80.70      4.13     -17.9058%
numa05.sh      User:  2196.67    2689.63    2443.15    246.48   -37.6006%

vmstat counters

+ve %Change would mean hits have increased)
vmstat counters for numa01
param                   v5.5-rc2    with_patch  %Change
-----                   ----------  ----------  -------
numa_hint_faults        2075794     2162993     4.20075%
numa_hint_faults_local  363105      393400      8.34332%
numa_hit                1333086     1190972     -10.6605%
numa_local              1332945     1190789     -10.6648%
numa_other              141         183         29.7872%
numa_pages_migrated     303268      316709      4.43205%
numa_pte_updates        2076930     2164327     4.20799%
pgfault                 4773768     4378411     -8.28186%
pgmajfault              288         266         -7.63889%
pgmigrate_success       303268      316709      4.43205%

vmstat counters for numa02
param                   v5.5-rc2    with_patch  %Change
-----                   ----------  ----------  -------
numa_hint_faults        61234       90455       47.7202%
numa_hint_faults_local  31024       69953       125.48%
numa_hit                78931       68528       -13.1799%
numa_local              78931       68528       -13.1799%
numa_pages_migrated     30005       20281       -32.4079%
numa_pte_updates        63694       92503       45.2303%
pgfault                 139196      161149      15.7713%
pgmajfault              65          70          7.69231%
pgmigrate_success       30005       20281       -32.4079%

vmstat counters for numa03
param                   v5.5-rc2    with_patch  %Change
-----                   ----------  ----------  -------
numa_hint_faults        692956      799162      15.3265%
numa_hint_faults_local  95121       167989      76.6056%
numa_hit                256729      223528      -12.9323%
numa_local              256729      223528      -12.9323%
numa_pages_migrated     106499      116825      9.69587%
numa_pte_updates        693020      803373      15.9235%
pgfault                 1003178     1004960     0.177635%
pgmajfault              84          79          -5.95238%
pgmigrate_success       106499      116825      9.69587%

vmstat counters for numa04
param                   v5.5-rc2    with_patch  %Change
-----                   ----------  ----------  -------
numa_hint_faults        4766686     5512065     15.6373%
numa_hint_faults_local  2574830     3040466     18.0841%
numa_hit                1797339     1975390     9.90637%
numa_local              1797330     1975357     9.90508%
numa_pages_migrated     958674      1144133     19.3454%
numa_pte_updates        4784502     5533075     15.6458%
pgfault                 5855953     6546520     11.7926%
pgmajfault              124         118         -4.83871%
pgmigrate_success       958674      1144133     19.3454%

vmstat counters for numa05
param                   v5.5-rc2    with_patch  %Change
-----                   ----------  ----------  -------
numa_hint_faults        11252825    10988104    -2.35248%
numa_hint_faults_local  7379141     8290124     12.3454%
numa_hit                3669519     2964756     -19.2059%
numa_local              3669518     2964702     -19.2073%
numa_pages_migrated     2050570     1696810     -17.2518%
numa_pte_updates        11326394    11003544    -2.85042%
pgfault                 13059535    12747105    -2.39235%
pgmajfault              83          433         421.687%
pgmigrate_success       2050570     1696810     -17.2518%

-- 
Thanks and Regards
Srikar Dronamraju

