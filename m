Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E42C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFDC2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbfCZV7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:59:15 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:46402 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726782AbfCZV7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:59:15 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QLrtvZ021168;
        Tue, 26 Mar 2019 21:58:48 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 2rfsy2h8kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Mar 2019 21:58:48 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id AEB8360;
        Tue, 26 Mar 2019 21:58:47 +0000 (UTC)
Received: from [16.214.194.75] (unknown [16.214.194.75])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 1284149;
        Tue, 26 Mar 2019 21:58:45 +0000 (UTC)
Subject: Re: [PATCH 3/6] bitmap_parselist: rework input string parser
To:     Yuri Norov <ynorov@marvell.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Travis <travis@sgi.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190325210748.6571-1-ynorov@marvell.com>
 <20190325210748.6571-4-ynorov@marvell.com>
 <20190326101045.GT9224@smile.fi.intel.com>
 <MN2PR18MB30862D49744CFC6FEAD78177CB5F0@MN2PR18MB3086.namprd18.prod.outlook.com>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <ae8abbbe-108d-93bd-99d6-251e0d1f36ac@hpe.com>
Date:   Tue, 26 Mar 2019 14:58:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <MN2PR18MB30862D49744CFC6FEAD78177CB5F0@MN2PR18MB3086.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/2019 2:09 PM, Yuri Norov wrote:
> + Mike Travis <travis@sgi.com>
> + Thomas Gleixner <tglx@linutronix.de>
> 
> ----------------------------------------------------------------------
> On Tue, Mar 26, 2019 at 12:07:45AM +0300, Yury Norov wrote:
>>> The requirement for this rework is to keep the __bitmap_parselist()
>>> copy-less and single-pass but make it more readable and maintainable by
>>> splitting into logical parts and removing explicit nested cycles and
>>> opaque local variables.
>>>
>>> __bitmap_parselist() can parse userspace inputs and therefore we cannot
>>> use simple_strtoul() to parse numbers.
> 
>> So, all above depends to what memory we access kernel / user space.
>> Perhaps we can get copy of memory of a given size and then parse it in kernel space always?
> 
>> --
>> With Best Regards,
>> Andy Shevchenko
> 
> What I missed during rework is that we have only one caller of *parselist_user  -
> it's write_irq_affinity() introduced by Mike Travis in kernel/irq/proc.c. It doesn't look
> like a hot path as it's file operations handler. If no objections from Mike or Thomas,

No objections from me as long as you can still change irq affinity using 
a cpulist instead of a cpumask.

Thanks,
Mike Travis


> I think it would make sense to copy_from_user() the userspace data at the beginning
> in sake of simplicity of __bitmap_parselist(), as you suggested above.
> 
> Yury
> 
