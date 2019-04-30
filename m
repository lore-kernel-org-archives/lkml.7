Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A05C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BAD120644
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbfD3Qec convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:34:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726105AbfD3Qeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:34:31 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3UGM0Fa068788
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 12:34:30 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s6rkj4kmr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 12:34:29 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nathanl@linux.ibm.com>;
        Tue, 30 Apr 2019 17:34:29 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 30 Apr 2019 17:34:26 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3UGYPTI19464192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 16:34:26 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9C10AC05E;
        Tue, 30 Apr 2019 16:34:25 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADC1BAC065;
        Tue, 30 Apr 2019 16:34:25 +0000 (GMT)
Received: from localhost (unknown [9.80.206.5])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Apr 2019 16:34:25 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v4] powerpc/pseries: Remove limit in wait for dying CPU
In-Reply-To: <20190423223914.3882-1-bauerman@linux.ibm.com>
References: <20190423223914.3882-1-bauerman@linux.ibm.com>
Date:   Tue, 30 Apr 2019 11:34:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19043016-0072-0000-0000-000004233511
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011023; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01196625; UDB=6.00627556; IPR=6.00977474;
 MB=3.00026669; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-30 16:34:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19043016-0073-0000-0000-00004C0622C1
Message-Id: <877ebbsb8u.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904300100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> This can be a problem because if the busy loop finishes too early, then the
> kernel may offline another CPU before the previous one finished dying,
> which would lead to two concurrent calls to rtas-stop-self, which is
> prohibited by the PAPR.
>
> Since the hotplug machinery already assumes that cpu_die() is going to
> work, we can simply loop until the CPU stops.
>
> Also change the loop to wait 100 µs between each call to
> smp_query_cpu_stopped() to avoid querying RTAS too often.

[...]

> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index 97feb6e79f1a..d75cee60644c 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -214,13 +214,17 @@ static void pseries_cpu_die(unsigned int cpu)
>  			msleep(1);
>  		}
>  	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {
> -
> -		for (tries = 0; tries < 25; tries++) {
> +		/*
> +		 * rtas_stop_self() panics if the CPU fails to stop and our
> +		 * callers already assume that we are going to succeed, so we
> +		 * can just loop until the CPU stops.
> +		 */
> +		while (true) {
>  			cpu_status = smp_query_cpu_stopped(pcpu);
>  			if (cpu_status == QCSS_STOPPED ||
>  			    cpu_status == QCSS_HARDWARE_ERROR)
>  				break;
> -			cpu_relax();
> +			udelay(100);
>  		}
>  	}

I agree with looping indefinitely but doesn't it need a cond_resched()
or similar check?

