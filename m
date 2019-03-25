Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAAF20850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfCYK2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:28:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730512AbfCYK2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:28:54 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PAIwHs065238
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 06:28:53 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2retfp11uq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 06:28:52 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.ibm.com>;
        Mon, 25 Mar 2019 10:28:51 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Mar 2019 10:28:47 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2PASk4n60948666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 10:28:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 678324C04E;
        Mon, 25 Mar 2019 10:28:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD0F54C046;
        Mon, 25 Mar 2019 10:28:45 +0000 (GMT)
Received: from [9.145.180.32] (unknown [9.145.180.32])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Mar 2019 10:28:45 +0000 (GMT)
Subject: Re: [PATCH] mm/slab: protect cache_reap() against CPU and memory hot
 plug operations
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     stable@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190311191701.24325-1-ldufour@linux.ibm.com>
 <20190325003841.503582148D@mail.kernel.org>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Date:   Mon, 25 Mar 2019 11:28:45 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190325003841.503582148D@mail.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032510-0008-0000-0000-000002D135C5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032510-0009-0000-0000-0000223D5CE7
Message-Id: <bcca778f-646c-378e-68ef-fde3e17c842c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/03/2019 à 01:38, Sasha Levin a écrit :
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
> 
> The bot has tested the following trees: v5.0.3, v4.19.30, v4.14.107, v4.9.164, v4.4.176, v3.18.136.
> 
> v5.0.3: Build OK!
> v4.19.30: Build OK!
> v4.14.107: Build OK!
> v4.9.164: Build OK!
> v4.4.176: Failed to apply! Possible dependencies:
>      27590dc17b34 ("hrtimer: Convert to hotplug state machine")
>      31487f8328f2 ("smp/cfd: Convert core to hotplug state machine")
>      512089d98457 ("perf/x86/intel/rapl: Clean up the printk output")
>      55f2890f0726 ("perf/x86/intel/rapl: Add proper error handling")
>      57ecde42cc74 ("powerpc/perf: Convert book3s notifier to state machine callbacks")
>      6731d4f12315 ("slab: Convert to hotplug state machine")
>      6b2c28471de5 ("x86/x2apic: Convert to CPU hotplug state machine")
>      7162b8fea630 ("perf/x86/intel/rapl: Refactor the code some more")
>      75c7003fbf41 ("perf/x86/intel/rapl: Calculate timing once")
>      7ee681b25284 ("workqueue: Convert to state machine callbacks")
>      8a6d2f8f73ca ("perf/x86/intel/rapl: Utilize event->pmu_private")
>      8b5b773d6245 ("perf/x86/intel/rapl: Convert to hotplug state machine")
>      9de8d686955b ("perf/x86/intel/rapl: Convert it to a per package facility")
>      a208749c6426 ("perf/x86/intel/rapl: Make PMU lock raw")
>      a409f5ee2937 ("blackfin/perf: Convert hotplug notifier to state machine")
>      b8b3319a471b ("perf/x86/intel/rapl: Sanitize the quirk handling")
>      e3cfce17d309 ("sh/perf: Convert the hotplug notifiers to state machine callbacks")
>      e6d4989a9ad1 ("relayfs: Convert to hotplug state machine")
>      e722d8daafb9 ("profile: Convert to hotplug state machine")
> 
> v3.18.136: Failed to apply! Possible dependencies:
>      13ca62b243f6 ("ACPI: Fix minor syntax issues in processor_core.c")
>      27590dc17b34 ("hrtimer: Convert to hotplug state machine")
>      31487f8328f2 ("smp/cfd: Convert core to hotplug state machine")
>      4daa832d9987 ("x86: Drop bogus __ref / __refdata annotations")
>      57ecde42cc74 ("powerpc/perf: Convert book3s notifier to state machine callbacks")
>      645523960102 ("perf/x86/intel/rapl: Fix energy counter measurements but supporing per domain energy units")
>      6731d4f12315 ("slab: Convert to hotplug state machine")
>      6b2c28471de5 ("x86/x2apic: Convert to CPU hotplug state machine")
>      7162b8fea630 ("perf/x86/intel/rapl: Refactor the code some more")
>      7ee681b25284 ("workqueue: Convert to state machine callbacks")
>      828aef376d7a ("ACPI / processor: Introduce phys_cpuid_t for CPU hardware ID")
>      8b5b773d6245 ("perf/x86/intel/rapl: Convert to hotplug state machine")
>      9de8d686955b ("perf/x86/intel/rapl: Convert it to a per package facility")
>      a409f5ee2937 ("blackfin/perf: Convert hotplug notifier to state machine")
>      af8f3f514d19 ("ACPI / processor: Convert apic_id to phys_id to make it arch agnostic")
>      d02dc27db0dc ("ACPI / processor: Rename acpi_(un)map_lsapic() to acpi_(un)map_cpu()")
>      d089f8e97d37 ("x86: fix up obsolete cpu function usage.")
>      e3cfce17d309 ("sh/perf: Convert the hotplug notifiers to state machine callbacks")
>      e6d4989a9ad1 ("relayfs: Convert to hotplug state machine")
>      e722d8daafb9 ("profile: Convert to hotplug state machine")
>      ecf5636dcd59 ("ACPI: Add interfaces to parse IOAPIC ID for IOAPIC hotplug")
>      fdaf3a6539d6 ("x86: fix more deprecated cpu function usage.")
> 
> 
> How should we proceed with this patch?

Please forget about it.

As reported by Michal, this patch is useless.
Sorry for the noise.

Thanks,
Laurent.

