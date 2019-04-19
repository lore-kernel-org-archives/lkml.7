Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8ECC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1811E2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Url4Yik5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfDSU7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:59:05 -0400
Received: from mail.efficios.com ([167.114.142.138]:52494 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfDSU7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:59:04 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B4602B1F7A;
        Fri, 19 Apr 2019 16:59:02 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 7_oVTEbGot9U; Fri, 19 Apr 2019 16:59:02 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 38716B1F77;
        Fri, 19 Apr 2019 16:59:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 38716B1F77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555707542;
        bh=QabJ/YC/LKiPQbCTiMhkOIEHrQcIVR8s1lMctjcDh6Q=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Url4Yik5RfvVfzEs109NMmZT37ijLb8Qi6pdiIHPQ0T8c0KNT4yIBuhEUWx5OLZwn
         4SVS8gcHhuSqanvzUBCkuI3ekcFKHy3qpXO0mKGW25OQHtS2Z94seAo2rHj3qb0m3H
         CVPQ+u2FS3/9nlYliOsHF8rJTs845fKFlHsLJX9cB7PSpqP1C4csMCd0hbKljGqOnt
         S54WihSe5+wD6C2LyFSKFrv2aRZkLC9SA4qbwxu/601M4CCLqR7PufWXePrgOtlIxm
         28Q5c9LX8+lrpzzbNHxBGG4kFxWaTrrxPJ/mFRoKwzhHD3KFXyC3Arr26BSrA1M31A
         y7p7F0xHAkcwA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id MMZS_4jG5WdG; Fri, 19 Apr 2019 16:59:02 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 13393B1F69;
        Fri, 19 Apr 2019 16:59:02 -0400 (EDT)
Date:   Fri, 19 Apr 2019 16:59:01 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     shuah <shuah@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Message-ID: <1136505826.203.1555707541777.JavaMail.zimbra@efficios.com>
In-Reply-To: <cfcbace7-363d-e45e-11da-8efb200783b7@kernel.org>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com> <1444419838.71.1555677682502.JavaMail.zimbra@efficios.com> <1266612341.87.1555678507226.JavaMail.zimbra@efficios.com> <614774674.134.1555681346941.JavaMail.zimbra@efficios.com> <1863599735.141.1555681723685.JavaMail.zimbra@efficios.com> <6ba0796c-8a96-f797-265c-37bfb9b4bb71@kernel.org> <580328197.148.1555684824260.JavaMail.zimbra@efficios.com> <cfcbace7-363d-e45e-11da-8efb200783b7@kernel.org>
Subject: Re: [PATCH for 5.1 3/3] rseq/selftests: Adapt number of threads to
 the number of detected cpus
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/selftests: Adapt number of threads to the number of detected cpus
Thread-Index: YAfWAh+GAzq5aLOBJFEB8cRAPFCeSg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 19, 2019, at 2:57 PM, shuah shuah@kernel.org wrote:
[...]
> Should I drop this patch that is currently in linux-kseltest next? Just
> confirming if your new patch is supposed to be applied on top of this
> one or not?

We should keep this patch in linux-kselftest next. The fix applies on top
of it.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
