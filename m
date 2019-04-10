Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435A6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E6E217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDJXI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:08:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725982AbfDJXI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:08:56 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3AMwv0p097990
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 19:08:55 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rsr7akuan-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 19:08:54 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 11 Apr 2019 00:08:53 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 00:08:52 +0100
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3AN8pN960096662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 23:08:51 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BE86BE053;
        Wed, 10 Apr 2019 23:08:51 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A8CEBE056;
        Wed, 10 Apr 2019 23:08:49 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.80.229.52])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 10 Apr 2019 23:08:49 +0000 (GMT)
References: <20190311193517.23756-1-bauerman@linux.ibm.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powerpc/pseries: Only wait for dying CPU after call to rtas_stop_self()
In-reply-to: <20190311193517.23756-1-bauerman@linux.ibm.com>
Date:   Wed, 10 Apr 2019 20:08:43 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19041023-0016-0000-0000-0000099F18F8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010905; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01187265; UDB=6.00621883; IPR=6.00968028;
 MB=3.00026383; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-10 23:08:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041023-0017-0000-0000-000042C48EB0
Message-Id: <87bm1dfog4.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904100150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Ping?

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:

> When testing DLPAR CPU add/remove on a system under stress,
> pseries_cpu_die() doesn't wait long enough for a CPU to die:
>
> [  446.983944] cpu 148 (hwid 148) Ready to die...
> [  446.984062] cpu 149 (hwid 149) Ready to die...
> [  446.993518] cpu 150 (hwid 150) Ready to die...
> [  446.993543] Querying DEAD? cpu 150 (150) shows 2
> [  446.994098] cpu 151 (hwid 151) Ready to die...
> [  447.133726] cpu 136 (hwid 136) Ready to die...
> [  447.403532] cpu 137 (hwid 137) Ready to die...
> [  447.403772] cpu 138 (hwid 138) Ready to die...
> [  447.403839] cpu 139 (hwid 139) Ready to die...
> [  447.403887] cpu 140 (hwid 140) Ready to die...
> [  447.403937] cpu 141 (hwid 141) Ready to die...
> [  447.403979] cpu 142 (hwid 142) Ready to die...
> [  447.404038] cpu 143 (hwid 143) Ready to die...
> [  447.513546] cpu 128 (hwid 128) Ready to die...
> [  447.693533] cpu 129 (hwid 129) Ready to die...
> [  447.693999] cpu 130 (hwid 130) Ready to die...
> [  447.703530] cpu 131 (hwid 131) Ready to die...
> [  447.704087] Querying DEAD? cpu 132 (132) shows 2
> [  447.704102] cpu 132 (hwid 132) Ready to die...
> [  447.713534] cpu 133 (hwid 133) Ready to die...
> [  447.714064] Querying DEAD? cpu 134 (134) shows 2
>
> This is a race between one CPU stopping and another one calling
> pseries_cpu_die() to wait for it to stop. That function does a short busy
> loop calling RTAS query-cpu-stopped-state on the stopping CPU to verify
> that it is stopped, but I think there's a lot for the stopping CPU to do
> which may take longer than this loop allows.
>
> As can be seen in the dmesg right before or after the "Querying DEAD?"
> messages, if pseries_cpu_die() waited a little longer it would have seen
> the CPU in the stopped state.
>
> What I think is going on is that CPU 134 was inactive at the time it was
> unplugged. In that case, dlpar_offline_cpu() calls H_PROD on that CPU and
> immediately calls pseries_cpu_die(). Meanwhile, the prodded CPU activates
> and start the process of stopping itself. The busy loop is not long enough
> to allow for the CPU to wake up and complete the stopping process.
>
> This can be a problem because if the busy loop finishes too early, then the
> kernel may offline another CPU before the previous one finished dying,
> which would lead to two concurrent calls to rtas-stop-self, which is
> prohibited by the PAPR.
>
> We can make the race a lot more even if we only start querying if the CPU
> is stopped when the stopping CPU is close to call rtas_stop_self(). Since
> pseries_mach_cpu_die() sets the CPU current state to offline almost
> immediately before calling rtas_stop_self(), we use that as a signal that
> it is either already stopped or very close to that point, and we can start
> the busy loop.
>
> As suggested by Michael Ellerman, this patch also changes the busy loop to
> wait for a fixed amount of wall time. Based on the measurements that
> Gautham did on a POWER9 system, in successful cases of
> smp_query_cpu_stopped(cpu) returning affirmative, the maximum time spent
> inside the loop was was 10 ms. This patch loops for 20 ms just be sure.
>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Analyzed-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> I have seen this problem since v4.8. Should this patch go to stable as
> well?
>
> Changes since v2:
> - Increaded busy loop to 200 iterations so that it can last up to 20 ms
>   (suggested by Gautham).
> - Changed commit message to include Gautham's remarks.
>
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index 97feb6e79f1a..ac6dc35ab829 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -214,13 +214,22 @@ static void pseries_cpu_die(unsigned int cpu)
>  			msleep(1);
>  		}
>  	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {
> +		/*
> +		 * If the current state is not offline yet, it means that the
> +		 * dying CPU (which is either in pseries_mach_cpu_die() or in
> +		 * the process of getting there) didn't have a chance yet to
> +		 * call rtas_stop_self() and therefore it's too early to query
> +		 * if the CPU is stopped.
> +		 */
> +		spin_event_timeout(get_cpu_current_state(cpu) == CPU_STATE_OFFLINE,
> +				   100000, 100);
>  
> -		for (tries = 0; tries < 25; tries++) {
> +		for (tries = 0; tries < 200; tries++) {
>  			cpu_status = smp_query_cpu_stopped(pcpu);
>  			if (cpu_status == QCSS_STOPPED ||
>  			    cpu_status == QCSS_HARDWARE_ERROR)
>  				break;
> -			cpu_relax();
> +			udelay(100);
>  		}
>  	}
>  

