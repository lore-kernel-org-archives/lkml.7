Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0E1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA08621872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL5iQMsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfCOP4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:56:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46858 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfCOP4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:56:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id a22so6728345pgg.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 08:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uc0vhG3MhfVNRLJi1L55FK2F6GkpZbde9A7irg6mAKE=;
        b=BL5iQMsqaQdxv4rnWwvG3QcwVBmyyQwvSLuXRrRG3Qy2NwbjX9s5S3gEUmC6XWP3ie
         bJZtA55yMYkw5u1XZy7MtVXczCi6KAoAnWWF/EVA5edPnlwOJyGtHP1Bb19vY8N4T5Ql
         WraIzixtqmT086H/z5oWEVSxpIP+CrcFyvx1bnP822OV0lP+jU7OH9c0C8eWsom37+XK
         ny+asvkdvQqmp+vOK0GKjB/0VI4GnLNBhGDdI6oHP3lLNVduNMjTwcXcBURMHVlOpBMZ
         8mStknUZYq/qVka3F+pq5nuHbD7kKjveqEaUCDCZTNyJxMX9Fnv8JRjvVaogGFwrthoD
         MHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uc0vhG3MhfVNRLJi1L55FK2F6GkpZbde9A7irg6mAKE=;
        b=kjnu8KtlLXmOY1cHmgRCfhN/rq9eVZJq9VQ4CS+kDKati2QkGn4QIk27cel8lvmpA7
         8xGks9hDfcQzmrR63xWm1e8JTAg+ikLV2DX52cAC5C6MVPGCbNISnW9T+m/GWexSONO3
         0QHHySfCBQQap3kShcah6yuoJ4O3mn8oYonren9MsweYZE+ohFBIY757mBw/wmMiazg9
         QyyAtPZ79BFullNulScmdL5wYweDlB4jRdHCmNAG+IBSy6LJugzuTlk3cP8FmIoNYav5
         CRE3Uvkmd3iHHvTxgpsVjQEG1f+CML758fJtvalMEV0SiQCS8NajpPB4fwReuGXJWMWh
         hyYA==
X-Gm-Message-State: APjAAAUUUEuXwoddB8yHSqu66Uy9tuU6CxpnXio2iNFILZ7G1rHuVNkj
        PDfehoUayHwNfBaQIC7KGrs=
X-Google-Smtp-Source: APXvYqxq0xbgBXKSJSD7vCPqJjYT3VJRzgoKjHdyEHEPSAKSGpRooZaS0HABYVnzDRTlSzIBUp2N7w==
X-Received: by 2002:a63:df09:: with SMTP id u9mr4036089pgg.299.1552665407374;
        Fri, 15 Mar 2019 08:56:47 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id v22sm6115822pfa.49.2019.03.15.08.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 08:56:46 -0700 (PDT)
Subject: Re: [PATCH] tracing: initialize variable in create_dyn_event()
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <1548382670-30266-1-git-send-email-frowand.list@gmail.com>
 <2872713a-8b99-5117-27df-eeda824e55a0@gmail.com>
 <20190314181908.0af526af@gandalf.local.home>
 <20190315082637.e38ff91363ecd57de4015c59@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <99e329a6-dff9-6eb4-8977-72e9d8aec28a@gmail.com>
Date:   Fri, 15 Mar 2019 08:56:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190315082637.e38ff91363ecd57de4015c59@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/19 4:26 PM, Masami Hiramatsu wrote:
> Hi Frank and Steve,
> 
> Thank you for pointing it out :)
> 
> On Thu, 14 Mar 2019 18:19:08 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Thu, 14 Mar 2019 14:05:02 -0700
>> Frank Rowand <frowand.list@gmail.com> wrote:
>>
>>> Hi Steve,
>>>
>>> Ping.
>>
>> Thanks, this got buried.
>>
>>>>  static int create_dyn_event(int argc, char **argv)
>>>>  {
>>>>  	struct dyn_event_operations *ops;
>>>> -	int ret;
>>>> +	int ret = 0;
>>
>> Probably should be ret = -ENODEV;
>>
>> As if ret doesn't get set, then no dynamic code has been registered,
>> and something is truly wrong.
> 
> I Agreed to return -ENODEV instead of 0.
> 
> Thank you,
> 
>>
>> -- Steve
>>
>>
>>>>  
>>>>  	if (argv[0][0] == '-' || argv[0][0] == '!')
>>>>  		return dyn_event_release(argc, argv, NULL);
>>>>   
>>
> 
> 

Thanks, I'll fix and resend.
