Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DA4C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB43A20870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="W2AM6gex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfHXAaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 20:30:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45604 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfHXAaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 20:30:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so6495176plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 17:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xnR71yxvWSFn7GNIN4j2Fr3rKuwX+n1QmLSLVRDzZPA=;
        b=W2AM6gexTKN/VXcMZcNlCQUd1t7QNxA2cYHEuT6iNPI+LLeisFbLGSp7EFWmfR/GqJ
         ukVzvf47sFPlyUlhrgBgefa3c7ywbe85INX7ypVuklNfnx6nvpvLMTazX+f0PYBsK3j8
         2eFIoiuvEZOQxF2Jqk0NRW4rLxK3k3vp7yuu3KLd805bbiw/GDeFzDlmTkMRh0b+e8u/
         6BdSDVqdKECnS95a+YReAWFtZyA/LxvK8E48vaGRDb5CzKWAI/aSoy+v3zqvrFPazhs2
         BfyBlcWZkL2HrkKyQ5wWUtZpK/NGNqqCX1lpcQrzvqJSlXIl3aUFcEwmhjE1//XwP4sl
         fDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xnR71yxvWSFn7GNIN4j2Fr3rKuwX+n1QmLSLVRDzZPA=;
        b=YKkZzSx4taJ98gp5NWLOPCy/V7wQLNM0W8ZoxQzVB7sYHyBbif+jvoVl+eCW76+RXK
         djuJklRx9BRqcFND7OgxpkVsLQ8WFR3BzniYMXoDiHWfLenojy/6ADCBEHGMx/dyTgKy
         Yvq9Jgmsj+PSddJrpnGzrDXtJsQtPSNvWdAhZA5JkXJVoda4Bmj6Hfz2GFBL8QoemORB
         mPwwE1F68TkO6IOzOO4NiR7vZDxgdT1TgZLRInvpsPmg+OBzvcfy0WCswGCLiBfTDnz9
         raIKBi9W5CTk2HCOCSTmHtFIYt3tJyXyvRhnlXKhvfO6W7ks9jw6RN/Q+m0Z3XAfittX
         1XCQ==
X-Gm-Message-State: APjAAAXYQdpDW+fdFvR4C/DOdRD8RPW5M/sncOym1w71S5ymm8Ia2IhN
        DBhHdz5m4seeGXTLM3JFrYOXsg==
X-Google-Smtp-Source: APXvYqypnIHRw+gX7a2zAkaV+URyBUoTsPo6A6KcuRTTuMEOhltXd4pwHW+VP0k4vY8gZmJbUDCW8A==
X-Received: by 2002:a17:902:e613:: with SMTP id cm19mr7207697plb.299.1566606654666;
        Fri, 23 Aug 2019 17:30:54 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id h9sm2890450pgh.51.2019.08.23.17.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 17:30:54 -0700 (PDT)
Date:   Fri, 23 Aug 2019 17:30:53 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Tycho Andersen <tycho@tycho.ws>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Vincent Chen <vincentc@andestech.com>,
        Alan Kao <alankao@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, me@carlosedp.com
Subject: Re: [PATCH v2] riscv: add support for SECCOMP and SECCOMP_FILTER
In-Reply-To: <20190822205533.4877-1-david.abdurachmanov@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1908231717550.25649@viisi.sifive.com>
References: <20190822205533.4877-1-david.abdurachmanov@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019, David Abdurachmanov wrote:

> There is one failing kernel selftest: global.user_notification_signal

Is this the only failing test?  Or are the rest of the selftests skipped 
when this test fails, and no further tests are run, as seems to be shown 
here:

  https://lore.kernel.org/linux-riscv/CADnnUqcmDMRe1f+3jG8SPR6jRrnBsY8VVD70VbKEm0NqYeoicA@mail.gmail.com/

For example, looking at the source, I'd naively expect to see the 
user_notification_closed_listener test result -- which follows right 
after the failing test in the selftest source.  But there aren't any 
results?

Also - could you follow up with the author of this failing test to see if 
we can get some more clarity about what might be going wrong here?  It 
appears that the failing test was added in commit 6a21cc50f0c7f ("seccomp: 
add a return code to trap to userspace") by Tycho Andersen 
<tycho@tycho.ws>.


- Paul
