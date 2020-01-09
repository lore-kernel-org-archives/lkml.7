Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B57C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D832075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGmbTjKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgAIUqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:46:45 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46591 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgAIUqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:46:44 -0500
Received: by mail-qt1-f195.google.com with SMTP id g1so7011574qtr.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 12:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DWM0j5tZLR3359c+a2rA4wyZv8TrqZcQKkaM1KEojEY=;
        b=mGmbTjKXlVt1lompbLHwd/o0loS1Ui1RASNS3ZCwAby7hncY8DP4zZqRNWujbFiPVQ
         1Yre3YqeeOUg/RQ0swG4m3uPf4VRMXn2Egv5Bkn2Tc9MmRzAZBJf8iw/NdKj9DBFRAb0
         8qFVdaEZaxzDO5k+ssPER1RiYQ2K7p+1U/mtE4SyLk3ZUrpsMtbkhton/QRPRKx/XS6g
         NiXbAUQTpmU1ctkhjmm2lpp7Ci4nuMX0i6NEJonIASaB/eOhaBAKm9efbNKMvAvUWLJn
         0hSo2EQ4C8g5Fkz3Wu0LWh7Ri5gmJuxmoTw3Ob7uSiP+CXFjEKJ1mKyTJpwNLd8kVWF2
         ZMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DWM0j5tZLR3359c+a2rA4wyZv8TrqZcQKkaM1KEojEY=;
        b=QxszFA5u6/TGpKsVbE8J815GqksFUmGRvXj+kVerx9+cxOCsL08JDLvsfIepWH8kZD
         0Ome96lNwo1a+lnGNM8LJYOPZDUCFh7vBFfVUz3BqT6wlge7STmuLzvc3bPa+9UHJr0j
         LY1K6+nZf1dywTfMVEiNSBc4OsSVMRnzdhsHTY77i+VGwO9L8Iumo6t4lwWOq7xwsR+p
         3045/4l4Q7/flyT8gAAp3IOzuXjIgnMku2mwVfzVa3zLG1c7e0NgZ4Gq6N/M1+H5sbgQ
         WI8syLeTyjxv0tHaKfQKD4vpWvUeEJCpbuUBe8hx7VUcVzf5lFaGl/GaReGa+2Uyu6dl
         oPWw==
X-Gm-Message-State: APjAAAWzURR+ld/yFumLGF0xyZLaMoxzhy+CNhLje/OH2/gwOklLWUPL
        r6zLQKe4NY8AE3EHILh6h+6yw4PSG0Y=
X-Google-Smtp-Source: APXvYqxybzWgUcYhtudbjmkLjeD3PtY/3I527wBsTWBCp1KPrdCi6Bg9T8RpSrIBmxeFmTbGWdc/HQ==
X-Received: by 2002:ac8:37d3:: with SMTP id e19mr3173027qtc.361.1578602803027;
        Thu, 09 Jan 2020 12:46:43 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f26sm3846724qtv.77.2020.01.09.12.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 12:46:42 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 9 Jan 2020 15:46:41 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2] x86/boot/KASLR: Fix unused variable warning
Message-ID: <20200109204638.GA523773@rani.riverdale.lan>
References: <20200103033929.4956-1-zhenzhong.duan@gmail.com>
 <20200109184055.GI5603@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200109184055.GI5603@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 07:40:55PM +0100, Borislav Petkov wrote:
> On Fri, Jan 03, 2020 at 11:39:29AM +0800, Zhenzhong Duan wrote:
> > Local variable 'i' is referenced only when CONFIG_MEMORY_HOTREMOVE and
> > CONFIG_ACPI are defined, but definition of variable 'i' is out of guard.
> > If any of the two macros is undefined, below warning triggers during
> > build, fix it by moving 'i' in the guard.
> > 
> > arch/x86/boot/compressed/kaslr.c:698:6: warning: unused variable ‘i’ [-Wunused-variable]
> 
> How do you trigger this?
> 
> I have:
> 
> $  grep -E "(CONFIG_MEMORY_HOTREMOVE|CONFIG_ACPI)" .config
> # CONFIG_ACPI is not set
> 
> but no warning. Neither with gcc 8 nor with gcc 9.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

The boot/compressed Makefile resets KBUILD_CFLAGS.  Following hack and
building with W=1 shows it, or just add -Wunused in there.

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 56aa5fa0a66b..791c0d5a952a 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -35,6 +35,9 @@ KBUILD_CFLAGS += $(cflags-y)
 KBUILD_CFLAGS += -mno-mmx -mno-sse
 KBUILD_CFLAGS += $(call cc-option,-ffreestanding)
 KBUILD_CFLAGS += $(call cc-option,-fno-stack-protector)
+
+include scripts/Makefile.extrawarn
+
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
 KBUILD_CFLAGS += -Wno-pointer-sign
