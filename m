Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6558C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAE02171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfDLPcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:32:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43624 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLPcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:32:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id n8so5291803plp.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 08:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=noS2y6mJ1srr5NBsPltQTfG4rP0q2Q9Awkb9hBGouko=;
        b=S4S8+pEyGf2d9lMUeyk0EqKsRVeiYnShDIKwLXN9Dp6oN9jlC+5flSunUnFKXppTGU
         EgBJ3oA3X5gkzCHR+H0Dxg9BUUv94JxLfDJKkN5JWiKXeDFoX2OSHWW2fuUqUcBX5D7y
         an+VPSSzlhtgfEZ6kOnQiO2D2b7rZ94CeaI54bn4RL+Hc+K+Dq3ZELNLkYlToq1OBdFH
         /WPKM6yOKigDeYcrScoU8Utiw0Nl2OZLfcbDIGq0gn6dkF5EHdrUaYwAOBANitXsTegV
         61TVymEf6DUtmI/QLixWnYIg/dBaChrAbS0SdJMT/1vXS6L+mmp33S1xnkVH6PE8Yvbi
         dwOQ==
X-Gm-Message-State: APjAAAXZ9NfCvSDrc+G61t41/1RC3fhcfsTWXOtuE1sCXMPVhUeknPDG
        3wQFWjPYj0vDPbHM5h1ddfA=
X-Google-Smtp-Source: APXvYqyEJWZyVMv3UE/MFjBW4rBnWptp+N5Gg9RUasFpP6tTmSh+OKTTUY/J/Vzw3Q5KZkJGCZcXkQ==
X-Received: by 2002:a17:902:263:: with SMTP id 90mr5562143plc.257.1555083164966;
        Fri, 12 Apr 2019 08:32:44 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 4sm56723694pfn.159.2019.04.12.08.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 08:32:44 -0700 (PDT)
Message-ID: <1555083162.161891.83.camel@acm.org>
Subject: Re: [PATCH] locking/lockdep: Make lockdep_register_key() ignore
 'debug_locks'
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Waiman Long <longman@redhat.com>, shenghui <shhuiw@foxmail.com>
Date:   Fri, 12 Apr 2019 08:32:42 -0700
In-Reply-To: <20190412054719.GA80743@gmail.com>
References: <20190411172612.39180-1-bvanassche@acm.org>
         <20190412054719.GA80743@gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-12 at 07:47 +-0200, Ingo Molnar wrote:
+AD4 So why don't we add a debug+AF8-locks test to lockdep+AF8-unregister+AF8-key() 
+AD4 instead? The general principle to bring lockdep to a screeching halt when 
+AD4 bugs are detected, ASAP.

Hi Ingo,

Since this issue was introduced by patch +ACI-locking/lockdep: Zap lock classes
even with lock debugging disabled+ACI and since that patch is in the tip tree
but not yet upstream: do you prefer that I post a version 3 of that patch or
do you rather prefer that I post a follow-up patch?

Thanks,

Bart.
