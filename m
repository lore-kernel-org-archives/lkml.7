Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DDFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AE0207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ul3BFuwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391260AbfIES17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:27:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35732 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731541AbfIES17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:27:59 -0400
Received: by mail-io1-f66.google.com with SMTP id f4so6244448ion.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+a3LtWFrnf98U6Vz9nmHmxlCeDZ2bfINz0CsyEoJr+Q=;
        b=ul3BFuwDZE3rrJP8A2QO2y6ehBfCpRd6K12h43sXG/ssf31ITv2bLsODXbyOb2hvK2
         GMQRX6MYcSGkQgrhJzVcF9WLxgWnicuiJEMTLAoixjJYdFqcFn1s+q+6g/zFSeWrfYzV
         d8SMfysDdlecDhwyr693Tz72hTKxKEdDrdq9t219/YF3nt9m6OKl9pyb0cpfCHu48plm
         /3dY+uMkhGwdlhS/rIx8oxfFNGV5wFZgq30x8/ZQdLm4i4HsTTvCjFU1Jx9EEIK125Qy
         //q1z3DsrLNa+Yv++CHrBz/qZXv8m2KEZTAneXd3OWxbIvjUL6DH5bd9ozv6rjy3hcPD
         UPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+a3LtWFrnf98U6Vz9nmHmxlCeDZ2bfINz0CsyEoJr+Q=;
        b=T2+6UpQ71EYoVHuCCLc+I53BKK9XuFfxKW+i73uxs0hyhbyvFvQCUy5uiZkW7j//+F
         A1vi/ZRkMtn5fITJbOeOUscHJHuT0Z+msZjaqvL3ZqBB5SHwCFuLZomW9/6YzTDMKyOw
         +ROKIpFiGSnhnXoELKuzALIelrTUwmGw5xFO+kPLPn1ZFHhWkt/oCw4HO1zYqffLf+RF
         uLsEqgFLTjHpwqtsqK7KVeveuhaWidOrWf2I3L9nsx6d2qRDU1Li6KTpE1SG1COHd66W
         y38RdeGwll0WVqatIu8n74yiqcL3uF/KJ59zMEGBBc7gR5skkH2M3LEel5TJBDBIS64W
         dMNw==
X-Gm-Message-State: APjAAAVwE+iQaltmU4g+jZBQBPaYNiHxTna8OAZRiM285n6LCQBKLHMw
        fcf1L+4FV5WQ61nWoAFogA==
X-Google-Smtp-Source: APXvYqy1iqfIwkwUZWO4/hfjhObtm2Y3L3t3tdetdH54rgz6grUIgYo0nqwz1QNkBHr43r1PhrKp7w==
X-Received: by 2002:a6b:9308:: with SMTP id v8mr5463208iod.221.1567708078333;
        Thu, 05 Sep 2019 11:27:58 -0700 (PDT)
Received: from [192.168.1.99] ([92.117.180.21])
        by smtp.googlemail.com with ESMTPSA id z20sm3107104iof.38.2019.09.05.11.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 11:27:57 -0700 (PDT)
Subject: Re: [PATCH v5 2/4] preemptirq_delay_test: Add the burst feature and a
 sysfs trigger
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
 <20190903132602.3440-3-viktor.rosendahl@gmail.com>
 <20190904074212.4c7d17dc@oasis.local.home>
 <4e1c66b8-4aee-77d3-cf3b-dc633f9abf6b@gmail.com>
 <20190905125227.2638e406@oasis.local.home>
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
Message-ID: <f7edefa4-38c3-6c8f-588d-1e8afe08316f@gmail.com>
Date:   Thu, 5 Sep 2019 20:27:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905125227.2638e406@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/19 6:52 PM, Steven Rostedt wrote:
> On Wed, 4 Sep 2019 21:10:38 +0200
> Viktor Rosendahl <viktor.rosendahl@gmail.com> wrote:
> 
>> On 9/4/19 1:42 PM, Steven Rostedt wrote:
>>
>> I am not so keen to clutter source files with a new copyright message.
>> My problem is that git-send-email doesn't work well with my work email
>> address, so I am forced to use my private gmail, which may create a
>> false impression that I as a private individual would be the copyright
>> holder.
>>
> 
> Then do what I do:
> 
>    Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> I did "(Red Hat)" when I worked for Red Hat.
> 
> -- Steve
> 

Ok, that seems simple and effective. I will update accordingly for v7 of 
the patches.

best regards,

Viktor
