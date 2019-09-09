Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CC6C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE042086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChMYNjOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfIIIuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:50:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51609 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfIIIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:50:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so3141531wme.1;
        Mon, 09 Sep 2019 01:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TyudP/VRC3LbsAYBLp6egmY8gzAh/9aWbYA7KdCUhLo=;
        b=ChMYNjOE7Wvi27lqZVRkcvUyEcvNbcguAcSSHe9t0QGM6NeptCo3EQofn7R9/AlD2k
         uQWDIZGs1a4KahbPRTEBCp5t9kR8D/ipgtrWvPXTOg1HH/Tg20tX6+wDn19E9AnJFm7j
         rZtOnmqqAIg9qaY+8uI22adLwX9+pVwAFhoSC/inc/OnXYoB7Cxh80E6S1irw87ss9yj
         fFjlHhUJHoyOEfr/y9n2Q3dR1GVO/9J+qr23Mi/eyKmZKd5SU2FeAluKHmB9uag+HcRe
         1Ulf0OJqZV1LtN2/FQenwg7kgyjFWq5u9bGe8z7AyV6lC8Y/GyFHf4UL2XfDGqUo/jdF
         3aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TyudP/VRC3LbsAYBLp6egmY8gzAh/9aWbYA7KdCUhLo=;
        b=XRGArx+dF/nItJ2D4pH2EpjhC/m2YjPiVMz7aNe6nH+cZMtbspcgSrS+o/cmR6xGsC
         YcaGHGyjnLwWLsIq4q3qSivMHQ48knGLknoyvD4MFcoywG9JvfuT+xfFblWM3Rp0lbj8
         z9PEvb+WNGmkuG/xppsgTYnrkqiOGQSVDnrWECeRzppsJ+8ReRiw9RFGx5tH9i5AXfWW
         HupZrBE7/ye9NWwhMRjKe37BlfzhCbog7OcldOu5gmF6yXELWn+rJRc2BAsy5Hp1mwzj
         Q9yJwATXp2trEGPfzXPRO5aaOwmouABveVIc1ySrPsfya25TTJMQ8qkxJaCDMH491qEp
         KhGw==
X-Gm-Message-State: APjAAAUwpvdaBissyNwtnFy67eoZuGMzOS/rXpM+m89TFg8WycAnK5Aq
        Pac3m4BdZc9+ntZuilkpju8=
X-Google-Smtp-Source: APXvYqyLQP9dt2/pAYw8P428X5pwdQen7RwrjQIYQbGEF7sH1Cr7J/nn46Q7UtZDu0Am8oYSsEnxDg==
X-Received: by 2002:a05:600c:cf:: with SMTP id u15mr18878455wmm.168.1568019020765;
        Mon, 09 Sep 2019 01:50:20 -0700 (PDT)
Received: from dahern-DO-macbook.local ([148.69.85.38])
        by smtp.googlemail.com with ESMTPSA id v4sm22052149wrg.56.2019.09.09.01.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 01:50:20 -0700 (PDT)
Subject: Re: [PATCH] Add input file_name support for perf sched
 {map|latency|replay|timehist}
To:     =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        windyu@tencent.com, Adrian Hunter <adrian.hunter@intel.com>,
        Wang Nan <wangnan0@huawei.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com
References: <20190903085535.23913-1-ufo19890607@gmail.com>
 <CAHCio2iLvOSDEJ8JSnBx6w_65yekWNWu0B8wTAWbLDjy65J9JQ@mail.gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <37eecde1-52de-0d7a-608f-8b8125ee1155@gmail.com>
Date:   Mon, 9 Sep 2019 09:50:18 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHCio2iLvOSDEJ8JSnBx6w_65yekWNWu0B8wTAWbLDjy65J9JQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/19 4:49 AM, 禹舟键 wrote:
>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>> index 025151dcb651..8e51fbb88549 100644
>> --- a/tools/perf/builtin-sched.c
>> +++ b/tools/perf/builtin-sched.c
>> @@ -3374,6 +3374,7 @@ int cmd_sched(int argc, const char **argv)
>>         const struct option latency_options[] = {
>>         OPT_STRING('s', "sort", &sched.sort_order, "key[,key2...]",
>>                    "sort by key(s): runtime, switch, avg, max"),
>> +       OPT_STRING('i', "input", &input_name, "file", "input file name"),
>>         OPT_INTEGER('C', "CPU", &sched.profile_cpu,
>>                     "CPU to profile on"),
>>         OPT_BOOLEAN('p', "pids", &sched.skip_merge,
>> @@ -3381,11 +3382,13 @@ int cmd_sched(int argc, const char **argv)
>>         OPT_PARENT(sched_options)
>>         };
>>         const struct option replay_options[] = {
>> +       OPT_STRING('i', "input", &input_name, "file", "input file name"),
>>         OPT_UINTEGER('r', "repeat", &sched.replay_repeat,
>>                      "repeat the workload replay N times (-1: infinite)"),
>>         OPT_PARENT(sched_options)
>>         };
>>         const struct option map_options[] = {
>> +       OPT_STRING('i', "input", &input_name, "file", "input file name"),
>>         OPT_BOOLEAN(0, "compact", &sched.map.comp,
>>                     "map output in compact mode"),
>>         OPT_STRING(0, "color-pids", &sched.map.color_pids_str, "pids",
>> @@ -3397,6 +3400,7 @@ int cmd_sched(int argc, const char **argv)
>>         OPT_PARENT(sched_options)
>>         };
>>         const struct option timehist_options[] = {
>> +       OPT_STRING('i', "input", &input_name, "file", "input file name"),
>>         OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
>>                    "file", "vmlinux pathname"),
>>         OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
>> --
>> 2.23.0.37.g745f681
>>

This is not needed; -i already works with timehist (and others as I
recall). I believe OPT_PARENT passes the option to the subcommand.

