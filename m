Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246B4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E390F214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfCLJdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:33:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725767AbfCLJdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:33:44 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2C9T5R9041927
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 05:33:42 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r691a54en-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 05:33:42 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Tue, 12 Mar 2019 09:33:41 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Mar 2019 09:33:40 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2C9XdW220185218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 09:33:39 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 244B6AE05C;
        Tue, 12 Mar 2019 09:33:39 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E626AE062;
        Tue, 12 Mar 2019 09:33:38 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.102.1.56])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 12 Mar 2019 09:33:38 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id F0F7F2E2D40; Tue, 12 Mar 2019 15:02:46 +0530 (IST)
Date:   Tue, 12 Mar 2019 15:02:46 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powerpc/pseries: Only wait for dying CPU after call
 to rtas_stop_self()
Reply-To: ego@linux.vnet.ibm.com
References: <20190311193517.23756-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311193517.23756-1-bauerman@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 19031209-0060-0000-0000-0000031ABAAF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010743; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01173221; UDB=6.00613390; IPR=6.00953880;
 MB=3.00025943; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-12 09:33:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031209-0061-0000-0000-0000489509C5
Message-Id: <20190312093246.GA18313@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903120069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thiago,

On Mon, Mar 11, 2019 at 04:35:17PM -0300, Thiago Jung Bauermann wrote:
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

Thanks for this version. I have tested the patch and we no longer see
the "Querying DEAD? cpu X (Y) shows 2" message.


Tested-and-Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>


--
Thanks and Regards
gautham.

