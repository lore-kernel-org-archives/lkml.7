Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8825C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E5A205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfIRMbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:31:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725902AbfIRMbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:31:01 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8ICSEhx053540;
        Wed, 18 Sep 2019 08:30:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v3m2e9gu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 08:30:48 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8ICSNTJ054267;
        Wed, 18 Sep 2019 08:30:47 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v3m2e9gtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 08:30:47 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8ICUduw026397;
        Wed, 18 Sep 2019 12:30:47 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 2v37jw55bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 12:30:47 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8ICUj5w54657394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 12:30:46 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1D6278064;
        Wed, 18 Sep 2019 12:30:45 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AFD87805F;
        Wed, 18 Sep 2019 12:30:43 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.35.237])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 18 Sep 2019 12:30:43 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id DD1A22E2FC9; Wed, 18 Sep 2019 18:00:39 +0530 (IST)
Date:   Wed, 18 Sep 2019 18:00:39 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamaleshb@in.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH 0/2] pseries/hotplug: Change the default behaviour of
 cede_offline
Message-ID: <20190918123039.GA12534@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1568284541-15169-1-git-send-email-ego@linux.vnet.ibm.com>
 <87impxr0am.fsf@linux.ibm.com>
 <20190915074217.GA943@in.ibm.com>
 <87a7b2rfj0.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7b2rfj0.fsf@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=899 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909180127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nathan, Michael,

On Tue, Sep 17, 2019 at 12:36:35PM -0500, Nathan Lynch wrote:
> Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
> > On Thu, Sep 12, 2019 at 10:39:45AM -0500, Nathan Lynch wrote:
> >> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> >> > The patchset also defines a new sysfs attribute
> >> > "/sys/device/system/cpu/cede_offline_enabled" on PSeries Linux guests
> >> > to allow userspace programs to change the state into which the
> >> > offlined CPU need to be put to at runtime.
> >> 
> >> A boolean sysfs interface will become awkward if we need to add another
> >> mode in the future.
> >> 
> >> What do you think about naming the attribute something like
> >> 'offline_mode', with the possible values 'extended-cede' and
> >> 'rtas-stopped'?
> >
> > We can do that. However, IMHO in the longer term, on PSeries guests,
> > we should have only one offline state - rtas-stopped.  The reason for
> > this being, that on Linux, SMT switch is brought into effect through
> > the CPU Hotplug interface. The only state in which the SMT switch will
> > recognized by the hypervisors such as PHYP is rtas-stopped.
> 
> OK. Why "longer term" though, instead of doing it now?

Because adding extended-cede into a cpuidle state is non-trivial since
a CPU in that state is non responsive to external interrupts. We will
additional changes in the IPI, Timer and the Interrupt code to ensure
that these get translated to a H_PROD in order to wake-up the target
CPU in extended CEDE.

Timer: is relatively easy since the cpuidle infrastructure has the
       timer-offload framework (used for fastsleep in POWER8) where we
       can offload the timers of an idling CPU to another CPU which
       can wakeup the CPU when the timer expires via an IPI.

IPIs: We need to ensure that icp_hv_set_qirr() correctly sends H_IPI
      or H_PROD depending on whether or not the target CPU is in
      extended CEDE.

Interrupts: Either we migrate away the interrupts from the CPU that is
            entering extended CEDE or we prevent a CPU that is the
            sole target for an interrupt from entering extended CEDE.

The accounting problem in tools such as lparstat with
"cede_offline=on" is affecting customers who are using these tools for
capacity-planning. That problem needs a fix in the short-term, for
which Patch 1 changes the default behaviour of cede_offline from "on"
to "off". Since this patch would break the existing userspace tools
that use the CPU-Offline infrastructure to fold CPUs for saving power,
the sysfs interface allowing a runtime change of cede_offline_enabled
was provided to enable these userspace tools to cope with minimal
change.

> 
> 
> > All other states (such as extended-cede) should in the long-term be
> > exposed via the cpuidle interface.
> >
> > With this in mind, I made the sysfs interface boolean to mirror the
> > current "cede_offline" commandline parameter. Eventually when we have
> > only one offline-state, we can deprecate the commandline parameter as
> > well as the sysfs interface.
> 
> I don't care for adding a sysfs interface that is intended from the
> beginning to become vestigial...

Fair point. Come to think of it, in case the cpuidle menu governor
behaviour doesn't match the expectations provided by the current
userspace solutions for folding idle CPUs for power-savings, it would
be useful to have this option around so that existing users who prefer
the userspace solution can still have that option.

> 
> This strikes me as unnecessarily incremental if you're changing the
> default offline state. Any user space programs depending on the current
> behavior will have to change anyway (and why is it OK to break them?)
>

Yes, the current userspace program will need to be modified to check
for the sysfs interface and change the value to
cede_offline_enabled=1.

> Why isn't the plan:
> 
>   1. Add extended cede support to the pseries cpuidle driver
>   2. Make stop-self the only cpu offline state for pseries (no sysfs
>      interface necessary)

This is the plan, except that 1. requires some additional work and
this patchset is proposed as a short-term mitigation until we get
1. right.

> 
> ?

--
Thanks and Regards
gautham.
