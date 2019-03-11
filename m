Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F21C10F0C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DA4206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ENlxhxor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfCKJNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:13:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33573 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfCKJNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:13:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id i8so4180745wrm.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v/GXb4J8pruY+jsYpA5h+s1lRj17Oc3uyTpQGDh1w8w=;
        b=ENlxhxor5yVkfqj2Mq6zMM7gCyyA+zH9ueY3O0/xLlglPlG3wLfjh+lIwxAkBjlmQb
         Sc1yNzXV1MLPSVi7eQ4MFpRmIBXWLuHBhyECz88wd8EtirjfzAjcKlqZGEW3WqqYXbD/
         k7c21cH1AfFDfluvsCNoLlJ9FKYkh9NkmIsOWCU/sGzPShLy3AACvkBNqLrQ3xhtfmy5
         ZHtiLUP5L6gsypO1yzzuKMr9zzdwEZOQqeLYMtoCEXly74RikDFQRZnRN+xxnpwikM06
         Elr6vy2UEpbpuMOUeTeTlMmEq7RK51AE56NxxcdAQDkonGOCoDMQnMwLs+WTh/srZbBq
         jNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=v/GXb4J8pruY+jsYpA5h+s1lRj17Oc3uyTpQGDh1w8w=;
        b=Ypr8+OiRkU0H0FT3P5iaTkTxlEY8kfEyUyGX/F35+yXZMyb+uoU0LTgMcvv57CPCow
         N42CI22ePjP5/poWKm3wvJeCKDDdRVW1W1fb8yFUkjl8bQ3YlGVapqqmCLUG040Piodh
         CgpOwE03JRjhl6uLhTuSZNV5CdUhgvM/rO3I7PDILCS1kpoR2BzxUm/T297XBYf6mHVJ
         TS0PhHVXwZXJMwg3ihV/Dtg1+ZtcdXxFDddHtRtBBRKSxLsqQ9VSzhSfda4b4ujKzhQc
         XJFosYm+nzn82VIxKbdp5XU7zi22L+73ubuNcnFcGbFyWC8McujSj0CqNHC+k/qStMCN
         LWHQ==
X-Gm-Message-State: APjAAAVl9KPufYRIKsQgwTfSj14M89ZOWYymA4VY3Iz5ao7dhD8VOv0H
        R/UBTHht3pgo9ZuwjqsSgtr4gQ==
X-Google-Smtp-Source: APXvYqwo6hItvEQ9SuWbQ7XxvTra4ikvKzQiaWvfbWCT4LFBxxglZklsf9KhIqXT3U6OzD1sJmIiJQ==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr2430118wrk.197.1552295614993;
        Mon, 11 Mar 2019 02:13:34 -0700 (PDT)
Received: from [192.168.0.100] (146-241-91-215.dyn.eolo.it. [146.241.91.215])
        by smtp.gmail.com with ESMTPSA id w4sm22318088wmg.8.2019.03.11.02.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 02:13:34 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BUGFIX IMPROVEMENT V2 7/9] block, bfq: print SHARED
 instead of pid for shared queues in logs
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <491be7d2-cbe2-a1f1-e102-b449b3a8ace6@applied-asynchrony.com>
Date:   Mon, 11 Mar 2019 10:13:31 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Oleksandr Natalenko' via bfq-iosched 
        <bfq-iosched@googlegroups.com>, oleksandr@natalenko.name,
        fra.fra.800@gmail.com, alessio.masola@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <74D5550B-765A-46C4-9663-F2CEA2E95F5E@linaro.org>
References: <20190310181137.2604-1-paolo.valente@linaro.org>
 <20190310181137.2604-8-paolo.valente@linaro.org>
 <491be7d2-cbe2-a1f1-e102-b449b3a8ace6@applied-asynchrony.com>
To:     =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 11 mar 2019, alle ore 10:08, Holger Hoffst=C3=A4tte =
<holger@applied-asynchrony.com> ha scritto:
>=20
> Hi,
>=20
> Guess what - more problems ;-)

The curse of the print SHARED :)

Thank you very much Holger for testing what I guiltily did not.  I'll
send a v3 as Francesco fixes this too.

Paolo

> This time when building without CONFIG_BFQ_GROUP_IOSCHED, see below..
>=20
> On 3/10/19 7:11 PM, Paolo Valente wrote:
>> From: Francesco Pollicino <fra.fra.800@gmail.com>
>> The function "bfq_log_bfqq" prints the pid of the process
>> associated with the queue passed as input.
>> Unfortunately, if the queue is shared, then more than one process
>> is associated with the queue. The pid that gets printed in this
>> case is the pid of one of the associated processes.
>> Which process gets printed depends on the exact sequence of merge
>> events the queue underwent. So printing such a pid is rather
>> useless and above all is often rather confusing because it
>> reports a random pid between those of the associated processes.
>> This commit addresses this issue by printing SHARED instead of a pid
>> if the queue is shared.
>> Signed-off-by: Francesco Pollicino <fra.fra.800@gmail.com>
>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>> ---
>>  block/bfq-iosched.c | 10 ++++++++++
>>  block/bfq-iosched.h | 23 +++++++++++++++++++----
>>  2 files changed, 29 insertions(+), 4 deletions(-)
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 500b04df9efa..7d95d9c01036 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -2590,6 +2590,16 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct =
bfq_io_cq *bic,
>>  	 *   assignment causes no harm).
>>  	 */
>>  	new_bfqq->bic =3D NULL;
>> +	/*
>> +	 * If the queue is shared, the pid is the pid of one of the =
associated
>> +	 * processes. Which pid depends on the exact sequence of merge =
events
>> +	 * the queue underwent. So printing such a pid is useless and =
confusing
>> +	 * because it reports a random pid between those of the =
associated
>> +	 * processes.
>> +	 * We mark such a queue with a pid -1, and then print SHARED =
instead of
>> +	 * a pid in logging messages.
>> +	 */
>> +	new_bfqq->pid =3D -1;
>>  	bfqq->bic =3D NULL;
>>  	/* release process reference to bfqq */
>>  	bfq_put_queue(bfqq);
>> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
>> index 829730b96fb2..6410cc9a064d 100644
>> --- a/block/bfq-iosched.h
>> +++ b/block/bfq-iosched.h
>> @@ -32,6 +32,8 @@
>>  #define BFQ_DEFAULT_GRP_IOPRIO	0
>>  #define BFQ_DEFAULT_GRP_CLASS	IOPRIO_CLASS_BE
>>  +#define MAX_PID_STR_LENGTH 12
>> +
>>  /*
>>   * Soft real-time applications are extremely more latency sensitive
>>   * than interactive ones. Over-raise the weight of the former to
>> @@ -1016,13 +1018,23 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, =
struct bfq_queue *bfqq);
>>  /* --------------- end of interface of B-WF2Q+ ---------------- */
>>    /* Logging facilities. */
>> +static void bfq_pid_to_str(int pid, char *str, int len)
>> +{
>> +	if (pid !=3D -1)
>> +		snprintf(str, len, "%d", pid);
>> +	else
>> +		snprintf(str, len, "SHARED-");
>> +}
>> +
>>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
>>  struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
>>    #define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	do {			=
\
>> +	char pid_str[MAX_PID_STR_LENGTH];	\
>> +	bfq_pid_to_str((bfqq)->pid, pid_str, MAX_PID_STR_LENGTH);	=
\
>>  	blk_add_cgroup_trace_msg((bfqd)->queue,				=
\
>>  			bfqg_to_blkg(bfqq_group(bfqq))->blkcg,		=
\
>> -			"bfq%d%c " fmt, (bfqq)->pid,			=
\
>> +			"bfq%s%c " fmt, pid_str,			=
\
>>  			bfq_bfqq_sync((bfqq)) ? 'S' : 'A', ##args);	=
\
>>  } while (0)
>>  @@ -1033,10 +1045,13 @@ struct bfq_group *bfqq_group(struct =
bfq_queue *bfqq);
>>    #else /* CONFIG_BFQ_GROUP_IOSCHED */
>>  -#define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	\
>> -	blk_add_trace_msg((bfqd)->queue, "bfq%d%c " fmt, (bfqq)->pid,	=
\
>> +#define bfq_log_bfqq(bfqd, bfqq, fmt, args...) do {	\
>> +	char pid_str[MAX_PID_STR_LENGTH];	\
>> +	bfq_pid_to_str((bfqq)->pid, pid_str, MAX_PID_STR_LENGTH);	=
\
>> +	blk_add_trace_msg((bfqd)->queue, "bfq%s%c " fmt, pid_str,	=
\
>>  			bfq_bfqq_sync((bfqq)) ? 'S' : 'A',		=
\
>> -				##args)
>> +				##args)		\
> ---------------------------------------^ compilation error due to =
missing ;
>=20
>> +} while (0)
>>  #define bfq_log_bfqg(bfqd, bfqg, fmt, args...)		do {} =
while (0)
> ^^^^^^^^^^^^^^^^^^^^^^^^
> Here you re- and effectively undefine the previous new bfq_log_bfqq()
> definition with an empty block; I think you wanted to delete the =
second
> (empty) definition, otherwise the new code won't do much.
>=20
> Finally there is now a warning at bfq-cgroup.c:25 that =
bfq_pid_to_str()
> is defined but not used (in that compilation unit) since it is defined
> unconditionally for both cases of CONFIG_BFQ_GROUP_IOSCHED, which is
> required for bfq-cgroup.c. Since reordering the includes there won't =
work
> due to ifdef overlaps, the easiest fix for that is to mark =
bfq_pid_to_str()
> as "static inline", as already suggested by Oleksandr.
>=20
> With those changes it builds.
>=20
> cheers,
> Holger

