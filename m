Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6976C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBB32077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfLDMoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:44:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbfLDMoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:44:39 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4CgJnU085212;
        Wed, 4 Dec 2019 07:44:31 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wnjeb0a5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 07:44:30 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xB4CZ8p3022319;
        Wed, 4 Dec 2019 12:37:30 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 2wkg26xf7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 12:37:30 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB4CbT5J40632730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Dec 2019 12:37:29 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4C8A2805A;
        Wed,  4 Dec 2019 12:37:29 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97A812805C;
        Wed,  4 Dec 2019 12:37:29 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.31.190])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  4 Dec 2019 12:37:29 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id ACABD2E2EB4; Wed,  4 Dec 2019 18:07:28 +0530 (IST)
Date:   Wed, 4 Dec 2019 18:07:28 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] powerpc/sysfs: Show idle_purr and idle_spurr for
 every CPU
Message-ID: <20191204123728.GD5197@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1574856072-30972-1-git-send-email-ego@linux.vnet.ibm.com>
 <1574856072-30972-3-git-send-email-ego@linux.vnet.ibm.com>
 <9b8f82b0-86dd-d524-aae6-34f8c33bd2c2@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b8f82b0-86dd-d524-aae6-34f8c33bd2c2@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamalesh,

On Tue, Dec 03, 2019 at 07:07:53PM +0530, Kamalesh Babulal wrote:
> On 11/27/19 5:31 PM, Gautham R. Shenoy wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > On Pseries LPARs, to calculate utilization, we need to know the
> > [S]PURR ticks when the CPUs were busy or idle.
> > 
> > The total PURR and SPURR ticks are already exposed via the per-cpu
> > sysfs files /sys/devices/system/cpu/cpuX/purr and
> > /sys/devices/system/cpu/cpuX/spurr.
> > 
> > This patch adds support for exposing the idle PURR and SPURR ticks via
> > /sys/devices/system/cpu/cpuX/idle_purr and
> > /sys/devices/system/cpu/cpuX/idle_spurr.
> 
> The patch looks good to me, with a minor file mode nit pick mentioned below.
> 
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/sysfs.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> > index 80a676d..42ade55 100644
> > --- a/arch/powerpc/kernel/sysfs.c
> > +++ b/arch/powerpc/kernel/sysfs.c
> > @@ -1044,6 +1044,36 @@ static ssize_t show_physical_id(struct device *dev,
> >  }
> >  static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
> > 
> > +static ssize_t idle_purr_show(struct device *dev,
> > +			      struct device_attribute *attr, char *buf)
> > +{
> > +	struct cpu *cpu = container_of(dev, struct cpu, dev);
> > +	unsigned int cpuid = cpu->dev.id;
> > +	struct lppaca *cpu_lppaca_ptr = paca_ptrs[cpuid]->lppaca_ptr;
> > +	u64 idle_purr_cycles = be64_to_cpu(cpu_lppaca_ptr->wait_state_cycles);
> > +
> > +	return sprintf(buf, "%llx\n", idle_purr_cycles);
> > +}
> > +static DEVICE_ATTR_RO(idle_purr);
> 
> per cpu purr/spurr sysfs file is created with file mode 0400. Using
> DEVICE_ATTR_RO for their idle_* variants will create sysfs files with 0444 as
> their file mode, you should probably use DEVICE_ATTR() with file mode 0400 to
> have consist permission for both variants.

Thanks for catching this. I missed checking the permissions of purr
and spurr. Will send another version.


> 
> -- 
> Kamalesh
