Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6B5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9ED2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Md3o2/HG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbfDXUn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:43:58 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37626 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731232AbfDXUnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:43:55 -0400
Received: by mail-io1-f66.google.com with SMTP id a23so13310996iot.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to;
        bh=OlTAAJebMkgW+ciUrCmLN83qkVIGeXnDfsuTHcO0qn8=;
        b=Md3o2/HGGsWKVXObBs4Xeuy7RgpcUXVQWXMB/lHlBmZetw7XWjZpdu/7z7pgvG49yw
         cYFwDFPCzW8Kb6TwKy6jQCLiLh9ax3uvib1wNzEcpmEKZ3r91NdgNA1ricXMhdyMOrsB
         EaIKj10mz/3Z+jc1maZuQmNPESm+SiSPUDVKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to;
        bh=OlTAAJebMkgW+ciUrCmLN83qkVIGeXnDfsuTHcO0qn8=;
        b=fUC64jJYyZ80XKiuSK5WBf2N7W7yV5N//OQdru33C9rmQ8D6arGwrfzxJdFNl6Nw5b
         qklOeWxIoxzAbVN0sa0MKCCdWMM/T5FSQ0ryglhXdQmK0qfg5kTlzWoT2V3jEsL9DgFE
         o9eKyG+wG/tBbQNCxtGpaZ7H5+l0onqemkk373Ya4oK97y9UcuQ0VIpX54Bgnjujvm2O
         qKpTANvpP3sAkqzONtrmt8/SUiPA7DqPIZksKRxYCgtcAciPapWVxyFQSGINRJveso4C
         KCjNv/KcQINPcCweFlFTcrpfyNUttDKc15aEoi+BYD8KRncuN3+yoJwpuuj0h/HrZ5E3
         A5jA==
X-Gm-Message-State: APjAAAWNY7HWtjnZ0gpChTR3yxXD4CeJTk/egZTMJPJfEbq/FNN5fetZ
        k0D5/bpqQ1sHHs9wCsDMpZwX/w==
X-Google-Smtp-Source: APXvYqwxrYxlQs0/nf9r/uCddp1FSaPRH8CRY6jWkwEqv+ZYzwmv8vYcsjdf+2q0MfFbZsfl5pBYEg==
X-Received: by 2002:a5d:898a:: with SMTP id m10mr21623268iol.296.1556138634702;
        Wed, 24 Apr 2019 13:43:54 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id t22sm6717590iob.16.2019.04.24.13.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 13:43:54 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Aubrey Li <aubrey.intel@gmail.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH v2 11/17] sched: Basic tracking of matching tasks
Date:   Wed, 24 Apr 2019 20:43:37 +0000
Message-Id: <20190424204337.22283-2-vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424204337.22283-1-vpillai@digitalocean.com>
References: <20190424204337.22283-1-vpillai@digitalocean.com>
In-Reply-To: <c2b101e4-4ce4-4aee-b1ec-e4a753cb9590@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The sched_core_* functions are used only in the core.c
> they are declared in.  We can convert them to static functions.

Thanks for pointing this out, will accomodate this in v3.

Thanks
