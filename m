Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58ECCA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886C32087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RfvI6IJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfJ2WBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 18:01:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39588 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfJ2WBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 18:01:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id t8so377034qtc.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=IkV7pzdHzeP4W9uWbTsQ7etbx4DSYi39wSa2PvGrX6c=;
        b=RfvI6IJX3Jf/JhX4q/KwdEzN4UF0kChI0DDMFYEYqA+F9Mmy8ug1DbpQvquaIkh9+i
         DvC2bPiyTBMjQnjtE3XdjvaktrG24Ku8RyVky9le/cZDwcJXlOOxD23pjxA/jdm51GDD
         RGF1jXeDj+alZw/xoU72AmDNt2pvUZYS6T+g4AQaZxlYtmWCKbJZH6s2GHEhXX2JpiG5
         BxSR0fkB2gxylEY9WQNt4BtPh9mdmC/dIaF49bzj9Q1C3K0Wi8Kz7FyHu8dt+CPEZhvo
         tmIGP+gwiQw1CnKpEGoCrURJkOuwgXNoiEzAMHvoGPJL6TCfe0vuYxqEpgzsSceg8Nh6
         9gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=IkV7pzdHzeP4W9uWbTsQ7etbx4DSYi39wSa2PvGrX6c=;
        b=MGlemp656Qe4Yeau38zyv56exIl3MUBrKEZf21VGU9NGS9tQgYWynXX5fkH4t3rPf8
         KguxiZlTuriUxYylNiiXQJXqK2+0SFKiaL0OUPs018nIdWolo1ZceyZMjWSADMPc+fM7
         CTS/qbgRSeSPzwzfh6Q5WixqkuldQUkvaOwK/41+XZDazQm4JV9whudfdJ/+thgkJkiW
         IU4mmeXUTB5P+fGjUzVUs2GXJiP3bY4yCYjvlBJev2VDr9Q4eKilMC6JiLSRswgXZXF+
         QtEDi4yO+A/NV9J17sSBxfNUsbDfA8gdsJ5bia70kXCzPg9HXPyYnIT99tpCwThQ5bMT
         rDRA==
X-Gm-Message-State: APjAAAW9aDyDddlqhF15LoNpsCEBhTPU+SCt0F3y5E9sF7J/VW5XjM39
        R6As/4S/cgTHM7gryNTPKzDumQ==
X-Google-Smtp-Source: APXvYqzRDJnyT0AvItDzx453y4BLjC9jf3D+/3b3ob/WwGM7SPp0dlo5AEIDPRWfSp/v5PbLannDWQ==
X-Received: by 2002:a0c:c3c5:: with SMTP id p5mr25907593qvi.34.1572386492432;
        Tue, 29 Oct 2019 15:01:32 -0700 (PDT)
Received: from ?IPv6:2600:1000:b063:e143:e15a:1807:6e04:c401? ([2600:1000:b063:e143:e15a:1807:6e04:c401])
        by smtp.gmail.com with ESMTPSA id u18sm89248qth.20.2019.10.29.15.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2019 15:01:31 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: "Force HWP min perf before offline" triggers unchecked MSR access errors
Date:   Tue, 29 Oct 2019 18:01:30 -0400
Message-Id: <A94C23C3-E6B9-4390-B380-C49D87731D81@lca.pw>
References: <CAJZ5v0g6_-HBEKfHtfe8LFG9PKosGeUW3-gwTBW6F32OwFwO3g@mail.gmail.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAJZ5v0g6_-HBEKfHtfe8LFG9PKosGeUW3-gwTBW6F32OwFwO3g@mail.gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 29, 2019, at 5:47 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>=20
> The MSR_IA32_ENERGY_PERF_BIAS MSR appears to be not present, which
> should be caught by the X86_FEATURE_EPB check in
> intel_pstate_set_epb().
>=20
> Do you run this in a guest perchance?

No, it is a baremetal HPE server. The dmesg does say something like energy p=
erf bias changed from performance to normal, and the cpuflag contains epb wh=
ich I thought that would pass the feature check? I could upload the whole dm=
esg a bit later if that helps.=
