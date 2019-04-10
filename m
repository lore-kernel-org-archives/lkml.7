Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2187AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E485A2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfDJHRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:17:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45656 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726725AbfDJHRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:17:38 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3A7Fqlu143609
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 03:17:36 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rs9nf5gyu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 03:17:36 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Wed, 10 Apr 2019 08:17:34 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Apr 2019 08:17:32 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3A7HV8F30408782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 07:17:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FC4142045;
        Wed, 10 Apr 2019 07:17:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9D7A42049;
        Wed, 10 Apr 2019 07:17:30 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.134])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Apr 2019 07:17:30 +0000 (GMT)
Subject: Re: [PATCH] perf/report: [RFC] Handling OOM in perf report
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
References: <20190401142000.17679-1-tmricht@linux.ibm.com>
 <20190409104205.GB29688@krava>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Wed, 10 Apr 2019 09:17:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409104205.GB29688@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041007-0016-0000-0000-0000026D355C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041007-0017-0000-0000-000032C96251
Message-Id: <06273b1f-faea-5d88-1696-eb686ef47a6c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904100053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/19 12:42 PM, Jiri Olsa wrote:
> On Mon, Apr 01, 2019 at 04:20:00PM +0200, Thomas Richter wrote:
> 
> SNIP
> 
>> perf_session__process_event() returns to its caller, where -ENOMEM is
>> changed to -EINVAL and processing stops:
>>
>>  if ((skip = perf_session__process_event(session, event, head)) < 0) {
>>       pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
>> 	     head, event->header.size, event->header.type);
>>       err = -EINVAL;
>>       goto out_err;
>>  }
>>
>> This occured in the FINISHED_ROUND event when it has to process some
>> 10000 entries and ran out of memory.
>>
>> I understand that my perf.data file might just be too big, but I would
>> like to see some error message indicating OOM error instead of
>> processing failure of a unrelated event.
> 
> you can limit the size of the report queue via ~/.perfconfig file:
> 
> [report]
> queue-size=1M
> 
> above should use only 1M for the queue management data the data
> for sample still get allocated thought.. but it could help
> 
>>
>> However this patch just does what the pr_debug() statement indicates,
>> the event is skipped and processing continues.
>> But at least the root cause is indicated and also shows up in the
>> GUI.
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> ---
>>  tools/perf/builtin-report.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index 4054eb1f98ac..7a27b815f7a8 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -283,8 +283,13 @@ static int process_sample_event(struct perf_tool *tool,
>>  		al.map->dso->hit = 1;
>>  
>>  	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
>> -	if (ret < 0)
>> +	if (ret < 0) {
>>  		pr_debug("problem adding hist entry, skipping event\n");
>> +		if (ret == -ENOMEM) {
>> +			pr_err("Running out of memory\n");
>> +			ret = 0;
>> +		}
>> +	}
> 
> 
> I think we can propagate the error completely (like below),
> and even warn about ENOMEM specificaly
> 
> but I think we should bail out in case of ENOMEM, because
> the data are incomplete and misleading
> 
> jirka
> 
> 
> ---
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index b17f1c9bc965..eea247a26ad8 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1933,7 +1933,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
>  		       file_offset + head, event->header.size,
>  		       event->header.type);
> -		err = -EINVAL;
> +		err = skip;
>  		goto out;
>  	}
>  
> 

Above patch does not help, you simply return -ENOMEM instead of -EINVAL and processing
stops with no indication that perf ran out of memory. Bailing out in this case is ok.

I am fine with your patch, as long as it gives a reason why processing stopped.
In the GUI it shows on the bottom line the reason:

  0xf4198 [0x8]: failed to process type: 68 [Cannot allocate memory]


diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b17f1c9bc965..e89716175588 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1930,10 +1930,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
        if (size < sizeof(struct perf_event_header) ||
            (skip = rd->process(session, event, file_pos)) < 0) {
-               pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
+               pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
                       file_offset + head, event->header.size,
-                      event->header.type);
-               err = -EINVAL;
+                      event->header.type, strerror(-skip));
+               err = skip;
                goto out;
        }
 
[root@m35lp76 perf]#
-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

