Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94737C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7675420B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfJJKnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:43:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfJJKnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:43:14 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB93880F7C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 10:43:14 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id q9so2422133wmj.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 03:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E85BCGQmqVsmCuJEJ/4DUXdYmnYWuqddkfV+jB9bC0I=;
        b=cgS/NyrB9E5dS1p/GdVmOoBjJxCR96hhKXB2zV6hXAXNliQ2yuPib5qWETBx6BC41t
         zrV0d8dA6QNnuR96exWAwsrgZdOtyANtmyoHK4akEmd5c1yixzCFQEP8iJmZj819dUfl
         ICdMA1pmDrGTcerPHeTutokRj4uHITz9hlVXLT5IoGgZMrj4HkeCvtZcCVjY4IMk5TJo
         Dnt04sV110kYSX5QA/mYKmYzYafpGs/u+klZ5AJrson23Qbm98vDqLzE5N188XI7Ev2F
         cDT9yzo4S29T7uVZjmf8pmOPMylLU9/6NZLPLTuTnCjuSikddEll5dEzvdRv+pSrAKHD
         i0kQ==
X-Gm-Message-State: APjAAAX0HnJ4GcAiSFbQQkG8pY0yyQDMcfBn80b1uCeMa6pPS1zWCoh9
        Mye6HNNshpS7YsxIRCr0htWVaSuNnCoMuYXirYmyeaJytQMM/tGagM5Ro83nK1GwDpHwfpSPJAZ
        psnfSsJd15dz9oov2jk3O1ezh
X-Received: by 2002:adf:9e02:: with SMTP id u2mr8269565wre.329.1570704193456;
        Thu, 10 Oct 2019 03:43:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxj+cNEr44B5+Ya5hop2TN6bpLeUDycV9++bm0c33NmD+aE03zGdR7jC6/ouvh33i25Mt2QWQ==
X-Received: by 2002:adf:9e02:: with SMTP id u2mr8269546wre.329.1570704193084;
        Thu, 10 Oct 2019 03:43:13 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id a204sm7425238wmh.21.2019.10.10.03.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 03:43:12 -0700 (PDT)
Subject: Re: [RFC v2 0/2] kvm: Use host timekeeping in guest.
To:     Suleiman Souhlal <suleiman@google.com>, rkrcmar@redhat.com,
        tglx@linutronix.de
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        ssouhlal@freebsd.org, tfiga@chromium.org, vkuznets@redhat.com
References: <20191010073055.183635-1-suleiman@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3120662b-9ea6-d86c-dc04-5f06a6e60afc@redhat.com>
Date:   Thu, 10 Oct 2019 12:43:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191010073055.183635-1-suleiman@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/19 09:30, Suleiman Souhlal wrote:
> 
> Changes in v2:
> - Move out of kvmclock and into its own clocksource and file.
> - Remove timekeeping.c #ifdefs.
> - Fix i386 build.

This is now pretty clean, so my objections are more or less gone.  I
haven't put much thought into this, but are all fields of struct
timekeeping necessary?  Some of them are redundant with the existing
wallclock MSRs.  The handling of versioning probably varies depending on
the exact set of fields, too.

Paolo
